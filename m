From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] af_iucv: fix AF_IUCV sendmsg() errno
Date: Tue, 31 Mar 2015 16:07:32 -0400 (EDT)
Message-ID: <20150331.160732.1671403715519775179.davem@davemloft.net>
References: <1427722842-49894-1-git-send-email-ubraun@linux.vnet.ibm.com>
	<1427722842-49894-2-git-send-email-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1427722842-49894-2-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, Eugene.Crosser@ru.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Mon, 30 Mar 2015 15:40:42 +0200

> From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
> 
> When sending over AF_IUCV socket, errno was incorrectly set to
> ENOMEM even when other values where appropriate, notably EAGAIN.
> With this patch, error indicator returned by sock_alloc_send_skb()
> is passed to the caller, rather than being overwritten with ENOMEM.
> 
> Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>

Applied, thanks.
