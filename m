Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14FC433EF
	for <linux-s390@archiver.kernel.org>; Mon,  9 May 2022 11:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiEIMCl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 May 2022 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiEIMCl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 May 2022 08:02:41 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915FF27FE2;
        Mon,  9 May 2022 04:58:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VClEqzf_1652097524;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VClEqzf_1652097524)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 19:58:45 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net/smc: two fixes for using smc with io_uring
Date:   Mon,  9 May 2022 19:58:35 +0800
Message-Id: <20220509115837.94911-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch set includes two fixes for using smc with io_uring.

Guangguan Wang (2):
  net/smc: non blocking recvmsg() return -EAGAIN when no data and
    signal_pending
  net/smc: align the connect behaviour with TCP

 net/smc/af_smc.c | 53 ++++++++++++++++++++++++++++++++++++++++++++----
 net/smc/smc_rx.c |  4 ++--
 2 files changed, 51 insertions(+), 6 deletions(-)

-- 
2.24.3 (Apple Git-128)

