Return-Path: <schwidefsky@de.ibm.com>
Date: Wed, 7 Feb 2018 13:17:19 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
In-Reply-To: <1518005275.3677.112.camel@infradead.org>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
	<1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
	<20180207100726.GB31392@amd>
	<1518005275.3677.112.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20180207131719.4aeb316e@mschwideX1>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 07 Feb 2018 12:07:55 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2018-02-07 at 11:07 +0100, Pavel Machek wrote:
> > This is really unfortunate naming of kernel option.
> >=20
> > spectre_v2=3Doff sounds like we are turning the "bug" off, but i somehow
> > suspect you are turning the bug _workaround_ off. =20
>=20
> That's consistent with what we have on x86.
>=20
> > > +ifdef CONFIG_EXPOLINE
> > > +=C2=A0=C2=A0ifeq ($(call cc-option-yn,$(CC_FLAGS_MARCH) -mindirect-b=
ranch=3Dthunk),y)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0CC_FLAGS_EXPOLINE :=3D -mindirect-branch=3Dt=
hunk
> > > +=C2=A0=C2=A0=C2=A0=C2=A0CC_FLAGS_EXPOLINE +=3D -mfunction-return=3Dt=
hunk
> > > +=C2=A0=C2=A0=C2=A0=C2=A0CC_FLAGS_EXPOLINE +=3D -mindirect-branch-tab=
le
> > > +=C2=A0=C2=A0=C2=A0=C2=A0export CC_FLAGS_EXPOLINE
> > > +=C2=A0=C2=A0=C2=A0=C2=A0cflags-y +=3D $(CC_FLAGS_EXPOLINE)
> > > +=C2=A0=C2=A0else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0$(warning "Your gcc lacks the -mindirect-bra=
nch=3D option")
> > > +=C2=A0=C2=A0endif
> > > +endif =20
>=20
> That isn't, though. Linus asked us to drop the $(warning) part.
>=20
> ... and then spent a week building with a non-retpoline compiler and
> not noticing, so he might have changed his mind ;)

I found the warning to have some value, it helps for the case where my
fingers are faster than my brain and I type "make" instead of "smake"
which uses the alternative compiler with the required support.

@Linus: do you want a warning or prefer not to have one ?

--=20
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
