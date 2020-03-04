Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw>
 <7c707b7f-ce3d-993b-8042-44fdc1ed28bf@c-s.fr>
 <1582732318.7365.129.camel@lca.pw> <1583178042.7365.146.camel@lca.pw>
 <e8516497-f1b9-b222-e219-73b68880ac75@arm.com>
 <12260F9A-695D-40F8-932F-61D86D77D441@lca.pw>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c022e863-0807-fab1-cd41-3c320381f448@c-s.fr>
Date: Wed, 4 Mar 2020 07:48:54 +0100
MIME-Version: 1.0
In-Reply-To: <12260F9A-695D-40F8-932F-61D86D77D441@lca.pw>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>, Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, the arch/x86 maintainers <x86@kernel.org>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>



Le 04/03/2020 à 02:39, Qian Cai a écrit :
> 
>> Below is slightly modified version of your change above and should still
>> prevent the bug on powerpc. Will it be possible for you to re-test this
>> ? Once confirmed, will send a patch enabling this test on powerpc64
>> keeping your authorship. Thank you.
> 
> This works fine on radix MMU but I decided to go a bit future to test hash
> MMU. The kernel will stuck here below. I did confirm that pte_alloc_map_lock()
> was successful, so I don’t understand hash MMU well enough to tell why
> it could still take an interrupt at pte_clear_tests() even before we calls
> pte_unmap_unlock()?

AFAIU, you are not taking an interrupt here. You are stuck in the 
pte_update(), most likely due to nested locks. Try with LOCKDEP ?

Christophe

> 
> [   33.881515][    T1] ok 8 - property-entry
> [   33.883653][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
> architecture page table helpers
> [   60.418885][    C8] watchdog: BUG: soft lockup - CPU#8 stuck for 23s!
> [swapper/0:1]
