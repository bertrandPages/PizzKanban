package pizzkanban;

import org.atmosphere.cpr.AtmosphereResource;
import org.atmosphere.cpr.Broadcaster;
import org.atmosphere.cpr.BroadcasterFactory;
import org.atmosphere.websocket.WebSocket;
import org.atmosphere.websocket.WebSocketEventListenerAdapter;
import org.atmosphere.websocket.WebSocketHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Stephane Maldini <smaldini@doc4web.com>
 * @version 1.0
 * @file
 * @date 10/05/12
 * @section DESCRIPTION
 * <p/>
 * [Does stuff]
 */
public class PizzaSocketHandler extends WebSocketHandler {

    private static final Logger logger = LoggerFactory.getLogger(PizzaSocketHandler.class);

    @Override
    public void onTextMessage(WebSocket webSocket, String message) {
        AtmosphereResource r = webSocket.resource();
        Broadcaster b = lookupBroadcaster(r.getRequest().getPathInfo());

        if (message != null && message.indexOf("message") != -1) {
            b.broadcast(message.substring("message=".length()));
        }
    }

    @Override
    public void onOpen(WebSocket webSocket) {
        // Accept the handshake by suspending the response.
        AtmosphereResource r = webSocket.resource();
        // Create a Broadcaster based on the path
        Broadcaster b = lookupBroadcaster(r.getRequest().getPathInfo());
        r.setBroadcaster(b);
        r.addEventListener(new WebSocketEventListenerAdapter());
        r.suspend(-1);
    }

    /**
     * Retrieve the {@link Broadcaster} based on the request's path info.
     *
     * @param pathInfo
     * @return the {@link Broadcaster} based on the request's path info.
     */
    Broadcaster lookupBroadcaster(String pathInfo) {
        String[] decodedPath = pathInfo.split("/");
        Broadcaster b = BroadcasterFactory.getDefault().lookup(decodedPath[decodedPath.length - 1], true);
        return b;
    }
}
