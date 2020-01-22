Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52245 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgAVGrs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Jan 2020 01:47:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so5595666wmc.2
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 22:47:46 -0800 (PST)
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
References: <cover.1579248206.git.michal.simek@xilinx.com>
 <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
 <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <5dac2fdd-6e4e-dd16-a149-fbdd8117ac1c@monstr.eu>
Date: Wed, 22 Jan 2020 07:47:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2dbNcSDggiI5dxMnAV22UCPQ9muiAKI4S"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, git@xilinx.com, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, X86 ML <x86@kernel.org>, Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Wesley Terpstra <wesley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul.walmsley@sifive.com>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Chris Zankel <chris@zankel.net>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2dbNcSDggiI5dxMnAV22UCPQ9muiAKI4S
Content-Type: multipart/mixed; boundary="FbunjY3XOg7TLNQEYAVrl68e0gK20Tj5W";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Masahiro Yamada <masahiroy@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, git@xilinx.com,
 Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
 Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, X86 ML <x86@kernel.org>, Guo Ren <guoren@kernel.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Wesley Terpstra <wesley@sifive.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Will Deacon <will@kernel.org>, Christian Borntraeger
 <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Chris Zankel <chris@zankel.net>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>,
 James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <5dac2fdd-6e4e-dd16-a149-fbdd8117ac1c@monstr.eu>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
References: <cover.1579248206.git.michal.simek@xilinx.com>
 <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
 <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>
In-Reply-To: <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>

--FbunjY3XOg7TLNQEYAVrl68e0gK20Tj5W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21. 01. 20 16:43, Masahiro Yamada wrote:
> Hi.
>=20
> On Fri, Jan 17, 2020 at 5:03 PM Michal Simek <michal.simek@xilinx.com> =
wrote:
>>
>> dma-continuguous.h is generic for all architectures except arm32 which=
 has
>> its own version.
>=20
>=20
>=20
> Currently, <asm/dma-contiguous.h> is present
> for only architectures that select HAVE_DMA_CONTIGUOUS.
>=20
> After this commit, the other architectures will end
> up with generating the unused header.
>=20
> That would not be a big deal, but
> it could be mentioned in the commit message?

I have not a problem with mentioning it but not sure if this was done in
past.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--FbunjY3XOg7TLNQEYAVrl68e0gK20Tj5W--

--2dbNcSDggiI5dxMnAV22UCPQ9muiAKI4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXifv/wAKCRDKSWXLKUoM
IVUkAJ9gJ/92v49cM3s26jCgIZyQ1BDZJwCggrGUMIoHH0J6KEp9UuM3wHKXoAo=
=zquH
-----END PGP SIGNATURE-----

--2dbNcSDggiI5dxMnAV22UCPQ9muiAKI4S--
