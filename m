Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
References: <c022e863-0807-fab1-cd41-3c320381f448@c-s.fr>
 <11F41980-97CF-411F-8120-41287DC1A382@lca.pw>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <57a3bc61-bbd5-e251-9621-7bc28f7901a1@arm.com>
Date: Thu, 5 Mar 2020 06:24:44 +0530
MIME-Version: 1.0
In-Reply-To: <11F41980-97CF-411F-8120-41287DC1A382@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>, Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, the arch/x86 maintainers <x86@kernel.org>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>



On 03/04/2020 04:59 PM, Qian Cai wrote:
> 
> 
>> On Mar 4, 2020, at 1:49 AM, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>> AFAIU, you are not taking an interrupt here. You are stuck in the pte_update(), most likely due to nested locks. Try with LOCKDEP ?
> 
> Not exactly sure what did you mean here, but the kernel has all lockdep enabled and did not flag anything here.

As the patch has been dropped from Linux next (next-20200304) perhaps in
order to fold back the __pa_symbol() fix [1], so I am planning to respin
the original patch once more as V15 while adding Qian's signed off by for
the powerpc part. For now lets enable radix MMU ppc64 along with existing
ppc32. As PPC_RADIX_MMU depends on PPC_BOOK3S_64, the following change
should be good enough ?

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 497b7d0b2d7e..8d5ae14c5d4c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -116,6 +116,7 @@  config PPC
 	#
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEBUG_VIRTUAL
+	select ARCH_HAS_DEBUG_VM_PGTABLE if (PPC_RADIX_MMU || PPC32)
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE

[1] https://patchwork.kernel.org/patch/11407715/
