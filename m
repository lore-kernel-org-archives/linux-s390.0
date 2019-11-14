Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbfKNRKM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 12:10:12 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEGnAM7073970
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 12:10:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w91m7t3j5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 12:10:08 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 17:09:50 -0000
Subject: Re: [PATCH v1 4/4] s390x: Testing the Subchannel I/O read
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-5-git-send-email-pmorel@linux.ibm.com>
 <db451544-fcb1-9d81-7042-ef91c8324204@linux.ibm.com>
 <81ef68d4-5ec5-b14e-6c3d-6935e9a6a1c1@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 18:09:46 +0100
MIME-Version: 1.0
In-Reply-To: <81ef68d4-5ec5-b14e-6c3d-6935e9a6a1c1@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bDgQcatBFO5NPM7l0ZjVZFK5shJZdHzBr"
Message-Id: <b5ce5e92-9412-d491-8d7c-270a92f3bff0@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bDgQcatBFO5NPM7l0ZjVZFK5shJZdHzBr
Content-Type: multipart/mixed; boundary="W4KtuUDDr0deCMounFwMWplOYmhRUaFkQ"

--W4KtuUDDr0deCMounFwMWplOYmhRUaFkQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/14/19 5:38 PM, Pierre Morel wrote:
>=20
> On 2019-11-14 10:15, Janosch Frank wrote:
>> On 11/13/19 1:23 PM, Pierre Morel wrote:
>>> This simple test test the I/O reading by the SUB Channel by:
>>> - initializing the Channel SubSystem with predefined CSSID:
>>>    0xfe000000 CSSID for a Virtual CCW
>>>    0x00090000 SSID for CCW-PONG
>>> - initializing the ORB pointing to a single READ CCW
>>> - starts the STSH command with the ORB
>>> - Expect an interrupt
>>> - writes the read data to output
>>>
>>> The test implements lots of traces when DEBUG is on and
>>> tests if memory above the stack is corrupted.
>> What happens if we do not habe the pong device?
>=20
> CC error on stsch() which is currently not cached (but will in the next=
=20
> version)
>=20
> CC error on msch() and on ssch() which is cached and makes the test to =
fail.
>=20
>=20
>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   lib/s390x/css.h      | 244 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>>   lib/s390x/css_dump.c | 141 +++++++++++++++++++++++++++++
>> Hmm, what about splitting the patch into css.h/css_dump.c and the actu=
al
>> test in s390x/css.c?
>=20
> OK
>=20
>=20
>>
>>>   s390x/Makefile       |   2 +
>>>   s390x/css.c          | 222 ++++++++++++++++++++++++++++++++++++++++=
++++++
>>>   s390x/unittests.cfg  |   4 +
>>>   5 files changed, 613 insertions(+)
>>>   create mode 100644 lib/s390x/css.h
>>>   create mode 100644 lib/s390x/css_dump.c
>>>   create mode 100644 s390x/css.c
>>>
>>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>>> new file mode 100644
>=20
> OK to all comments...=C2=A0 (I sniped out for clarity)
>=20
> ...snip...
>=20
>=20
>>> +static char buffer[4096];
>>> +
>>> +static void delay(int d)
>>> +{
>>> +	int i, j;
>>> +
>>> +	while (d--)
>>> +		for (i =3D 1000000; i; i--)
>>> +			for (j =3D 1000000; j; j--)
>>> +				;
>>> +}
>> You could set a timer.
>=20
>=20
> Hum, do we really want to do this?

Why exactly do you need it if you can't have an exact time to wait for?

