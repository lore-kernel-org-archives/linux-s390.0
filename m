From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Tue, 29 Jan 2019 20:39:33 +0100
Message-ID: <20190129203933.4e57cd91@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190125152154.05120461.cohuck@redhat.com>
	<20190125170404.28c61eab@oc2783563651>
	<20190128181355.2d79cae7.cohuck@redhat.com>
	<20190128203000.6dbf7ba3@oc2783563651>
	<20190129105840.1bf46c3b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190129105840.1bf46c3b.cohuck@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 29 Jan 2019 10:58:40 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > > > The problem I see with the let the hardware sort it out is that, for
> > > > that to work, we need to juggle multiple translations simultaneously
> > > > (or am I wrong?). Doing that does not appear particularly simple to
> > > > me.   =20
> > >=20
> > > None in the first stage, at most two in the second stage, I guess.
> > >    =20
> >=20
> > Expected benefit of the second stage over the first stage? (I see none.=
) =20
>=20
> Making something possible that is allowed by the architecture. Not
> really important, though.
>=20

I had a chat with Farhan, and he suggested that by 'allowed by
architecture' you mean " You can submit a new request if the subchannel
is pending with primary, but not with secondary state." (from Message-ID:
<20190125152154.05120461.cohuck@redhat.com>).

So I re-read the PoP.

=46rom the description of the start subchannel instruction:
"""
Special Conditions

Condition code 1 is set, and no other action is
taken, when the subchannel is status pending when
START SUBCHANNEL is executed. On some mod-
els, condition code 1 is not set when the subchannel
is status pending with only secondary status; instead,
the status-pending condition is discarded.

Condition code 2 is set, and no other action is
taken, when a start, halt, or clear function is currently
in progress at the subchannel (see =E2=80=9CFunction Control
(FC)=E2=80=9D on page 13).

"""

So I guess you mixed primary and secondary up and wanted to say:
"You can submit a new request if the subchannel
is pending with _secondary_, but not with _primary_ _status_."

But does that really mean architecture allows the subchannel
to accept multiple ssch() instructions so that it ends up processing
two or more channel programs in parallel.

My answer to that question is: no it does not, and furthermore
it would not make sense.

So let me provide some quotes that explain how this ominous accepting
the ssch() with a status pending can occur.

"""
Conclusion of I/O Operations

The conclusion of an I/O operation normally is indi-
cated by two status conditions: channel end and
device end. The channel-end condition indicates that
the I/O device has received or provided all data asso-
ciated with the operation and no longer needs chan-
nel-subsystem facilities. This condition is called the
primary interruption condition, and the channel end
in this case is the primary status. Generally, the pri-
mary interruption condition is any interruption condi-
tion that relates to an I/O operation and that signals
the conclusion at the subchannel of the I/O operation
or chain of I/O operations.

The device-end signal indicates that the I/O device
has concluded execution and is ready to perform
another operation. This condition is called the sec-
ondary interruption condition, and the device end in
this case is the secondary status. Generally, the sec-
ondary interruption condition is any interruption con-
dition that relates to an I/O operation and that signals
the conclusion at the device of the I/O operation or
chain of operations. The secondary interruption con-
dition can occur concurrently with, or later than, the
primary interruption condition.
"""

In my reading this means that a device may lag with signaling
that it is done (with respect to the conclusion at the subchannel).

It that window between primary and secondary the driver could do the
proper driving of a ccw device stuff, do the store subchannel and clear
the primary status. See  And happily start the next ssch(). If that
ssch() now hit a subchannel thah just got the secondary status, for some
modes we apparently don't need to wait for the secondary status before
issuing the next ssch(), nor do we need to do we need to do the clear the
pending status dance because ssch() says cc =3D=3D 1. The subchannel will
discard the secondary status and process the second ssch(). But the
previous ssch() has long concluded. Because as the quoted text says
the primary status is either simultaneous with or precedes the secondary
status.

Also if the subchannel were to process more than one channel program
at the time, questions would arise like what happens if one of them fails
(does that affect the other one?). It's something I find very hard to
even thing about.

BTW we would have to deal with these problems as well, if we were
to implement your second stage.

> >  =20
> > > > Furthermore we would go through all that hassle knowingly that
> > > > the sole reason is working around bugs. We still expect our
> > > > Linux guests serializing it's ssch() stuff as it does today.
> > > > Thus I would except this code not getting the love nor the
> > > > coverage that would guard against bugs in that code.   =20
> > >=20
> > > So, we should have test code for that? (Any IBM-internal channel
> > > I/O exercisers that may help?)
> > >   =20
> >=20
> > None that I'm aware of. Anyone else?=20
> >=20
> > But the point I was trying to make is the following: I prefer keeping
> > the handling for the case "ssch()'s on top of each other" as trivial
> > as possible. (E.g. bail out if CP_PENDING without doing any
> > translation.)=20
> > > We should not rely on the guest being sane, although Linux
> > > probably is in that respect.
> > >    =20
> >=20
> > I agree 100%: we should not rely on either guest or userspace
> > emulator being sane. But IMHO we should handle insanity with the
> > least possible investment. =20
>=20
> We probably disagree what the least possible investment is.
>=20

Yes. IMHO making sure that we accept io_requests only if we are in
an appropriate state (currently the IDLE) and rejecting requests with
the appropriate error code is easy. And juggling parallel translations is
hard. My intuition. I can try to prove my point should anybody ever try
to submit patches that attempt this juggling parallel translations. But
I'm loosing my confidence in my ability to convince people.

Farhan, Eric any opinions?

Regards,
Halil
