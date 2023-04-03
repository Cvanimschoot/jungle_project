describe('product_details', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is at least 1 product on the page", () => {
    cy.get(".products article").should("have.length.greaterThan", 1);
  });

  it("Should click on a product and navigate to a product details page", () => {
    cy.get('[alt="Cliff Collard"]').click()
    cy.wait(1000)
    cy.contains('Cliff Collard')
  })
})