Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385DBC4332F
	for <linux-s390@archiver.kernel.org>; Thu,  2 Nov 2023 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjKBOya (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Nov 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjKBOy3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Nov 2023 10:54:29 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F30A13D;
        Thu,  2 Nov 2023 07:54:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VvWTSr._1698936858;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VvWTSr._1698936858)
          by smtp.aliyun-inc.com;
          Thu, 02 Nov 2023 22:54:19 +0800
Date:   Thu, 2 Nov 2023 22:54:18 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Li RongQing <lirongqing@baidu.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path
 when possible
Message-ID: <20231102145418.GH92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231102092712.30793-1-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102092712.30793-1-lirongqing@baidu.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 02, 2023 at 05:27:12PM +0800, Li RongQing wrote:
>these is less opportunity that conn->tx_pushing is not 1, since

these -> there ?

>tx_pushing is just checked with 1, so move the setting tx_pushing
>to 1 after atomic_dec_and_test() return false, to avoid atomic_set
>and smp_wmb in tx path when possible

The patch should add [PATCH net-next] subject-prefix since this is an optimization.

Besides, do you have any performance number ?

Thanks

>
>Signed-off-by: Li RongQing <lirongqing@baidu.com>
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
> 		goto again;
>+	}
> 
> 	return rc;
> }
>-- 
>2.9.4
