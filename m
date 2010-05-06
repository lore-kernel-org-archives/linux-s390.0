Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4BE27123.6070501@gmail.com>
Date: Thu, 06 May 2010 09:34:59 +0200
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
MIME-Version: 1.0
Subject: Re: deadline ALWAYS default for dasd devices(s390) ?
References: <4BD58848.8090205@gmail.com> <20100505061620.GA2381@osiris.boeblingen.de.ibm.com> <4BE123B1.1050500@linux.vnet.ibm.com>
In-Reply-To: <4BE123B1.1050500@linux.vnet.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Weinhuber <wein@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Horst Hummel <Horst.Hummel@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/05/2010 09:52 AM, Stefan Weinhuber wrote:

hi,

> At the time this change was made we had the problem that the
> default scheduler chosen by the distributions resulted in
> bad performance for DASD devices.

Have you done recently new cfq vs. deadline tests, in z/VM
and LPAR ?

> I agree that hard coding this choice into the driver is not pretty,
> but it is pragmatic.=20

It's awful. Easier and simpler from user space: /sys/block/dasdX/queue/sche=
duler

> Some generic mechanism for setting driver specific
> defaults would be nicer, but I doubt that many other drivers would
> actually benefit from such an interface.

see s390-tools-1.8.4/etc/udev/rules.d/60-readahead.rules
That's the way to do it.

-thanks-

--=20
=ABAll=E1 muevan feroz guerra, ciegos reyes por un palmo m=E1s de tierra;
que yo aqu=ED tengo por m=EDo cuanto abarca el mar brav=EDo, a quien nadie
impuso leyes. Y no hay playa, sea cualquiera, ni bandera de esplendor,
que no sienta mi derecho y d=E9 pecho a mi valor.=BB
