Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA39C47E4B
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77C361370
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 19:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhGNTsS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237971AbhGNTq4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Jul 2021 15:46:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C714B613F3;
        Wed, 14 Jul 2021 19:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626291777;
        bh=BjACueZrmMy41jSblqDHRPa31XqeZiJocDVJMgODDA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XasX9UmbmfttsLMnKjV1dqeGO6A4F1KuY+4RUxAAAKXRUmxpJSl6N5CeCzpDP5PAF
         m1KxwL1tUUeotVMEKSGAA+VDVP4C/5SQjQ8dOpww0LSjSznjQk6ge9f1QFLwowwD22
         jxafQ/AJmaDbObmQ4qUKddPT+CC2dA6E10+7t5WsfQi/VPMcFYcx4hmre0FzMd1ufr
         v4LZqAaPeir1vuzMBDAlXTDdwQlzJ8KWq5P9vbFIKm0rK54zg8cMOIUja6TRWfvkuL
         H6z7HQP0br0+Pwvpy0TtzU+q4h+kiF8xDFqP62Utq3xKu9adTrmk+AJMNq8kzPQbCJ
         m/Bcj3QFdHDwA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 100/102] s390/traps: do not test MONITOR CALL without CONFIG_BUG
Date:   Wed, 14 Jul 2021 15:40:33 -0400
Message-Id: <20210714194036.53141-100-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714194036.53141-1-sashal@kernel.org>
References: <20210714194036.53141-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit b8e9cc20b808e26329090c19ff80b7f5098e98ff ]

tinyconfig fails to boot, because without CONFIG_BUG report_bug()
always returns BUG_TRAP_TYPE_BUG, which causes mc 0,0 in
test_monitor_call() to panic. Fix by skipping the test without
CONFIG_BUG.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index db7dd59b570c..c1b8d9170ba3 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -276,6 +276,8 @@ static void __init test_monitor_call(void)
 {
 	int val = 1;
 
+	if (!IS_ENABLED(CONFIG_BUG))
+		return;
 	asm volatile(
 		"	mc	0,0\n"
 		"0:	xgr	%0,%0\n"
-- 
2.30.2

