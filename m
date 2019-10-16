Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726949AbfJPIU2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 04:20:28 -0400
Date: Wed, 16 Oct 2019 10:20:22 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH V6 0/2] mm/debug: Add tests validating architecture page
 table helpers
Message-ID: <20191016082022.GN317@dhcp22.suse.cz>
References: <1571131302-32290-1-git-send-email-anshuman.khandual@arm.com>
 <1571150502.5937.39.camel@lca.pw>
 <c052784a-a5d7-878e-cd97-01daa90c0ed8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c052784a-a5d7-878e-cd97-01daa90c0ed8@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Qian Cai <cai@lca.pw>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Mike Kravetz <mike.kravetz@oracle.com>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue 15-10-19 20:51:11, Anshuman Khandual wrote:
>=20
>=20
> On 10/15/2019 08:11 PM, Qian Cai wrote:
> > The x86 will crash with linux-next during boot due to this series (v5) =
with the
> > config below plus CONFIG_DEBUG_VM_PGTABLE=3Dy. I am not sure if v6 woul=
d address
> > it.
> >=20
> > https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> >=20
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.862600][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1] page:ffffea0009000000 is uninitialized and poisoned
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.862608][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > ffffff871140][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDT1]=EF=BF=BD=EF=BF=BD=
? _raw_spin_unlock_irq+0x27/0x40
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.871140][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1]=EF=BF=BD=EF=BF=BD? rest_init+0x307/0x307
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.871140][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1]=EF=BF=BD=EF=BF=BDkernel_init+0x11/0x139
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.871140][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1]=EF=BF=BD=EF=BF=BD? rest_init+0x307/0x307
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.871140][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1]=EF=BF=BD=EF=BF=BDret_from_fork+0x27/0x50
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.871140][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1] Modules linked in:
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.871140][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1] ---[ end trace e99d392b0f7befbd ]---
> > [=EF=BF=BD=EF=BF=BD=EF=BF=BD33.871140][=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDT1] RIP: 0010:alloc_gigantic_page_order+0x3fe/0x490
>=20
> Hmm, with defconfig (DEBUG_VM=3Dy and DEBUG_VM_PGTABLE=3Dy) it does not c=
rash but
> with the config above, it does. Just wondering if it is possible that the=
se
> pages might not been initialized yet because DEFERRED_STRUCT_PAGE_INIT=3D=
y ?

Quite likely. You need to wait for page_alloc_init_late to finish.
>=20
> [   13.898549][    T1] page:ffffea0005000000 is uninitialized and poisoned
> [   13.898549][    T1] raw: ffffffffffffffff ffffffffffffffff fffffffffff=
fffff ffffffffffffffff
> [   13.898549][    T1] raw: ffffffffffffffff ffffffffffffffff fffffffffff=
fffff ffffffffffffffff
> [   13.898549][    T1] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p=
))
> [   13.898549][    T1] ------------[ cut here ]------------
> [   13.898549][    T1] kernel BUG at ./include/linux/mm.h:1107!
> [   13.898549][    T1] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASA=
N PTI
> [   13.898549][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc=
3-next-20191015+ #

--=20
Michal Hocko
SUSE Labs
