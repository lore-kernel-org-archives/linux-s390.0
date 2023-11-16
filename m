Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6050AC54FB9
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 06:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjKPGST (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 01:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPGSS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 01:18:18 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108519F;
        Wed, 15 Nov 2023 22:18:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VwV9lei_1700115491;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VwV9lei_1700115491)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 14:18:12 +0800
Date:   Thu, 16 Nov 2023 14:18:11 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Li RongQing <lirongqing@baidu.com>, wenjia@linux.ibm.co,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Message-ID: <20231116061811.GC121324@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231116022041.51959-1-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116022041.51959-1-lirongqing@baidu.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 16, 2023 at 10:20:41AM +0800, Li RongQing wrote:
>there is rare possibility that conn->tx_pushing is not 1, since
>tx_pushing is just checked with 1, so move the setting tx_pushing
>to 1 after atomic_dec_and_test() return false, to avoid atomic_set
>and smp_wmb in tx path
>
>Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/smc_tx.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
>index 3b0ff3b..72dbdee 100644
>--- a/net/smc/smc_tx.c
>+++ b/net/smc/smc_tx.c
>@@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
> 		return 0;
> 
> again:
>-	atomic_set(&conn->tx_pushing, 1);
>-	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
> 	rc = __smc_tx_sndbuf_nonempty(conn);
> 
> 	/* We need to check whether someone else have added some data into
>@@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
> 	 * If so, we need to push again to prevent those data hang in the send
> 	 * queue.
> 	 */
>-	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
>+	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
>+		atomic_set(&conn->tx_pushing, 1);
>+		smp_wmb(); /* Make sure tx_pushing is 1 before real send */
nit: it would be better if we change the comments to "send again".

Thanks
> 		goto again;
>+	}
> 
> 	return rc;
> }
>-- 
>2.9.4
