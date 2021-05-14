
const notifbtn = document.querySelector(".count");
const notifdiv = document.querySelector(".notifcontainer");

notifbtn.addEventListener("click", () => {
    notifdiv.classList.toggle("open");
});
function closenotif () {
    notifdiv.classList.toggle("open");
}