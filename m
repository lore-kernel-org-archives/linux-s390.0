Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D854AC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 30 May 2022 14:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiE3O24 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 May 2022 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbiE3OXE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 May 2022 10:23:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F24A7761;
        Mon, 30 May 2022 06:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFCC4B80DBB;
        Mon, 30 May 2022 13:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499A7C385B8;
        Mon, 30 May 2022 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918627;
        bh=o5pO4LCMS5/b+2fU+WThBdm9r/1xafoD8Nszr9ODGqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yj2CmD1LXJHN63k0jRs+fjGbEuCwVmBf93bEssnR6Ul6W3L9zCuwadmXNYCR3xscH
         zq5UupCt25H4GMqHN3A59Gx8GGzUvHajPQTTpsTQnoBQaREgdOfP0poGo2//RXcJvR
         QgaMctGVIPtZY9CfyNpoIX/3dV4SOn1SV2TeLDXmzSq4yNxi1ydhmxLAvBPFNxtEZk
         tyYAJr0aMNPq/gCjoKsDjD+2LpkL4fK8k6HRBHwc84jlBWoD25pBmyysZzQ8c3cJtn
         ZiP4sSfWnlSExsz/qCf5SxEKZKbb5BhjLkNU7/++8T35uFJizh0As9q4G4xoohsTpD
         Ed9Y0hrMmzSXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, vschneid@redhat.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 25/38] s390/preempt: disable __preempt_count_add() optimization for PROFILE_ALL_BRANCHES
Date:   Mon, 30 May 2022 09:49:11 -0400
Message-Id: <20220530134924.1936816-25-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530134924.1936816-1-sashal@kernel.org>
References: <20220530134924.1936816-1-sashal@kernel.org>
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
index 23a14d187fb1..1aebf09fbcd8 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -50,10 +50,17 @@ static inline bool test_preempt_need_resched(void)
 
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

