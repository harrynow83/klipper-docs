const cardsData = [
    {
        title: "Tarjeta 1",
        description: "Descripción de la primera tarjeta.",
        image: "img/kiauh.png",
        link: "detalle1.html"
    },
    {
        title: "Tarjeta 2",
        description: "Descripción de la segunda tarjeta.",
        image: "img/kiauh.png",
        link: "detalle2.html"
    },
    {
        title: "Tarjeta 3",
        description: "Descripción de la tercera tarjeta.",
        image: "img/mellow-compile.png",
        link: "https://www.google.com"
    },
    {
        title: "Tarjeta 4",
        description: "Descripción de la cuarta tarjeta.",
        image: "img/pi-zero.jpg",
        link: "#"
    }
];

const container = document.getElementById("cardContainer");

cardsData.forEach(card => {
    const link = document.createElement("a");
    link.href = card.link;
    link.classList.add("card-link");

    const cardElement = document.createElement("div");
    cardElement.classList.add("card");

    cardElement.innerHTML = `
        <img src="${card.image}" alt="${card.title}" loading="lazy">
        <div class="card-content">
            <h3>${card.title}</h3>
            <p>${card.description}</p>
        </div>
    `;

    link.appendChild(cardElement);
    container.appendChild(link);
});
