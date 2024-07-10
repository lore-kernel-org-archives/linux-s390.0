Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C733EA9B;
	Wed, 10 Jul 2024 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720587775; cv=none; b=PQe40qy6PiImnPGdyJGXiQhjwLpk8CWUDHTym/koOzF7+52YilmBA3VFyx30ZqVs5NA4OwXQfteB5wOEmunBlV9DZ64fKtmclAlNAFeCcfb4eLNcTxKYZvO7oTY61+WSbWt4EDBxphZIkGieRRhWNO6M8MhkGXY0daa+0iC0lcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720587775; c=relaxed/simple;
	bh=x/oOsXF4lZjZG8r5EXicRgAz+NbzpNSCQdbEminxFB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5wzaECN2tcnvGsEYyl623BhF+y2w/lZEEPZG7KI5nhnACMDp0u3zdKydlwY/32L3rO8henMM8nYpfQcNcgqUeQI4sQX6NY75zjOgQNzcSlusyMGZSnIK+2NEgF2mJrkVSX+VERk7DvxWzJwzCvuh28IOZCyKKD+UmJYQUz5gA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=KS8/WKSl; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="KS8/WKSl"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B619A1E4787;
	Wed, 10 Jul 2024 07:02:47 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720587767; bh=mNyrtf9OiXenXHzoPlDYAJL6aVBgwWzJqttkZSth0pA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KS8/WKSlqLiLM7OShOG3aGuXAi4ASoAHFdn8srepZfUqZmobQIxHdkxHVMaSCYBI1
	 R3JHXgxd03t0Q2LsNL44XTdqnHJP1ZnRtlTO/yEf38Hd5kxPEFfYVL7RvVMVpdfFZE
	 cErulrnckda3ftsVxlatUEbPU4SmH7qs41rxGnI3/AxqozjFJIlFXUXE1AXlnumPht
	 DxeCTnqlW9EcpfjpQMS9RmbFRkrEMYVaYZ8FozD9puaZjsRXmiI8lztfSolw+7XsKJ
	 Jnd1xx7gQ2n5UtZEuG11VY3TQsZ7U/BFJ7sBHTmzy/rL6CplSLuWA1/xrDUOqMLPP5
	 3oglbHzPpZ7LA==
Date: Wed, 10 Jul 2024 07:02:46 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <20240710070246.001873c4@meshulam.tesarici.cz>
In-Reply-To: <Zo2j3hgOhh9EQld1@telecaster.dhcp.thefacebook.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
	<Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
	<20240709212141.31160508@meshulam.tesarici.cz>
	<Zo2j3hgOhh9EQld1@telecaster.dhcp.thefacebook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jul 2024 13:55:58 -0700
Omar Sandoval <osandov@osandov.com> wrote:

