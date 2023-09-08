Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE7EE14C3
	for <linux-s390@archiver.kernel.org>; Fri,  8 Sep 2023 03:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjIHDcE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Sep 2023 23:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjIHDcD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Sep 2023 23:32:03 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73471BD8;
        Thu,  7 Sep 2023 20:31:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vrb2bY9_1694143914;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vrb2bY9_1694143914)
          by smtp.aliyun-inc.com;
          Fri, 08 Sep 2023 11:31:55 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] Two fixes for SMC-R
Date:   Fri,  8 Sep 2023 11:31:41 +0800
Message-Id: <20230908033143.89489-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Two fixes for SMC-R.

Guangguan Wang (2):
  net/smc: bugfix for smcr v2 server connect success statistic
  net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in
    smcr_port_add

 net/smc/smc_core.c  | 2 ++
 net/smc/smc_stats.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.24.3 (Apple Git-128)

