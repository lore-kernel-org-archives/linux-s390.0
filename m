From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: Re: [net-next,v2,2/4] net/smc: ipv6 support for smc_diag.c
Date: Sun, 7 Oct 2018 03:11:52 +0200
Message-ID: <20181007011152.GA11112@asgard.redhat.com>
References: <20180502145647.36147-3-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502145647.36147-3-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 02, 2018 at 04:56:45PM +0200, Ursula Braun wrote:
> From: Karsten Graul <kgraul@linux.ibm.com>
> 
> Update smc_diag.c to support ipv6 addresses on the diagnosis interface.
> 
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> ---
>  net/smc/smc_diag.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index 427b91c1c964..05dd7e6d314d 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -38,17 +38,27 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
>  {
>  	struct smc_sock *smc = smc_sk(sk);
>  
> -	r->diag_family = sk->sk_family;
>  	if (!smc->clcsock)
>  		return;
>  	r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
>  	r->id.idiag_dport = smc->clcsock->sk->sk_dport;
>  	r->id.idiag_if = smc->clcsock->sk->sk_bound_dev_if;
>  	sock_diag_save_cookie(sk, r->id.idiag_cookie);
> -	memset(&r->id.idiag_src, 0, sizeof(r->id.idiag_src));
> -	memset(&r->id.idiag_dst, 0, sizeof(r->id.idiag_dst));
> -	r->id.idiag_src[0] = smc->clcsock->sk->sk_rcv_saddr;
> -	r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
> +	if (sk->sk_protocol == SMCPROTO_SMC) {
> +		r->diag_family = PF_INET;
> +		memset(&r->id.idiag_src, 0, sizeof(r->id.idiag_src));
> +		memset(&r->id.idiag_dst, 0, sizeof(r->id.idiag_dst));
> +		r->id.idiag_src[0] = smc->clcsock->sk->sk_rcv_saddr;
> +		r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	} else if (sk->sk_protocol == SMCPROTO_SMC6) {
> +		r->diag_family = PF_INET6;
> +		memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_saddr,
> +		       sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
> +		memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
> +		       sizeof(smc->clcsock->sk->sk_v6_daddr));
> +#endif
> +	}

This change makes it impossible to distinguish an inet_sock_diag
response message from SMC sock_diag response (previously it reported
AF_SMC in diag_family which allows deciding whether that a part of
struct smc_diag_msg or struct inet_diag_msg).