>=20
>=20
>>
>>> +
>>> +static void set_io_irq_subclass_mask(uint64_t const new_mask)
>>> +{
>>> +	asm volatile (
>>> +		"lctlg %%c6, %%c6, %[source]\n"
>>> +		: /* No outputs */
>>> +		: [source] "R" (new_mask));
>> arch_def.h has lctlg() and ctl_set/clear_bit
>=20
>=20
> OK, thanks
>=20
>=20
>>
>>> +}
>>> +
>>> +static void set_system_mask(uint8_t new_mask)
>>> +{
>>> +	asm volatile (
>>> +		"ssm %[source]\n"
>>> +		: /* No outputs */
>>> +		: [source] "R" (new_mask));
>>> +}
>>> +
>>> +static void enable_io_irq(void)
>>> +{
>>> +	set_io_irq_subclass_mask(0x00000000ff000000);
>>> +	set_system_mask(PSW_PRG_MASK >> 56);
>> load_psw_mask(extract_psw_mask() | PSW_PRG_MASK); no need for another
>> inline asm function :)
>>
>> Or add a psw_set/clear_bit function and fixup enter_pstate()
>=20
> I look at this.
>=20
>=20
>>
>>> +}
>>> +
>>> +void handle_io_int(sregs_t *regs)
>>> +{
> ,,,snip...
>>> +
>>> +	delay(1);
>>> +
>>> +	stsch(CSSID_PONG, &schib);
>>> +	dump_schib(&schib);
>> Is all that dumping necessary or just a dev remainder?
>=20
>=20
> it goes in the logs, so I thought it could be interresting to keep it.

Depends on how much output is produced.
If I have to scroll through your dumps to get to the ouptuts
 of the reports then they are .

See the answer below...

>=20
>=20
>>
>>> +	DBG("got: %s\n", buffer);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +#define MAX_ERRORS 10
>>> +static int checkmem(phys_addr_t start, phys_addr_t end)
>>> +{
>>> +	phys_addr_t curr;
>>> +	int err =3D 0;
>>> +
>>> +	for (curr =3D start; curr !=3D end; curr +=3D PAGE_SIZE)
>>> +		if (memcmp((void *)start, (void *)curr, PAGE_SIZE)) {
>>> +			report("memcmp failed %lx", true, curr);
>> How many errors do you normally run into (hopefully 0)?
>=20
>=20
> hopefully.
>=20
> However I thought it could be interesting to know how many pages have=20
> been dirtied.

Honestly, for debugging a failing test we would need to add prints or
attach gdb anyway. So I see no reason to not fail on the first occurrence=
=2E

>=20
>=20
>>
>>> +			if (err++ > MAX_ERRORS)
>>> +				break;
>>> +		}
>>> +	return err;
>>> +}
>>> +
>>> +extern unsigned long bss_end;
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	phys_addr_t base, top;
>>> +	int check_mem =3D 0;
>>> +	int err =3D 0;
>>> +
>>> +	if (argc =3D=3D 2 && !strcmp(argv[1], "-i"))
>>> +		check_mem =3D 1;
>>> +
>>> +	report_prefix_push("css");
>>> +	phys_alloc_get_unused(&base, &top);
>>> +
>>> +	top =3D 0x08000000; /* 128MB Need to be updated */
>>> +	base =3D (phys_addr_t)&stacktop;
>>> +
>>> +	if (check_mem)
>>> +		memset((void *)base, 0x00, top - base);
>>> +
>>> +	if (check_mem)
>>> +		err =3D checkmem(base, top);
>>> +	if (err)
>>> +		goto out;
>>> +
>>> +	err =3D css_run(0);
>>> +	if (err)
>>> +		goto out;
>>> +
>>> +	if (check_mem)
>>> +		err =3D checkmem(base, top);
>>> +
>>> +out:
>>> +	if (err)
>>> +		report("Tested", 0);
>>> +	else
>>> +		report("Tested", 1);
>> Normally we report the sucsess or failure of single actions and a
>> summary will tell us if the whole test ran into errors.
>=20
> Right, will be enhanced.
>=20
> Thanks for the comments.
>=20
> Regards,
>=20
> Pierre
>=20
>=20



--W4KtuUDDr0deCMounFwMWplOYmhRUaFkQ--

--bDgQcatBFO5NPM7l0ZjVZFK5shJZdHzBr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NiloACgkQ41TmuOI4
ufg77hAAwPLc3BTzlUisc2uhHCc5S/c892QuRG6ZIlPAQ4zXkO3IYbhu9GcfYnmY
S2dM0dWAguHYm9eskBhYXURIi9Yb0fBqUQZQ0y24OO1wXUL9b3AwE7GxiN26SAY9
Io6fDaPLOLYZY+8cyhxysnzhMWihK9f+v3HYXCxcgQhSrCq3NgssBo6pMnbF9+02
xuBLg2YTfB7ls/IdG/TUqD1hwR5m1/D2dY3wS6ls8016pOOXxfIDcI2ucKfV6QZj
rb763I8QdD2yIF3RG6KTlJLIaVT6GIxzO5jI+HfLtz8vhRZ2UrOu3wDalgLlWrNf
V1TxcBT0crztm6rTdmYaYxNs7TAlgiaovUsBPd4vX3t7jXXjbd8ePTaz5ioE9CpA
O1ntjgSUhpeL7xI4sN/j1FE1ZxK1sWnGo6NaTbWHifmwa3StWdbuNL5/91TcwK7N
7f73iK1EAL4E31JWRkajiGpztyS2rdyNmzgM9FJiDHxETlfF4INUGgnALTU+3VYg
Ijkjrzf8/GlN41MOCGBtKq/J/r46pHJib32BVBnv9Tj8zwIEFtnDw0emICmZDvHg
hR2zd3pPBuxUzAMLcG65HqPQzpsUZwIAnUc0lDfTpNJ1MfVKaQOnw8Q7O7CFRAAh
q0LmabGJl9uAAullCMkp0E6F0Se338fIQobmj7QJxNSo25/WGSc=
=tC+M
-----END PGP SIGNATURE-----

--bDgQcatBFO5NPM7l0ZjVZFK5shJZdHzBr--
