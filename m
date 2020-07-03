Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725984AbgGCMCA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 08:02:00 -0400
Subject: Re: [kvm-unit-tests PATCH v10 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1593707480-23921-1-git-send-email-pmorel@linux.ibm.com>
 <1593707480-23921-10-git-send-email-pmorel@linux.ibm.com>
 <d8b2ed8c-3948-1cba-47af-ef2a8cdf27ed@redhat.com>
 <0aaab65b-7856-9be9-c6dc-4da8e8d529d4@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <75982e29-5df8-abf3-57aa-ff717a4868d6@linux.ibm.com>
Date: Fri, 3 Jul 2020 14:01:50 +0200
MIME-Version: 1.0
In-Reply-To: <0aaab65b-7856-9be9-c6dc-4da8e8d529d4@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QKIBioCp2dHTAz4FbE9l1ty1waX2iSH7o"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com, drjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QKIBioCp2dHTAz4FbE9l1ty1waX2iSH7o
Content-Type: multipart/mixed; boundary="wz2sV3eMKvbNw10rKNgrHGkidQr08jZuL"

--wz2sV3eMKvbNw10rKNgrHGkidQr08jZuL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/3/20 11:05 AM, Pierre Morel wrote:
>=20
>=20
> On 2020-07-03 10:41, Thomas Huth wrote:
>> On 02/07/2020 18.31, Pierre Morel wrote:
>>> After a channel is enabled we start a SENSE_ID command using
>>> the SSCH instruction to recognize the control unit and device.
>>>
>>> This tests the success of SSCH, the I/O interruption and the TSCH
>>> instructions.
>>>
>>> The SENSE_ID command response is tested to report 0xff inside
>>> its reserved field and to report the same control unit type
>>> as the cu_type kernel argument.
>>>
>>> Without the cu_type kernel argument, the test expects a device
>>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>> [...]
>>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>>> index 0ddceb1..9c22644 100644
>>> --- a/lib/s390x/css.h
>>> +++ b/lib/s390x/css.h
>>> @@ -11,6 +11,8 @@
>>>   #ifndef CSS_H
>>>   #define CSS_H
>>>  =20
>>> +#define lowcore_ptr ((struct lowcore *)0x0)
>>
>> I'd prefer if you could either put this into the css_lib.c file or in
>> lib/s390x/asm/arch_def.h.
>=20
> I have a patch ready for this :)
> But I did not want to add too much new things in this series that could=
=20
> start a new discussion.
>=20
> I have 2 versions of the patch:
> - The simple one with just the declaration in arch_def.h
> - The complete one with update of all tests (but smp) using a pointer t=
o=20
> lowcore.
>=20

I've seen that patch on your branch and like most maintainers I'm not
incredibly happy with patches touching a single line in a lot of files.

Maybe we can achieve a compromise and only clean up our library. The
tests can be changed when they need to be touched for other changes.

Anyway for now I think css_lib.c might be the right place. We can talk
about a lowcore cleanup next week if you want.

>=20
>>
> ...snip...
>=20
>>>   static inline int ssch(unsigned long schid, struct orb *addr)
>>> @@ -251,6 +271,16 @@ void dump_orb(struct orb *op);
>>>  =20
>>>   int css_enumerate(void);
>>>   #define MAX_ENABLE_RETRIES      5
>>> -int css_enable(int schid);
>>> +int css_enable(int schid, int isc);
>>> +
>>> +
>>
>> In case you respin: Remove one empty line?
>=20
> yes
>=20
>>
>>> +/* Library functions */
>>> +int start_ccw1_chain(unsigned int sid, struct ccw1 *ccw);
>=20
> ...snip...
>=20
>>> +	lowcore_ptr->io_int_param =3D 0;
>>> +
>>> +	memset(&senseid, 0, sizeof(senseid));
>>> +	ret =3D start_single_ccw(test_device_sid, CCW_CMD_SENSE_ID,
>>> +			       &senseid, sizeof(senseid), CCW_F_SLI);
>>> +	if (ret) {
>>> +		report(0, "ssch failed for SENSE ID on sch %08x with cc %d",
>>> +		       test_device_sid, ret);
>>> +		goto unreg_cb;
>>> +	}
>>
>> I'd maybe rather do something like:
>>
>> 	report(ret =3D=3D 0, "SENSE ID on sch %08x has good CC (%d)", ...)
>> 	if (ret)
>> 		goto unreg_cb;
>>
>> and avoid report(0, ...) statements. Also for the other tests below. B=
ut
>> maybe that's really just a matter of taste.
>=20
> I prefer to use report(0,....) when an unexpected error occurs: This=20
> keep the test silent when what is expected occurs.
>=20
> And use report(ret =3D=3D xxx, ....) as the last report to report overa=
ll=20
> success or failure of the test.
>=20
> Other opinions?

So, I'm not a big fan of changes to the amount of output depending on
the test PASS/FAIL. It screws with my ability to parse the output.

However this is your test, I don't expect other people touching this in
the near future and the output has lots of information where stuff went
wrong. As long as you debug the fails I'm ok with that style :)

>=20
>>
>>> +	wait_for_interrupt(PSW_MASK_IO);
>=20
> ...snip...
>=20
>>
>> Apart from the nits, I'm fine with the patch.
>>
>> Acked-by: Thomas Huth <thuth@redhat.com>

Acked-by: Janosch Frank <frankja@de.ibm.com>

>>
>=20
> Thanks,
> Pierre
>=20
>=20



--wz2sV3eMKvbNw10rKNgrHGkidQr08jZuL--

--QKIBioCp2dHTAz4FbE9l1ty1waX2iSH7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7/Hi4ACgkQ41TmuOI4
ufj3og//WoHnbb8K2e7rrgrbtTVFFJAT544OylKaH7dN9N8R5BZjd6vTVDkVozQE
wwxaUiPAJ8tkUI0uO5amGQSLrUVxLb+PuXmTn01onZJXwY1MH0vb3z8hKeYV1wGt
AOl1KJEq7bpEk7NkB8AGl4ftAO4MAvlV7BgHSqDK2xx4HsDXFO0088zXVzodzUUy
nw5HWsfp3BIZUIRq4wU7p4Y5E0c8gI2PE0wE3NBPaXNwZPo4Zy8nUjZu3382Vear
GiUt9HXfSmA+Ib9IzkaEjZxbTJbWBmSR3VSJAGkNcyjCNf5SKC5rVOMw8NxTbd0+
uptLrCYgM6MdA0XrAKBQNeoxi8wsLZaS1UjM1AXN2bd2xhKs16PYMj6ZNUA1+nCD
/i4+nE/44IJmug0JOlNZQquiKaANxOmxmvON7RBjC8FbHSZ9hlap5cD41t4cW+uc
F2hlmafXHFDQhPkXn4IfB3nyT9YCIJhjzzKM0TSjPLTbVCy+y9cE8tpWlu4VdWlL
Ww83ukGG5FyY4nteET914qq5NtcoOVHZQ8XO75MvpkSJt7qtALT5yXgPfapPKvz0
5PwPpnDb7Dd+ZXk1xOAZuiVFfviJT6eybfRvZSklRazVvyBVQ9ikYIbI1bErLkcs
KorSjNo87M9xPWVDo3SwHe8gaemhs9Fg8/Eodou1RXrR8GTgfo8=
=Nugx
-----END PGP SIGNATURE-----

--QKIBioCp2dHTAz4FbE9l1ty1waX2iSH7o--
