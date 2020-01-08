Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbgAHOfb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 09:35:31 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008ER5vc136370
        for <linux-s390@vger.kernel.org>; Wed, 8 Jan 2020 09:35:30 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xdg1bj857-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Jan 2020 09:35:30 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 8 Jan 2020 14:35:28 -0000
Subject: Re: [PATCH v3] KVM: s390: Add new reset vcpu API
References: <20191205120956.50930-1-frankja@linux.ibm.com>
 <dd724da0-9bba-079e-6b6f-756762dbc942@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 8 Jan 2020 15:35:23 +0100
MIME-Version: 1.0
In-Reply-To: <dd724da0-9bba-079e-6b6f-756762dbc942@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7bCh22BcqRrQcCniO2yPWurqWY883cTpH"
Message-Id: <d0db08ef-ade9-93d4-105f-ace6fef50c81@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7bCh22BcqRrQcCniO2yPWurqWY883cTpH
Content-Type: multipart/mixed; boundary="iI3xbfS85s4k2CoopTNPLgtkxKRHvJzv2"

--iI3xbfS85s4k2CoopTNPLgtkxKRHvJzv2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/8/20 3:28 PM, Christian Borntraeger wrote:
>=20
>=20
> On 05.12.19 13:09, Janosch Frank wrote:
> [...]
>> +4.123 KVM_S390_CLEAR_RESET
>> +
>> +Capability: KVM_CAP_S390_VCPU_RESETS
>> +Architectures: s390
>> +Type: vcpu ioctl
>> +Parameters: none
>> +Returns: 0
>> +
>> +This ioctl resets VCPU registers and control structures that QEMU
>> +can't access via the kvm_run structure. The clear reset is a superset=

>> +of the initial reset and additionally clears general, access, floatin=
g
>> +and vector registers.
>=20
> As Thomas outlined, make it more obvious that userspace does the remain=
ing
> parts. I do not think that we want the kernel to do the things (unless =
it
> helps you in some way for the ultravisor guests)

Ok, will do

>=20
> [...]
>> =20
>> +static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
>> +{
>> +	kvm_clear_async_pf_completion_queue(vcpu);
>> +	kvm_s390_clear_local_irqs(vcpu);
>> +	return 0;
>=20
> Shouldnt we also do=20
>         if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
>                 kvm_s390_vcpu_stop(vcpu);
>=20
> here?

Isn't userspace cpu state ctrl basically a prereq anyway for getting
those new ioctls?

>=20
>=20
>> +}
>> +
>>  static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>  {
>>  	kvm_s390_vcpu_initial_reset(vcpu);
>> @@ -4363,9 +4371,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  		r =3D kvm_arch_vcpu_ioctl_set_initial_psw(vcpu, psw);
>>  		break;
>>  	}
>> +
>> +	case KVM_S390_CLEAR_RESET:
>> +		/* fallthrough */
>>  	case KVM_S390_INITIAL_RESET:
>>  		r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>>  		break;
>=20
> Then we could also do a fallthrough here and do:
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d9e6bf3..c715ae3 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2867,10 +2867,6 @@ static void kvm_s390_vcpu_initial_reset(struct k=
vm_vcpu *vcpu)
>         vcpu->arch.sie_block->pp =3D 0;
>         vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>         vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
> -       kvm_clear_async_pf_completion_queue(vcpu);
> -       if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
> -               kvm_s390_vcpu_stop(vcpu);
> -       kvm_s390_clear_local_irqs(vcpu);
>  }
> =20
>  void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>=20
>=20
>=20
>=20
>> +	case KVM_S390_NORMAL_RESET:
>> +		r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>> +		break;
>>  	case KVM_SET_ONE_REG:
>>  	case KVM_GET_ONE_REG: {



--iI3xbfS85s4k2CoopTNPLgtkxKRHvJzv2--

--7bCh22BcqRrQcCniO2yPWurqWY883cTpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4V6KwACgkQ41TmuOI4
ufhcfBAAx0wYhaNa12HBDyKtFT2PGztBhy//RVjPkYRmbCIng/I9phuDgG/h7q31
NufGzARTRzKYROFsAPPrs46mzxuRuw81k4owgy+LINLXg0kTJW3Bemje/aQupCLW
0dLBH2vkmoPDeHqxWPrKVJtz1M81YDOcEWk39JPOOdB5jCpuRN0XC0JrXVSKN009
a23GXqt5LjS4o6eCUQqNmzHsGu/a0Vjgwf29Huc94GLdeFk2qNQUhZ2LqnoutiUq
4J7hL1YW1NUSC9GGI/QqxPrQimp9PP2fQ1x/vgmQoLyO2bOtrzR+ryc2BuYgLLjP
+vjgc8jRmvoSC+/r+JNBJ6po3x9PHEGyklTMcR7yzZATFqJbPeSaS5U/kV6uOncr
jGHj/pTVdl4fjrA3TGebtIXXGjDQZF4gKUnjghfaFeSfthNWuZZUqfq6GFhoA7ZH
rrHc8cBTxeqFFoFZjKLK6O0onyfrfz5bqRY4HfyfoIpWhbyZvs2vVtP14G0C4dtq
yzEJOkLcUEiSb2yZnlk4063QSKNANnv+8v46qm/ZsaBbTXpBU281GgoWCqcWW4fw
CcpxTJtc9umfPfTQN4kQkf+in21KdLhRfXrce9g3SpeEhAbIua8vNd3sv8Y4YD3J
2ia4lmBLxxXofEfurGlzHQ1lKNZwSNfRTW9mfRqYpIw6i6OdF7Q=
=UOrk
-----END PGP SIGNATURE-----

--7bCh22BcqRrQcCniO2yPWurqWY883cTpH--
