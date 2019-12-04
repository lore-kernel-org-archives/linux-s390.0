Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726899AbfLDKG1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Dec 2019 05:06:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4A3BL0107554
        for <linux-s390@vger.kernel.org>; Wed, 4 Dec 2019 05:06:26 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wnsd4wh5r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2019 05:06:25 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 4 Dec 2019 10:06:24 -0000
Subject: Re: [PATCH v2] KVM: s390: Add new reset vcpu API
References: <20191203162055.3519-1-frankja@linux.ibm.com>
 <c22eefd7-2c99-ec8e-3b5c-fabb343230a9@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 4 Dec 2019 11:06:19 +0100
MIME-Version: 1.0
In-Reply-To: <c22eefd7-2c99-ec8e-3b5c-fabb343230a9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ExzxFqnbt3eXJ62bVySFXO6EKLyH0uwqt"
Message-Id: <26845508-9a35-7ec6-fc01-49ab4b7e3473@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ExzxFqnbt3eXJ62bVySFXO6EKLyH0uwqt
Content-Type: multipart/mixed; boundary="GPdkDX2PbElgakyMyjFk2AgB9GNHvM5TW"

--GPdkDX2PbElgakyMyjFk2AgB9GNHvM5TW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/4/19 10:32 AM, Thomas Huth wrote:
> On 03/12/2019 17.20, Janosch Frank wrote:
>> The architecture states that we need to reset local IRQs for all CPU
>> resets. Because the old reset interface did not support the normal CPU=

>> reset we never did that.
>>
>> Now that we have a new interface, let's properly clear out local IRQs
>> and let this commit be a reminder.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 13 +++++++++++++
>>  include/uapi/linux/kvm.h |  4 ++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d9e6bf3d54f0..602214c5616c 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -529,6 +529,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
>>  	case KVM_CAP_S390_CMMA_MIGRATION:
>>  	case KVM_CAP_S390_AIS:
>>  	case KVM_CAP_S390_AIS_MIGRATION:
>> +	case KVM_CAP_S390_VCPU_RESETS:
>>  		r =3D 1;
>>  		break;
>>  	case KVM_CAP_S390_HPAGE_1M:
>> @@ -3287,6 +3288,13 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(stru=
ct kvm_vcpu *vcpu,
>>  	return r;
>>  }
>> =20
>> +static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
>> +{
>> +	kvm_clear_async_pf_completion_queue(vcpu);
>> +	kvm_s390_clear_local_irqs(vcpu);
>> +	return 0;
>> +}
>> +
>>  static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>  {
>>  	kvm_s390_vcpu_initial_reset(vcpu);
>> @@ -4363,7 +4371,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  		r =3D kvm_arch_vcpu_ioctl_set_initial_psw(vcpu, psw);
>>  		break;
>>  	}
>> +	case KVM_S390_NORMAL_RESET:
>> +		r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>> +		break;
>>  	case KVM_S390_INITIAL_RESET:
>> +		/* fallthrough */
>> +	case KVM_S390_CLEAR_RESET:
>>  		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>>  		break;
>=20
> Isn't clear reset supposed to do more than the initial reset? If so, I'=
d
> rather expect it the other way round:

In the PV patch I remove the fallthrough and add a function for the
clear reset. I add the UV reset calls into the
kvm_arch_vcpu_ioctl_*_reset() functions, therefore I can't fallthrough
because the Ultravisor does currently not allow staged resets (i.e.
first initial then clear if a clear reset is needed)

>=20
> 	case KVM_S390_CLEAR_RESET:
> 		/* fallthrough */
> 	case KVM_S390_INITIAL_RESET:
> 		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
> 		break;
>=20
> ... so you can later add the additional stuff before the "/* fallthroug=
h
> */"?
>=20
>  Thomas
>=20



--GPdkDX2PbElgakyMyjFk2AgB9GNHvM5TW--

--ExzxFqnbt3eXJ62bVySFXO6EKLyH0uwqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3nhRsACgkQ41TmuOI4
ufgFkRAAwNIEGdeEBZGd8XPkNrABROS1n6A8Al2gsi/gXIU94pLgh+VX0JhTByuL
m3uKbABDr9i2L8rfcKVW2EwXcMGBHtCnGS/fHyvjgNnTvbGFyBNOcYNi5QrQv9iy
2zxPgPFdUr9QO0EdjAf5j6M4LQwZm3SLz5dVD6zvaACGSYg4zFuDDEg9HLtq2D6Z
e5hbAijwfCkdBjiZNLtMC6hMtJn1srO0w/IbGTjCBt1ItkrYXNrR64ZmP0Bsfj6w
N42ohiBD1VCJ9KV42/P7I0b+uO38Db+7fUAp8wqJiMGUrEK9eZdYbXbLiRoYEteK
HbsDAmmoKgZaP7y2RhxQYKHdN0XyBHy/afUhANsDEWBaHJ6IOG64EosCdmiShw6J
qPzMAA0F4W2tEwEmpQj/hVR5ruXhGVZxRMSvvoUGn+PZBzHnoJjRDsAuZwO7Qro0
ss0FEHb9RCuth55nlMPIoUvoNRwhXO38QUjZrjmJ3Z+Yy6JWJO06Tz3JqAln8G25
tY3aV9p98uN+9kXTyFZd4BOSQpdWQMmRsytAGfucIkU0yI+iaqvY2yMwQchsawmq
9pj5j3+rOp1iUJKJq5CpQubPwDdadMiPJek/nvvvSM6Ai4VftYlFM1osRzk6ApgQ
D/xavQBZRFf9P3Taiiqrd5Izcqjrx5jWHoYc15ARl9XEkN8VZko=
=uT3n
-----END PGP SIGNATURE-----

--ExzxFqnbt3eXJ62bVySFXO6EKLyH0uwqt--
