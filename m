Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D00C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 12:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0A061108
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 12:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhINMMQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhINMMP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 08:12:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCDDD60ED8;
        Tue, 14 Sep 2021 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631621458;
        bh=6eta5IaVQyecbFieqH1slYSKBR/IBlo0wo4FWcGW+A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6PMg+sWDjuXVYOpHuiBJTnlf+P2umXdEtKmIi5OJ2aR2reaLlexXQ+BPFTYvAylb
         FGT0YjQHmGh3dGIlYYmBzqoSD54+cAEAAPF5fpPnUlkdtCjkYsyO2FQH+OngVLu5QW
         zjZ42wCUKiM4AfqGPvzRk2Y4+bmX5oKye50C8ybF71uM5ansUx/KNU37Apfn6nngWT
         N0D+mesAhaqSK9PoTvOGoHT+kyWZdG1kZFSs07USsnr/8n8pDqDGm3ZKGW6urjoJew
         h7lgbd80Wd6mMWq7N2dwW/0FEFfVxaKKW9ogZAu70f1G6C/NobToXYV9OCrPKF7WFc
         ZwWItb/PrKNDg==
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
Subject: [RFC PATCH 2/8] x86: add CPU field to struct thread_info
Date:   Tue, 14 Sep 2021 14:10:30 +0200
Message-Id: <20210914121036.3975026-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914121036.3975026-1-ardb@kernel.org>
References: <20210914121036.3975026-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The CPU field will be moved back into thread_info even when
THREAD_INFO_IN_TASK is enabled, so add it back to x86's definition of
struct thread_info.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/thread_info.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf132663c219..ebec69c35e95 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -57,6 +57,9 @@ struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 	u32			status;		/* thread synchronous flags */
+#ifdef CONFIG_SMP
+	u32			cpu;		/* current CPU */
+#endif
 };
 
 #define INIT_THREAD_INFO(tsk)			\
-- 
2.30.2

