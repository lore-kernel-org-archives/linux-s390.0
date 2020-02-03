Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46702 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgBCPsU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Feb 2020 10:48:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so11735559qtr.13
        for <linux-s390@vger.kernel.org>; Mon, 03 Feb 2020 07:48:20 -0800 (PST)
Message-ID: <1580744894.7365.3.camel@lca.pw>
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page
 table helpers
From: Qian Cai <cai@lca.pw>
Date: Mon, 03 Feb 2020 10:48:14 -0500
In-Reply-To: <8e94a073-4045-89aa-6a3b-24847ad7c858@c-s.fr>
References: <473d8198-3ac4-af3b-e2ec-c0698a3565d3@c-s.fr>
         <2C4ADFAE-7BB4-42B7-8F54-F036EA7A4316@lca.pw>
         <8e94a073-4045-89aa-6a3b-24847ad7c858@c-s.fr>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Anshuman Khandual <Anshuman.Khandual@arm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>

On Mon, 2020-02-03 at 16:14 +0100, Christophe Leroy wrote:
> 
> Le 02/02/2020 à 12:26, Qian Cai a écrit :
> > 
> > 
> > > On Jan 30, 2020, at 9:13 AM, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> > > 
> > > config DEBUG_VM_PGTABLE
> > >     bool "Debug arch page table for semantics compliance" if ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
> > >     depends on MMU
> > >     default 'n' if !ARCH_HAS_DEBUG_VM_PGTABLE
> > >     default 'y' if DEBUG_VM
> > 
> > Does it really necessary to potentially force all bots to run this? Syzbot, kernel test robot etc? Does it ever pay off for all their machine times there?
> > 
> 
> Machine time ?
> 
> On a 32 bits powerpc running at 132 MHz, the tests takes less than 10ms. 
> Is it worth taking the risk of not detecting faults by not selecting it 
> by default ?

The risk is quite low as Catalin mentioned this thing is not to detect
regressions but rather for arch/mm maintainers.

I do appreciate the efforts to get everyone as possible to run this thing,
so it get more notices once it is broken. However, DEBUG_VM seems like such
a generic Kconfig those days that have even been enabled by default for
Fedora Linux, so I would rather see a more sensitive default been taken
even though the test runtime is fairly quickly on a small machine for now.

> 
> [    5.656916] debug_vm_pgtable: debug_vm_pgtable: Validating 
> architecture page table helpers
> [    5.665661] debug_vm_pgtable: debug_vm_pgtable: Validated 
> architecture page table helpers
