From: Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Wed, 30 Jan 2019 09:32:50 -0500
Message-ID: <12c10ee1-2ef4-313f-459a-132f4e7900d8@linux.ibm.com>
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
	<20190129203933.4e57cd91@oc2783563651>
	<20190130142956.57f9eff3.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190130142956.57f9eff3.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/30/2019 08:29 AM, Cornelia Huck wrote:
> On Tue, 29 Jan 2019 20:39:33 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
>> On Tue, 29 Jan 2019 10:58:40 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>>>>> The problem I see with the let the hardware sort it out is that, f=
or
>>>>>> that to work, we need to juggle multiple translations simultaneous=
ly
>>>>>> (or am I wrong?). Doing that does not appear particularly simple t=
o
>>>>>> me.
>>>>>
>>>>> None in the first stage, at most two in the second stage, I guess.
>>>>>       =20
>>>>
>>>> Expected benefit of the second stage over the first stage? (I see no=
ne.)
>>>
>>> Making something possible that is allowed by the architecture. Not
>>> really important, though.
>>>   =20
>>
>> I had a chat with Farhan, and he suggested that by 'allowed by
>> architecture' you mean " You can submit a new request if the subchanne=
l
>> is pending with primary, but not with secondary state." (from Message-=
ID:
>> <20190125152154.05120461.cohuck@redhat.com>).
>=20
> Yes. I might have mixed things up, though.
>=20
>>
>> So I re-read the PoP.
>>
>>  From the description of the start subchannel instruction:
>> """
>> Special Conditions
>>
>> Condition code 1 is set, and no other action is
>> taken, when the subchannel is status pending when
>> START SUBCHANNEL is executed. On some mod-
>> els, condition code 1 is not set when the subchannel
>> is status pending with only secondary status; instead,
>> the status-pending condition is discarded.
>>
>> Condition code 2 is set, and no other action is
>> taken, when a start, halt, or clear function is currently
>> in progress at the subchannel (see =E2=80=9CFunction Control
>> (FC)=E2=80=9D on page 13).
>>
>> """
>>
>> So I guess you mixed primary and secondary up and wanted to say:
>> "You can submit a new request if the subchannel
>> is pending with _secondary_, but not with _primary_ _status_."
>>
>> But does that really mean architecture allows the subchannel
>> to accept multiple ssch() instructions so that it ends up processing
>> two or more channel programs in parallel.
>=20
> That's not what I meant. The vfio-ccw driver still holds on to one cp,
> while a second one could be submitted.
>=20
> But let's just end discussing this here, and continue with discussing
> the reworked state machine, ok? It's not really relevant for going
> forward with halt/clear.
>=20
>=20
+1
  I think we should move forward with halt/clear.

Thanks
Farhan
