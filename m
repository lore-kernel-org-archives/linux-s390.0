Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730885AbgIIQN0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Sep 2020 12:13:26 -0400
Date: Wed, 9 Sep 2020 18:12:11 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200909181211.1cad8d28@thinkpad>
In-Reply-To: <20200908193650.1c1511d0@thinkpad>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907201256.GC1976319@kernel.org>
        <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
        <20200908193650.1c1511d0@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 8 Sep 2020 19:36:50 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

[..]
> 
> It seems now that the generalization is very well accepted so far,
> apart from some apparent issues on arm. Also, merging 2 + 3 and
> putting them first seems to be acceptable, so we could do that for
> v3, if there are no objections.
> 
> Of course, we first need to address the few remaining issues for
> arm(32?), which do look quite confusing to me so far. BTW, sorry for
> the compile error with patch 3, I guess we did the cross-compile only
> for 1 + 2 applied, to see the bloat-o-meter changes. But I guess
> patch 3 already proved its usefulness by that :-)

Umm, replace "arm" with "power", sorry. No issues on arm so far, but
also no ack I think.

Thanks to Christophe for the power change, and to Mike for volunteering
for some cross compilation and cross-arch testing. Will send v3 with
merged and re-ordered patches after some more testing.
