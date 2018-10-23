From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] Revert "net: simplify sock_poll_wait"
Date: Tue, 23 Oct 2018 10:57:36 -0700 (PDT)
Message-ID: <20181023.105736.1045050740571467220.davem@davemloft.net>
References: <20181023114039.56959-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181023114039.56959-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, hch@lst.de, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Tue, 23 Oct 2018 13:40:39 +0200

> This reverts commit dd979b4df817e9976f18fb6f9d134d6bc4a3c317.
> 
> This broke tcp_poll for SMC fallback: An AF_SMC socket establishes an
> internal TCP socket for the initial handshake with the remote peer.
> Whenever the SMC connection can not be established this TCP socket is
> used as a fallback. All socket operations on the SMC socket are then
> forwarded to the TCP socket. In case of poll, the file->private_data
> pointer references the SMC socket because the TCP socket has no file
> assigned. This causes tcp_poll to wait on the wrong socket.
> 
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied and queued up for -stable, thank you.
