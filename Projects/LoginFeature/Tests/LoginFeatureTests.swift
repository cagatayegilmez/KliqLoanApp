//
//  LoginFeatureTests.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 15.07.2026.
//

@testable import LoginFeature
import Testing
import UIKit

private enum Constant {

    static let validEmail = "user@kliq.com"
    static let validPassword = "123456"
    static let invalidEmail = "userkliq.com"
    static let shortPassword = "123"
    static let mailEmptyError = "Please enter email"
    static let passwordEmptyError = "Please enter password"
    static let validMailError = "Please enter valid email"
    static let validPasswordError = "Password should be at least 6 characters"
}

private struct MockError: Error {}

@MainActor
struct LoginFeatureTests {

    private let router: MockLoginFeatureRouter
    private let authService: MockAuthService
    private let sut: any LoginFeatureViewModelProtocol

    init() {
        router = MockLoginFeatureRouter()
        authService = MockAuthService()
        sut = LoginFeatureViewModel(router: router, authService: authService)
    }

    @Test
    func signInWithEmptyFieldsShowsEmptyErrors() async {
        await sut.signInButtonTapped()

        #expect(sut.mailError == Constant.mailEmptyError)
        #expect(sut.passwordError == Constant.passwordEmptyError)
        #expect(authService.loginCallCount == 0)
    }

    @Test
    func signInWithInvalidMailShowsValidMailError() async {
        sut.email = Constant.invalidEmail
        sut.password = Constant.validPassword

        await sut.signInButtonTapped()

        #expect(sut.mailError == Constant.validMailError)
        #expect(sut.passwordError == nil)
        #expect(authService.loginCallCount == 0)
    }

    @Test
    func signInWithShortPasswordShowsValidPasswordError() async {
        sut.email = Constant.validEmail
        sut.password = Constant.shortPassword

        await sut.signInButtonTapped()

        #expect(sut.mailError == nil)
        #expect(sut.passwordError == Constant.validPasswordError)
        #expect(authService.loginCallCount == 0)
    }

    @Test
    func signInWithValidCredentialsRoutesToHome() async {
        sut.email = Constant.validEmail
        sut.password = Constant.validPassword

        await sut.signInButtonTapped()

        #expect(authService.loginCallCount == 1)
        #expect(authService.lastEmail == Constant.validEmail)
        #expect(authService.lastPassword == Constant.validPassword)
        #expect(router.routeToHomeCallCount == 1)
        #expect(sut.mailError == nil)
        #expect(sut.passwordError == nil)
    }

    @Test
    func signInFailureTriggersOnError() async {
        authService.loginError = MockError()
        sut.email = Constant.validEmail
        sut.password = Constant.validPassword

        var receivedError: (any Error)?
        sut.onError = { receivedError = $0 }

        await sut.signInButtonTapped()

        #expect(receivedError is MockError)
        #expect(router.routeToHomeCallCount == 0)
    }

    @Test
    func signInCancellationDoesNotTriggerOnError() async {
        authService.loginError = CancellationError()
        sut.email = Constant.validEmail
        sut.password = Constant.validPassword

        var receivedError: (any Error)?
        sut.onError = { receivedError = $0 }

        await sut.signInButtonTapped()

        #expect(receivedError == nil)
        #expect(router.routeToHomeCallCount == 0)
    }

    @Test
    func presentAlertForwardsToRouter() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        sut.presentAlert(alert)

        #expect(router.presentedAlert === alert)
    }
}
