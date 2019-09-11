Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726724AbfIKIdZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Sep 2019 04:33:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8B8WUAB125998
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2019 04:33:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxtrf57wj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2019 04:33:24 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Sep 2019 09:33:22 +0100
Subject: Re: [kvm-unit-tests PATCH v2 4/6] s390x: Add initial smp code
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-5-frankja@linux.ibm.com>
 <51f23b0f-a928-1cd3-787d-31aed3ab7005@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 11 Sep 2019 10:33:18 +0200
MIME-Version: 1.0
In-Reply-To: <51f23b0f-a928-1cd3-787d-31aed3ab7005@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e9EgWm6zIZ4mCHv0RWLuP0iRQN6XxoYSw"
Message-Id: <ca96ce20-a12c-9af1-bcf2-a795a5eab860@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e9EgWm6zIZ4mCHv0RWLuP0iRQN6XxoYSw
Content-Type: multipart/mixed; boundary="sO5Vv5ZTSQzKOotYiLxXzI4A6V3kXs0l0";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <ca96ce20-a12c-9af1-bcf2-a795a5eab860@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/6] s390x: Add initial smp code
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-5-frankja@linux.ibm.com>
 <51f23b0f-a928-1cd3-787d-31aed3ab7005@redhat.com>
In-Reply-To: <51f23b0f-a928-1cd3-787d-31aed3ab7005@redhat.com>

--sO5Vv5ZTSQzKOotYiLxXzI4A6V3kXs0l0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/9/19 5:37 PM, Thomas Huth wrote:
> On 05/09/2019 12.39, Janosch Frank wrote:
>> Let's add a rudimentary SMP library, which will scan for cpus and has
>> helper functions that manage the cpu state.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
> [...]
>> +/*Expected to be called from boot cpu */
>> +extern uint64_t *stackptr;
>> +void smp_setup(void)
>> +{
>> +	int i =3D 0;
>> +	unsigned short cpu0_addr =3D stap();
>> +	struct ReadCpuInfo *info =3D (void *)cpu_info_buffer;
>> +
>> +	spin_lock(&lock);
>> +	sclp_mark_busy();
>> +	info->h.length =3D PAGE_SIZE;
>> +	sclp_service_call(SCLP_READ_CPU_INFO, cpu_info_buffer);
>> +
>> +	if (smp_query_num_cpus() > 1)
>> +		printf("SMP: Initializing, found %d cpus\n", info->nr_configured);
>> +
>> +	cpus =3D calloc(info->nr_configured, sizeof(cpus));
>> +	for (i =3D 0; i < info->nr_configured; i++) {
>> +		if (info->entries[i].address =3D=3D cpu0_addr) {
>> +			cpu0 =3D &cpus[i];
>> +			cpu0->stack =3D stackptr;
>> +			cpu0->lowcore =3D (void *)0;
>> +			cpu0->active =3D true;
>=20
> So here cpus[i].active gets set to true ...
>=20
>> +		}
>> +		cpus[i].addr =3D info->entries[i].address;
>> +		cpus[i].active =3D false;
>=20
> ... but here it is set back to false.
>=20
> Maybe move the if-statement below this line?
>=20
>> +	}
>> +	spin_unlock(&lock);
>> +}
> [...]
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 36f7cab..a45ea8f 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -172,6 +172,13 @@ diag308_load_reset:
>>  	lhi	%r2, 1
>>  	br	%r14
>> =20
>> +.globl smp_cpu_setup_state
>> +smp_cpu_setup_state:
>> +	xgr	%r1, %r1
>> +	lmg     %r0, %r15, 512(%r1)
>=20
> Can you use GEN_LC_SW_INT_GRS instead of 512?
>=20
>> +	lctlg   %c0, %c0, 776(%r1)
>=20
> ... and here GEN_LC_SW_INT_CR0 instead of 776?
>=20
> Apart from that, the patch looks fine to me.

Thanks, just fixed that



--sO5Vv5ZTSQzKOotYiLxXzI4A6V3kXs0l0--

--e9EgWm6zIZ4mCHv0RWLuP0iRQN6XxoYSw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl14sU8ACgkQ41TmuOI4
ufgNCQ/4/6tIA/YNoZbAOWqLpY1IHWAJsgSbYLg9JtYB/9qMKO3kkmVux5s3WdV1
vYrhgu7Z4/VjIclYuVG5o6tTA2VA3qfMWbP6FQFOCK8YbnS2Cu59b77LYRksxhn/
UZLN35beF/wjlwp2tX0xOZ74hNAaZfuIw0Rtxnvc+v5poIbZG1OYEFyUWIxm3LMS
mPIk1OKtIsPJbAFDRxwex86ASlEVBCipQe28fap4vgEBKsTfpjO9u8O85QUiAn1v
oQXSZINZq+hW54UtNiGUSXAAqYkU9B2wV93FG5l2gZWJDX5xsV/uW6MrHlFy8O4M
vcTDAM3w7Ib/Qau/yiKduBxnUBQTMED0+cZGsVP5WwWour8NXIQ193V1EnUiipdo
wjJu1sOFUrBgdVOilThrJBxJq6d5d8b1Bbjzn0JxUDJW3ujhTJ3wAcNfU3cjGu5V
tJ+KGdFUssVJBcB8IOQoAHUKDin254cNZzPkiFTH/x+QcxsBO0KSSkcwyvLQqit8
E/T8Xf22ZqBtVqOa7CchSXRZWEB/WVV5DnrJtahA6o3gMXvdnJutPfy/aG/3vILv
Yl//xiNrEzy+6O7Chnl25ybSTmlET4x0qcUiWO5WVoaI3MyboHpM4n/lO2Z8xCTb
689juM5TR60F9wDRqydSORBBuJB7sHKN5Y4v3pcIszGMaR0e3w==
=itzb
-----END PGP SIGNATURE-----

--e9EgWm6zIZ4mCHv0RWLuP0iRQN6XxoYSw--
