Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727183AbfKOKQb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:16:31 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFAC8ot092592
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 05:16:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nse19kr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 05:16:29 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 10:16:27 -0000
Subject: Re: [RFC 24/37] KVM: s390: protvirt: Write sthyi data to instruction
 data area
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-25-frankja@linux.ibm.com>
 <cf52261e-9281-b11c-fee4-b97013a77ff2@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 11:16:22 +0100
MIME-Version: 1.0
In-Reply-To: <cf52261e-9281-b11c-fee4-b97013a77ff2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R1X0BeEmDhtvdjsMkiqystVIQlo8ovDk1"
Message-Id: <25dcf105-9a25-2e88-287c-c7dfdff429c4@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R1X0BeEmDhtvdjsMkiqystVIQlo8ovDk1
Content-Type: multipart/mixed; boundary="rIo2895KEPxUfb8EOgMhWe372hf1bFWUe"

--rIo2895KEPxUfb8EOgMhWe372hf1bFWUe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 9:04 AM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> STHYI data has to go through the bounce buffer.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/intercept.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
>> index 510b1dee3320..37cb62bc261b 100644
>> --- a/arch/s390/kvm/intercept.c
>> +++ b/arch/s390/kvm/intercept.c
>> @@ -391,7 +391,7 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
>>  		goto out;
>>  	}
>> =20
>> -	if (addr & ~PAGE_MASK)
>> +	if (!kvm_s390_pv_is_protected(vcpu->kvm) && (addr & ~PAGE_MASK))
>>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> =20
>>  	sctns =3D (void *)get_zeroed_page(GFP_KERNEL);
>> @@ -402,10 +402,15 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
>> =20
>>  out:
>>  	if (!cc) {
>> -		r =3D write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
>> -		if (r) {
>> -			free_page((unsigned long)sctns);
>> -			return kvm_s390_inject_prog_cond(vcpu, r);
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			memcpy((void *)vcpu->arch.sie_block->sidad, sctns,
>=20
> sidad & PAGE_MASK, just to be sure?

How about a macro or just saving the pointer in an arch struct?

>=20
>> +			       PAGE_SIZE);
>> +		} else {
>> +			r =3D write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
>> +			if (r) {
>> +				free_page((unsigned long)sctns);
>> +				return kvm_s390_inject_prog_cond(vcpu, r);
>> +			}
>>  		}
>>  	}
>> =20
>>
>=20
> With "& PAGE_MASK":
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20



--rIo2895KEPxUfb8EOgMhWe372hf1bFWUe--

--R1X0BeEmDhtvdjsMkiqystVIQlo8ovDk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OevYACgkQ41TmuOI4
ufhI8w//Um54bh3fscX0u4pd2SuoEv94BXoNziNR7iSPz2HsE2KE1ufvXTUhxTJY
erXWPv8K2occVrTJNCG9doSJbAiZuRNwqq/PbcdHR9IuhVGyzlG+0EnCxxILtPeN
fA67kH3A0afkZvRRZc1n8v2mfbF8sJya8N1FyMD2Fg8X960lUouzvaTxYrStX3Xl
Y3sCPnn4yT/UmvLWoCq5mt674nzu6F7paYCKpk0OLXqRcjBXHVgGFnlC5LvBt529
2F4WiEYawtt51jnnsbPUIQs/p9z0YC7NQ3YeXKG/Du3MS9KSQRDDLH+V52JN+AaM
OC+i8nBzkXNpMVF72D1s/ipVERudlnAjVF/3nQDn1JSDxp0TdM08j/TJGVtE0B1y
rOhGODhCRGilh+4ge7oVTFJTpKYCqe3eYZp3HDy79kT9Lpgb+HWcuD8irYYZsXUk
dlpsRjhjrJ591mE78LxWPfFLv01xAXV2xpiBOed7S6FpCX6eYBiO+F4qmA464TlT
AExkO/WaERfKMsIzMQOxHyxt7OcUfgocIKUyU+AmjxEO/apk4Vc/g1m9aOd9Ej4Q
keZSFzede8/H1A46pkTCk1ITVCjG3ZGRP2MMbiDgFfbZ26W3mnT8clyCfVRB9il3
UabkFOi42FUB2IlWS6d679dw/XJ60YvUP4qv/IWf3AhPTGMyKsI=
=mcs8
-----END PGP SIGNATURE-----

--R1X0BeEmDhtvdjsMkiqystVIQlo8ovDk1--
