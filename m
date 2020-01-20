Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726897AbgATOmB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 09:42:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KEcxO4178654
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 09:41:59 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg7y4hq4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 09:41:59 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 20 Jan 2020 14:41:57 -0000
Subject: Re: [kvm-unit-tests PATCH v3 7/9] s390x: smp: Remove unneeded cpu
 loops
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-8-frankja@linux.ibm.com>
 <20200120122956.6879d159.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 20 Jan 2020 15:41:52 +0100
MIME-Version: 1.0
In-Reply-To: <20200120122956.6879d159.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dNF8HX2goLRKXBtciUZa08s6yU9iiLlfk"
Message-Id: <97f7f794-e0be-3984-99b2-ba229212fd3e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dNF8HX2goLRKXBtciUZa08s6yU9iiLlfk
Content-Type: multipart/mixed; boundary="bIn2RBtwsTXHf7PdXSSZN4mwqMohus2bc"

--bIn2RBtwsTXHf7PdXSSZN4mwqMohus2bc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/20/20 12:29 PM, Cornelia Huck wrote:
> On Fri, 17 Jan 2020 05:46:38 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Now that we have a loop which is executed after we return from the
>> main function of a secondary cpu, we can remove the surplus loops.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/smp.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index 555ed72..c12a3db 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -29,15 +29,9 @@ static void wait_for_flag(void)
>>  	}
>>  }
>> =20
>> -static void cpu_loop(void)
>> -{
>> -	for (;;) {}
>> -}
>> -
>>  static void test_func(void)
>>  {
>>  	testflag =3D 1;
>> -	cpu_loop();
>>  }
>> =20
>>  static void test_start(void)
>> @@ -234,7 +228,7 @@ int main(void)
>> =20
>>  	/* Setting up the cpu to give it a stack and lowcore */
>>  	psw.mask =3D extract_psw_mask();
>> -	psw.addr =3D (unsigned long)cpu_loop;
>> +	psw.addr =3D (unsigned long)test_func;
>=20
> Before, you did not set testflag here... intended change?

Yes
It is set to 0 before the first test, so it shouldn't matter.

>=20
>>  	smp_cpu_setup(1, psw);
>>  	smp_cpu_stop(1);
>> =20
>=20



--bIn2RBtwsTXHf7PdXSSZN4mwqMohus2bc--

--dNF8HX2goLRKXBtciUZa08s6yU9iiLlfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4lvDEACgkQ41TmuOI4
ufhmAg//Vr2/Xk2o228CfRCwWChZvOyQTPHB9brOSF0B1LY6vei7Ij7jO+vBvB2D
f63rjY4X5M1fYj0O7N9EuuMHSAAU9yA6bOczAE2uYCI1PrW6zJdvdRfZmbnWe0eT
b5oLmwqYRhySGFn4z3PQYZ7fJdcJZ4AEAV3n32O0nclCs5hHKBC62GYxhnKWSesy
2U3cz9B9ODTHrBI2FYDXK2+8cia7wJTOvXZcFTa6U6KpIHtWRC42ynW4iPDCdrRf
fdnNYKlLX1wUZLpNyh736rQsWRunhX37tZi8fJWXUcYbu6UZ2RLwLhdHBRvDs4hv
caTpQoGBUYfoKG676oU5K6sj3eEoKEWIgIvxCQy4FkVPYmRWDuc2iVXRyr4JtJvi
bxAtFkLjuyUnzvxH+kfpxUdsdBpFzjdWxKJzjX4Fbyfn5SVcqNgmBc1SduGvHb2H
4Pie9sxVNjDDYz2flDBx9GwPPkFDxn/WdiJnKrho2OZMr64TBfRz/y7maPFhqwOT
BvYRCGDYLSmmTQu0M8JDrhzkQDvBU4X7KqCnw/MD1VQPeWDcRVBuf9shgic0tYQv
liNNCHp0rhXLMpqJq75M97Gs6hPdIdidZw4I53/ardf1inKXyj271HtP+bu8Q9/y
PQ7WQBhLXS4sNa2o2vkKoeRyya3uNKpPOu4n2lM+SDrzhbiRUM8=
=lG9v
-----END PGP SIGNATURE-----

--dNF8HX2goLRKXBtciUZa08s6yU9iiLlfk--
