//
//  CreateUserViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//


import Foundation
import CryptoKit
import AuthenticationServices

protocol CreateUserViewModelDelegate: AnyObject {
    func presentAlertController(error: Error)
    func userSignedIn()
}

class CreateUserViewModel {
    
    private var service: FirebaseSyncable?
    private weak var delegate: CreateUserViewModelDelegate?
    
    init(service: FirebaseSyncable = FirebaseService(), delegate: CreateUserViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
   
    func createUser(with email: String, password: String, confirmPassword: String) {
        service?.createUser(with: email, password: password) { result in
            switch result {
            case .success:
                self.delegate?.userSignedIn()
            case .failure(let error):
                self.delegate?.presentAlertController(error: error)
            }
        }
    }
    
    func signInWithApple(token: String, nonce: String) {
        service?.signInWithApple(token: token, nonce: nonce)
    }
    
    // sign in with apple
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    private(set) var currentNonce: String?

    func startSignInWithAppleFlow(delegate: ASAuthorizationControllerDelegate, presentationProvider: ASAuthorizationControllerPresentationContextProviding) {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = delegate
      authorizationController.presentationContextProvider = presentationProvider
      authorizationController.performRequests()
    }
    
} // end of class
