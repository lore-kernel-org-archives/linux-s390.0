From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 21 Jan 2019 09:47:17 +0000
Subject: Re: [kvm-unit-tests PATCH v6 07/11] s390x: Use interrupts in SCLP and add locking
Message-Id: <103a6963-20aa-5e91-93c8-c7ff29debbd8@linux.ibm.com>
In-Reply-To: <48e97627-5c51-d89e-7bdc-b098a7186d38@redhat.com>
References: <48e97627-5c51-d89e-7bdc-b098a7186d38@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--9qjaNiKrM256CmZmRHjP87ze8c1P8gW4U"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qjaNiKrM256CmZmRHjP87ze8c1P8gW4U
Content-Type: multipart/mixed; boundary="7MXdAD3Wu5eBmg2qHE2HPo2cpaeoXoDXY";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <103a6963-20aa-5e91-93c8-c7ff29debbd8@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v6 07/11] s390x: Use interrupts in SCLP and
 add locking
References: <20190118114204.147868-1-frankja@linux.ibm.com>
 <20190118114204.147868-8-frankja@linux.ibm.com>
 <48e97627-5c51-d89e-7bdc-b098a7186d38@redhat.com>
In-Reply-To: <48e97627-5c51-d89e-7bdc-b098a7186d38@redhat.com>

--7MXdAD3Wu5eBmg2qHE2HPo2cpaeoXoDXY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.01.19 09:58, David Hildenbrand wrote:
> On 18.01.19 12:42, Janosch Frank wrote:
[...]
>> +void sclp_handle_ext(void)
>> +{
>> +	ctl_clear_bit(0, 9);
>> +	spin_lock(&sclp_lock);
>> +	sclp_busy =3D false;
>> +	spin_unlock(&sclp_lock);
>=20
> With multiple CPUs, this is problematic. Just when the interrupt comes
> in, SCLP is marked as !busy and the SCCB block can immediately be reuse=
d
> by other callers waiting in sclp_mark_busy().
>=20
> Wasn't the idea to also protect the whole global SCCB?
>=20
> We should maybe stop using a gloval page and instead get one per caller=

> via the page allocator. Or let the caller of sclp_mark_busy() set SCLP
> as !busy once he's done handling the block.

Yes, I need to rethink all of that properly instead of fixing around it.

We could for now use a two stage lock/indication:
mark_busy()
On sclp call sclp code sets processed =3D false;
svc interrupt sets processed =3D true
Caller loops on processed and unlocks busy after processing.

Later on we either use pcpu pages and locks or stay with it, as it's
less complicated.

That's from the top of my head, so -ENOCOFFEE

>=20
>> +}
>> +
>> +void sclp_wait_busy(void)
>> +{
>> +	while (sclp_busy)
>> +		mb();
>> +}
>> +
>> +void sclp_mark_busy(void)
>> +{
>> +	/*
>> +	 * With multiple CPUs we might need to wait for another CPU's
>> +	 * request before grabbing the busy indication.
>> +	 */
>> +retry_wait:
>> +	sclp_wait_busy();
>> +	spin_lock(&sclp_lock);
>> +	if (sclp_busy) {
>> +		spin_unlock(&sclp_lock);
>> +		goto retry_wait;
>> +	}
>> +	sclp_busy =3D true;
>> +	spin_unlock(&sclp_lock);
>> +}
>> +
>>  static void sclp_read_scp_info(ReadInfo *ri, int length)
>>  {
>>  	unsigned int commands[] =3D { SCLP_CMDW_READ_SCP_INFO_FORCED,
>>  				    SCLP_CMDW_READ_SCP_INFO };
>> -	int i;
>> +	int i, cc;
>> =20
>>  	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> +		sclp_mark_busy();
>>  		memset(&ri->h, 0, sizeof(ri->h));
>>  		ri->h.length =3D length;
>> =20
>> -		if (sclp_service_call(commands[i], ri))
>> +		cc =3D sclp_service_call(commands[i], ri);
>> +		if (cc)
>>  			break;
>>  		if (ri->h.response_code =3D=3D SCLP_RC_NORMAL_READ_COMPLETION)
>>  			return;
>> @@ -57,12 +105,14 @@ int sclp_service_call(unsigned int command, void =
*sccb)
>>  {
>>  	int cc;
>> =20
>> +	sclp_setup_int();
>>  	asm volatile(
>>  		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
>>  		"       ipm     %0\n"
>>  		"       srl     %0,28"
>>  		: "=3D&d" (cc) : "d" (command), "a" (__pa(sccb))
>>  		: "cc", "memory");
>> +	sclp_wait_busy();
>>  	if (cc =3D=3D 3)
>>  		return -1;
>>  	if (cc =3D=3D 2)
>> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
>> index 583c4e5..63cf609 100644
>> --- a/lib/s390x/sclp.h
>> +++ b/lib/s390x/sclp.h
>> @@ -213,6 +213,9 @@ typedef struct ReadEventData {
>>  } __attribute__((packed)) ReadEventData;
>> =20
>>  extern char _sccb[];
>> +void sclp_handle_ext(void);
>> +void sclp_wait_busy(void);
>> +void sclp_mark_busy(void);
>>  void sclp_console_setup(void);
>>  void sclp_print(const char *str);
>>  int sclp_service_call(unsigned int command, void *sccb);
>>
>=20
>=20



--7MXdAD3Wu5eBmg2qHE2HPo2cpaeoXoDXY--

--9qjaNiKrM256CmZmRHjP87ze8c1P8gW4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcRZUlAAoJEONU5rjiOLn4Y+wP/231ONQhFxmbycCAg2i1ItXz
1wgkvgz+VVFo6LcX2kxnfzD0qYQ8+D4TlHHYhmspTXJwUK0qsWxV/cFLPFZfBgD/
MqYlFfG9CFck/evPxgJgqZH+szBssEdSdXUfA2xOlZK6GxuFDqwPxJoMatEozTf2
JbP/tSoZNCl7sm7D2WqmzuJkMjU0J5WtX5xGlkJIup3hhyXViYB0nTBavE/qo6M1
K61I5oOz01Rj5/xOaeXR0BvzwOkPjH+W6jB5B35T2E2wNKS6k35nZEmIwZesjmOb
WKgac3ECiHvTVkqFGbrqXvXyDV5IUmHa65z57fQbMLR0kCKxkgKN3ysjj9XOm49k
S2fVyzJa5LKx5kbD2MHZEMiAQcRw1rA5oimSz5QE47DbjW/VXkkBSq5XTpl6Nqfx
OhOUidyH9pyA3L4W4o1siJDGrgsf9zQTvShKIJIJN9O5E+ZiQEyIZEEaGukJWE/c
KI7du3FN819MFiBjSxDSDHcINDoA1654vXjplCyosAKpUwrTQ/mjec7TCU5PS59R
Z7ftAWiRG+x2UIbmuEZRJsngdmThnDzyaWS9NjsqQcsNwZaGp70CpzpXg7OiY2aj
A6BNIWvI0S+NQrtB1EKu6lamWMFm0UgYo2624Qc6bOgqmUQ7m9g3p4OOCNurR6na
fyz61RiO+bmt3/15eYnC
=Nv8m
-----END PGP SIGNATURE-----

--9qjaNiKrM256CmZmRHjP87ze8c1P8gW4U--
