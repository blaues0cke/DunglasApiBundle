Feature: Using custom writable identifier on resource
  In order to use an hypermedia API
  As a client software developer
  I need to be able to user other identifier than id in resource and set it via API call on POST / PUT.

  @createSchema
  Scenario: Create a resource
    When I send a "POST" request to "/custom_writable_identifier_dummies" with body:
    """
    {
      "name": "My Dummy",
      "slug": "my_slug"
    }
    """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/CustomWritableIdentifierDummy",
      "@id": "/custom_writable_identifier_dummies/my_slug",
      "@type": "CustomWritableIdentifierDummy",
      "name": "My Dummy"
    }
    """

  Scenario: Get a resource
    When I send a "GET" request to "/custom_writable_identifier_dummies/my_slug"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/CustomWritableIdentifierDummy",
      "@id": "/custom_writable_identifier_dummies/my_slug",
      "@type": "CustomWritableIdentifierDummy",
      "name": "My Dummy"
    }
    """

  Scenario: Get a collection
    When I send a "GET" request to "/custom_writable_identifier_dummies"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/CustomWritableIdentifierDummy",
      "@id": "/custom_writable_identifier_dummies",
      "@type": "hydra:PagedCollection",
      "hydra:totalItems": 1,
      "hydra:itemsPerPage": 3,
      "hydra:firstPage": "/custom_writable_identifier_dummies",
      "hydra:lastPage": "/custom_writable_identifier_dummies",
      "hydra:member": [
        {
          "@id": "/custom_writable_identifier_dummies/my_slug",
          "@type": "CustomWritableIdentifierDummy",
          "name": "My Dummy"
        }
      ]
    }
    """

  Scenario: Update a resource
      When I send a "PUT" request to "/custom_writable_identifier_dummies/my_slug" with body:
      """
      {
        "name": "My Dummy modified",
        "slug": "slug_modified"
      }
      """
      Then the response status code should be 200
      And the response should be in JSON
      And the header "Content-Type" should be equal to "application/ld+json"
      And the JSON should be equal to:
      """
      {
        "@context": "/contexts/CustomWritableIdentifierDummy",
        "@id": "/custom_writable_identifier_dummies/slug_modified",
        "@type": "CustomWritableIdentifierDummy",
        "name": "My Dummy modified"
      }
      """

  Scenario: Vocab is correctly generated
    When I send a "GET" request to "/vocab"
    Then the response status code should be 200
    And the response should be in JSON
    And the hydra class "CustomWritableIdentifierDummy" exist
    And 3 operations are availables for hydra class "CustomWritableIdentifierDummy"
    And 2 properties are availables for hydra class "CustomWritableIdentifierDummy"
    And "name" property is readable for hydra class "CustomWritableIdentifierDummy"
    And "name" property is writable for hydra class "CustomWritableIdentifierDummy"
    And "slug" property is not readable for hydra class "CustomWritableIdentifierDummy"
    And "slug" property is writable for hydra class "CustomWritableIdentifierDummy"

  @dropSchema
  Scenario: Delete a resource
    When I send a "DELETE" request to "/custom_writable_identifier_dummies/slug_modified"
    Then the response status code should be 204
    And the response should be empty
