Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:29864 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfLJGfS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Dec 2019 01:35:18 -0500
Subject: Re: [PATCH v2 1/4] mm: define MAX_PTRS_PER_{PTE,PMD,PUD}
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-2-dja@axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <80f340f2-0323-8092-7e6d-c93b26fb7cf7@c-s.fr>
Date: Tue, 10 Dec 2019 07:35:15 +0100
MIME-Version: 1.0
In-Reply-To: <20191210044714.27265-2-dja@axtens.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com, bsingharora@gmail.com



Le 10/12/2019 à 05:47, Daniel Axtens a écrit :
> powerpc has boot-time configurable PTRS_PER_PTE, PMD and PUD. The
> values are selected based on the MMU under which the kernel is
> booted. This is much like how 4 vs 5-level paging on x86_64 leads to
> boot-time configurable PTRS_PER_P4D.
> 
> So far, this hasn't leaked out of arch/powerpc. But with KASAN, we
> have static arrays based on PTRS_PER_*, so for powerpc support must
> provide constant upper bounds for generic code.
> 
> Define MAX_PTRS_PER_{PTE,PMD,PUD} for this purpose.
> 
> I have configured these constants:
>   - in asm-generic headers
>   - on arches that implement KASAN: x86, s390, arm64, xtensa and powerpc

I think we shoud avoid spreading default values all over the place when 
all arches but one uses the default.

I would drop this patch 1, squash the powerpc part of it in the last 
patch, and define defaults in patch 2, see my comments there.

> 
> I haven't wired up any other arches just yet - there is no user of
> the constants outside of the KASAN code I add in the next patch, so
> missing the constants on arches that don't support KASAN shouldn't
> break anything.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>   arch/arm64/include/asm/pgtable-hwdef.h       | 3 +++
>   arch/powerpc/include/asm/book3s/64/hash.h    | 4 ++++
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 7 +++++++
>   arch/powerpc/include/asm/book3s/64/radix.h   | 5 +++++
>   arch/s390/include/asm/pgtable.h              | 3 +++
>   arch/x86/include/asm/pgtable_types.h         | 5 +++++
>   arch/xtensa/include/asm/pgtable.h            | 1 +
>   include/asm-generic/pgtable-nop4d-hack.h     | 9 +++++----
>   include/asm-generic/pgtable-nopmd.h          | 9 +++++----
>   include/asm-generic/pgtable-nopud.h          | 9 +++++----
>   10 files changed, 43 insertions(+), 12 deletions(-)
> 

Christophe
