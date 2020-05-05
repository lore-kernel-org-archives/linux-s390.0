Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727785AbgEEUQK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 16:16:10 -0400
Date: Tue, 5 May 2020 23:15:22 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 17/20] mm: free_area_init: allow defining max_zone_pfn
 in descending order
Message-ID: <20200505201522.GA683243@linux.ibm.com>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-18-rppt@kernel.org>
 <20200503174138.GA114085@roeck-us.net>
 <20200503184300.GA154219@roeck-us.net>
 <20200504153901.GM14260@kernel.org>
 <a0b20e15-fddb-aa9c-fd67-f1c8e735b4a4@synopsys.com>
 <20200505091946.GG342687@linux.ibm.com>
 <88b9465b-6e6d-86ca-3776-ccb7a5b60b7f@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <88b9465b-6e6d-86ca-3776-ccb7a5b60b7f@synopsys.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Mike Rapoport <rppt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, Ley Foon Tan <ley.foon.tan@intel.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Greg Ungerer <gerg@linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Helge Deller <deller@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, May 05, 2020 at 06:07:46PM +0000, Vineet Gupta wrote:
> On 5/5/20 2:19 AM, Mike Rapoport wrote:
> > From the code I've got the impression that it is either one of them. I.e
> > the physical memory is either at
> >
> > 0x8000_0000 - <end of DDR 0 bank>
> > 0x0000_0000 - <end of DDR 1 bank>
> >
> > or
> >
> > 0x0_8000_0000 - <end of DDR 0 bank>
> > 0x1_0000_0000 - <end of DDR 1 bank>
> >
> > Is this possible to have a system with three live ranges? Like
> >
> > 0x0_0000_0000 - <end of DDR 1 bank>
> > 0x0_8000_0000 - <end of DDR 0 bank>
> > 0x1_0000_0000 - <end of DDR 2 bank>
>=20
> We don't have such a system, but it is indeed possible in theory. The que=
stion is
> =EF=BF=BD- Can other arches have such a setup too

At the moment all architectures that support HIGHMEM have it above
DMA/NORMAL. I'm not sure if such a setup is theoretically possible for
other architectures, but as of now none of them support it in Linux.

The general case is somewhat like

	max_dma_pfn <=3D max_normal_pfn < max_high_pfn

And of course, either max_dma_pfn or max_high_pfn or both may be not
needed for an architecture.

> =EF=BF=BD- Is it not better to have the core retain the flexibility just =
in case

Hmm, there is indeed flexibility in the nodes and zones initialization,
but if you'd look more closely to free_area_init*() and friends, there
is a lot of cruft and retrofitting ;-)

What we have is two mutually exclusive paths, one that relies on the
architecture to calculate zone sizes and find the holes between the
zones (!CONFIG_HAVE_MEMBLOCK_NODE_MAP) and the other one that only
requires the architectures to pass possible limit for each zone and
detects the actual zone spans based on the knowlegde about the actual
physical memory layout that comes from memblock.

These patches attempt to drop the older method and switch all the
architectures to use newer and simpler one.

If the requirement to have support for 3-banks is a theoretical
possibility, I would prefer to adjust ARC's version of
arch_has_descending_max_zone_pfns() to cope with either of 2-banks
configuration (PAE40 and non-PAE40) and deal with the third bank when/if
it actually materializes.

> Thx,
> -Vineet

--=20
Sincerely yours,
Mike.
