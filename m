Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898A2C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 30 May 2022 14:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiE3OXk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 May 2022 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiE3OSr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 May 2022 10:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD61207DA;
        Mon, 30 May 2022 06:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3122160F14;
        Mon, 30 May 2022 13:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE54C36AE7;
        Mon, 30 May 2022 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918515;
        bh=1oaoX4ok9yeMVtkHfkvusLYM5Kis7pHtPy11PUfzcqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZr5hZZkwh1MBLbeC5nBcAe+Vdj/LdnYJi3bVQNkzZEeLgvLa1Ko2jWT11JSSZq9V
         9LIUJx+d46Fwr7rSejc+cdBw/t6ib5kX8sB0xqoVY+0/4/8O2t14GcbovPpU4Qky/I
         GNFqR3p+uCdOl/Vu/NLc3IcnL3iAgbfAqV9+b76cfQI5jgpk2PhVjdth4d0Jw5Nyn9
         bYW158sW0pAuHHFbNzX8lNBdcWyLfbBEJT22//9Z0b+cEYs8hnMAGJW/U+Gg37+TbC
         At/D05VAjXXBo0X9bLpLIw5nR7ON0Xyuktsm3L1naIw+5aHos1CXDXUOnSIEzVEhcA
         +DOTO2DMXd5CQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, vschneid@redhat.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 35/55] s390/preempt: disable __preempt_count_add() optimization for PROFILE_ALL_BRANCHES
Date:   Mon, 30 May 2022 09:46:41 -0400
Message-Id: <20220530134701.1935933-35-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530134701.1935933-1-sashal@kernel.org>
References: <20220530134701.1935933-1-sashal@kernel.org>
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
index b5ea9e14c017..3dcd8ab3db73 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -52,10 +52,17 @@ static inline bool test_preempt_need_resched(void)
 
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

