Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD67C433E6
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 02:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6E964E7C
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 02:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhCCCUH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349147AbhCBM3J (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Mar 2021 07:29:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B65F764FCB;
        Tue,  2 Mar 2021 11:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686373;
        bh=HAHCf/VyvL/BDirKz3srbwwm7Y/wDsom2wujpSsazBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxNhDG3vFrESELPocy4WPZN6cFIFbifCnlvM4f0PZXLuaPP1M/bIZk2lp/X1vgcGS
         wtMD5LiX4Wb27tCRYaAV0qcRZU+Bsx/s3S1DteROFLvMxgwtideR/SrXe2Xwb9RKbv
         ZVHIiMJAotDmtveVSDKX9UUwcZCLAY54D0gFffW8RFlM923UkwrIsuL5X2ese2jmi8
         hchle1TrDbA3lyyB0Di3KgUGPkqjx7/RVv6XBFk1fg1mnh/eAbLsDk0Ig/bCEy1TsS
         jY8jjSgmfQUDEOlVs5Ao15uclyRqqx8XxsswPF6H4v3HMkjSkG04q3kuvSNNclByIG
         54qmq2XO5kkNA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/10] s390/smp: __smp_rescan_cpus() - move cpumask away from stack
Date:   Tue,  2 Mar 2021 06:59:20 -0500
Message-Id: <20210302115921.63636-9-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115921.63636-1-sashal@kernel.org>
References: <20210302115921.63636-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 62c8dca9e194326802b43c60763f856d782b225c ]

Avoid a potentially large stack frame and overflow by making
"cpumask_t avail" a static variable. There is no concurrent
access due to the existing locking.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index cba8e56cd63d..54eb8fe95212 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -727,7 +727,7 @@ static int smp_add_core(struct sclp_core_entry *core, cpumask_t *avail,
 static int __smp_rescan_cpus(struct sclp_core_info *info, bool early)
 {
 	struct sclp_core_entry *core;
-	cpumask_t avail;
+	static cpumask_t avail;
 	bool configured;
 	u16 core_id;
 	int nr, i;
-- 
2.30.1

