Return-Path: <netdev-owner@vger.kernel.org>
Subject: Re: [PATCH net-next 1/1] net/ipv4: disable SMC TCP option with SYN
 Cookies
References: <20180320155340.18017-1-ubraun@linux.vnet.ibm.com>
 <20180320155340.18017-2-ubraun@linux.vnet.ibm.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <435f82d0-407e-6675-194a-102d83f418f8@gmail.com>
Date: Tue, 20 Mar 2018 09:21:32 -0700
MIME-Version: 1.0
In-Reply-To: <20180320155340.18017-2-ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <ubraun@linux.vnet.ibm.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 03/20/2018 08:53 AM, Ursula Braun wrote:
> From: Hans Wippel <hwippel@linux.vnet.ibm.com>
> 
> Currently, the SMC experimental TCP option in a SYN packet is lost on
> the server side when SYN Cookies are active. However, the corresponding
> SYNACK sent back to the client contains the SMC option. This causes an
> inconsistent view of the SMC capabilities on the client and server.
> 
> This patch disables the SMC option in the SYNACK when SYN Cookies are
> active to avoid this issue.
> 
> Signed-off-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
> ---
>  net/ipv4/tcp_output.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 383cac0ff0ec..22894514feae 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3199,6 +3199,8 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
>  		/* Under synflood, we do not attach skb to a socket,
>  		 * to avoid false sharing.
>  		 */
> +		if (IS_ENABLED(CONFIG_SMC))
> +			ireq->smc_ok = 0;
>  		break;
>  	case TCP_SYNACK_FASTOPEN:
>  		/* sk is a const pointer, because we want to express multiple
> 

I disagree with net-next qualification.

This fixes a bug, so please send it for net tree, and including an appropriate Fixes: tag.

Thanks !
