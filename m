Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbfKSLgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 06:36:31 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJBWrq4111124
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 06:36:30 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf579n3n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 06:36:30 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 19 Nov 2019 11:36:29 -0000
Subject: Re: [RFC 23/37] KVM: s390: protvirt: Make sure prefix is always
 protected
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-24-frankja@linux.ibm.com>
 <ded0154c-a9b4-4419-14c8-a34095494d82@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 19 Nov 2019 12:36:24 +0100
MIME-Version: 1.0
In-Reply-To: <ded0154c-a9b4-4419-14c8-a34095494d82@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r96P6bmXUHkwtLw6Y9aFNZgIB8pjwkINf"
Message-Id: <ab65cb14-e9b1-aced-9068-11d2ca566093@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r96P6bmXUHkwtLw6Y9aFNZgIB8pjwkINf
Content-Type: multipart/mixed; boundary="2g65zlWkLNPx2YehiJq15LI9IfSdpeiDQ"

--2g65zlWkLNPx2YehiJq15LI9IfSdpeiDQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/19/19 11:18 AM, David Hildenbrand wrote:
> On 24.10.19 13:40, Janosch Frank wrote:
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index eddc9508c1b1..17a78774c617 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3646,6 +3646,15 @@ static int kvm_s390_handle_requests(struct kvm_=
vcpu *vcpu)
>>   		rc =3D gmap_mprotect_notify(vcpu->arch.gmap,
>>   					  kvm_s390_get_prefix(vcpu),
>>   					  PAGE_SIZE * 2, PROT_WRITE);
>> +		if (!rc && kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			rc =3D uv_convert_to_secure(vcpu->arch.gmap,
>> +						  kvm_s390_get_prefix(vcpu));
>> +			WARN_ON_ONCE(rc && rc !=3D -EEXIST);
>> +			rc =3D uv_convert_to_secure(vcpu->arch.gmap,
>> +						  kvm_s390_get_prefix(vcpu) + PAGE_SIZE);
>> +			WARN_ON_ONCE(rc && rc !=3D -EEXIST);
>> +			rc =3D 0;
>> +		}
>=20
> ... what if userspace reads the prefix pages just after these calls?=20
> validity? :/

Currently yes, we're working with firmware to fix this.

>=20
>>   		if (rc) {
>>   			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
>>   			return rc;
>>
>=20



--2g65zlWkLNPx2YehiJq15LI9IfSdpeiDQ--

--r96P6bmXUHkwtLw6Y9aFNZgIB8pjwkINf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3T07gACgkQ41TmuOI4
ufiZZw/+KG8Ugl2/ARQI9jsKFfVRqwX3Q5DmxTBDiyuGO0UWlJTe6RiaLS3hTRjL
tWbE+LvD1U1gjXQtc4VgedVfJL8nYIzNwHU93iEXqYIHSHbWIaiRwTNLDa6OPu0A
ikPRUHHOS9uL8mD+KdYKUlp9+22NUuQ8D1VRVoaQtP+G2pzERXRKY03VNrd7LbDJ
3ojJFVDOSwMKTbKiSbMrqGLvwFONQ1EGYO6TsBbO4hu1z/xcNG8qXQtBrQXedP07
AhbEhlvUHltf426Tqt4R4Si9cgkbtyTG6Cf+yI098FAEfm9sRqBgq0Lfu7EehJ8c
mz5AiNsK0dancuLafFDbQA70f35eTuoWSTh1rhYyiSCgBzCCAuXJkDyHSad1T5Jp
OOxyqwuwbEtuauzrWhYUzgpuQ6vR9RoDzDld1Oe0EYkfelu+w9TkfgAYZae688AA
Sk+l14Sj4ohBbX40mhReTBc2yDb/AK49wnBflgnOY8iiNk/YHYkJ46S6iCsJU5hL
cioA/FHIiK0FRWq/vfvWT7DgDzkizFioom4iYbWETdj+T7+ECJNFI5epICIzloHW
zfYZ3jEUPo09HMkFepa06S0Kx8Ys4gaeqEFo1GeP5a96LHB/3RHmHVJ2D3wR0F9w
vljIbd6xo1BSRwaIXd5ohl9ryS1yUzSG048mIyVR4PsugVhmS6Y=
=VII4
-----END PGP SIGNATURE-----

--r96P6bmXUHkwtLw6Y9aFNZgIB8pjwkINf--
