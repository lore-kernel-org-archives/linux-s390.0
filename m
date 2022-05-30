Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B642C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 30 May 2022 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiE3OXk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 May 2022 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241372AbiE3ORc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 May 2022 10:17:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88FB8FF80;
        Mon, 30 May 2022 06:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 599EAB80D83;
        Mon, 30 May 2022 13:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032C6C385B8;
        Mon, 30 May 2022 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918354;
        bh=im+cepvljc7lf1qmxeA/Pg3Q0vGcfHUx4GIwSUU/uJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzsBSTelaO8SpxnC8gajpgTaNjHvDKWEFPH+6b5ZQHaGx4kpksqwMk2vguwMnSzLb
         M7wpGtAvTB1OVT0XzTDx0OleXc+hvyqWCar5etuXX8KKpHJuho+4tyP7AopQ+33D8S
         M5Ul83swS+WuFbTvqdwCy2XZvQi0ezwsaTm7QRuq0Jl2L8ktfogcWSWiudqxCWED+0
         HUSfyeOtXsoXAh4NsTtQkVIwdxCun7cX0KqvlLTMgpcagd7y148093l0RqnMjsay23
         mxuo88lpo5w7VJEmhx7YEQiA3nW2V6On2d0OEJURxq+PC/ZzsjwgG+R7IGst9m5+UD
         xSBf34tQOe0qg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, vschneid@redhat.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 47/76] s390/preempt: disable __preempt_count_add() optimization for PROFILE_ALL_BRANCHES
Date:   Mon, 30 May 2022 09:43:37 -0400
Message-Id: <20220530134406.1934928-47-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530134406.1934928-1-sashal@kernel.org>
References: <20220530134406.1934928-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 63678eecec57fc51b778be3da35a397931287170 ]

gcc 12 does not (always) optimize away code that should only be generated
if parameters are constant and within in a certain range. This depends on
various obscure kernel config options, however in particular
PROFILE_ALL_BRANCHES can trigger this compile error:

In function ‘__atomic_add_const’,
    inlined from ‘__preempt_count_add.part.0’ at ./arch/s390/include/asm/preempt.h:50:3:
./arch/s390/include/asm/atomic_ops.h:80:9: error: impossible constraint in ‘asm’
   80 |         asm volatile(                                                   \
      |         ^~~

Workaround this by simply disabling the optimization for
PROFILE_ALL_BRANCHES, since the kernel will be so slow, that this
optimization won't matter at all.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/preempt.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index b5f545db461a..60e101b8460c 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -46,10 +46,17 @@ static inline bool test_preempt_need_resched(void)
 
 static inline void __preempt_count_add(int val)
 {
-	if (__builtin_constant_p(val) && (val >= -128) && (val <= 127))
-		__atomic_add_const(val, &S390_lowcore.preempt_count);
-	else
-		__atomic_add(val, &S390_lowcore.preempt_count);
+	/*
+	 * With some obscure config options and CONFIG_PROFILE_ALL_BRANCHES
+	 * enabled, gcc 12 fails to handle __builtin_constant_p().
+	 */
+	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES)) {
+		if (__builtin_constant_p(val) && (val >= -128) && (val <= 127)) {
+			__atomic_add_const(val, &S390_lowcore.preempt_count);
+			return;
+		}
+	}
+	__atomic_add(val, &S390_lowcore.preempt_count);
 }
 
 static inline void __preempt_count_sub(int val)
-- 
2.35.1

