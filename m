Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbgEGU7x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 16:59:53 -0400
Date: Thu, 7 May 2020 23:59:00 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 17/20] mm: free_area_init: allow defining max_zone_pfn
 in descending order
Message-ID: <20200507205900.GH683243@linux.ibm.com>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-18-rppt@kernel.org>
 <20200503174138.GA114085@roeck-us.net>
 <20200503184300.GA154219@roeck-us.net>
 <20200504153901.GM14260@kernel.org>
 <a0b20e15-fddb-aa9c-fd67-f1c8e735b4a4@synopsys.com>
 <20200505091946.GG342687@linux.ibm.com>
 <88b9465b-6e6d-86ca-3776-ccb7a5b60b7f@synopsys.com>
 <20200505201522.GA683243@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200505201522.GA683243@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Greg Ungerer <gerg@linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Mike Rapoport <rppt@kernel.org>

On Tue, May 05, 2020 at 11:15:22PM +0300, Mike Rapoport wrote:
> On Tue, May 05, 2020 at 06:07:46PM +0000, Vineet Gupta wrote:
> > On 5/5/20 2:19 AM, Mike Rapoport wrote:
>=20
> > =EF=BF=BD- Is it not better to have the core retain the flexibility jus=
t in case
>=20
> If the requirement to have support for 3-banks is a theoretical
> possibility, I would prefer to adjust ARC's version of
> arch_has_descending_max_zone_pfns() to cope with either of 2-banks
> configuration (PAE40 and non-PAE40) and deal with the third bank when/if
> it actually materializes.
>=20
> > Thx,
> > -Vineet
>=20

The fix below should take care of any 2-bank configurations.=20
This is vs. current mmotm.

From eb8124fb3584607d1036b7ae00c8092ae43e480d Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 7 May 2020 23:44:15 +0300
Subject: [PATCH] arc: free_area_init(): take into account PAE40 mode

The arch_has_descending_max_zone_pfns() does not take into account physical
memory layout for PAE40 configuration.
With PAE40 enabled, the HIGHMEM is actually higher than NORMAL and
arch_has_descending_max_zone_pfns() should return false in this case.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 386959bac3d2..e7bdc2ac1c87 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -79,7 +79,7 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 s=
ize)
=20
 bool arch_has_descending_max_zone_pfns(void)
 {
-	return true;
+	return !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
 }
=20
 /*
--=20
2.26.1


--=20
Sincerely yours,
Mike.
