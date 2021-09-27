Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B245C433FE
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452EE60F44
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhI0POd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235002AbhI0POc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Sep 2021 11:14:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED8B7611C0;
        Mon, 27 Sep 2021 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632755575;
        bh=CKBeZqx1JroYNLrGq5H114mf1zFlMql7osjtvpITDCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EVBbs3MVb2rKhlVS8zKpcM376o/TKjtkXDHHd/wsTbaLfx6lDmygiZpT3x7nXiuQ3
         qI6Y85rpLepdxU+wE0Grxf7YsEaSbNhENVT+K25JSCaaY+814CwQ0wyxUsc9KUuvQy
         hQdmzWSytaJMhwWEBAVICPEipETSfP3Xu6nDTfAdg5aRgouxOHTt3NfeACf7kbOWCR
         OsCr7y6iELtBigI8CNkHzbquvZiEOaAvAmL84E8ja0KTlJjM1I99On/bQ1Ypc9tMZk
         SaL7iKw5FGEGEAfGtwf33A3FoOYzfQslocN3+NGigGTpzuzQ60fFGB/7x3vYj7X3Wo
         Dc/q7pfQ+7M1Q==
Received: by mail-oi1-f171.google.com with SMTP id x124so25951234oix.9;
        Mon, 27 Sep 2021 08:12:54 -0700 (PDT)
X-Gm-Message-State: AOAM530Ilm/x5W+uOuMSC71Qm/zfE2USl6OULczEtCmN1IelD0KI7y4p
        JFtfsdUvSfsD+gfpaK90THwE0z+7e9CdWn+9RKs=
X-Google-Smtp-Source: ABdhPJyeC8BgibE5zzxbqU0l8Tut8FIpgncaCT3Q0Qb4RyOfhbEhCIFLxw2ikpv+mDHPe9VMwWn8YxftPxI0HPTWIJ0=
X-Received: by 2002:aca:32c2:: with SMTP id y185mr501704oiy.47.1632755574136;
 Mon, 27 Sep 2021 08:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-5-ardb@kernel.org>
In-Reply-To: <20210914121036.3975026-5-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Sep 2021 17:12:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEojbQbNzCP39KT4EzFAyW3J1Tfm_stCZ+fGo8_SO90PA@mail.gmail.com>
Message-ID: <CAMj1kXEojbQbNzCP39KT4EzFAyW3J1Tfm_stCZ+fGo8_SO90PA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] powerpc: add CPU field to struct thread_info
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 14 Sept 2021 at 14:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The CPU field will be moved back into thread_info even when
> THREAD_INFO_IN_TASK is enabled, so add it back to powerpc's definition
> of struct thread_info.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Michael,

Do you have any objections or issues with this patch or the subsequent
ones cleaning up the task CPU kludge for ppc32? Christophe indicated
that he was happy with it.

Thanks,
Ard.


> ---
>  arch/powerpc/include/asm/thread_info.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index b4ec6c7dd72e..5725029aaa29 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -47,6 +47,9 @@
>  struct thread_info {
>         int             preempt_count;          /* 0 => preemptable,
>                                                    <0 => BUG */
> +#ifdef CONFIG_SMP
> +       unsigned int    cpu;
> +#endif
>         unsigned long   local_flags;            /* private flags for thread */
>  #ifdef CONFIG_LIVEPATCH
>         unsigned long *livepatch_sp;
> --
> 2.30.2
>
