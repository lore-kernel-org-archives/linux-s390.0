Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfJ3R6R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 13:58:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9UHJ4EO024615
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2019 13:58:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyead2vcf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2019 13:58:16 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 30 Oct 2019 17:58:14 -0000
Subject: Re: [RFC 12/37] KVM: s390: protvirt: Handle SE notification
 interceptions
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-13-frankja@linux.ibm.com>
 <a3d3923a-4047-9d6e-8caf-a07c294e8c7a@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 30 Oct 2019 18:58:08 +0100
MIME-Version: 1.0
In-Reply-To: <a3d3923a-4047-9d6e-8caf-a07c294e8c7a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9njPz0MR3Ie7OdJLYN1ViX9BYSDd8kC5A"
Message-Id: <5a9facd2-3981-ff55-d861-e818cad3fd18@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9njPz0MR3Ie7OdJLYN1ViX9BYSDd8kC5A
Content-Type: multipart/mixed; boundary="o2tJgswU0X4rSbn7KY5x9f3YsFhghwkUP"

--o2tJgswU0X4rSbn7KY5x9f3YsFhghwkUP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/30/19 4:50 PM, David Hildenbrand wrote:
> On 24.10.19 13:40, Janosch Frank wrote:
>> Since KVM doesn't emulate any form of load control and load psw
>> instructions anymore, we wouldn't get an interception if PSWs or CRs
>> are changed in the guest. That means we can't inject IRQs right after
>> the guest is enabled for them.
>>
>> The new interception codes solve that problem by being a notification
>> for changes to IRQ enablement relevant bits in CRs 0, 6 and 14, as
>> well a the machine check mask bit in the PSW.
>>
>> No special handling is needed for these interception codes, the KVM
>> pre-run code will consult all necessary CRs and PSW bits and inject
>> IRQs the guest is enabled for.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  2 ++
>>   arch/s390/kvm/intercept.c        | 18 ++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/=
kvm_host.h
>> index d4fd0f3af676..6cc3b73ca904 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -210,6 +210,8 @@ struct kvm_s390_sie_block {
>>   #define ICPT_PARTEXEC	0x38
>>   #define ICPT_IOINST	0x40
>>   #define ICPT_KSS	0x5c
>> +#define ICPT_PV_MCHKR	0x60
>> +#define ICPT_PV_INT_EN	0x64
>>   	__u8	icptcode;		/* 0x0050 */
>>   	__u8	icptstatus;		/* 0x0051 */
>>   	__u16	ihcpu;			/* 0x0052 */
>> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
>> index a389fa85cca2..acc1710fc472 100644
>> --- a/arch/s390/kvm/intercept.c
>> +++ b/arch/s390/kvm/intercept.c
>> @@ -480,6 +480,24 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcp=
u)
>>   	case ICPT_KSS:
>>   		rc =3D kvm_s390_skey_check_enable(vcpu);
>>   		break;
>> +	case ICPT_PV_MCHKR:
>> +		/*
>> +		 * A protected guest changed PSW bit 13 to one and is now
>> +		 * enabled for interrupts. The pre-run code will check
>> +		 * the registers and inject pending MCHKs based on the
>> +		 * PSW and CRs. No additional work to do.
>> +		 */
>> +		rc =3D 0;
>> +		break;
>> +	case  ICPT_PV_INT_EN:
>> +		/*
>> +		 * A protected guest changed CR 0,6,14 and may now be
>> +		 * enabled for interrupts. The pre-run code will check
>> +		 * the registers and inject pending IRQs based on the
>> +		 * CRs. No additional work to do.
>> +		 */
>> +		rc =3D 0;
>> +	break;
>=20
> Wrong indentation.
>=20
> Maybe simply
>=20
> case ICPT_PV_MCHKR:
> ICPT_PV_INT_EN:
> 	/*
> 	 * PSW bit 13 or a CR (0, 6, 14) changed and we might now be
>           * able to deliver interrupts. pre-run code will take care of
>           * this.
> 	 */
> 	rc =3D 0;
> 	break;

Sounds good, I'll fix it



--o2tJgswU0X4rSbn7KY5x9f3YsFhghwkUP--

--9njPz0MR3Ie7OdJLYN1ViX9BYSDd8kC5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl25zzAACgkQ41TmuOI4
ufhnohAAsMxqj1o3usNXOyEMnqZ24bQqsAeI7ah1WRUKybCAnmGGGIT2MIJrmrJz
2PlzVXV1WVlyY0aJPmO+JR10WDlcSDgzEwErogeNlnG56FNpw5GQgwtOHTxQU6m7
411lxMoU1dtAsxRKtKEBSyg4s0g6AAz632MtRor6SQ7hF7e24ZSodeCX6wctuoen
CHaBoD92+LqwYWdsiPiescldlQuGixxdy0UIXtoalYSpKrLZZWhllslX+6Pa7R6M
ncy/Lx53Fotg+qnYukuzwLFNfTmweYbUrkX5rH0WmBPfGPP71mr1P0aiHbvM/SlB
kHGf0ccsVD9hUmYSiIMZkJN8zfVmojRq6mf6N7whAUvrhZAT19uNpFGvIezIBlG3
/tpacBdl4Lpsh2KT4sNFlU1WAPvZa6LHeZmmSn/6Erym7HG5pIl+EpHmuGwW2n73
HPfjDqLkvU5Bi2RrQdEHzYG6BI48e/XYSwRv6GJaPeKFcp54GHhqMbgFQ5H9xSU5
PNhyxacUhPkjgXj+EdZ4zDSMozQ4yAQ4FsLqnM/9I4fpa8Zvlz6VeTCm2ftTNrfU
6MpuDAFyskJya54woLA5/NmU+/aceHGXOK+lyi3MS5UpLMVCBi41PMZ1bZu/6XP6
+C6to7DeYQy+a3qkRiL+4W2g0/gr0rfKunvD0f2A/7coVKNvi8k=
=ATAQ
-----END PGP SIGNATURE-----

--9njPz0MR3Ie7OdJLYN1ViX9BYSDd8kC5A--