> On Tue, Jul 09, 2024 at 09:21:41PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Thu, 27 Jun 2024 15:51:09 +0200
> > Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> >  =20
> > > On Thu, Jun 20, 2024 at 04:34:15PM -0700, Omar Sandoval wrote:
> > >=20
> > > Hi Omar,
> > >  =20
> > > > Hi, Alexander and Sven,
> > > >=20
> > > > I just got around to testing drgn on s390x on 6.10-rc4, and it appe=
ars
> > > > to be broken. I bisected it to commit 56b1069c40c7 ("s390/boot: Rew=
ork
> > > > deployment of the kernel image") and narrowed it down to an issue w=
ith
> > > > the KERNELOFFSET value reported in vmcoreinfo.
> > > >=20
> > > > On my test kernel, the ELF symbol for init_task is 0xc96f00:
> > > >=20
> > > >   $ eu-readelf -s build/vmtest/s390x/kernel-6.10.0-rc4-vmtest30.1de=
fault/build/vmlinux | grep ' init_task$'
> > > >   72273: 0000000000c96f00   4352 OBJECT  GLOBAL DEFAULT       18 in=
it_task
> > > >=20
> > > > And the address in the loaded kernel is 0x3ffffeaaf00:
> > > >=20
> > > >   # grep ' init_task$' /proc/kallsyms
> > > >   000003ffffeaaf00 D init_task
> > > >=20
> > > > 0x3ffffeaaf00 - 0xc96f00 is 0x3ffff214000
> > > >=20
> > > > However, this doesn't match the value of KERNELOFFSET in vmcoreinfo:
> > > >=20
> > > >   # eu-readelf -n /proc/kcore | grep KERNELOFFSET
> > > >     KERNELOFFSET=3D3ffff314000
> > > >=20
> > > > It's off by 0x100000. This causes drgn to compute the wrong address=
es
> > > > for all global variables.
> > > >=20
> > > > For context, I'm testing using QEMU emulation on an x86-64 host. No=
te
> > > > that it logs "KASLR disabled: CPU has no PRNG" early during boot. My
> > > > exact setup is:
> > > >=20
> > > >   $ git clone https://github.com/osandov/drgn.git
> > > >   $ cd drgn
> > > >   $ python3 -m vmtest.rootfsbuild -a s390x --build-drgn
> > > >   $ python3 -m vmtest.vm -k 's390x:6.10.*' bash -i
> > > >   # python3 -m drgn   =20
> > > >   >>> prog['init_task'].comm   =20
> > > >   (char [16])""
> > > >=20
> > > > That should be printing "swapper/0".
> > > >=20
> > > > Any ideas what's going on here?   =20
> > >=20
> > > On s390 no kernel symbol exists below 0x100000 offset within the
> > > vmlinux image and thus this part is never mapped into the kernel
> > > memory. That way KERNELOFFSET turns out to be off on value of
> > > 0x100000 - and that is what you observe.
> > >=20
> > > That breaks the way drgn finds a kernel symbol, but does not
> > > exactly contradicts to the existing KERNELOFFSET description
> > > (Documentation/admin-guide/kdump/vmcoreinfo.rst):
> > >=20
> > > =3D=3D=3D
> > > KERNELOFFSET
> > > ------------
> > >=20
> > > The kernel randomization offset. Used to compute the page offset. If
> > > KASLR is disabled, this value is zero.
> > > =3D=3D=3D
> > >=20
> > > I would say to some degree there is also inconsisten with regard
> > > to /proc/ files existence:
> > > /proc/kcore    is enabled by CONFIG_PROC_KCORE option, while
> > > /proc/kallsyms is enabled by CONFIG_KALLSYMS option.
> > > I assume drgn expects both files exist and does not work otherwise. =
=20
>=20
> drgn doesn't use kallsyms, partially because it's not guaranteed to
> exist as you pointed out, and partially because it's slow.
>=20
> > > Nevertheless, it is still possible to refer to only one file for
> > > symbol resolution and use an always-present symbol. E.g _stext
> > > could be leveraged like this:
> > >=20
> > > # grep -w init_task /proc/kallsyms
> > > 000003ffe13e9400 D init_task
> > > # grep -w _stext /proc/kallsyms
> > > 000003ffe0000000 T _stext
> > >=20
> > > 0x3ffe13e9400 - 0x3ffe0000000 =3D=3D 0x13e9400
> > >=20
> > > # eu-readelf -s vmlinux | grep -w _stext
> > > 178112: 0000000000100000      0 NOTYPE  GLOBAL DEFAULT        1 _stext
> > >=20
> > > 0x13e9400 + 0x100000 =3D=3D 0x14e9400
> > >=20
> > > # eu-readelf -s vmlinux | grep -w init_task
> > >   498: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS init_t=
ask.c
> > > 182344: 00000000014e9400   8960 OBJECT  GLOBAL DEFAULT       28 init_=
task
> > >=20
> > > I guess, the above holds true for all architectures.
> > > If so, I would suggest consider using that approach.
> > >=20
> > > Having said that, we will try to turn KERNELOFFSET from a synthetic
> > > value "Used to compute the page offset" to what drgn expects it to be=
. =20
> >=20
> > Thinking about it now, I'm not sure it makes life easier. Because then
> > we'll have some old kernels with the current (unexpected) definition of
> > KERNELOFFSET and some new kernels with a more standard definition of
> > it, but if I read vmcoreinfo, how do I know if the value has the old or
> > the new meaning? =20
>=20
> I wasn't able to get real KASLR working on my s390x VM, but what I found
> in testing without KASLR was:
>=20
> - Before commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual
>   address spaces"), KERNELOFFSET was not set at all (this is expected).
> - After commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual
>   address spaces"), but before commit 56b1069c40c7 ("s390/boot: Rework
>   deployment of the kernel image"), KERNELOFFSET was set in a way that
>   drgn understands even without KASLR (that's a little odd but fine with
>   me).
> - After commit 56b1069c40c7 ("s390/boot: Rework deployment of the kernel
>   image"), KERNELOFFSET was set "incorrectly"
>=20
> So at least for no KASLR, the breakage has been limited only to the 6.10
> rcs, which isn't too late to fix. I'd be curious what the behavior was
> with KASLR before 6.10, though.

OK, I'll check SLES 15 SP5 (kernel 5.14) and SP6 (kernel 6.4). Both
enable KASLR, but it can be turned off on the command line (or I can
even rebuild the kernel without CONFIG_RANDOMIZE_BASE if that makes a
difference).

Petr T
