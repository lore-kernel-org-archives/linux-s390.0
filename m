Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E8EC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 12:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED706112E
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 12:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhINMM2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhINMM1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 08:12:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6A9D61151;
        Tue, 14 Sep 2021 12:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631621470;
        bh=0gZ7g4PrdHovHhvTbvNDdx6ByPhH72YCH9mSQcGy7nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bWOE2FcgJCPImZMVbgRai97mW40puruvu263BNQpF0CEHWNMsO826h665RsNX/7Jr
         aqgwL0RlnK8VJxV7LLj9nd6yswsVqUQGV82MtpUJjfx0LwA9SHq4rk56b2jwiD+VgK
         cqD25xaieY1IenKCbr7MoLWsXxwK0Kgak0Wck7CgA3p0h7TjmCFBrR0IgSRbuA3fZ2
         yxbWKo/wj1bx49qHZiMF7N3XdoVIlTNx/u0Q/KzGeXlYQxfFlk8VTcGg1gTg5W6lci
         FGMqXMPbJDkb4kUSIPn3rntL0eeF3iDCcqaD/ilJ9Dh7doCYOr//PRPgiPV1swNdk9
         8bmEuLMDGLldA==
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
Subject: [RFC PATCH 4/8] powerpc: add CPU field to struct thread_info
Date:   Tue, 14 Sep 2021 14:10:32 +0200
Message-Id: <20210914121036.3975026-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914121036.3975026-1-ardb@kernel.org>
References: <20210914121036.3975026-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The CPU field will be moved back into thread_info even when
THREAD_INFO_IN_TASK is enabled, so add it back to powerpc's definition
of struct thread_info.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/powerpc/include/asm/thread_info.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index b4ec6c7dd72e..5725029aaa29 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -47,6 +47,9 @@
 struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
+#ifdef CONFIG_SMP
+	unsigned int	cpu;
+#endif
 	unsigned long	local_flags;		/* private flags for thread */
 #ifdef CONFIG_LIVEPATCH
 	unsigned long *livepatch_sp;
-- 
2.30.2

