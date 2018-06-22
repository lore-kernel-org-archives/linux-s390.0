From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH net V2 1/1] net/smc: coordinate wait queues for
 nonblocking connect
Date: Thu, 21 Jun 2018 19:12:05 -0700
Message-ID: <CAM_iQpVXEQ7yo-zopuZiwsx+3xYWTMzY-xwxOU0qysBz_y-4pw@mail.gmail.com>
References: <20180621142318.72681-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180621142318.72681-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, raspl@linux.ibm.com, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jun 21, 2018 at 7:23 AM, Ursula Braun <ubraun@linux.ibm.com> wrote:
> @@ -605,6 +606,13 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
>
>         smc_copy_sock_settings_to_clc(smc);
>         tcp_sk(smc->clcsock->sk)->syn_smc = 1;
> +       if (flags & O_NONBLOCK) {
> +               rcu_read_lock();
> +               smc->smcwq = rcu_dereference(sk->sk_wq);
> +               rcu_assign_pointer(sock->sk->sk_wq,
> +                                  rcu_dereference(smc->clcsock->sk->sk_wq));
> +               rcu_read_unlock();

Are you really deref'ing any RCU pointer here?
