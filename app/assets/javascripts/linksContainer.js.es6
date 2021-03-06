class LinksContainer {
  constructor() {
    this.links = []
    this.getLinks = this.getLinks.bind(this)
    this.toggleReadStatus = this.toggleReadStatus.bind(this)
    this.filterLinks = this.filterLinks.bind(this)
    this.filterRead = this.filterRead.bind(this)
    this.filterUnread = this.filterUnread.bind(this)
    this.filterABC = this.filterABC.bind(this)

    $(document).on('click', '.mark-read', this.toggleReadStatus)
    $(document).on('keyup', '#link-search', this.filterLinks)
    $(document).on('click', '#filter-read', this.filterRead)
    $(document).on('click', '#filter-unread', this.filterUnread)
    $(document).on('click', '#filter-abc', this.filterABC)
  }

  getLinks() {
    $('.new-link-url').val('')
    $('.new-link-title').val('')

    $.getJSON('/api/v1/links.json')
      .done( data => $('.links').append(this.renderLinks(data)))
  }

  renderLinks(data) {
    console.log(data)
    return data.map(link => {
      if (link.read) {
        return `<div id=${link.id} class='link'>
                 <a href=${link.url} style='color:red;' class='link-title' target='_blank'>${link.title}</a><p>Read: ${link.read}</p>
                 <a href='#' class='mark-read'>Mark as Unread</a>
                 <a href='/links/${link.id}/edit' class='edit-link button warning'>Edit</a>
                 <p>This is a short story about <strong>${link.html_title}</strong>, starting with <strong>${link.html_h1}</strong></p>
                 <hr>
                </div>`
      }
      else {
        return `<div id=${link.id} class='link'>
                 <a href=${link.url} class='link-title' target='_blank'>${link.title}</a><p>Read: ${link.read}</p>
                 <a href='#' class='mark-read'>Mark as Read</a>
                 <a href='links/${link.id}/edit' class='edit-link button warning'>Edit</a>
                 <p>This is a short story about <strong>${link.html_title}</strong>, starting with <strong>${link.html_h1}</strong></p>
                 <hr>
                </div>`
      }
    })
  }

  toggleReadStatus(e) {
    e.preventDefault()

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

  filterLinks(e) {
    let searchParams = e.target.value.toLowerCase()

    $('.link').each((index, link) => {
      let $link = $(link)
      let linkTitle = $link.find('.link-title')[0].innerText.toLowerCase()
      if (linkTitle.indexOf(searchParams) === -1) {
        $link.hide()
      }
      else {
        $link.show()
      }
    })
  }

  filterRead(e) {
    e.preventDefault()

    $('.link').each((index, link) => {
      let $linkDiv = $(link)
      let linkP = $linkDiv.find('p')
      if (linkP[0].innerText === 'Read: true') {
        $linkDiv.show()
      }
      else {
        $linkDiv.hide()
      }
    })
  }

  filterUnread(e) {
    e.preventDefault()

    $('.link').each((index, link) => {
      let $linkDiv = $(link)
      let linkP = $linkDiv.find('p')
      if (linkP[0].innerText === 'Read: true') {
        $linkDiv.hide()
      }
      else {
        $linkDiv.show()
      }
    })
  }

  filterABC(e) {
    $.getJSON('/api/v1/links.json?ordered=true')
      .done( data => {
        $('.links').empty()
        $('.links').append(this.renderLinks(data))
      })
  }

  updateReadStatus(id, readStatus) {
    $.ajax({
      url: `/api/v1/links/${id}.json`,
      type: 'PUT',
      data: { read: readStatus }
    })
  }

  postLinkRequest(title, url) {
    $.ajax({
      url: `/api/v1/links.json`,
      type: 'POST',
      data: { link: { title: title, url: url } }
    })
  }
}
