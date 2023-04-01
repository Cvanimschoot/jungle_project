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
})