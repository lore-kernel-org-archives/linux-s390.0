Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B8C11F68
	for <linux-s390@archiver.kernel.org>; Sat, 10 Jul 2021 02:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F13B613C5
	for <linux-s390@archiver.kernel.org>; Sat, 10 Jul 2021 02:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhGJCfd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Jul 2021 22:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234892AbhGJCeX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 9 Jul 2021 22:34:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B5EB613CC;
        Sat, 10 Jul 2021 02:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625884298;
        bh=mgudEMBHGEz15OedNNtUSAC+tW05dczxAYbP9/Nk0ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yx/3bIMlBk/zj6to9I3KzaYkcmyVNHJH5+vXhCHL0GvLcR3PEx14r6voUAcuIsIde
         cSwjYX7sdu2j3FBtr4hJs/SCg5SpnfU/F/I2JFtxYLLitW4KQYsmRJWujWEv6uaZwE
         ffqn7a5Bq/UAifEJWx3vM6fWtSGFO3LeIXnhg6Ycer/aHgK0XCILGxRC84T2XrllIi
         80RvREKQtFoxjmugkjbQg9sr6QRcA9693VGjKZ64jXDEc454VBM/p5nAngjjzUQkbo
         e0ZB1EF+kWHeL7swoFrnZ8honbwQDB022PbN1WrmC7Jd1JQIQa0Y46X2QcySZaGXHg
         hZf4tBlYQfVuQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 44/63] s390/ipl_parm: fix program check new psw handling
Date:   Fri,  9 Jul 2021 22:26:50 -0400
Message-Id: <20210710022709.3170675-44-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022709.3170675-1-sashal@kernel.org>
References: <20210710022709.3170675-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 88c2510cecb7e2b518e3c4fdf3cf0e13ebe9377c ]

The __diag308() inline asm temporarily changes the program check new
psw to redirect a potential program check on the diag instruction.
Restoring of the program check new psw is done in C code behind the
inline asm.

This can be problematic, especially if the function is inlined, since
the compiler can reorder instructions in such a way that a different
instruction, which may result in a program check, might be executed
before the program check new psw has been restored.

To avoid such a scenario move restoring into the inline asm. For
consistency reasons move also saving of the original program check new
psw into the inline asm.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/ipl_parm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 24ef67eb1cef..75905b548f69 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -27,22 +27,25 @@ static inline int __diag308(unsigned long subcode, void *addr)
 	register unsigned long _addr asm("0") = (unsigned long)addr;
 	register unsigned long _rc asm("1") = 0;
 	unsigned long reg1, reg2;
-	psw_t old = S390_lowcore.program_new_psw;
+	psw_t old;
 
 	asm volatile(
+		"	mvc	0(16,%[psw_old]),0(%[psw_pgm])\n"
 		"	epsw	%0,%1\n"
-		"	st	%0,%[psw_pgm]\n"
-		"	st	%1,%[psw_pgm]+4\n"
+		"	st	%0,0(%[psw_pgm])\n"
+		"	st	%1,4(%[psw_pgm])\n"
 		"	larl	%0,1f\n"
-		"	stg	%0,%[psw_pgm]+8\n"
+		"	stg	%0,8(%[psw_pgm])\n"
 		"	diag	%[addr],%[subcode],0x308\n"
-		"1:	nopr	%%r7\n"
+		"1:	mvc	0(16,%[psw_pgm]),0(%[psw_old])\n"
 		: "=&d" (reg1), "=&a" (reg2),
-		  [psw_pgm] "=Q" (S390_lowcore.program_new_psw),
+		  "+Q" (S390_lowcore.program_new_psw),
+		  "=Q" (old),
 		  [addr] "+d" (_addr), "+d" (_rc)
-		: [subcode] "d" (subcode)
+		: [subcode] "d" (subcode),
+		  [psw_old] "a" (&old),
+		  [psw_pgm] "a" (&S390_lowcore.program_new_psw)
 		: "cc", "memory");
-	S390_lowcore.program_new_psw = old;
 	return _rc;
 }
 
-- 
2.30.2

