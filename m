From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/ipv4: fix tcp_poll for SMC fallback
Date: Thu, 18 Oct 2018 11:22:04 -0700 (PDT)
Message-ID: <20181018.112204.1468321456234076481.davem@davemloft.net>
References: <20181016144554.49660-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181016144554.49660-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, ubraun@linux.ibm.com, hch@lst.de, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Tue, 16 Oct 2018 16:45:54 +0200

> Commit dd979b4df817 ("net: simplify sock_poll_wait") breaks tcp_poll for 
> SMC fallback: An AF_SMC socket establishes an internal TCP socket for the 
> CLC handshake with the remote peer. Whenever the SMC connection can not be 
> established this CLC socket is used as a fallback. All socket operations on the 
> SMC socket are then forwarded to the CLC socket. In case of poll, the 
> file->private_data pointer references the SMC socket because the CLC socket has 
> no file assigned. This causes tcp_poll to wait on the wrong socket.
> 
> This patch fixes the issue by (re)introducing a sock_poll_wait variant with 
> a socket parameter, and let tcp_poll use this variant.
> 
> Fixes: dd979b4df817 ("net: simplify sock_poll_wait")
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Generally speaking, if the invariant of filp->private_data == sock
does not actually hold true universally, I'd rather revert the
simplifications and add a big comment to sock_poll_wait() explaining
this.

Thank you.
