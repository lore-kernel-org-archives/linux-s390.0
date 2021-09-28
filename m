Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D8C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6590F61206
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 13:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbhI1Nyu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241045AbhI1Nyt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Sep 2021 09:54:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF84B6127C;
        Tue, 28 Sep 2021 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632837189;
        bh=jrbVenceAWLgQkHzrFIo4zTN1wFu086UNecp+tCchZ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BJTpbVzxSlWP7bMXn78zpcAI8AzZBFum7ggL0nmew76COMAheV0+QtFCooIzVjSA+
         8BTYrxda+iUt4es/uiEyCPAxXqJfu/6LLciq4r/IBalgwp0FbcCIjVx2qs2I5M8yyY
         9MUZsUqJA8Wzkd560YijUKsvx54Y3nhT5/PNRqyjRt1rSNxgLMltgQPPPsanqi3v84
         3pgfA/EtgGoCRNd75w4xMl3PrVxKHdDcAz/y9a2ZY2YZFj8NPQydK5G/tqtxxdEGT2
         lRmWsIR4tF3IJIqtUlksoXB1ehXeu0YUl0qxeZms7xxpFa7nQqutq2pMNklY79Ncob
         AMSiwHlYGRgtA==
Received: by mail-oi1-f182.google.com with SMTP id z11so30082326oih.1;
        Tue, 28 Sep 2021 06:53:09 -0700 (PDT)
X-Gm-Message-State: AOAM531dVnBEuDH3ATIw4F2RoMjkS7VSJrKoPGGsilIDDLajKkC3b96q
        Y/9cBT3iV1HvFLWZdWv2kVUZnNTbGa5zHzevTMI=
X-Google-Smtp-Source: ABdhPJz9to8lWFr60Gpre4Od/46x6s4Nrtse/34SwP3rmoXnxlQkLzOc/1tmIX3U1LqO/1/3HTa84J5WaQo7iINmJLs=
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr3628695oiu.33.1632837188990;
 Tue, 28 Sep 2021 06:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-4-ardb@kernel.org>
In-Reply-To: <20210914121036.3975026-4-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Sep 2021 15:52:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGfPYBRKoj5eBefr61kHc=m336g0EbPUeDRy+GZVGw26w@mail.gmail.com>
Message-ID: <CAMj1kXGfPYBRKoj5eBefr61kHc=m336g0EbPUeDRy+GZVGw26w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/8] s390: add CPU field to struct thread_info
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Keith Packard <keithpac@amazon.com>,
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
> THREAD_INFO_IN_TASK is enabled, so add it back to s390's definition of
> struct thread_info.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/s390/include/asm/thread_info.h | 1 +
>  1 file changed, 1 insertion(+)
>

Heiko, Christian, Vasily,

Do you have any objections to this change? If you don't, could you
please ack it so it can be taken through another tree (or if that is
problematic for you, could you please propose another way of merging
these changes?)

Thanks,
Ard.

> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
> index e6674796aa6f..b2ffcb4fe000 100644
> --- a/arch/s390/include/asm/thread_info.h
> +++ b/arch/s390/include/asm/thread_info.h
> @@ -37,6 +37,7 @@
>  struct thread_info {
>         unsigned long           flags;          /* low level flags */
>         unsigned long           syscall_work;   /* SYSCALL_WORK_ flags */
> +       unsigned int            cpu;            /* current CPU */
>  };
>
>  /*
> --
> 2.30.2
>
