Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgAPNBp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 08:01:45 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GCvuo4076741
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 08:01:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xjkbm32yc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 08:01:44 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 16 Jan 2020 13:01:42 -0000
Subject: Re: [kvm-unit-tests PATCH v2 1/7] s390x: smp: Cleanup smp.c
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-2-frankja@linux.ibm.com>
 <6eba828e-7bb8-e917-a21f-eaf7aa725ac4@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 16 Jan 2020 14:01:38 +0100
MIME-Version: 1.0
In-Reply-To: <6eba828e-7bb8-e917-a21f-eaf7aa725ac4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="06l1kGaLhujkz3CHDsyix4HZklzn3iOIu"
Message-Id: <db8f2c86-a49a-95a8-3024-2f4c898b4512@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--06l1kGaLhujkz3CHDsyix4HZklzn3iOIu
Content-Type: multipart/mixed; boundary="EXrDmkVVywBsbvmhHDA4enih78QaegH3z"

--EXrDmkVVywBsbvmhHDA4enih78QaegH3z
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/16/20 1:13 PM, David Hildenbrand wrote:
> On 16.01.20 13:05, Janosch Frank wrote:
>> Let's remove a lot of badly formatted code by introducing the
>> wait_for_flag() function.
>>
>> Also let's remove some stray spaces.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  s390x/smp.c | 42 ++++++++++++++++++++++++------------------
>>  1 file changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index ab7e46c..02204fd 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -22,6 +22,13 @@
>> =20
>>  static int testflag =3D 0;
>> =20
>> +static void wait_for_flag(void)
>> +{
>> +	while (!testflag) {
>> +		mb();
>> +	}
>> +}
>> +
>>  static void cpu_loop(void)
>>  {
>>  	for (;;) {}
>> @@ -37,13 +44,11 @@ static void test_func(void)
>>  static void test_start(void)
>>  {
>>  	struct psw psw;
>> -	psw.mask =3D  extract_psw_mask();
>> +	psw.mask =3D extract_psw_mask();
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	smp_cpu_setup(1, psw);
>> -	while (!testflag) {
>> -		mb();
>> -	}
>> +	wait_for_flag();
>>  	report(1, "start");
>>  }
>> =20
>> @@ -98,6 +103,7 @@ static void test_store_status(void)
>>  	report(1, "status written");
>>  	free_pages(status, PAGE_SIZE * 2);
>>  	report_prefix_pop();
>> +	smp_cpu_stop(1);
>=20
> This hunk does not seem to belong into this patch.
>=20
> Apart from that, looks good to me.

Hunk was moved to the next patch and I pushed the branch


--EXrDmkVVywBsbvmhHDA4enih78QaegH3z--

--06l1kGaLhujkz3CHDsyix4HZklzn3iOIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4gXrIACgkQ41TmuOI4
ufj68hAAlm/zEZo9L5fl8CtMxDZ/EZOGB58fE8jcjH+VD7LnyXSKFg8+g5KkDeKR
V4CiV1WpPQJSUr+ppqYEOlNIhbvDSl4C/WbjivNde/9SE6bL0DGhYTplGOX1RfHt
C2Qeo4J/tdGNsYeQ7TJbqA8ttNrigX3W1nUrSd9l0QMc2WQAOmaof92Q0/8yujUw
27q7KrrmaCI7WlH1q40BOxpV65xc8oil+CrGebSI5LUazky2ofVaeByoSi877KVf
9n/u8qOpOHPdrIox+RBeluKfCatWETFE0LJHnfYw8iFkDyNwRXNNUFgbI9vu190/
Y6Ei+7qi716OKHQLjXHRkJ367newu+YnUZBB8QK4ucAe89M6JbwAYluE97UgKm6O
iWzMsyW89DgbqPsdG+SHlSn1T7Z8fQfmHjTyv2lxRM8BIsMWnTQoi94a+3b9xmef
bh3kZKhoaI1Q1tQRT5DkAYNhO3+53+eB0gK2vxiLe3aQZ6ze4208932y2mA8wbyk
i3yZizAG6KMxQbOmUeYMqdQnQcw607394buxEgRhR3hVsI6m+fStli6Zjx48dz7s
sxjxNIy9NDsAkQ46ygdOesHGpGGG18Obh+b+I6nLK4PYBvrm5rjDPP5d03pYq+jT
wKKAWteUWw9Ank4qbLXgv1TaCHZxZozeUFY1U++lskgAKUwDYBY=
=b+st
-----END PGP SIGNATURE-----

--06l1kGaLhujkz3CHDsyix4HZklzn3iOIu--
