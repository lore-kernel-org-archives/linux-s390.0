Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728088AbfKSPjB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Nov 2019 10:39:01 -0500
Date: Tue, 19 Nov 2019 16:38:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 03/10] vfio-ccw: Use subchannel lpm in the orb
Message-ID: <20191119163846.18df1f69.cohuck@redhat.com>
In-Reply-To: <fa7f22e1-df44-4ad2-871a-23cd4feebc5e@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-4-farman@linux.ibm.com>
        <20191119140046.4b81edd8.cohuck@redhat.com>
        <fa7f22e1-df44-4ad2-871a-23cd4feebc5e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Tue, 19 Nov 2019 10:16:30 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 11/19/19 8:00 AM, Cornelia Huck wrote:
> > On Fri, 15 Nov 2019 03:56:13 +0100
> > Eric Farman <farman@linux.ibm.com> wrote:
> >  =20
> >> From: Farhan Ali <alifm@linux.ibm.com>
> >>
> >> The subchannel logical path mask (lpm) would have the most
> >> up to date information of channel paths that are logically
> >> available for the subchannel.
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> >> ---
> >>
> >> Notes:
> >>     v0->v1: [EF]
> >>      - None; however I am greatly confused by this one.  Thoughts? =20
> >=20
> > I think it's actually wrong.
> >  =20
> >>
> >>  drivers/s390/cio/vfio_ccw_cp.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_cc=
w_cp.c
> >> index 3645d1720c4b..d4a86fb9d162 100644
> >> --- a/drivers/s390/cio/vfio_ccw_cp.c
> >> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> >> @@ -779,9 +779,7 @@ union orb *cp_get_orb(struct channel_program *cp, =
u32 intparm, u8 lpm)
> >>  =09orb->cmd.intparm =3D intparm;
> >>  =09orb->cmd.fmt =3D 1;
> >>  =09orb->cmd.key =3D PAGE_DEFAULT_KEY >> 4;
> >> -
> >> -=09if (orb->cmd.lpm =3D=3D 0)
> >> -=09=09orb->cmd.lpm =3D lpm; =20
> >=20
> > In the end, the old code will use the lpm from the subchannel
> > structure, if userspace did not supply anything to be used.
> >  =20
> >> +=09orb->cmd.lpm =3D lpm; =20
> >=20
> > The new code will always discard any lpm userspace has supplied and
> > replace it with the lpm from the subchannel structure. This feels
> > wrong; what if the I/O is supposed to be restricted to a subset of the
> > paths? =20
>=20
> I had the same opinion, but didn't want to flat-out discard it from his
> series without a second look.  :)

:)

>=20
> >=20
> > If we want to include the current value of the subchannel lpm in the
> > requests, we probably want to AND the masks instead. =20
>=20
> Then we'd be on the hook to return some sort of error if the result is
> zero.  Is it better to just send it to hw as-is, and let the response
> come back naturally?  (Which is what we do today.)

But if a chpid is logically varied off, it is removed from the lpm,
right? Therefore, the caller really should get a 'no path' indication
back, shouldn't it?

>=20
> >  =20
> >> =20
> >>  =09chain =3D list_first_entry(&cp->ccwchain_list, struct ccwchain, ne=
xt);
> >>  =09cpa =3D chain->ch_ccw; =20
> >  =20
>=20
