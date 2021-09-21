Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6E5C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 21 Sep 2021 12:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BB360FE8
	for <linux-s390@archiver.kernel.org>; Tue, 21 Sep 2021 12:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhIUM4I (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Sep 2021 08:56:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51728 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232667AbhIUM4H (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Sep 2021 08:56:07 -0400
Received: from zn.tnic (p200300ec2f0d0600f4996d443fa85fcf.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:600:f499:6d44:3fa8:5fcf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46FEE1EC0298;
        Tue, 21 Sep 2021 14:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632228874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hZ7yxBVSWH21LOuOd2ow1m9BReyxD+pdLNk3tjWtt4g=;
        b=QASWuh6RdRkpA0LAaYaPhIJvLhaVZ2ici0IxlRxwCS/ouu8ti51xV8dExeVbLhVxveiljk
        98P3emQVKTBiP8qqaHik3OQBCEzhzYM5cYi7UXe462n6pN2+B+DUvtqOeoyBmVf3tcUcc8
        9SKW8H64cSA4GH1lz9E0o4TPwp9cPbI=
Date:   Tue, 21 Sep 2021 14:54:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Keith Packard <keithpac@amazon.com>,
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] x86: add CPU field to struct thread_info
Message-ID: <YUnWBJekSa5Vx1I9@zn.tnic>
References: <20210914121036.3975026-1-ardb@kernel.org>
 <20210914121036.3975026-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914121036.3975026-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 14, 2021 at 02:10:30PM +0200, Ard Biesheuvel wrote:
> The CPU field will be moved back into thread_info even when
> THREAD_INFO_IN_TASK is enabled, so add it back to x86's definition of
> struct thread_info.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/thread_info.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index cf132663c219..ebec69c35e95 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -57,6 +57,9 @@ struct thread_info {
>  	unsigned long		flags;		/* low level flags */
>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>  	u32			status;		/* thread synchronous flags */
> +#ifdef CONFIG_SMP
> +	u32			cpu;		/* current CPU */
> +#endif
>  };
>  
>  #define INIT_THREAD_INFO(tsk)			\
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
