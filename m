Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbfKONGz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 08:06:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFD2FYh128436
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 08:06:54 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9jttb3n8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 08:06:53 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 13:06:51 -0000
Subject: Re: [RFC 33/37] KVM: s390: Introduce VCPU reset IOCTL
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-34-frankja@linux.ibm.com>
 <e7a62927-7e0e-1309-d5ad-b4a59149bb6a@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 14:06:47 +0100
MIME-Version: 1.0
In-Reply-To: <e7a62927-7e0e-1309-d5ad-b4a59149bb6a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FInTHdGSJW5w35FgS19iuYyD6iNw8VEPw"
Message-Id: <fde8cd83-035e-5ef6-6b34-455857b3c579@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FInTHdGSJW5w35FgS19iuYyD6iNw8VEPw
Content-Type: multipart/mixed; boundary="iiJa9QxglP50i7DD6B7OdYg2HnQRFgyMt"

--iiJa9QxglP50i7DD6B7OdYg2HnQRFgyMt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 11:47 AM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> With PV we need to do things for all reset types, not only initial...
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 53 +++++++++++++++++++++++++++++++++++++++=
+
>>  include/uapi/linux/kvm.h |  6 +++++
>>  2 files changed, 59 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d3fd3ad1d09b..d8ee3a98e961 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3472,6 +3472,53 @@ static int kvm_arch_vcpu_ioctl_initial_reset(st=
ruct kvm_vcpu *vcpu)
>>  	return 0;
>>  }
>> =20
>> +static int kvm_arch_vcpu_ioctl_reset(struct kvm_vcpu *vcpu,
>> +				     unsigned long type)
>> +{
>> +	int rc;
>> +	u32 ret;
>> +
>> +	switch (type) {
>> +	case KVM_S390_VCPU_RESET_NORMAL:
>> +		/*
>> +		 * Only very little is reset, userspace handles the
>> +		 * non-protected case.
>> +		 */
>> +		rc =3D 0;
>> +		if (kvm_s390_pv_handle_cpu(vcpu)) {
>> +			rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
>> +					   UVC_CMD_CPU_RESET, &ret);
>> +			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET NORMAL VCPU: cpu %d rc %x rrc =
%x",
>> +				   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
>> +		}
>> +		break;
>> +	case KVM_S390_VCPU_RESET_INITIAL:
>> +		rc =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>> +		if (kvm_s390_pv_handle_cpu(vcpu)) {
>> +			uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
>> +				      UVC_CMD_CPU_RESET_INITIAL,
>> +				      &ret);
>> +			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET INITIAL VCPU: cpu %d rc %x rrc=
 %x",
>> +				   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
>> +		}
>> +		break;
>> +	case KVM_S390_VCPU_RESET_CLEAR:
>> +		rc =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>> +		if (kvm_s390_pv_handle_cpu(vcpu)) {
>> +			rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
>> +					   UVC_CMD_CPU_RESET_CLEAR, &ret);
>> +			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET CLEAR VCPU: cpu %d rc %x rrc %=
x",
>> +				   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
>> +		}
>> +		break;
>> +	default:
>> +		rc =3D -EINVAL;
>> +		break;
>=20
> (nit: you could drop the "break;" here)
>=20
>> +	}
>> +	return rc;
>> +}
>> +
>> +
>>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_re=
gs *regs)
>>  {
>>  	vcpu_load(vcpu);
>> @@ -4633,8 +4680,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  		break;
>>  	}
>>  	case KVM_S390_INITIAL_RESET:
>> +		r =3D -EINVAL;
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm))
>> +			break;
>=20
> Wouldn't it be nicer to call
>=20
>   kvm_arch_vcpu_ioctl_reset(vcpu, KVM_S390_VCPU_RESET_INITIAL)
>=20
> in this case instead?

How about:
        case KVM_S390_INITIAL_RESET:


                arg =3D KVM_S390_VCPU_RESET_INITIAL;


        case KVM_S390_VCPU_RESET:


                r =3D kvm_arch_vcpu_ioctl_reset(vcpu, arg);


                break;



>=20
>>  		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>>  		break;
>> +	case KVM_S390_VCPU_RESET:
>> +		r =3D kvm_arch_vcpu_ioctl_reset(vcpu, arg);
>> +		break;
>>  	case KVM_SET_ONE_REG:
>>  	case KVM_GET_ONE_REG: {
>>  		struct kvm_one_reg reg;
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index f75a051a7705..2846ed5e5dd9 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1496,6 +1496,12 @@ struct kvm_pv_cmd {
>>  #define KVM_S390_PV_COMMAND		_IOW(KVMIO, 0xc3, struct kvm_pv_cmd)
>>  #define KVM_S390_PV_COMMAND_VCPU	_IOW(KVMIO, 0xc4, struct kvm_pv_cmd)=

>> =20
>> +#define KVM_S390_VCPU_RESET_NORMAL	0
>> +#define KVM_S390_VCPU_RESET_INITIAL	1
>> +#define KVM_S390_VCPU_RESET_CLEAR	2
>> +
>> +#define KVM_S390_VCPU_RESET    _IO(KVMIO,   0xd0)
>=20
> Why not 0xc5 ?

Fixed

>=20
>  Thomas
>=20



--iiJa9QxglP50i7DD6B7OdYg2HnQRFgyMt--

--FInTHdGSJW5w35FgS19iuYyD6iNw8VEPw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OoucACgkQ41TmuOI4
ufjbhRAAsCsc4E71QYJsHXgyeDy6TG8FUQibjsEErTL5eiwqmb+lkRVFN006f0JC
WFOdawfUnFyl4hCSczOU3hyfKIX0bTLdkbqFaUTREKj76Ug9vjRp14PCA7kOFYRs
a+lTRxh/K2WsONe3uC9lD6W4GIqeVEvj79eKiTFIHoJGI41nZq9xMwvVuvOdrPuL
qiUKeUxpUB4lJFT/m9D4KfxIbG0NWi1wh6iVhuUEPR5VeA2yjLU2THMfqJNtentC
T2sESQQN04sKsStAFSFoqBAaZ0Vx//BOYZkQvS1m+VqTbZZMef0PherD3RNoGcNS
lNiSpJVltap7Wzs5QrPxllSs7s7yCb9DtUBdWQHycM5ryPTOFN9nDB8MCGgJ/JN6
gMdSbMbjZ2CKYTlSWtzR6UsFy0GeTF5c3LUW53SBebKCrts61oTRf/V3YI30XPzy
4A4MTLbkMLTIcmJc+1m+gB4M6kAXKbb6+MpFPdWZmm78xWo5e6uRp50ePorXe4I/
+CaVqZjaoG9bg4e0TdA87awPQGWowDOq6tpnG3FFgieCV7RAlMkbmHNlbS1rgTKM
Pd1FejVD678Lh1fZ7afa98eSXBD9dGnsAPzz2FdMpqwTtoKwIiaIDi80GuCs9Yil
wNamewVUNpUvppGAR3De5eWeruVuC8gcqMowOhHIEc7ww800Mdc=
=IZyR
-----END PGP SIGNATURE-----

--FInTHdGSJW5w35FgS19iuYyD6iNw8VEPw--
