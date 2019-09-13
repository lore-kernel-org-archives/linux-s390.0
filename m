Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:60145 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387427AbfIMKBG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Sep 2019 06:01:06 -0400
Subject: Re: [PATCH V2 2/2] mm/pgtable/debug: Add test validating architecture
 page table helpers
References: <1568268173-31302-1-git-send-email-anshuman.khandual@arm.com>
 <1568268173-31302-3-git-send-email-anshuman.khandual@arm.com>
 <ab0ca38b-1e4f-b636-f8b4-007a15903984@c-s.fr>
 <502c497a-9bf1-7d2e-95f2-cfebcd9cf1d9@arm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <95ed9d92-dd43-4c45-2e52-738aed7f2fb5@c-s.fr>
Date: Fri, 13 Sep 2019 12:01:00 +0200
MIME-Version: 1.0
In-Reply-To: <502c497a-9bf1-7d2e-95f2-cfebcd9cf1d9@arm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org



Le 13/09/2019 à 11:02, Anshuman Khandual a écrit :
> 
>>> +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(__ARCH_HAS_4LEVEL_HACK)
>>
>> #ifdefs have to be avoided as much as possible, see below
> 
> Yeah but it has been bit difficult to avoid all these $ifdef because of the
> availability (or lack of it) for all these pgtable helpers in various config
> combinations on all platforms.

As far as I can see these pgtable helpers should exist everywhere at 
least via asm-generic/ files.

Can you spot a particular config which fails ?

> 
>>

[...]

>>> +#if !defined(__PAGETABLE_PUD_FOLDED) && !defined(__ARCH_HAS_5LEVEL_HACK)
>>
>> The same can be done here.
> 
> IIRC not only the page table helpers but there are data types (pxx_t) which
> were not present on various configs and these wrappers help prevent build
> failures. Any ways will try and see if this can be improved further. But
> meanwhile if you have some suggestions, please do let me know.

pgt_t and pmd_t are everywhere I guess.
then pud_t and p4d_t have fallbacks in asm-generic files.

So it shouldn't be an issue. Maybe if a couple of arches miss them, the 
best would be to fix the arches, since that's the purpose of your 
testsuite isn't it ?


Christophe
