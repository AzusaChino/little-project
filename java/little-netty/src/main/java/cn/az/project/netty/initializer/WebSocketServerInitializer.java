package cn.az.project.netty.initializer;

import cn.az.project.netty.handler.WebSocketChannelHandler;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.socket.SocketChannel;
import io.netty.handler.codec.http.HttpObjectAggregator;
import io.netty.handler.codec.http.HttpServerCodec;
import io.netty.handler.codec.http.websocketx.WebSocketServerProtocolHandler;
import io.netty.handler.stream.ChunkedWriteHandler;

/**
 * @author az
 */
public class WebSocketServerInitializer extends ChannelInitializer<SocketChannel> {


    @Override
    protected void initChannel(SocketChannel socketChannel) {
        ChannelPipeline cp = socketChannel.pipeline();

        // websocket based on http
        cp.addLast(new HttpServerCodec());

        // support for big data write
        cp.addLast(new ChunkedWriteHandler());

        // aggregate http message -> FullHttpRequest/FullHttpResponse
        cp.addLast(new HttpObjectAggregator(1024 * 64));

        // websocket server protocol | route:/ws
        // helps deal with hand shaking
        // for web socket, data transferred by frames
        cp.addLast(new WebSocketServerProtocolHandler("/ws"));

        cp.addLast(new WebSocketChannelHandler());
    }
}
