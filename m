Return-Path: <linux-kernel-owner+w=401wt.eu-S1758848AbYG2PPq@vger.kernel.org>
Subject: Re: [patch 02/15] kmsg: Kernel message catalog script.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <ef1cd66f0807290801q647d7efbn9f9058531bc6f32c@mail.gmail.com>
References: <20080728175355.734299984@de.ibm.com>
	 <20080728175511.260174666@de.ibm.com>
	 <20080728192828.GA11431@uranus.ravnborg.org>
	 <1217320950.10259.15.camel@localhost>
	 <20080729084536.GA29659@uranus.ravnborg.org>
	 <1217329750.10259.38.camel@localhost>
	 <ef1cd66f0807290801q647d7efbn9f9058531bc6f32c@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 29 Jul 2008 17:15:29 +0200
Message-Id: <1217344529.10259.51.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2008-07-29 at 16:01 +0100, Jochen Vo=DF wrote:
> Hi Martin,
>=20
> I think the changelog needs fixing, too:
>=20
> 2008/7/29 Martin Schwidefsky <schwidefsky@de.ibm.com>:
> > The kmsg check is invoked with "make K=3D1" and reads the source files =
for
> > all objects that are built by the current configuration and searches for
> > matching kmsg descriptions for the kmsg messages in the source which
> > have a messages id > 0. If a message description can not be found the
> > script prints a blueprint and causes a make error.
> >
> > The kmsg man page creation is invoked with "make K=3D2" and reads the s=
ource
> > files for all built objects, looks up the message description and writes
> > a man page to $(objtree)/man.
> This should be "D=3D1" and "D=3D2" now, shouldn't it?

Yes, indeed. Thanks.

--=20
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
