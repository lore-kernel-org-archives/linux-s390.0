Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/2] s390: uv: Fix sysfs max number of VCPUs reporting
References: <20210119100402.84734-1-frankja@linux.ibm.com>
 <20210119100402.84734-2-frankja@linux.ibm.com>
 <d72e2823-f30f-02be-1ee5-445496ca9dbc@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <945319e9-641b-70ea-0e0b-2e71f73cf086@linux.ibm.com>
Date: Tue, 19 Jan 2021 11:15:53 +0100
MIME-Version: 1.0
In-Reply-To: <d72e2823-f30f-02be-1ee5-445496ca9dbc@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JXmkQwHCz3sbY2Fj0qkTT5EXxMRwhLeHS"
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JXmkQwHCz3sbY2Fj0qkTT5EXxMRwhLeHS
Content-Type: multipart/mixed; boundary="lz5q6hLeak3dWPor1jJiwzRZnMqWZiCIj";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com,
 imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org,
 gor@linux.ibm.com, mihajlov@linux.ibm.com
Message-ID: <945319e9-641b-70ea-0e0b-2e71f73cf086@linux.ibm.com>
Subject: Re: [PATCH 1/2] s390: uv: Fix sysfs max number of VCPUs reporting
References: <20210119100402.84734-1-frankja@linux.ibm.com>
 <20210119100402.84734-2-frankja@linux.ibm.com>
 <d72e2823-f30f-02be-1ee5-445496ca9dbc@de.ibm.com>
In-Reply-To: <d72e2823-f30f-02be-1ee5-445496ca9dbc@de.ibm.com>

--lz5q6hLeak3dWPor1jJiwzRZnMqWZiCIj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/19/21 11:11 AM, Christian Borntraeger wrote:
>=20
>=20
> On 19.01.21 11:04, Janosch Frank wrote:
>> The number reported by the query is N-1 and I think people reading the=

>> sysfs file would expect N instead. For users creating VMs there's no
>> actual difference because KVM's limit is currently below the UV's
>> limit.
>>
>> The naming of the field is a bit misleading. Number in this context is=

>> used like ID and starts at 0. The query field denotes the maximum
>> number that can be put into the VCPU number field in the "create
>> secure CPU" UV call.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Fixes: a0f60f8431999 ("s390/protvirt: Add sysfs firmware interface for=
 Ultravisor information")
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/s390/boot/uv.c        | 2 +-
>>  arch/s390/include/asm/uv.h | 4 ++--
>>  arch/s390/kernel/uv.c      | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
>> index a15c033f53ca..afb721082989 100644
>> --- a/arch/s390/boot/uv.c
>> +++ b/arch/s390/boot/uv.c
>> @@ -35,7 +35,7 @@ void uv_query_info(void)
>>  		uv_info.guest_cpu_stor_len =3D uvcb.cpu_stor_len;
>>  		uv_info.max_sec_stor_addr =3D ALIGN(uvcb.max_guest_stor_addr, PAGE_=
SIZE);
>>  		uv_info.max_num_sec_conf =3D uvcb.max_num_sec_conf;
>> -		uv_info.max_guest_cpus =3D uvcb.max_guest_cpus;
>> +		uv_info.max_guest_cpu_id =3D uvcb.max_guest_cpu_num;
>>  	}
>> =20
>>  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 0325fc0469b7..c484c95ea142 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -96,7 +96,7 @@ struct uv_cb_qui {
>>  	u32 max_num_sec_conf;
>>  	u64 max_guest_stor_addr;
>>  	u8  reserved88[158 - 136];
>> -	u16 max_guest_cpus;
>> +	u16 max_guest_cpu_num;
>=20
> I think it would read better if we name this also max_guest_cpu_id.
> Otherwise this looks good.
>=20

Yes, but I wanted to have the same name as in the specification.
So, what do we value more?


--lz5q6hLeak3dWPor1jJiwzRZnMqWZiCIj--

--JXmkQwHCz3sbY2Fj0qkTT5EXxMRwhLeHS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAmAGsVkFAwAAAAAACgkQ41TmuOI4ufh3
8RAAvEI3EI9BFL8WyNz+3cZsOMr9YUwTDQ8hH1ZmxYf6Gn2dxY91L1Tq1KENifEOI00d6N3XSyar
hPt+dZfuumEBMgVgS/7gj68rzf1hMl0aiZzdPAmlCGHbrz/QcwXkcYUyY2Xl5xAyx7AmoI/31JZL
BzYcxOce3LWBiW//oukm2WUC5iF5QTpDxj0SoOBBhs/F4p2eIxD6PLZ0H1ft5+DDU4sJMZx7t2f+
yuyKeGZVjtbGheoCambagQIbfsT67hBo1GNlwXF9AYlfC5U9uqorblnEFAqSevdxxjd0aAd0LOJK
egB+7ERukG4vIcLDXxUEUSfNXlj98I92XLs8sLuZZRmfHLGkMp6hRUuXLXuuATK6lVwtSC22u6ll
3SG1+pQaB9jGkgsfh3BjKcJyU2YDOurCvhrPOYep4AeI/WQPDhCgRDcQ5YQG+Ts0vaGzaqQjRo9H
i3lYOsEU1pxGkXMA7ypDDRQoB1+8hj2eeLpxDHnpEm2o8SelCwS/kFxg2+rVusYnnMzG0yoAW9yR
U01P5kUO6EC0+4rpz2rsI0pNy4pZop36j7ZEqr+RPseXnEk21FOopwOpKArmwb+v394rpvel+Syk
RZnJSvnYE9nJAxZquBVuS7b338azcFe3tYsbF8YssBV9h9yHdrCEO/MalIYpJGnTZdk0uGEcz/oh
3os=
=GVgv
-----END PGP SIGNATURE-----

--JXmkQwHCz3sbY2Fj0qkTT5EXxMRwhLeHS--
