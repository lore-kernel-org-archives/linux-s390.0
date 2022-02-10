Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E018C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 10 Feb 2022 02:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiBJCuJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:50:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBJCuJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Feb 2022 21:50:09 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793EA240A4;
        Wed,  9 Feb 2022 18:50:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V41xdUo_1644461407;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0V41xdUo_1644461407)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Feb 2022 10:50:07 +0800
Date:   Thu, 10 Feb 2022 10:50:06 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: Avoid overwriting the copies of clcsock
 callback functions
Message-ID: <YgR9XrT8cATDP4Zx@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <1644415853-46641-1-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644415853-46641-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 09, 2022 at 10:10:53PM +0800, Wen Gu wrote:
> The callback functions of clcsock will be saved and replaced during
> the fallback. But if the fallback happens more than once, then the
> copies of these callback functions will be overwritten incorrectly,
> resulting in a loop call issue:
> 
> clcsk->sk_error_report
>  |- smc_fback_error_report() <------------------------------|
>      |- smc_fback_forward_wakeup()                          | (loop)
>          |- clcsock_callback()  (incorrectly overwritten)   |
>              |- smc->clcsk_error_report() ------------------|
> 
> So this patch fixes the issue by saving these function pointers only
> once in the fallback and avoiding overwriting.
> 
> Reported-by: syzbot+4de3c0e8a263e1e499bc@syzkaller.appspotmail.com
> Fixes: 341adeec9ada ("net/smc: Forward wakeup to smc socket waitqueue after fallback")
> Link: https://lore.kernel.org/r/0000000000006d045e05d78776f6@google.com
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/af_smc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 8c89d0b..306d9e8c 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -667,14 +667,17 @@ static void smc_fback_error_report(struct sock *clcsk)
>  static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
>  {
>  	struct sock *clcsk;
> +	int rc = 0;
>  
>  	mutex_lock(&smc->clcsock_release_lock);
>  	if (!smc->clcsock) {
> -		mutex_unlock(&smc->clcsock_release_lock);
> -		return -EBADF;
> +		rc = -EBADF;
> +		goto out;
>  	}
>  	clcsk = smc->clcsock->sk;
>  
> +	if (smc->use_fallback)
> +		goto out;
>  	smc->use_fallback = true;

I am wondering that there is a potential racing. If ->use_fallback is
setted to true, but the rest of replacing process is on the way, others
who tested and passed ->use_fallback, they would get old value before
replacing.

Thanks,
Tony Lu
