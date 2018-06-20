From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH net 1/1] net/smc: coordinate wait queues for nonblocking connect
Date: Wed, 20 Jun 2018 15:56:27 -0700
Message-ID: <CAM_iQpV=3wmEBm2OjJ9HSvP=XE_CEs7einMKO3sgTEwvt+8wag@mail.gmail.com>
References: <20180620080737.50323-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180620080737.50323-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, raspl@linux.ibm.com, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jun 20, 2018 at 1:07 AM, Ursula Braun <ubraun@linux.ibm.com> wrote:
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index da7f02edcd37..21c84b924ffb 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -605,6 +605,8 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
>
>         smc_copy_sock_settings_to_clc(smc);
>         tcp_sk(smc->clcsock->sk)->syn_smc = 1;
> +       if (flags & O_NONBLOCK)
> +               sock->sk->sk_wq = smc->clcsock->sk->sk_wq;
>         rc = kernel_connect(smc->clcsock, addr, alen, flags);
>         if (rc)
>                 goto out;
> @@ -1285,12 +1287,9 @@ static __poll_t smc_poll_mask(struct socket *sock, __poll_t events)
>
>         smc = smc_sk(sock->sk);
>         sock_hold(sk);
> -       lock_sock(sk);
>         if ((sk->sk_state == SMC_INIT) || smc->use_fallback) {
>                 /* delegate to CLC child sock */
> -               release_sock(sk);
>                 mask = smc->clcsock->ops->poll_mask(smc->clcsock, events);
> -               lock_sock(sk);
>                 sk->sk_err = smc->clcsock->sk->sk_err;
>                 if (sk->sk_err) {
>                         mask |= EPOLLERR;
> @@ -1299,7 +1298,10 @@ static __poll_t smc_poll_mask(struct socket *sock, __poll_t events)
>                         if (sk->sk_state == SMC_INIT &&
>                             mask & EPOLLOUT &&
>                             smc->clcsock->sk->sk_state != TCP_CLOSE) {
> +                               sock->sk->sk_wq = smc->smcwq;
> +                               lock_sock(sk);

I think you need to use proper RCU API to protect these
assignment of sk->sk_wq.
