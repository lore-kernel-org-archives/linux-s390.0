Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA0CC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 28 Mar 2022 09:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiC1JF5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Mar 2022 05:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbiC1JF4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Mar 2022 05:05:56 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B98B63CD;
        Mon, 28 Mar 2022 02:04:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V8Q3eBj_1648458252;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0V8Q3eBj_1648458252)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 17:04:12 +0800
Date:   Mon, 28 Mar 2022 17:04:11 +0800
From:   "dust.li" <dust.li@linux.alibaba.com>
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: Send out the remaining data in sndbuf
 before close
Message-ID: <20220328090411.GI35207@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1648447836-111521-1-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648447836-111521-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Mar 28, 2022 at 02:10:36PM +0800, Wen Gu wrote:
>The current autocork algorithms will delay the data transmission
>in BH context to smc_release_cb() when sock_lock is hold by user.
>
>So there is a possibility that when connection is being actively
>closed (sock_lock is hold by user now), some corked data still
>remains in sndbuf, waiting to be sent by smc_release_cb(). This
>will cause:
>
>- smc_close_stream_wait(), which is called under the sock_lock,
>  has a high probability of timeout because data transmission is
>  delayed until sock_lock is released.
>
>- Unexpected data sends may happen after connction closed and use
>  the rtoken which has been deleted by remote peer through
>  LLC_DELETE_RKEY messages.
>
>So this patch will try to send out the remaining corked data in
>sndbuf before active close process, to ensure data integrity and
>avoid unexpected data transmission after close.

I think this issue should also happen if TCP_CORK is set and
autocorking is not enabled ?

Autocorking and delaying the TX from BH to smc_release_cb() greatly
increased the probability of this problem.

>
>Reported-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>Fixes: 6b88af839d20 ("net/smc: don't send in the BH context if sock_owned_by_user")
>Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>---
> net/smc/smc_close.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>index 292e4d9..676cb23 100644
>--- a/net/smc/smc_close.c
>+++ b/net/smc/smc_close.c
>@@ -57,6 +57,9 @@ static void smc_close_stream_wait(struct smc_sock *smc, long timeout)
> 	if (!smc_tx_prepared_sends(&smc->conn))
> 		return;
> 
>+	/* Send out corked data remaining in sndbuf */
>+	smc_tx_pending(&smc->conn);
>+
> 	smc->wait_close_tx_prepared = 1;
> 	add_wait_queue(sk_sleep(sk), &wait);
> 	while (!signal_pending(current) && timeout) {
>-- 
>1.8.3.1
