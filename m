Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E84C77B7A
	for <linux-s390@archiver.kernel.org>; Fri, 26 May 2023 11:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbjEZLtT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 May 2023 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbjEZLtK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 May 2023 07:49:10 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9E116;
        Fri, 26 May 2023 04:49:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VjWOl6G_1685101741;
Received: from h68b04305.sqa.eu95.tbsite.net(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VjWOl6G_1685101741)
          by smtp.aliyun-inc.com;
          Fri, 26 May 2023 19:49:04 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] Two fixes for SMCRv2
Date:   Fri, 26 May 2023 19:48:59 +0800
Message-Id: <1685101741-74826-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch set includes two bugfix for SMCRv2.

Wen Gu (2):
  net/smc: Scan from current RMB list when no position specified
  net/smc: Don't use RMBs not mapped to new link in SMCRv2 ADD LINK

 net/smc/smc_llc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
1.8.3.1

