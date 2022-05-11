describe('Product Detail Tests', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('Can click a product title and navigate to the detail page', () => {
    cy.contains('Scented Blade').click();
    cy.contains(
      'article.product-detail',
      'The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks.'
    );
    cy.url().should('include', '/products/2');
  });

  it('Can add an item to the cart', () => {
    cy.contains('Scented Blade').click();
    cy.contains('.btn', 'Add').click();
    cy.contains('.nav-link', 'My Cart').click();
    cy.contains('table.table.table-bordered', 'Scented Blade').click();
  });
});
