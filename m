Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 8 Sep 2020 19:36:50 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200908193650.1c1511d0@thinkpad>
In-Reply-To: <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907201256.GC1976319@kernel.org>
        <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 8 Sep 2020 07:22:39 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

>=20
>=20
> Le 07/09/2020 =C3=A0 22:12, Mike Rapoport a =C3=A9crit=C2=A0:
> > On Mon, Sep 07, 2020 at 08:00:55PM +0200, Gerald Schaefer wrote:
> >> This is v2 of an RFC previously discussed here:
> >> https://lore.kernel.org/lkml/20200828140314.8556-1-gerald.schaefer@lin=
ux.ibm.com/
> >>
> >> Patch 1 is a fix for a regression in gup_fast on s390, after our conve=
rsion
> >> to common gup_fast code. It will introduce special helper functions
> >> pXd_addr_end_folded(), which have to be used in places where pagetable=
 walk
> >> is done w/o lock and with READ_ONCE, so currently only in gup_fast.
> >>
> >> Patch 2 is an attempt to make that more generic, i.e. change pXd_addr_=
end()
> >> themselves by adding an extra pXd value parameter. That was suggested =
by
> >> Jason during v1 discussion, because he is already thinking of some oth=
er
> >> places where he might want to switch to the READ_ONCE logic for pageta=
ble
> >> walks. In general, that would be the cleanest / safest solution, but t=
here
> >> is some impact on other architectures and common code, hence the new a=
nd
> >> greatly enlarged recipient list.
> >>
> >> Patch 3 is a "nice to have" add-on, which makes pXd_addr_end() inline
> >> functions instead of #defines, so that we get some type checking for t=
he
> >> new pXd value parameter.
> >>
> >> Not sure about Fixes/stable tags for the generic solution. Only patch 1
> >> fixes a real bug on s390, and has Fixes/stable tags. Patches 2 + 3 mig=
ht
> >> still be nice to have in stable, to ease future backports, but I guess
> >> "nice to have" does not really qualify for stable backports.
> >=20
> > I also think that adding pXd parameter to pXd_addr_end() is a cleaner
> > way and with this patch 1 is not really required. I would even merge
> > patches 2 and 3 into a single patch and use only it as the fix.
>=20
> Why not merging patches 2 and 3, but I would keep patch 1 separate but=20
> after the generic changes, so that we first do the generic changes, then=
=20
> we do the specific S390 use of it.

Yes, we thought about that approach too. It would at least allow to
get all into stable, more or less nicely, as prerequisite for the s390
fix.

Two concerns kept us from going that way. For once, it might not be
the nicest way to get it all in stable, and we would not want to risk
further objections due to the imminent and rather scary data corruption
issue that we want to fix asap.

For the same reason, we thought that the generalization part might
need more time and agreement from various people, so that we could at
least get the first patch as short-term solution.

It seems now that the generalization is very well accepted so far,
apart from some apparent issues on arm. Also, merging 2 + 3 and
putting them first seems to be acceptable, so we could do that for
v3, if there are no objections.

Of course, we first need to address the few remaining issues for
arm(32?), which do look quite confusing to me so far. BTW, sorry for
the compile error with patch 3, I guess we did the cross-compile only
for 1 + 2 applied, to see the bloat-o-meter changes. But I guess
patch 3 already proved its usefulness by that :-)
