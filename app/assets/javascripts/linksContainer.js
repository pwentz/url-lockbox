class LinksContainer {
  constructor() {
    this.links = []
  }

  getLinks() {
    $.getJSON('/api/v1/links.json')
      .done( data => $('.links').append(this.renderLinks()))
  }

  renderLinks() {
    return this.links.map(link => {
      return `<div>
               <a href=${link.url}>${link.title}</a>
              </div>`
    })
  }
}
