import HttpPipeline
import Testing

@Test
func testEncrypt() {
  #expect(
    "000000000000000000000000e377fa5aa3bcb469cfcd8e1e25b4743bdcde0b98" ==
    encrypted(
      text: "blah",
      secret: "DeadBeefDeadBeef0123012301230123",
      nonce: .init(repeating: 0, count: 12)
    )
  )
  
  // Secret is too short
  #expect(nil == encrypted(text: "blah", secret: "deadbeefdeadbeef"))
  
  // Secret is not valid hex string
  #expect(nil == encrypted(text: "blah", secret: "asdfasdfasdfasdfasdfasdfasdfasdf"))
}

@Test
func testDecrypt() {
  
  let secret = "DeadBeefDeadBeef0123012301230123"
  let text = "blah"
   
  let encrypt = encrypted(text: text, secret: secret)
  
  #expect("blah" == decrypted(text: encrypt!, secret: secret))
  
  // Secret is too short
  #expect(nil == decrypted(text: "836fdf1bf0008e1be7b352d0ccd42dcb", secret: "deadbeefdeadbeef"))
  
  // Secret is not valid hex string
  #expect(nil == decrypted(text: "836fdf1bf0008e1be7b352d0ccd42dcb", secret: "asdfasdfasdfasdfasdfasdfasdfasdf"))
  
  // Encrypted text is not even length
  #expect(nil == decrypted(text: "8", secret: "deadbeefdeadbeefdeadbeefdeadbeef"))
  
  // Encrypted text is not valid.
  #expect(nil == decrypted(text: "83", secret: "deadbeefdeadbeefdeadbeefdeadbeef"))
  
  // Encrypted text is not valid hex string.
  #expect(nil == decrypted(text: "asdf", secret: "deadbeefdeadbeefdeadbeefdeadbeef"))
}

@Test
func testDigest() {
  #expect(nil != digest(value: "ZNeX1idK+rOYKu9jcq7AS9+IBA3wuPWWZeUQchQrLIs=", secret: "deadbeef"))
}

