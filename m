From: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Fri, 25 Jan 2019 10:57:38 -0500
Message-ID: <565393ea-e9dc-4455-a22b-16d4bd2cfbb8@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190125135835.2d59b511.cohuck@redhat.com>
Content-Language: en-US
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
Cc: linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>



On 01/25/2019 07:58 AM, Cornelia Huck wrote:
> On Fri, 25 Jan 2019 11:24:37 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
>> On Thu, 24 Jan 2019 21:37:44 -0500
>> Eric Farman <farman@linux.ibm.com> wrote:
>>
>>> On 01/24/2019 09:25 PM, Eric Farman wrote:
>>>>
>>>>
>>>> On 01/21/2019 06:03 AM, Cornelia Huck wrote:
>>
>>>> [1] I think these changes are cool.=C2=A0 We end up going into (and =
staying
>>>> in) state=3DBUSY if we get cc=3D0 on the SSCH, rather than in/out as=
 we
>>>> bumble along.
>>>>
>>>> But why can't these be separated out from this patch?=C2=A0 It does =
change
>>>> the behavior of the state machine, and seem distinct from the additi=
on
>>>> of the mutex you otherwise add here?=C2=A0 At the very least, this b=
ehavior
>>>> change should be documented in the commit since it's otherwise lost =
in
>>>> the mutex/EAGAIN stuff.
>>
>> That's a very good idea. I'll factor them out into a separate patch.
>=20
> And now that I've factored it out, I noticed some more problems.

That's good!  Maybe it helps us with the circles we're on :)

>=20
> What we basically need is the following, I think:
>=20
> - The code should not be interrupted while we process the channel
>    program, do the ssch etc. We want the caller to try again later (i.e.
>    return -EAGAIN)
> - We currently do not want the user space to submit another channel
>    program while the first one is still in flight.=20

These two seem to contradict one another.  I think you're saying is that=20
we don't _want_ userspace to issue another channel program, even though=20
its _allowed_ to as far as vfio-ccw is concerned.

As submitting another
>    one is a valid request, however, we should allow this in the future
>    (once we have the code to handle that in place).
> - With the async interface, we want user space to be able to submit a
>    halt/clear while a start request is still in flight, but not while
>    we're processing a start request with translation etc. We probably
>    want to do -EAGAIN in that case.
>=20
> My idea would be:
>=20
> - The BUSY state denotes "I'm busy processing a request right now, try
>    again". We hold it while processing the cp and doing the ssch and
>    leave it afterwards (i.e., while the start request is processed by
>    the hardware). I/O requests and async requests get -EAGAIN in that
>    state.
> - A new state (CP_PENDING?) is entered after ssch returned with cc 0
>    (from the BUSY state). We stay in there as long as no final state fo=
r
>    that request has been received and delivered. (This may be final
>    interrupt for that request, a deferred cc, or successful halt/clear.=
)
>    I/O requests get -EBUSY

I liked CP_PENDING, since it corresponds to the subchannel being marked=20
"start pending" as described in POPS, but this statement suggests that=20
the BUSY/PENDING state to be swapped, such that state=3DPENDING returns=20
-EAGAIN and state=3DBUSY returns -EBUSY.  Not super-concerned with the=20
terminology though.

, async requests are processed. This state can
>    be removed again once we are able to handle more than one outstandin=
g
>    cp.
>=20
> Does that make sense?
>=20

I think so, and I think I like it.  So you want to distinguish between=20
(I have swapped BUSY/PENDING in this example per my above comment):

A) SSCH issued by userspace (IDLE->PENDING)
B) SSCH issued (successfully) by kernel (PENDING->BUSY)
B') SSCH issued (unsuccessfully) by kernel (PENDING->IDLE?)
C) Interrupt received by kernel (no change?)
D) Interrupt given to userspace (BUSY->IDLE)

If we receive A and A, the second A gets EAGAIN

If we do A+B and A, the second A gets EBUSY (unless async, which is=20
processed)

Does the boundary of "in flight" in the interrupt side (C and D) need to=20
be defined, such that we go BUSY->PENDING->IDLE instead of BUSY->IDLE ?
