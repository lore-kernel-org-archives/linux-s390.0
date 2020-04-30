Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgD3HkZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 03:40:25 -0400
Subject: Re: [PATCH v3 08/10] s390x: smp: Wait for sigp completion
References: <20200429143518.1360468-1-frankja@linux.ibm.com>
 <20200429143518.1360468-9-frankja@linux.ibm.com>
 <6fb43d45-952e-f66b-a0b2-19d8c3f44cd5@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <68e16d1a-8990-0160-307d-93e870338879@linux.ibm.com>
Date: Thu, 30 Apr 2020 09:40:18 +0200
MIME-Version: 1.0
In-Reply-To: <6fb43d45-952e-f66b-a0b2-19d8c3f44cd5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3YBtVv1Yu0VOIKkHYA8CbE7MXXW8SoCTJ"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3YBtVv1Yu0VOIKkHYA8CbE7MXXW8SoCTJ
Content-Type: multipart/mixed; boundary="mN2sWxTwlxnqnpVlJGEZJMPytCL2FaRXg"

--mN2sWxTwlxnqnpVlJGEZJMPytCL2FaRXg
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/29/20 5:15 PM, David Hildenbrand wrote:
> On 29.04.20 16:35, Janosch Frank wrote:
>> Sigp orders are not necessarily finished when the processor finished
>> the sigp instruction. We need to poll if the order has been finished
>> before we continue.
>>
>> For (re)start and stop we already use sigp sense running and sigp
>> sense loops. But we still lack completion checks for stop and store
>> status, as well as the cpu resets.
>>
>> Let's add them.
>>
>> KVM currently needs a workaround for the stop and store status test,
>> since KVM's SIGP Sense implementation doesn't honor pending SIGPs at
>> it should. Hopefully we can fix that in the future.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  lib/s390x/smp.c |  9 +++++++++
>>  lib/s390x/smp.h |  1 +
>>  s390x/smp.c     | 12 ++++++++++--
>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> index 6ef0335..8628a3d 100644
>> --- a/lib/s390x/smp.c
>> +++ b/lib/s390x/smp.c
>> @@ -49,6 +49,14 @@ struct cpu *smp_cpu_from_addr(uint16_t addr)
>>  	return NULL;
>>  }
>> =20
>> +void smp_cpu_wait_for_completion(uint16_t addr)
>> +{
>> +	uint32_t status;
>> +
>> +	/* Loops when cc =3D=3D 2, i.e. when the cpu is busy with a sigp ord=
er */
>> +	sigp_retry(1, SIGP_SENSE, 0, &status);
>> +}
>> +
>>  bool smp_cpu_stopped(uint16_t addr)
>>  {
>>  	uint32_t status;
>> @@ -100,6 +108,7 @@ int smp_cpu_stop_store_status(uint16_t addr)
>> =20
>>  	spin_lock(&lock);
>>  	rc =3D smp_cpu_stop_nolock(addr, true);
>> +	smp_cpu_wait_for_completion(addr);
>>  	spin_unlock(&lock);
>>  	return rc;
>>  }
>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>> index ce63a89..a8b98c0 100644
>> --- a/lib/s390x/smp.h
>> +++ b/lib/s390x/smp.h
>> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>  int smp_cpu_stop(uint16_t addr);
>>  int smp_cpu_stop_store_status(uint16_t addr);
>> +void smp_cpu_wait_for_completion(uint16_t addr);
>>  int smp_cpu_destroy(uint16_t addr);
>>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>>  void smp_teardown(void);
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index c7ff0ee..bad2131 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -75,7 +75,12 @@ static void test_stop_store_status(void)
>>  	lc->prefix_sa =3D 0;
>>  	lc->grs_sa[15] =3D 0;
>>  	smp_cpu_stop_store_status(1);
>> -	mb();
>> +	/*
>> +	 * This loop is workaround for KVM not reporting cc 2 for SIGP
>> +	 * sense if a stop and store status is pending.
>> +	 */
>> +	while (!lc->prefix_sa)
>> +		mb();
>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "pref=
ix");
>>  	report(lc->grs_sa[15], "stack");
>>  	report(smp_cpu_stopped(1), "cpu stopped");
>> @@ -85,7 +90,8 @@ static void test_stop_store_status(void)
>>  	lc->prefix_sa =3D 0;
>>  	lc->grs_sa[15] =3D 0;
>>  	smp_cpu_stop_store_status(1);
>> -	mb();
>> +	while (!lc->prefix_sa)
>> +		mb();
>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "pref=
ix");
>>  	report(lc->grs_sa[15], "stack");
>>  	report_prefix_pop();
>> @@ -215,6 +221,7 @@ static void test_reset_initial(void)
>>  	wait_for_flag();
>> =20
>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>> +	smp_cpu_wait_for_completion(1);
>=20
> ^ is this really helpful? The next order already properly synchronizes,=
 no?

Well, the next order isn't issued with sigp_retry, so we could actually
get a cc 2 on the store. I need a cpu stopped loop here as well.

>=20
>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> =20
>>  	report_prefix_push("clear");
>> @@ -265,6 +272,7 @@ static void test_reset(void)
>>  	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>> +	smp_cpu_wait_for_completion(1);
>=20
> Isn't this racy for KVM as well?
>=20
> I would have expected a loop until it is actually stopped.

I'd add a loop with a comment, but also keep the wait for completion.

>=20
>>  	report(smp_cpu_stopped(1), "cpu stopped");
>> =20
>>  	set_flag(0);
>>
>=20
>=20



--mN2sWxTwlxnqnpVlJGEZJMPytCL2FaRXg--

--3YBtVv1Yu0VOIKkHYA8CbE7MXXW8SoCTJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6qgOMACgkQ41TmuOI4
ufir8xAAs7VkkNz2fS8Ud70m8cF9BGYx8ku3BbItGZYpkxbzv50HYebsS9FEzzcO
bRMXhaKgLQJ2kyJ3a3Mxk7xZ+nKd9oeT6RLy0TDCV0S+ATD3YlCPdRHV7IWcFuJq
TMmipJrDnbd+fh6d7YZoOLyxecxVFRdDjrip3ZGI18gow8KBYohR6dUWBwQCOPbk
lDH5TjVFgwZPGmU72BDVUGG7ijxGwUCOHC0RaAaH5+zrhsT9pt8DuJ++kkvc95kq
1m68BQw4UjJAx1/ic4vlDfYWj36hQnzuu1Q2XEL6cmVN/Y0rk3NMZapwOxa4cLY4
ShKxYq/Ahj0K3tQDKHG//ze0idj1FjeRb2RVkevh9ZUIBPTmSLJ/n9NINd3InRe1
ak/T9s2cQEr6cKYlQla/XpF98TWModIwfD8E+8P2auzvGBYEB6R/25gdGGvv9e9R
3hhhTRQ67NvUaiM9RTtbB8L5Sx1e6/DQOcq6w6maNr8594aXs2PPKwQ1674mfPvM
Iu0F5+6ScR4cpfPUQsHif/oSYcYlsAPiVnbNaoxfyo6w5rw8N9PmlO7qt+q0uwqo
eywBrA3mRx5oebEBBpXGYgjaisfeWTsL6d4u6vn7XPHibb9EX3qz+wQEz0sbm4NV
j9jHQ3+01oP+2ibmKw3ZYtFpHlNxPtoeC4Emp29DBA0xEBvW/G0=
=bYDM
-----END PGP SIGNATURE-----

--3YBtVv1Yu0VOIKkHYA8CbE7MXXW8SoCTJ--
