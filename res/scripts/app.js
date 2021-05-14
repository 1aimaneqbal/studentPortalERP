const resultbtn = document.querySelector(".res");
const resultdiv = document.querySelector(".result");

resultbtn.addEventListener("click", () => {
    resultdiv.classList.toggle("openres");
});
function closeRes () {
    resultdiv.classList.toggle("openres");
}
const ldbtn = document.querySelector(".ldb");
const lddiv = document.querySelector(".leader");

ldbtn.addEventListener("click", () => {
    lddiv.classList.toggle("openldb");
});
function closeLead () {
    lddiv.classList.toggle("openldb");
}
const rqbtn = document.querySelector(".rupdt");
const rqdiv = document.querySelector(".update");

rqbtn.addEventListener("click", () => {
    rqdiv.classList.toggle("openreq");
});
function closeReq () {
    rqdiv.classList.toggle("openreq");
}