Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34331 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgBDKbW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Feb 2020 05:31:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so22316155wrr.1
        for <linux-s390@vger.kernel.org>; Tue, 04 Feb 2020 02:31:19 -0800 (PST)
Subject: Re: [PATCH v2 0/2] microblaze: Enable CMA
References: <cover.1579248206.git.michal.simek@xilinx.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <5706978d-4c9a-1123-c34b-e19e2b8aa37f@monstr.eu>
Date: Tue, 4 Feb 2020 11:30:56 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1579248206.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pBOm8rNjCoJTkwKyfl4Ed8HeJH77Ps32T"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, Christoph Hellwig <hch@lst.de>
Cc: Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@linux.ibm.com>, Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, x86@kernel.org, Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Wesley Terpstra <wesley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul.walmsley@sifive.com>, Andrew Morton <akpm@linux-foundation.org>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Chris Zankel <chris@zankel.net>, Manish Narani <manish.narani@xilinx.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, linux-arm-kernel@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, James Hogan <jhogan@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Guo Ren <ren_guo@c-sky.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pBOm8rNjCoJTkwKyfl4Ed8HeJH77Ps32T
Content-Type: multipart/mixed; boundary="BbuWsr0XsV2TagfAoYrRnS0Lcvh9jdEaZ";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, git@xilinx.com, Christoph Hellwig <hch@lst.de>
Cc: Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
 Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, x86@kernel.org,
 Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>,
 Wesley Terpstra <wesley@sifive.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Andrew Morton <akpm@linux-foundation.org>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Will Deacon <will@kernel.org>, Christian Borntraeger
 <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Chris Zankel <chris@zankel.net>, Manish Narani <manish.narani@xilinx.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, James Hogan <jhogan@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Guo Ren <ren_guo@c-sky.com>
Message-ID: <5706978d-4c9a-1123-c34b-e19e2b8aa37f@monstr.eu>
Subject: Re: [PATCH v2 0/2] microblaze: Enable CMA
References: <cover.1579248206.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1579248206.git.michal.simek@xilinx.com>

--BbuWsr0XsV2TagfAoYrRnS0Lcvh9jdEaZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17. 01. 20 9:03, Michal Simek wrote:
> Hi,
>=20
> the patchset enable CMA on Microblaze. Based on Christoph request I hav=
e
> created the first patch which makes dma-continugous.h mandatory for all=

> archs before Microblaze wiring.
>=20
> Thanks,
> Michal
>=20
> Changes in v2:
> - New patch suggested by Christoph
> - Align commit message
> - Remove adding dma-contigous.h via Kbuild because it is done by previo=
us
>   patch
>=20
> Michal Simek (2):
>   asm-generic: Make dma-contiguous.h a mandatory include/asm header
>   microblaze: Wire CMA allocator
>=20
>  arch/arm64/include/asm/Kbuild         | 1 -
>  arch/csky/include/asm/Kbuild          | 1 -
>  arch/microblaze/Kconfig               | 1 +
>  arch/microblaze/configs/mmu_defconfig | 2 ++
>  arch/microblaze/mm/init.c             | 4 ++++
>  arch/mips/include/asm/Kbuild          | 1 -
>  arch/riscv/include/asm/Kbuild         | 1 -
>  arch/s390/include/asm/Kbuild          | 1 -
>  arch/x86/include/asm/Kbuild           | 1 -
>  arch/xtensa/include/asm/Kbuild        | 1 -
>  include/asm-generic/Kbuild            | 1 +
>  11 files changed, 8 insertions(+), 7 deletions(-)
>=20

Applied.

Thanks,
Michal
--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--BbuWsr0XsV2TagfAoYrRnS0Lcvh9jdEaZ--

--pBOm8rNjCoJTkwKyfl4Ed8HeJH77Ps32T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXjlH4AAKCRDKSWXLKUoM
IXg5AJ9J98El4wJeR5l37eVkp19mJ5smqwCdGPO/rvmeDwYSeGZMMaNPcnZNHRA=
=bdA8
-----END PGP SIGNATURE-----

--pBOm8rNjCoJTkwKyfl4Ed8HeJH77Ps32T--
