From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [patch 1/2] af_iucv: fix recvmsg by replacing skb_pull()
 function
Date: Mon, 08 Apr 2013 13:16:32 -0700
Message-ID: <1365452192.3887.39.camel@edumazet-glaptop>
References: <20130408081925.995757091@de.ibm.com>
	 <20130408082003.666955316@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20130408082003.666955316@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2013-04-08 at 10:19 +0200, frank.blaschka@de.ibm.com wrote:
> plain text document attachment (601-af-iucv-skb-pull.diff)
> From: Ursula Braun <ursula.braun@de.ibm.com>
> 
> When receiving data messages, the "BUG_ON(skb->len < skb->data_len)" in
> the skb_pull() function triggers a kernel panic.
> 
> Replace the skb_pull logic by a per skb offset as advised by
> Eric Dumazet.
> 
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
> Signed-off-by: Frank Blaschka <blaschka@linux.vnet.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---

This is indeed a nicer patch ;)

Acked-by: Eric Dumazet <edumazet@google.com>
