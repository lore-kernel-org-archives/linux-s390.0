From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 10:55:25 +0200
Message-ID: <5728677D.206@de.ibm.com>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
 <20160502133428.GA30059@potion> <57276489.2050902@de.ibm.com>
 <20160502152517.GB30059@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160502152517.GB30059@potion>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 05/02/2016 05:25 PM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
[...]
>> I have some pathological cases where I can easily get all CPUs to po=
ll all
>> the time without the shrinking part of the patch. (e.g. guest with 1=
6 CPUs,
>> 8 null block devices and 64 dd reading small blocks with O_DIRECT fr=
om these disks)
>> which cause permanent exits which consumes all 16 host CPUs. Limitin=
g the grow
>> did not seem to be enough in my testing, but when I also made shrink=
ing more
>> aggressive things improved.
>=20
> So the problem is that a large number of VCPUs and devices will often
> have a floating irq and the polling always succeeds unless halt_poll_=
ns
> is very small.  Poll window doesn't change if the poll succeds,
> therefore we need a very agressive shrinker in order to avoid polling=
?

Yes, thats what I concluded after experimenting.

>=20
>> But I am certainly open for other ideas how to tune this.
>=20
> I don't see good improvements ... the problem seems to lie elsewhere:
> Couldn't we exclude floating irqs from kvm_vcpu_check_block()?
>=20
> (A VCPU running for other reasons could still handle a floating irq a=
nd
>  we always kick one VCPU, so VM won't starve and other VCPUs won't be
>  prevented from sleeping.)


I thought about that in my first experiments, but we really have to lea=
ve
vcpu_block for all cases otherwise we might add huge latencies or even=20
starve the delivery. For example the other CPUs can block specific=20
interruption subclass via the control register 6.=20


>>> It would make more sense to me, because we are not interested in la=
tency
>>> of invalid wakeups, so they shouldn't affect valid ones.
>>>
>>>>  	} else
>>>>  		vcpu->halt_poll_ns =3D 0;
>>>> +	vcpu_reset_wakeup(vcpu);
>>>> =20
>>>>  	trace_kvm_vcpu_wakeup(block_ns, waited);
>>>
>>> (Tracing valid/invalid wakeups could be useful.)
>>
>> As an extension of the old trace events?
>=20
> Yes.
>=20
