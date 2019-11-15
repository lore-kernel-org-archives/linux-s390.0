Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbfKOLiF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 06:38:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFBWsXB033784
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 06:38:03 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w9jtvt9gp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 06:38:03 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 11:38:01 -0000
Subject: Re: [RFC 35/37] KVM: s390: Fix cpu reset local IRQ clearing
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-36-frankja@linux.ibm.com>
 <6128cef9-5780-a5dd-68a1-62d7cfeaf05a@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 12:37:57 +0100
MIME-Version: 1.0
In-Reply-To: <6128cef9-5780-a5dd-68a1-62d7cfeaf05a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vDEtcf0lPdu94hX9l4qJc7eI1vgURv0n8"
Message-Id: <c4214ae3-483e-5b68-8b68-73ac3b4f3ea1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vDEtcf0lPdu94hX9l4qJc7eI1vgURv0n8
Content-Type: multipart/mixed; boundary="NK9JZlCj9SzSpbumC42VvYdNEWZf5wXFV"

--NK9JZlCj9SzSpbumC42VvYdNEWZf5wXFV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 12:23 PM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> The architecture states that we need to reset local IRQs for all CPU
>> resets. Because the old reset interface did not support the normal CPU=

>> reset we never did that.
>>
>> Now that we have a new interface, let's properly clear out local IRQs
>> and let this commit be a reminder.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index ba6144fdb5d1..cc5feb67f145 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3485,6 +3485,8 @@ static int kvm_arch_vcpu_ioctl_reset(struct kvm_=
vcpu *vcpu,
>>  		 * non-protected case.
>>  		 */
>>  		rc =3D 0;
>> +		kvm_clear_async_pf_completion_queue(vcpu);
>> +		kvm_s390_clear_local_irqs(vcpu);
>>  		if (kvm_s390_pv_handle_cpu(vcpu)) {
>>  			rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
>>  					   UVC_CMD_CPU_RESET, &ret);
>>
>=20
> I think you could squash this into patch 33/37 where you've introduced
> the RESET_NORMAL (and adjust the patch description there).
>=20
>  Thomas
>=20

Yes, that hunk was singled out to have an item to discuss internally.
Since we now established, that it is needed, I can squash it.


--NK9JZlCj9SzSpbumC42VvYdNEWZf5wXFV--

--vDEtcf0lPdu94hX9l4qJc7eI1vgURv0n8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OjhUACgkQ41TmuOI4
ufjRvw/+L4XX9ZE2pt1DqwjknPSh7pUIj1wKrt+N0pCdtW78gx1HrtQH/m5cdWds
26akSsFjWLipNdSZ+Ce5eBgUpi+lz7DFaT5EdWVX3t5UtBUskYN3xgSHl4vtSavN
DJb2YUZENNmKtn6RKg9O4L8Sz/HdKVc5Z10689VuqcWMTXGWCBSY9bNZkV+g5eAe
dcjeQdMSv2VmZuUC1Zo6tY0jfGOHSIDogthmmXi+48pcurlO2ljAfh7drzCAcVj0
K4niO3emSkE1hOfuP6mSddKNqH84Bz63hzjJdzZSnccTAvpc34hCSv1ZJFWgwCGq
vBZxdcw6EDZ4WzG1OwsQLVRO8CENePkndaUYPUdGUAN1P6ErbuLvx1SyQBV4mIn2
/HFagU+8mP9m7DvMlslKL4KNtg10S1f+cm2laxSkLTpLKa7U28VuS4zmqZdP4UQh
gxvAcm+ih1SxehOqNUBzZFfT5RT81aYaCDkAhDHUEORTm8QL8WLfrApgwCITetFJ
PI/5h6TziBz1ERHwXs0PyF2by1TOkcUWjAiXS/WF8F073Y9P5aTDyl9sEVP0GC8i
T0FOo712vfA2UWzt6c9f3NvVA7JeV0rsncaQa0k3YH62Y5+Cw/HmkJNc6b3OM/yX
vAt5bFSHuzVKJV4Hon8KfJx0deI5Mhi2QLoL8II32DXRbXMJ+xo=
=TCfJ
-----END PGP SIGNATURE-----

--vDEtcf0lPdu94hX9l4qJc7eI1vgURv0n8--
