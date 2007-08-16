Return-Path: <linux-kernel-owner+w=401wt.eu-S1759693AbXHPM3S@vger.kernel.org>
Date: Thu, 16 Aug 2007 18:11:17 +0530 (IST)
From: Satyam Sharma <satyam@infradead.org>
Subject: Re: drivers/infiniband/mlx/mad.c misplaced ;
In-Reply-To: <Pine.LNX.4.64.0708161248050.22579@kivilampi-30.cs.helsinki.fi>
Message-ID: <alpine.LFD.0.999.0708161801530.25951@enigma.security.iitk.ac.in>
References: <20070815235825.GB17004@redhat.com> <1187224811.5906.55.camel@localhost>
 <20070816084635.GA15985@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.64.0708161248050.22579@kivilampi-30.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="464262402-1168800151-1187268086=:25951"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: =?iso-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Joe Perches <joe@perches.com>, Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>, rolandd@cisco.com, Chas Williams <chas@cmf.nrl.navy.mil>, Paul Mundt <lethal@linux-sh.org>, isdn4linux@listserv.isdn4linux.de, mikep@linuxtr.net, Netdev <netdev@vger.kernel.org>, swen@vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, netfilter-devel@lists.netfilter.org, coreteam@netfilter.org
List-ID: <linux-s390.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--464262402-1168800151-1187268086=:25951
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,


On Thu, 16 Aug 2007, Ilpo J=E4rvinen wrote:

>=20
> ...I guess those guys hunting for broken busyloops in the other thread=20
> could also benefit from similar searching commands introduced in this=20
> thread... ...Ccing Satyam to caught their attention too.
>=20
>=20
> > On Wed, Aug 15, 2007 at 05:40:11PM -0700, Joe Perches wrote:
> > >=20
> > > There's more than a few of these (not inspected).
> > >=20
> > > $ egrep -r --include=3D*.c "\bif[[:space:]]*\([^\)]*\)[[:space:]]*\;"=
 *=20
>=20
> ...Hmm, I plugged in "a preprocessor" too to manage with non compliant=20
> coding styles :-). Please understand that the line numbers are not an=20
> exact match due to preprocessor changes:
>=20
> $ for i in `find . -name '*.[ch]'`; do echo $i; indent -npro -kr -i8 -ts8=
=20
> -sob -l8000 -ss -ncs -cp1 -nhnl -st $i | egrep -n "[[:space:]]if [(].*[)]=
 ;$";
> done | grep -B1 "^[^.]"

Thanks, looks useful, will check with this.


Satyam
--464262402-1168800151-1187268086=:25951--
