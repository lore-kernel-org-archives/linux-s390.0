Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D21FC433FE
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 12:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5E561151
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 12:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhINMMs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhINMMp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 08:12:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD1916112D;
        Tue, 14 Sep 2021 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631621488;
        bh=3Eo7aeQUKWhSuHa2Yy03uZkrXM9xu16VG+SpPZYmMqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGqXq7SuYLFaSMofX/n34tYQjKjRKyp2rUzLBToahvHZpcV5HQmhV2FBHm2Ccvydo
         l8eo30W842/61Yv9t4FWfZFFCGvufPKBQHi5kkzh+DiJf8bANhWqwVnOcsZQCs4tBo
         LwvK8qr+yFOoPIfEEsMV0GmzoMeSanwUR9HQH8m0w85cDn2VmVj9fvfvT0iJ6jkJVd
         V1Y5Zjr0h7fIov1IHkiMaS3YxTC0kg2/JZyRIPQGbQSIl6Qr03blMuKQ1zOpFsItLu
         KIGqTNePxnKgfiuTrnr+3WECWPE9NgfnPAYGBNCwFRbbCChEoiqOnPHALJhShPddgZ
         TOxAb7CtKizuQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: [RFC PATCH 7/8] riscv: rely on core code to keep thread_info::cpu updated
Date:   Tue, 14 Sep 2021 14:10:35 +0200
Message-Id: <20210914121036.3975026-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914121036.3975026-1-ardb@kernel.org>
References: <20210914121036.3975026-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Now that the core code switched back to using thread_info::cpu to keep
a task's CPU number, we no longer need to keep it in sync explicitly. So
just drop the code that does this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/kernel/asm-offsets.c | 1 -
 arch/riscv/kernel/entry.S       | 5 -----
 arch/riscv/kernel/head.S        | 1 -
 3 files changed, 7 deletions(-)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 90f8ce64fa6f..478d9f02dab5 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -33,7 +33,6 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
-	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
 
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 98f502654edd..459eb1714353 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -544,11 +544,6 @@ ENTRY(__switch_to)
 	REG_L s9,  TASK_THREAD_S9_RA(a4)
 	REG_L s10, TASK_THREAD_S10_RA(a4)
 	REG_L s11, TASK_THREAD_S11_RA(a4)
-	/* Swap the CPU entry around. */
-	lw a3, TASK_TI_CPU(a0)
-	lw a4, TASK_TI_CPU(a1)
-	sw a3, TASK_TI_CPU(a1)
-	sw a4, TASK_TI_CPU(a0)
 	/* The offset of thread_info in task_struct is zero. */
 	move tp, a1
 	ret
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fce5184b22c3..d5ec30ef6f5d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -317,7 +317,6 @@ clear_bss_done:
 	call setup_trap_vector
 	/* Restore C environment */
 	la tp, init_task
-	sw zero, TASK_TI_CPU(tp)
 	la sp, init_thread_union + THREAD_SIZE
 
 #ifdef CONFIG_KASAN
-- 
2.30.2

