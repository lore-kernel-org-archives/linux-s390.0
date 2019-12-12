Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <414293e0-3b75-8e78-90d8-2c14182f3739@c-s.fr>
References: <20191210044714.27265-1-dja@axtens.net> <20191210044714.27265-5-dja@axtens.net> <414293e0-3b75-8e78-90d8-2c14182f3739@c-s.fr>
Date: Fri, 13 Dec 2019 00:41:14 +1100
Message-ID: <87tv65br0l.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com, bsingharora@gmail.com

Hi Christophe,

I think I've covered everything you've mentioned in the v3 I'm about to
send, except for:

>> +	/* mark early shadow region as RO and wipe */
>> +	pte = __pte(__pa(kasan_early_shadow_page) |
>> +		    pgprot_val(PAGE_KERNEL_RO) | _PAGE_PTE);
>
> Any reason for _PAGE_PTE being required here and not being included in 
> PAGE_KERNEL_RO ?

I'm not 100% sure quite what you mean here. I think you're asking: why
do we need to supply _PAGE_PTE here, shouldn't PAGE_KERNEL_RO set that
bit or cover that case?

_PAGE_PTE is defined by section 5.7.10.2 of Book III of ISA 3.0: bit 1
(linux bit 62) is 'Leaf (entry is a PTE)' I originally had this because
it was set in Balbir's original implementation, but the bit is also set
by pte_mkpte which is called in set_pte_at, so I also think it's right
to set it.

I don't know why it's not included in the permission classes; I suspect
it's because it's not conceptually a permission, it's set and cleared in
things like swp entry code.

Does that answer your question?

Regards,
Daniel
