Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFACEC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 21 Sep 2021 13:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964546112F
	for <linux-s390@archiver.kernel.org>; Tue, 21 Sep 2021 13:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhIUNNq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232584AbhIUNNq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Sep 2021 09:13:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFEFC61166;
        Tue, 21 Sep 2021 13:12:13 +0000 (UTC)
Date:   Tue, 21 Sep 2021 14:12:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
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
Subject: Re: [RFC PATCH 5/8] sched: move CPU field back into thread_info if
 THREAD_INFO_IN_TASK=y
Message-ID: <YUnaKixPsMuHksI9@arm.com>
References: <20210914121036.3975026-1-ardb@kernel.org>
 <20210914121036.3975026-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914121036.3975026-6-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 14, 2021 at 02:10:33PM +0200, Ard Biesheuvel wrote:
> THREAD_INFO_IN_TASK moved the CPU field out of thread_info, but this
> causes some issues on architectures that define raw_smp_processor_id()
> in terms of this field, due to the fact that #include'ing linux/sched.h
> to get at struct task_struct is problematic in terms of circular
> dependencies.
> 
> Given that thread_info and task_struct are the same data structure
> anyway when THREAD_INFO_IN_TASK=y, let's move it back so that having
> access to the type definition of struct thread_info is sufficient to
> reference the CPU number of the current task.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
