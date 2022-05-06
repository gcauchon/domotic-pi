import {Socket} from "phoenix";
import {LiveSocket} from "phoenix_live_view";
import TopBar from "topbar";

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
const liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}});

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket

// Progress bar
window.addEventListener("phx:page-loading-start", (_info) => TopBar.show());
window.addEventListener("phx:page-loading-stop", (_info) => TopBar.hide());
