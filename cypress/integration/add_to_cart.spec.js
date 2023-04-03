describe('homepage', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is at least 1 product on the page", () => {
    cy.get(".products article").should("have.length.greaterThan", 1);
  });

  it("Should click on add to cart and see the shopping cart go up by 1", () => {
    cy.get('.nav-link').contains('My Cart (0)')
    const btn = cy.get('.btn').eq(0)
    btn.click({ force: true })
    cy.wait(500)
    cy.get('.nav-link').contains('My Cart (1)')
  })
})