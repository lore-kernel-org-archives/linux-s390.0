From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: Re: [net-next,v2,2/4] net/smc: ipv6 support for smc_diag.c
Date: Sat, 13 Oct 2018 05:45:30 +0200
Message-ID: <20181013034530.GH21972@asgard.redhat.com>
References: <20180502145647.36147-3-ubraun@linux.ibm.com>
 <20181007011152.GA11112@asgard.redhat.com>
 <3cb67163-53c6-dd63-71b6-d34581918708@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3cb67163-53c6-dd63-71b6-d34581918708@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 09, 2018 at 04:41:43PM +0200, Ursula Braun wrote:
> Eugene,
> 
> we are considering the following patch:
> 
> ---
>  net/smc/smc_diag.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index dbf64a93d68a..371b4cf31fcd 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -38,6 +38,7 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
>  {
>  	struct smc_sock *smc = smc_sk(sk);
>  
> +	r->diag_family = sk->sk_family;
>  	if (!smc->clcsock)
>  		return;
>  	r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
> @@ -45,14 +46,12 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
>  	r->id.idiag_if = smc->clcsock->sk->sk_bound_dev_if;
>  	sock_diag_save_cookie(sk, r->id.idiag_cookie);
>  	if (sk->sk_protocol == SMCPROTO_SMC) {
> -		r->diag_family = PF_INET;
>  		memset(&r->id.idiag_src, 0, sizeof(r->id.idiag_src));
>  		memset(&r->id.idiag_dst, 0, sizeof(r->id.idiag_dst));
>  		r->id.idiag_src[0] = smc->clcsock->sk->sk_rcv_saddr;
>  		r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	} else if (sk->sk_protocol == SMCPROTO_SMC6) {
> -		r->diag_family = PF_INET6;
>  		memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_saddr,
>  		       sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
>  		memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
> --
> 
> Tools would then need to derive the PF_INET/PF_INET6 info from the inet_diag_sockid info
> in the smc_diag_msg.

Unfortunately, struct inet_diag_sockid doesn't provide any clue
in order to derive address family.

There's unused (if I haven't missed anything) diag_shutdown field
in struct smc_diag_msg (it looks like that the shutdown state is
reported via a separate attribute in the current implementation),
it probably might be repurposed for providing information about
the underlying socket address family.

> However, this problem is in the mainline kernel since 4.18. So, we are not sure if we are allowed
> to change the user interface again.

Well, anything is better that the current state.
