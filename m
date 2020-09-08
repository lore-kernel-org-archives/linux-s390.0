Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 8 Sep 2020 15:38:57 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200908153857.08d09581@thinkpad>
In-Reply-To: <96b80926-cf5b-1afa-9b7a-949a2188e61f@csgroup.eu>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <82fbe8f9-f199-5fc2-4168-eb43ad0b0346@csgroup.eu>
        <70a3dcb5-5ed1-6efa-6158-d0573d6927da@de.ibm.com>
        <96b80926-cf5b-1afa-9b7a-949a2188e61f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>

On Tue, 8 Sep 2020 14:40:10 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

>=20
>=20
> Le 08/09/2020 =C3=A0 14:09, Christian Borntraeger a =C3=A9crit=C2=A0:
> >=20
> >=20
> > On 08.09.20 07:06, Christophe Leroy wrote:
> >>
> >>
> >> Le 07/09/2020 =C3=A0 20:00, Gerald Schaefer a =C3=A9crit=C2=A0:
> >>> From: Alexander Gordeev <agordeev@linux.ibm.com>
> >>>
> >>> Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_=
fast
> >>> code") introduced a subtle but severe bug on s390 with gup_fast, due =
to
> >>> dynamic page table folding.
> >>>
> >>> The question "What would it require for the generic code to work for =
s390"
> >>> has already been discussed here
> >>> https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
> >>> and ended with a promising approach here
> >>> https://lkml.kernel.org/r/20190419153307.4f2911b5@mschwideX1
> >>> which in the end unfortunately didn't quite work completely.
> >>>
> >>> We tried to mimic static level folding by changing pgd_offset to alwa=
ys
> >>> calculate top level page table offset, and do nothing in folded pXd_o=
ffset.
> >>> What has been overlooked is that PxD_SIZE/MASK and thus pXd_addr_end =
do
> >>> not reflect this dynamic behaviour, and still act like static 5-level
> >>> page tables.
> >>>
> >>
> >> [...]
> >>
> >>>
> >>> Fix this by introducing new pXd_addr_end_folded helpers, which take an
> >>> additional pXd entry value parameter, that can be used on s390
> >>> to determine the correct page table level and return corresponding
> >>> end / boundary. With that, the pointer iteration will always
> >>> happen in gup_pgd_range for s390. No change for other architectures
> >>> introduced.
> >>
> >> Not sure pXd_addr_end_folded() is the best understandable name, alltho=
ugh I don't have any alternative suggestion at the moment.
> >> Maybe could be something like pXd_addr_end_fixup() as it will disappea=
r in the next patch, or pXd_addr_end_gup() ?
> >>
> >> Also, if it happens to be acceptable to get patch 2 in stable, I think=
 you should switch patch 1 and patch 2 to avoid the step through pXd_addr_e=
nd_folded()
> >=20
> > given that this fixes a data corruption issue, wouldnt it be the best t=
o go forward
> > with this patch ASAP and then handle the other patches on top with all =
the time that
> > we need?
>=20
> I have no strong opinion on this, but I feel rather tricky to have to=20
> change generic part of GUP to use a new fonction then revert that change=
=20
> in the following patch, just because you want the first patch in stable=20
> and not the second one.
>=20
> Regardless, I was wondering, why do we need a reference to the pXd at=20
> all when calling pXd_addr_end() ?
>=20
> Couldn't S390 retrieve the pXd by using the pXd_offset() dance with the=20
> passed addr ?

Apart from performance impact when re-doing that what has already been
done by the caller, I think we would also break the READ_ONCE semantics.
After all, the pXd_offset() would also require some pXd pointer input,
which we don't have. So we would need to start over again from mm->pgd.

Also, it seems to be more in line with other primitives that take
a pXd value or pointer.
