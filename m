Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw> <1582726340.7365.124.camel@lca.pw>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <eb154054-68ab-a659-065b-f4f7dcbb8671@c-s.fr>
Date: Wed, 26 Feb 2020 15:44:23 +0100
MIME-Version: 1.0
In-Reply-To: <1582726340.7365.124.camel@lca.pw>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



Le 26/02/2020 à 15:12, Qian Cai a écrit :
> On Wed, 2020-02-26 at 09:09 -0500, Qian Cai wrote:
>> On Mon, 2020-02-17 at 08:47 +0530, Anshuman Khandual wrote:
>>
>> How useful is this that straightly crash the powerpc?
> 
> And then generate warnings on arm64,
> 
> [  146.634626][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
> architecture page table helpers
> [  146.643995][    T1] ------------[ cut here ]------------
> [  146.649350][    T1] virt_to_phys used for non-linear address:
> (____ptrval____) (start_kernel+0x0/0x580)

Must be something wrong with the following in debug_vm_pgtable()

	paddr = __pa(&start_kernel);

Is there any explaination why start_kernel() is not in linear memory on 
ARM64 ?

Christophe
