From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] cpu-model/s390: Add processor
 property routines
Date: Fri, 20 Feb 2015 16:41:49 +0100
Message-ID: <54E755BD.5000705@suse.de>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>	<1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>	<54E73EB2.6050700@suse.de> <20150220163209.4e082e0b@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220163209.4e082e0b@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

Am 20.02.2015 um 16:32 schrieb Michael Mueller:
> On Fri, 20 Feb 2015 15:03:30 +0100
> Alexander Graf <agraf@suse.de> wrote:
>=20
>>>
>>> - s390_get_proceccor_props()
>>> - s390_set_proceccor_props()
>>>
>>> They can be used to request or retrieve processor related informati=
on from an accelerator.
>>> That information comprises the cpu identifier, the ICB value and th=
e facility lists.
>>>
>>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com> =20
>>
>> Hrm, I still seem to miss the point of this interface. What do you n=
eed
>> it for?
>=20
> These functions make the internal s390 cpu model API independent from=
 a specific accelerator: =20
>=20
> int s390_set_processor_props(S390ProcessorProps *prop)
> {
>     if (kvm_enabled()) {
>         return kvm_s390_set_processor_props(prop);
>     }
>     return -ENOSYS;
> }
>=20
> It's called by:
>=20
> s390_select_cpu_model(const char *model)
>=20
> which is itself called by:
>=20
> S390CPU *cpu_s390x_init(const char *cpu_model)
> {
>     S390CPU *cpu;
>=20
>     cpu =3D S390_CPU(object_new(s390_select_cpu_model(cpu_model)));
>=20
>     object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
>=20
>     return cpu;
> }
>=20
> So above s390_set/get_processor_props() the code is accelerator indep=
endent.

Can't you just implement the class-level name-to-ObjectClass callback
that other CPUs have grown for the above use case?

Also a general comment: cpu-model/ is not an existing directory nor one
you add, so please use "target-s390x: Add foo to S390CPU" or so.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N=FCrnberg)
