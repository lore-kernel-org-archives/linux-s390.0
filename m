Return-Path: <linux-kernel-owner+w=401wt.eu-S1757791AbYBPTvI@vger.kernel.org>
Date: Sat, 16 Feb 2008 20:50:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] 2.6.25-rc2-mm1 - kernel oops while bootup on s390x
In-Reply-To: <alpine.LFD.1.00.0802162048120.7583@apollo.tec.linutronix.de>
Message-ID: <alpine.LFD.1.00.0802162050020.7583@apollo.tec.linutronix.de>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org> <47B70C3A.4050600@linux.vnet.ibm.com> <20080216114527.48408288.akpm@linux-foundation.org> <alpine.LFD.1.00.0802162048120.7583@apollo.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-898888635-1203191434=:7583"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-s390.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-898888635-1203191434=:7583
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Feb 2008, Thomas Gleixner wrote:
> On Sat, 16 Feb 2008, Andrew Morton wrote:
> > > The 2.6.25-rc2-mm1 kernel panic's while boot up on the s390x
> > >=20
> > > Unable to handle kernel pointer dereference at virtual kernel address=
 0000000000
> > > 000000
> > > Oops: 0004 #1=A8 SMP
> > First question is: does this happen in current mainline?
> >=20
> > If not, it would be useful if someone could test futex-fix-init-order.p=
atch
> > and futex-runtime-enable-pi-and-robust-functionality.patch on curent
> > mainline, because those are planned for 2.6.25.
>=20
> See: http://lkml.org/lkml/2008/2/16/109
>=20
> It unearthed a BUG in the S390 exception fixup tables :)

Oops, wrong reference.

      http://lkml.org/lkml/2008/2/16/95

Thanks,
	tglx
--8323328-898888635-1203191434=:7583--
