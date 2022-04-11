Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D079FC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 11 Apr 2022 08:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbiDKIlD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiDKIlD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Apr 2022 04:41:03 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502A3EAA4;
        Mon, 11 Apr 2022 01:38:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9kop81_1649666325;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0V9kop81_1649666325)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 16:38:45 +0800
Date:   Mon, 11 Apr 2022 16:38:45 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH net 3/3] net/smc: Fix af_ops of child socket pointing to
 released memory
Message-ID: <20220411083845.GA31900@e02h04389.eu6sqa>
Reply-To: "D. Wythe" <alibuda@linux.alibaba.com>
References: <20220408151035.1044701-1-kgraul@linux.ibm.com>
 <20220408151035.1044701-4-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408151035.1044701-4-kgraul@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Apr 08, 2022 at 05:10:35PM +0200, Karsten Graul wrote:
> Child sockets may inherit the af_ops from the parent listen socket.
> When the listen socket is released then the af_ops of the child socket
> points to released memory.
> Solve that by restoring the original af_ops for child sockets which
> inherited the parent af_ops. And clear any inherited user_data of the
> parent socket.
> 
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> ---
>  net/smc/af_smc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index f0d118e9f155..14ddc40149e8 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -121,6 +121,7 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  					  bool *own_req)
>  {
>  	struct smc_sock *smc;
> +	struct sock *child;
>  
>  	smc = smc_clcsock_user_data(sk);
>  
> @@ -134,8 +135,17 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  	}
>  
>  	/* passthrough to original syn recv sock fct */
> -	return smc->ori_af_ops->syn_recv_sock(sk, skb, req, dst, req_unhash,
> -					      own_req);
> +	child = smc->ori_af_ops->syn_recv_sock(sk, skb, req, dst, req_unhash,
> +					       own_req);
> +	/* child must not inherit smc or its ops */
> +	if (child) {
> +		rcu_assign_sk_user_data(child, NULL);
> +
> +		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
> +		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
> +			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
> +	}
> +	return child;
>  
>  drop:
>  	dst_release(dst);
> -- 
> 2.32.0

My bad, LGTM, Thanks for your fix.

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>

