const version = "${FRONT_VERSION}";

const comment = document.createComment(version);

const doc = document;

doc.insertBefore(comment, doc.firstChild);

fetch('https://${URL_IB_MONOLITO}/bocombbm-mf-ib-version.js')
    .then(response => response.text())
    .then(data => {
        const comment_monolito = document.createComment(data);

        comment.parentNode.insertBefore(comment_monolito, comment.nextSibling);
    })
    .catch(error => {
        console.log(error)
    })

