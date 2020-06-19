Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725826AbgFSSNN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Jun 2020 14:13:13 -0400
Received: by mail-wr1-f71.google.com with SMTP id d6so4678101wrn.1
        for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2020 11:13:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 2/2] s390/kvm: diagnose 0x318 sync and reset
Date: Fri, 19 Jun 2020 20:13:07 +0200
Message-Id: <3CD269AF-2179-4380-96D0-9A9C551A6153@redhat.com>
References: <91933f00-476b-7e94-29e6-99f96abd5fc3@linux.ibm.com>
In-Reply-To: <91933f00-476b-7e94-29e6-99f96abd5fc3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com



> Am 19.06.2020 um 19:56 schrieb Collin Walling <walling@linux.ibm.com>:
>=20
> =EF=BB=BFOn 6/19/20 1:17 PM, David Hildenbrand wrote:
>>> On 19.06.20 17:47, Collin Walling wrote:
>>> On 6/19/20 10:52 AM, David Hildenbrand wrote:
>>>> On 19.06.20 00:22, Collin Walling wrote:
>>>>> DIAGNOSE 0x318 (diag318) sets information regarding the environment
>>>>> the VM is running in (Linux, z/VM, etc) and is observed via
>>>>> firmware/service events.
>>>>>=20
>>>>> This is a privileged s390x instruction that must be intercepted by
>>>>> SIE. Userspace handles the instruction as well as migration. Data
>>>>> is communicated via VCPU register synchronization.
>>>>>=20
>>>>> The Control Program Name Code (CPNC) is stored in the SIE block. The
>>>>> CPNC along with the Control Program Version Code (CPVC) are stored
>>>>> in the kvm_vcpu_arch struct.
>>>>>=20
>>>>> The CPNC is shadowed/unshadowed in VSIE.
>>>>>=20
>>>>=20
>>>> [...]
>>>>=20
>>>>>=20
>>>>> int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_reg=
s *regs)
>>>>> @@ -4194,6 +4198,10 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcp=
u, struct kvm_run *kvm_run)
>>>>>        if (vcpu->arch.pfault_token =3D=3D KVM_S390_PFAULT_TOKEN_INVALI=
D)
>>>>>            kvm_clear_async_pf_completion_queue(vcpu);
>>>>>    }
>>>>> +    if (kvm_run->kvm_dirty_regs & KVM_SYNC_DIAG318) {
>>>>> +        vcpu->arch.diag318_info.val =3D kvm_run->s.regs.diag318;
>>>>> +        vcpu->arch.sie_block->cpnc =3D vcpu->arch.diag318_info.cpnc;
>>>>> +    }
>>>>>    /*
>>>>>     * If userspace sets the riccb (e.g. after migration) to a valid st=
ate,
>>>>>     * we should enable RI here instead of doing the lazy enablement.
>>>>> @@ -4295,6 +4303,7 @@ static void store_regs_fmt2(struct kvm_vcpu *vcp=
u, struct kvm_run *kvm_run)
>>>>>    kvm_run->s.regs.pp =3D vcpu->arch.sie_block->pp;
>>>>>    kvm_run->s.regs.gbea =3D vcpu->arch.sie_block->gbea;
>>>>>    kvm_run->s.regs.bpbc =3D (vcpu->arch.sie_block->fpf & FPF_BPBC) =3D=
=3D FPF_BPBC;
>>>>> +    kvm_run->s.regs.diag318 =3D vcpu->arch.diag318_info.val;
>>>>>    if (MACHINE_HAS_GS) {
>>>>>        __ctl_set_bit(2, 4);
>>>>>        if (vcpu->arch.gs_enabled)
>>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>>> index 9e9056cebfcf..ba83d0568bc7 100644
>>>>> --- a/arch/s390/kvm/vsie.c
>>>>> +++ b/arch/s390/kvm/vsie.c
>>>>> @@ -423,6 +423,8 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, st=
ruct vsie_page *vsie_page)
>>>>>        break;
>>>>>    }
>>>>>=20
>>>>> +    scb_o->cpnc =3D scb_s->cpnc;
>>>>=20
>>>> "This is a privileged s390x instruction that must be intercepted", how
>>>> can the cpnc change, then, while in SIE?
>>>>=20
>>>> Apart from that LGTM.
>>>>=20
>>>=20
>>> I thought shadow/unshadow was a load/store (respectively) when executing=

>>> in SIE for a level 3+ guest (where LPAR is level 1)?
>>>=20
>>> * Shadow SCB (load shadow VSIE page; originally CPNC is 0)
>>=20
>> 1. Here, you copy the cpnc from the pinned (original) SCB to the shadow S=
CB.
>>=20
>>>=20
>>> * Execute diag318 (under SIE)
>>=20
>> 2. Here the SIE runs using the shadow SCB.
>>=20
>>>=20
>>> * Unshadow SCB (store in original VSIE page; CPNC is whatever code the
>>> guest decided to set)
>>=20
>> 3. Here you copy back the cpnc from the shadow SCB to the pinned
>> (original) SCB.
>>=20
>>=20
>> If 2. cannot modify the cpnc residing in the shadow SCB, 3. can be
>> dropped, because the values will always match.
>>=20
>>=20
>> If guest3 tries to modify the cpnc (via diag 318), we exit the SIE
>> (intercept) in 2., return to our guest 2. guest 2 will perform the
>> change and adapt the original SCB.
>>=20
>> (yep, it's confusing)
>>=20
>> Or did I miss anything?
>>=20
>=20
> Ah, I see. So the shadowing isn't necessarily for SIE block values, but
> for storing the register / PSW / clock states, as well as facility bits
> for the level 3+ guests? Looking at what the

We have to forward all values the SIE has to see and copy back only what cou=
ld have been changed by the SIE.

> vsie code does, that seems
> to make sense.
>=20
> So we don't need to shadow OR unshadow the CPNC, then?

I think you have to shadow (forward the value) but not unshadow (value canno=
t change).

Cheers!

>=20
> --=20
> Regards,
> Collin
>=20
> Stay safe and stay healthy
>=20
