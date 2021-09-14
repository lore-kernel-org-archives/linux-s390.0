Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B666AC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 12:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C11D60ED8
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 12:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhINMME (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhINMMD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 08:12:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEAA46103B;
        Tue, 14 Sep 2021 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631621446;
        bh=1NIpBNLdfCZYb9J55l4Q8hL2EpMOVJf4F1ZP4EPic0o=;
        h=From:To:Cc:Subject:Date:From;
        b=Q7nvntBS2UPB7WBgtlsRmwoqulQsE1KJvhWDedyZA1BSnxb8yPU0K17QnznuiE3fU
         mAeLUTwMZ/zeLor7nmbccDG/KPyeNo62+HOjtNdyL6iAZTQ8hEAdpJiS1bX7tvkFcd
         pGPiYTsDjJggRDkG0PEhPZCBGyPgTAbGOdaQA2i4+t+5dTa6u/NO207XoF6tvowP1b
         9aNH1bsh+C4dVWnBEgC8NYYps4JsZcROJhlN5L7ekYMdg5YVNLb5X9hU6YeJP6yazc
         i1agQJWLHvsIkA7OW0eP1CG1zoVzC6WmTMxPnhjtaVgyONkRu94OZ6YvAsEoZv4THJ
         bFzLs/LVRpZCw==
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
Subject: [RFC PATCH 0/8] Move task_struct::cpu back into thread_info
Date:   Tue, 14 Sep 2021 14:10:28 +0200
Message-Id: <20210914121036.3975026-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit c65eacbe290b ("sched/core: Allow putting thread_info into
task_struct") mentions that, along with moving thread_info into
task_struct, the cpu field is moved out of the former into the latter,
but does not explain why.

While collaborating with Keith on adding THREAD_INFO_IN_TASK support to
ARM, we noticed that keeping CPU in task_struct is problematic for
architectures that define raw_smp_processor_id() in terms of this field,
as it requires linux/sched.h to be included, which causes a lot of pain
in terms of circular dependencies (or 'header soup', as the original
commit refers to it).

For examples of how existing architectures work around this, please
refer to patches #6 or #7. In the former case, it uses an awful
asm-offsets hack to index thread_info/current without using its type
definition. The latter approach simply keeps a copy of the task_struct
CPU field in thread_info, and keeps it in sync at context switch time.

Patch #8 reverts this latter approach for ARM, but this code is still
under review so it does not currently apply to mainline.

We also discussed introducing yet another Kconfig symbol to indicate
that the arch has THREAD_INFO_IN_TASK enabled but still prefers to keep
its CPU field in thread_info, but simply keeping it in thread_info in
all cases seems to be the cleanest approach here.

Cc: Keith Packard <keithpac@amazon.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org

Ard Biesheuvel (8):
  arm64: add CPU field to struct thread_info
  x86: add CPU field to struct thread_info
  s390: add CPU field to struct thread_info
  powerpc: add CPU field to struct thread_info
  sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y
  powerpc: smp: remove hack to obtain offset of task_struct::cpu
  riscv: rely on core code to keep thread_info::cpu updated
  ARM: rely on core code to keep thread_info::cpu updated

 arch/arm/include/asm/switch_to.h       | 14 --------------
 arch/arm/kernel/smp.c                  |  3 ---
 arch/arm64/include/asm/thread_info.h   |  1 +
 arch/arm64/kernel/asm-offsets.c        |  2 +-
 arch/arm64/kernel/head.S               |  2 +-
 arch/powerpc/Makefile                  | 11 -----------
 arch/powerpc/include/asm/smp.h         | 17 +----------------
 arch/powerpc/include/asm/thread_info.h |  3 +++
 arch/powerpc/kernel/asm-offsets.c      |  4 +---
 arch/powerpc/kernel/smp.c              |  2 +-
 arch/riscv/kernel/asm-offsets.c        |  1 -
 arch/riscv/kernel/entry.S              |  5 -----
 arch/riscv/kernel/head.S               |  1 -
 arch/s390/include/asm/thread_info.h    |  1 +
 arch/x86/include/asm/thread_info.h     |  3 +++
 include/linux/sched.h                  |  6 +-----
 kernel/sched/sched.h                   |  4 ----
 17 files changed, 14 insertions(+), 66 deletions(-)

-- 
2.30.2

