Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbfK2OdT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 09:33:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATEXAQI119310
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:33:18 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wjtts40ak-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:33:17 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 29 Nov 2019 14:33:16 -0000
Subject: Re: [PATCH] KVM: s390: Add new reset vcpu API
References: <20191129142122.21528-1-frankja@linux.ibm.com>
 <bc1d057f-03a0-b850-dff8-a7156bfe3274@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 29 Nov 2019 15:33:09 +0100
MIME-Version: 1.0
In-Reply-To: <bc1d057f-03a0-b850-dff8-a7156bfe3274@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BR9NIGIspKQOZIcJnRcJi4Ezs6P0isVVF"
Message-Id: <8e1aa1af-d929-e36b-f341-aa7dbe27f6a4@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BR9NIGIspKQOZIcJnRcJi4Ezs6P0isVVF
Content-Type: multipart/mixed; boundary="iHS6fPCUWAnOpMZyUFwpZBryG4qHF1gzN"

--iHS6fPCUWAnOpMZyUFwpZBryG4qHF1gzN
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/29/19 3:31 PM, David Hildenbrand wrote:
> On 29.11.19 15:21, Janosch Frank wrote:
>> The architecture states that we need to reset local IRQs for all CPU
>> resets. Because the old reset interface did not support the normal CPU=

>> reset we never did that.
>>
>> Now that we have a new interface, let's properly clear out local IRQs
>> and let this commit be a reminder.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 25 ++++++++++++++++++++++++-
>>  include/uapi/linux/kvm.h |  7 +++++++
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d9e6bf3d54f0..2f74ff46b176 100644
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
>> @@ -3293,6 +3294,25 @@ static int kvm_arch_vcpu_ioctl_initial_reset(st=
ruct kvm_vcpu *vcpu)
>>  	return 0;
>>  }
>> =20
>> +static int kvm_arch_vcpu_ioctl_reset(struct kvm_vcpu *vcpu, unsigned =
long type)
>> +{
>> +	int rc =3D -EINVAL;
>> +
>> +	switch (type) {
>> +	case KVM_S390_VCPU_RESET_NORMAL:
>> +		rc =3D 0;
>> +		kvm_clear_async_pf_completion_queue(vcpu);
>> +		kvm_s390_clear_local_irqs(vcpu);
>> +		break;
>> +	case KVM_S390_VCPU_RESET_INITIAL:
>> +		/* fallthrough */
>> +	case KVM_S390_VCPU_RESET_CLEAR:
>> +		rc =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>=20
> As we now have two interfaces to achieve the same thing (initial reset)=
,
> I do wonder if we should simply introduce
>=20
> KVM_S390_NORMAL_RESET
> KVM_S390_CLEAR_RESET
>=20
> instead ...
>=20
> Then you can do KVM_S390_NORMAL_RESET for the bugfix and
> KVM_S390_CLEAR_RESET later for PV.
>=20
> Does anything speak against that?

Apart from loosing one more ioctl number probably not



--iHS6fPCUWAnOpMZyUFwpZBryG4qHF1gzN--

--BR9NIGIspKQOZIcJnRcJi4Ezs6P0isVVF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3hLCYACgkQ41TmuOI4
ufg0hxAAhFsT3xaNo5wjdsMM9EnfglzO8FespiGRhjq8Zp5gKZFcuC/oCevB/vuh
qEO8mTgML3VDLgAjJBZW9AdSLW2xNP7sdd6Z1u7H3mtA36QU+abRqRpRIzUOWuuk
fN+wMqtzQCP+jq4EcQMS49iRlbw76EtGDMTgCqaHeuhfnonCT6eC76xEsqndIgYm
tYEUB4XtHOZz40zAmiE6g25kaJhsPCkUDC7uDEx/nRuQyI9S+hSKIuGCt1/Hg/U2
oL+XGxTqc8/PXvHfaIFhwxIyh9fWXzZWzCRTDsN5qDMEB3+YbxbU4PwoC4ZXYaqI
erW2xM2mnUfrKUvXIVPWYskJ5oUADPcZKvnrKlOKAwZea02a7EjHDBKCnfz3LNds
t7Ci4eADiR1s6MTtwKNDFaGgz5dCW/otXDrPBfcYSX+xP36ZoIMbkywOX3e1w3L/
KKx8/v4uzqbgVdNSJbw9Y6RrL2HzAyPCfqG10xTFOpLBudMRP/LpCx+JrzMD6pH1
e9MxW0SbO6C7eA/ZU1PqOcHbsRbMO4YOC9hwHCCb8w4moJu65XiRfjI7ayd95asb
ga3IOZFUmnOkTAzU/x0FgtgRhUcr6YnyR6+1x0Ai0v6XTYiSYEPabSiY2Qc/NY/t
x2InzGDE86Q8CJQewayjBrGMMgmsvgu10Aws8rykS9/vP+mhqH8=
=MFLK
-----END PGP SIGNATURE-----

--BR9NIGIspKQOZIcJnRcJi4Ezs6P0isVVF--
