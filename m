Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43660 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726040AbgDXEMN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Apr 2020 00:12:13 -0400
Date: Thu, 23 Apr 2020 23:12:01 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 6/9] s390/module: Use s390_kernel_write() for late
 relocations
Message-ID: <20200424041201.ekbx6wvl3dn45zfl@treble>
References: <18266eb2c2c9a2ce0033426837d89dcb363a85d3.1587131959.git.jpoimboe@redhat.com>
 <20200422164037.7edd21ea@thinkpad>
 <20200422172126.743908f5@thinkpad>
 <20200422194605.n77t2wtx5fomxpyd@treble>
 <20200423141834.234ed0bc@thinkpad>
 <alpine.LSU.2.21.2004231513250.6520@pobox.suse.cz>
 <20200423141228.sjvnxwdqlzoyqdwg@treble>
 <20200423181030.b5mircvgc7zmqacr@treble>
 <20200423232657.7minzcsysnhp474w@treble>
 <20200424023521.GA22117@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424023521.GA22117@redhat.com>
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Vasily Gorbik <gor@linux.ibm.com>

On Thu, Apr 23, 2020 at 10:35:21PM -0400, Joe Lawrence wrote:
> > diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> > index 2798329ebb74..fe446f42818f 100644
> > --- a/arch/s390/kernel/module.c
> > +++ b/arch/s390/kernel/module.c
> > @@ -297,7 +297,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr ba=
se, Elf_Sym *symtab,
> > =20
> >  			gotent =3D me->core_layout.base + me->arch.got_offset +
> >  				info->got_offset;
> > -			*gotent =3D val;
> > +			write(gotent, &val, sizeof(*gotent));
> >  			info->got_initialized =3D 1;
> >  		}
> >  		val =3D info->got_offset + rela->r_addend;
> > @@ -330,25 +330,29 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr =
base, Elf_Sym *symtab,
> >  	case R_390_PLTOFF32:	/* 32 bit offset from GOT to PLT. */
> >  	case R_390_PLTOFF64:	/* 16 bit offset from GOT to PLT. */
> >  		if (info->plt_initialized =3D=3D 0) {
> > -			unsigned int *ip;
> > +			unsigned int *ip, insn[5];
> > +
> >  			ip =3D me->core_layout.base + me->arch.plt_offset +
> >  				info->plt_offset;
>=20
> Would it be too paranoid to declare:
>=20
>   			const unsigned int *ip =3D me->core_layout.base +=20
> 						 me->arch.plt_offset +
>   						 info->plt_offset;
>=20
> That would trip an assignment to read-only error if someone were tempte=
d
> to write directly through the pointer in the future.  Ditto for Elf_Add=
r
> *gotent pointer in the R_390_GOTPLTENT case.

The only problem is then the write() triggers a warning because then we
*are* trying to write through the pointer :-)

arch/s390/kernel/module.c:300:10: warning: passing argument 1 of =E2=80=98=
write=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer ta=
rget type [-Wdiscarded-qualifiers]
  300 |    write(gotent, &val, sizeof(*gotent));

--=20
Josh
