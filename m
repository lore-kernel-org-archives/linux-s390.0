Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80996C433F5
	for <linux-s390@archiver.kernel.org>; Sat, 19 Feb 2022 07:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiBSHFz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 19 Feb 2022 02:05:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBSHFy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 19 Feb 2022 02:05:54 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB61256ED8;
        Fri, 18 Feb 2022 23:05:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4sb8o._1645254330;
Received: from 192.168.1.102(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0V4sb8o._1645254330)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Feb 2022 15:05:31 +0800
Message-ID: <89147077-fadc-e5fc-ce91-0f3d4403c5f2@linux.alibaba.com>
Date:   Sat, 19 Feb 2022 15:05:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH net-next] net/smc: unlock on error paths in
 __smc_setsockopt()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Karsten Graul <kgraul@linux.ibm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20220218153259.GA4392@kili>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20220218153259.GA4392@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



在 2022/2/18 下午11:32, Dan Carpenter 写道:
> These two error paths need to release_sock(sk) before returning.
> 
> Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by socket options")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   net/smc/af_smc.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d873afe2d4dc..38faf2b60327 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2715,10 +2715,14 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
>   	lock_sock(sk);
>   	switch (optname) {
>   	case SMC_LIMIT_HS:
> -		if (optlen < sizeof(int))
> -			return -EINVAL;
> -		if (copy_from_sockptr(&val, optval, sizeof(int)))
> -			return -EFAULT;
> +		if (optlen < sizeof(int)) {
> +			rc = -EINVAL;
> +			break;
> +		}
> +		if (copy_from_sockptr(&val, optval, sizeof(int))) {
> +			rc = -EFAULT;
> +			break;
> +		}
>   
>   		smc->limit_smc_hs = !!val;
>   		rc = 0;

My mistake... thanks for your fixes.

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
