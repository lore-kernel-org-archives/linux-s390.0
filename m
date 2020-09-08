Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:65048 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgIHFWu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 8 Sep 2020 01:22:50 -0400
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907201256.GC1976319@kernel.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
Date: Tue, 8 Sep 2020 07:22:39 +0200
MIME-Version: 1.0
In-Reply-To: <20200907201256.GC1976319@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>



Le 07/09/2020 à 22:12, Mike Rapoport a écrit :
> On Mon, Sep 07, 2020 at 08:00:55PM +0200, Gerald Schaefer wrote:
>> This is v2 of an RFC previously discussed here:
>> https://lore.kernel.org/lkml/20200828140314.8556-1-gerald.schaefer@linux.ibm.com/
>>
>> Patch 1 is a fix for a regression in gup_fast on s390, after our conversion
>> to common gup_fast code. It will introduce special helper functions
>> pXd_addr_end_folded(), which have to be used in places where pagetable walk
>> is done w/o lock and with READ_ONCE, so currently only in gup_fast.
>>
>> Patch 2 is an attempt to make that more generic, i.e. change pXd_addr_end()
>> themselves by adding an extra pXd value parameter. That was suggested by
>> Jason during v1 discussion, because he is already thinking of some other
>> places where he might want to switch to the READ_ONCE logic for pagetable
>> walks. In general, that would be the cleanest / safest solution, but there
>> is some impact on other architectures and common code, hence the new and
>> greatly enlarged recipient list.
>>
>> Patch 3 is a "nice to have" add-on, which makes pXd_addr_end() inline
>> functions instead of #defines, so that we get some type checking for the
>> new pXd value parameter.
>>
>> Not sure about Fixes/stable tags for the generic solution. Only patch 1
>> fixes a real bug on s390, and has Fixes/stable tags. Patches 2 + 3 might
>> still be nice to have in stable, to ease future backports, but I guess
>> "nice to have" does not really qualify for stable backports.
> 
> I also think that adding pXd parameter to pXd_addr_end() is a cleaner
> way and with this patch 1 is not really required. I would even merge
> patches 2 and 3 into a single patch and use only it as the fix.

Why not merging patches 2 and 3, but I would keep patch 1 separate but 
after the generic changes, so that we first do the generic changes, then 
we do the specific S390 use of it.

Christophe
