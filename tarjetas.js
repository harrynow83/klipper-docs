const cardsData = [
    {
        title: "Tarjeta 1",
        description: "Descripción de la primera tarjeta.",
        image: "https://picsum.photos/400/300?random=1"
    },
    {
        title: "Tarjeta 2",
        description: "Descripción de la segunda tarjeta.",
        image: "https://picsum.photos/400/300?random=2"
    },
    {
        title: "Tarjeta 3",
        description: "Descripción de la tercera tarjeta.",
        image: "https://picsum.photos/400/300?random=3"
    },
    {
        title: "Tarjeta 4",
        description: "Descripción de la cuarta tarjeta.",
        image: "https://picsum.photos/400/300?random=4"
    }
];

const container = document.getElementById("cardContainer");

cardsData.forEach(card => {
    const cardElement = document.createElement("div");
    cardElement.classList.add("card");

    cardElement.innerHTML = `
        <img src="${card.image}" alt="${card.title}">
        <div class="card-content">
            <h3>${card.title}</h3>
            <p>${card.description}</p>
        </div>
    `;

    container.appendChild(cardElement);
});

