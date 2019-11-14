Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbfKNP4V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 10:56:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEFsqTh104329
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 10:56:20 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w99hbskj2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 10:56:19 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 15:56:16 -0000
Subject: Re: [RFC 19/37] KVM: s390: protvirt: Add new gprs location handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-20-frankja@linux.ibm.com>
 <049b8634-c195-4b3f-4d9c-83a1df7f03f7@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 16:56:12 +0100
MIME-Version: 1.0
In-Reply-To: <049b8634-c195-4b3f-4d9c-83a1df7f03f7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qp2B3f9A6X4xMio4GmyZAWUKMhSuyCZMH"
Message-Id: <80d53c48-25a3-8ec8-ee94-1f7854522df6@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qp2B3f9A6X4xMio4GmyZAWUKMhSuyCZMH
Content-Type: multipart/mixed; boundary="MbsG7KSxNzr6i7hWAKRffv5hJS8klzuE6"

--MbsG7KSxNzr6i7hWAKRffv5hJS8klzuE6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/14/19 3:44 PM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> Guest registers for protected guests are stored at offset 0x380.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  4 +++-
>>  arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/=
kvm_host.h
>> index 0ab309b7bf4c..5deabf9734d9 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -336,7 +336,9 @@ struct kvm_s390_itdb {
>>  struct sie_page {
>>  	struct kvm_s390_sie_block sie_block;
>>  	struct mcck_volatile_info mcck_info;	/* 0x0200 */
>> -	__u8 reserved218[1000];		/* 0x0218 */
>> +	__u8 reserved218[360];		/* 0x0218 */
>> +	__u64 pv_grregs[16];		/* 0x380 */
>> +	__u8 reserved400[512];
>=20
> Maybe add a "/* 0x400 */" comment to be consisten with the other lines?=


Sure

>=20
>>  	struct kvm_s390_itdb itdb;	/* 0x0600 */
>>  	__u8 reserved700[2304];		/* 0x0700 */
>>  };
>=20
>  Thomas
>=20



--MbsG7KSxNzr6i7hWAKRffv5hJS8klzuE6--

--qp2B3f9A6X4xMio4GmyZAWUKMhSuyCZMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NeRwACgkQ41TmuOI4
ufhN3A//Z7KUusoa2kmB1Ah4VrUOR08qe60cqj/uHwLXeP6Yuga6YIgFHUt2OT8U
FM8QndSwGxWLUBLRwZikpOPNCRgysCoXk5gnBg0/u6GCslwBlQfeHZtIB/l4mG7X
0VOmgwed2BoGELFPAnELvIzXTcLhaoYPaqES/h9JQVHS5EqfuwKiYyXnhLFaw6vo
CTJ5NAKMmTKheyABdiZKver66s9u+IMfPGHnABWEDYDTyny7wMPEiCGCU6sKMcSI
x/t78IPpEum6nBPyU/IYCMB/YS/uH27lGla8a90qz/7ZLf8x4yFz3QBdntasJ0ns
+4gk+PTohBnLBQ2o+bO2mcdLq8l71xQBUQoaAv0g3/7v6IIzhnPMS6Dx9kfuUDpR
zhth73dJCS9bTHidOYwlWZ2V98328m0JN344K33d4jLLcbBlgulmlCT3CokQJAmJ
KPNt1nWh24Z/EWkR50v6couIP3RRI1zvtfJmqBoiqg+m3KLUPy+xvPgP7+KQ79b3
GQVfgeVDoqLKQyVhxTocty6nd5U5gvkfwb5ywSzYxHsNRS913G490wpokbOzyfRx
lkfe5aN0fAMBFUuqYUusyxjYrJdXsfDYEs7NPVbKPc83kmxIvDHdB42R2NE+MwwR
XsWusIRfkE7tXQMzDKKsIR+JYSLey+Jae4XQf+H6sx2LWh4Rwj0=
=1R2Y
-----END PGP SIGNATURE-----

--qp2B3f9A6X4xMio4GmyZAWUKMhSuyCZMH--
