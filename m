Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH V4 0/4] mm/debug_vm_pgtable: Add some more tests
References: <1593996516-7186-1-git-send-email-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3e03e6da-139f-94df-73aa-4aaf174f71f5@arm.com>
Date: Mon, 6 Jul 2020 06:41:42 +0530
MIME-Version: 1.0
In-Reply-To: <1593996516-7186-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>


On 07/06/2020 06:18 AM, Anshuman Khandual wrote:
> This series adds some more arch page table helper validation tests which
> are related to core and advanced memory functions. This also creates a
> documentation, enlisting expected semantics for all page table helpers as
> suggested by Mike Rapoport previously (https://lkml.org/lkml/2020/1/30/40).
> 
> There are many TRANSPARENT_HUGEPAGE and ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD
> ifdefs scattered across the test. But consolidating all the fallback stubs
> is not very straight forward because ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD is
> not explicitly dependent on ARCH_HAS_TRANSPARENT_HUGEPAGE.
> 
> Tested on arm64, x86 platforms but only build tested on all other enabled
> platforms through ARCH_HAS_DEBUG_VM_PGTABLE i.e powerpc, arc, s390. The
> following failure on arm64 still exists which was mentioned previously. It
> will be fixed with the upcoming THP migration on arm64 enablement series.
> 
> WARNING .... mm/debug_vm_pgtable.c:860 debug_vm_pgtable+0x940/0xa54
> WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))))
> 
> This series is based on v5.8-rc4.
> 
> Changes in V4:
> 
> - Replaced READ_ONCE() with ptep_get() while accessing PTE pointers per Christophe
> - Fixed function argument alignments per Christophe

+Cc - Zi Yan, Gerald Schaefer, Christophe Leroy

The Cc list was not complete. Please do let me know if you could
not retrieve all the four patches of the series from the list.

- Anshuman
