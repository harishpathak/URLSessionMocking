# URLSessionMocking
A sample unit test for mocking URL Session in network layer.

There will be two ways I'm showing in this sample.
1. Using dependency injection
2. Using URLProtocol class

Important Files to look into:
HTTPClient.swift - contains a simple API calling logic which we need to test, URLSession is injected as a dependency
MockURLSession - Mocked class for URLSession, with a mock implementation
MockURLProtocol - Mocked class for URLProtocol, which will be used to inject mock data using static property.
APIClientTestUsingMockURLSession - A test case using MockURLSession
APIClientTestUsingMockURLProtocol - A test case using MockURLProtocol
