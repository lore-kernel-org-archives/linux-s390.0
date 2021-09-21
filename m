Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E141C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 21 Sep 2021 12:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF4611ED
	for <linux-s390@archiver.kernel.org>; Tue, 21 Sep 2021 12:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhIUMG3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Sep 2021 08:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbhIUMG3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Sep 2021 08:06:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD1E661283;
        Tue, 21 Sep 2021 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632225900;
        bh=DG9JNZQFvl7efc4nexOO4fg+5WMfNAZoucbjG4viZJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NKhQ//8opxeA0g5NaMvTusKd95Jeh1r3yoFaq76nUvQR1KiwDblmo04KsiciTCHgr
         CO9zM6Vmo3427l7xLk7VtbvdwMvcOEZWiPDrWkOClAMDn2/mYya9nkPx2opqSZVVkg
         BjPAkkO+6RNgzmnQzHpn8YDYc+APYvooJUQWDVAH+vXIaSeOw4VA4iAKzPEzbR/14W
         pgUbAzg0CSDsV//1+s4rOvobBn7TVroQPaeyz+u5fnd+yLSEJ0ZadPpI0Hm1i+kChu
         Kf9O+YeCNKHVapXKthvVwD/iHWK9lDIeNGMCiAj5HIgnbEq1fajR4Z0NlgEANVAP96
         wrkUzx53d4JhA==
Received: by mail-ot1-f49.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so27952153otq.7;
        Tue, 21 Sep 2021 05:05:00 -0700 (PDT)
X-Gm-Message-State: AOAM530UfzC9gJbU8SU2CkBh7qrjHetVxnzjW/NB0qvPQHs9W0HcWW8N
        c1ZsJZeM1u4vznuUi7eGK/FmFDxgk9MpnXUzV5M=
X-Google-Smtp-Source: ABdhPJxUqmu5iQVr6fZ3TQM6eziNelFJiJn18TFwtwwTecybfc/0teebK58ixSK16CBCXGG0Y5zoMsZaVGfK1lcWdYI=
X-Received: by 2002:a05:6830:3189:: with SMTP id p9mr22365233ots.147.1632225899996;
 Tue, 21 Sep 2021 05:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-2-ardb@kernel.org>
 <YUNXfWKZ7XYvw2EK@arm.com>
In-Reply-To: <YUNXfWKZ7XYvw2EK@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Sep 2021 14:04:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFkJtVaT2CjigZHLT+AAjmCzU1OgTg+QS-ttJxmejGkRQ@mail.gmail.com>
Message-ID: <CAMj1kXFkJtVaT2CjigZHLT+AAjmCzU1OgTg+QS-ttJxmejGkRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] arm64: add CPU field to struct thread_info
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 16 Sept 2021 at 16:41, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Sep 14, 2021 at 02:10:29PM +0200, Ard Biesheuvel wrote:
> > The CPU field will be moved back into thread_info even when
> > THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition of
> > struct thread_info.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks. I take it this applies to patch #5 as well?
