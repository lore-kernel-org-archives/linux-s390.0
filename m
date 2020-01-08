Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgAHOmw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 09:42:52 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008Egm3d115769
        for <linux-s390@vger.kernel.org>; Wed, 8 Jan 2020 09:42:52 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xdfxf2u2w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Jan 2020 09:42:51 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 8 Jan 2020 14:42:34 -0000
Subject: Re: [PATCH v3] KVM: s390: Add new reset vcpu API
References: <20191205120956.50930-1-frankja@linux.ibm.com>
 <dd724da0-9bba-079e-6b6f-756762dbc942@de.ibm.com>
 <3b37f523-d67f-ba6c-8e14-77183f73a58a@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 8 Jan 2020 15:42:29 +0100
MIME-Version: 1.0
In-Reply-To: <3b37f523-d67f-ba6c-8e14-77183f73a58a@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s16VNpgLwBoSSHNUICg803qFy8EVHnIEJ"
Message-Id: <12d48cb4-40be-3044-d417-debceddcf011@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s16VNpgLwBoSSHNUICg803qFy8EVHnIEJ
Content-Type: multipart/mixed; boundary="zWs3JpglHZLx1Cp2bLz70nnMm5WHvIMlC"

--zWs3JpglHZLx1Cp2bLz70nnMm5WHvIMlC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/8/20 3:35 PM, Christian Borntraeger wrote:
>=20
>=20
> On 08.01.20 15:28, Christian Borntraeger wrote:
>>
>>
>> On 05.12.19 13:09, Janosch Frank wrote:
>> [...]
>>> +4.123 KVM_S390_CLEAR_RESET
>>> +
>>> +Capability: KVM_CAP_S390_VCPU_RESETS
>>> +Architectures: s390
>>> +Type: vcpu ioctl
>>> +Parameters: none
>>> +Returns: 0
>>> +
>>> +This ioctl resets VCPU registers and control structures that QEMU
>>> +can't access via the kvm_run structure. The clear reset is a superse=
t
>>> +of the initial reset and additionally clears general, access, floati=
ng
>>> +and vector registers.
>>
>> As Thomas outlined, make it more obvious that userspace does the remai=
ning
>> parts. I do not think that we want the kernel to do the things (unless=
 it
>> helps you in some way for the ultravisor guests)
>=20
> On the other hand. todays initial cpu reset DOES everything. So I guess=

> the other ones should do the same. That actually makes the semantics cl=
earer -
> when you call it it will have done whatever reset you have asked for.

Ok, will do, thanks for the clearup

>=20
>=20
>>
>> [...]
>>> =20
>>> +static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
>>> +{
>>> +	kvm_clear_async_pf_completion_queue(vcpu);
>>> +	kvm_s390_clear_local_irqs(vcpu);
>>> +	return 0;
>>
>> Shouldnt we also do=20
>>         if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
>>                 kvm_s390_vcpu_stop(vcpu);
>>
>> here?
>>
>>
>>> +}
>>> +
>>>  static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>>  {
>>>  	kvm_s390_vcpu_initial_reset(vcpu);
>>> @@ -4363,9 +4371,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>>  		r =3D kvm_arch_vcpu_ioctl_set_initial_psw(vcpu, psw);
>>>  		break;
>>>  	}
>>> +
>>> +	case KVM_S390_CLEAR_RESET:
>>> +		/* fallthrough */
>>>  	case KVM_S390_INITIAL_RESET:
>>>  		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>>>  		break;
>>
>> Then we could also do a fallthrough here and do:
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d9e6bf3..c715ae3 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2867,10 +2867,6 @@ static void kvm_s390_vcpu_initial_reset(struct =
kvm_vcpu *vcpu)
>>         vcpu->arch.sie_block->pp =3D 0;
>>         vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>>         vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
>> -       kvm_clear_async_pf_completion_queue(vcpu);
>> -       if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
>> -               kvm_s390_vcpu_stop(vcpu);
>> -       kvm_s390_clear_local_irqs(vcpu);
>>  }
>> =20
>>  void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>>
>>
>>
>>
>>> +	case KVM_S390_NORMAL_RESET:
>>> +		r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>>> +		break;
>>>  	case KVM_SET_ONE_REG:
>>>  	case KVM_GET_ONE_REG: {
>=20



--zWs3JpglHZLx1Cp2bLz70nnMm5WHvIMlC--

--s16VNpgLwBoSSHNUICg803qFy8EVHnIEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4V6lUACgkQ41TmuOI4
ufgCMQ/6AkBkCw6oX1vSOWmARTZABYD2992zCpZ7ZomAKJl8OqWnI0oSV61b4EbN
z4ZjlrH4V2TPMaftuCbiqbOt4MPVOd/wYA9cT0Ir7rZde5MznJ5ZRdr9WIyVlf9B
LoezAreXU4M2Csmh84Uf2YKo/auNVC4H1dT8JpWNwVvLSJUPiax/uK4KC7ol47WB
W7/BiM9m+afK1FUjGJmRVkW7v4Pifh08ShPT7oxPIEofOq6qaoabv3kqeubcD7me
L4iPwOHsgUdB0ZrIoJZCiuuVCtEF3vCWvtrVSbDbN8dJbT6UZyw8Bn6lwWicXGpl
KdzTyObwiqj8h5WJ2WKWYy31XjOyWjMARFvkZERO270RcSg09gINPOYil2FPtb7+
p329l8ug8/dy662EputbCVqGefbYT2ud/BhUbZNn10rmfzQV6F/aKfFqOJslMGVO
39194Nz1hsNJu3+QvltiO2aVd8rE5ILs+2lSW2iqDmdTFAo5N1yNDaAtYBgKeyWY
LMLM3C0aGkH4uuVWvgNZe6PLp0uvNYyJfA9Gxv5cIzJmOjOzLS8oGvEUaIkTrjRs
XEyoA4EnIenxfECMHLOY/VIiHfSuMI1lCUgvMxWfzoFoxpWWx8OeM0jYr07M3WCV
xX8J0Gv7ZO5NLF/Gp18rx4/LrKlFyhjaAxyE+KjCG/XGVsmZ9gA=
=+zyq
-----END PGP SIGNATURE-----

--s16VNpgLwBoSSHNUICg803qFy8EVHnIEJ--
