class LinksContainer {
  constructor() {
    this.links = []
    this.getLinks = this.getLinks.bind(this)
    this.markAsRead = this.markAsRead.bind(this)

    $(document).on('click', '.mark-read', this.markAsRead)
  }

  getLinks() {
    $.getJSON('/api/v1/links.json')
      .done( data => $('.links').append(this.renderLinks(data)))
  }

  renderLinks(data) {
    console.log(data)
    return data.map(link => {
      if (link.read) {
        return `<div id=${link.id}>
                 <a href=${link.url} style='color:red;' class='link-title'>${link.title}</a><p>Read: ${link.read}</p>
                 <a href='#' class='mark-read'>Mark as Unread</a>
                </div>`
      }
      else {
        return `<div id=${link.id}>
                 <a href=${link.url} class='link-title'>${link.title}</a><p>Read: ${link.read}</p>
                 <a href='#' class='mark-read'>Mark as Read</a>
                </div>`
      }
    })
  }

  markAsRead(e) {
    const targetDiv = e.target.closest('div')
    const targetP = $(targetDiv).find('p')
    const targetReadAnchor = $(targetDiv).find('.mark-read')
    const linkTitle = $(targetDiv).find('.link-title')
    if (targetP[0].innerText === 'Read: false') {
      targetP[0].innerText = 'Read: true'
      targetReadAnchor[0].innerText = 'Mark as Unread'
      $(linkTitle).css('color', 'red')
      this.updateReadStatus(targetDiv.id, 'true')
    }
    else {
      targetP[0].innerText = 'Read: false'
      targetReadAnchor[0].innerText = 'Mark as Read'
      $(linkTitle).css('color', '#2199e8')
      this.updateReadStatus(targetDiv.id, 'false')
    }
  }

  updateReadStatus(id, readStatus) {
    $.ajax({
      url: `/api/v1/links/${id}.json`,
      type: 'PUT',
      data: { read: readStatus }
    })
  }
}
