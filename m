Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbgD1JUL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 05:20:11 -0400
Subject: Re: [kvm-unit-tests PATCH v6 08/10] s390x: define wfi: wait for
 interrupt
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-9-git-send-email-pmorel@linux.ibm.com>
 <4cc33b1c-7fa2-0775-f176-08bb31b7e68e@linux.ibm.com>
 <60b951c7-2fa2-2284-db04-33e422974626@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <84cf8f4f-4d29-8ff5-0d84-5c9b0b52ff34@linux.ibm.com>
Date: Tue, 28 Apr 2020 11:20:04 +0200
MIME-Version: 1.0
In-Reply-To: <60b951c7-2fa2-2284-db04-33e422974626@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cZmmoQzVPj1RTwcvtr6jtzPlHZtnRNM6E"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cZmmoQzVPj1RTwcvtr6jtzPlHZtnRNM6E
Content-Type: multipart/mixed; boundary="W9I43BBl8msrJMTwFXBWBH5LOYLEZo6Ux"

--W9I43BBl8msrJMTwFXBWBH5LOYLEZo6Ux
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/28/20 10:44 AM, Pierre Morel wrote:
>=20
>=20
> On 2020-04-27 14:59, Janosch Frank wrote:
>> On 4/24/20 12:45 PM, Pierre Morel wrote:
>>> wfi(irq_mask) allows the programm to wait for an interrupt.
>>
>> s/programm/program/
>=20
> Thx,
>=20
>>
>>> The interrupt handler is in charge to remove the WAIT bit
>>> when it finished handling interrupt.
>>
>> ...finished handling the interrupt.
>=20
> OK, thx
>=20
>>
>=20
>>>   }
>>>  =20
>>> +static inline void wfi(uint64_t irq_mask)
>>
>> enabled_wait()
>=20
>=20
> I do not like enabled_wait(), we do not know what is enabled and we do =

> not know what we are waiting for.
>=20
> What about wait_for_interrupt()

As long as it's not called wfi...

>=20
>>
>>> +{
>>> +	uint64_t psw_mask;
>>
>> You can directly initialize this variable.
>>
>>> +
>>> +	psw_mask =3D extract_psw_mask();
>>> +	load_psw_mask(psw_mask | irq_mask | PSW_MASK_WAIT);
>>
>> Maybe add a comment here:
>>
>> /*
>>   * After being woken and having processed the interrupt, let's restor=
e
>> the PSW mask.
>> */
>>
>>> +	load_psw_mask(psw_mask);
>>> +}
>>> +
>=20
> I can do this, but wasn't it obvious?

It took me a minute, so it will take even longer for developers that are
not yet familiar with s390 kernel development.

>=20
>=20
> Regards,
> Pierre
>=20



--W9I43BBl8msrJMTwFXBWBH5LOYLEZo6Ux--

--cZmmoQzVPj1RTwcvtr6jtzPlHZtnRNM6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6n9UQACgkQ41TmuOI4
ufgsnRAAl5jtiENoqnLZjLOtGWFIjA81tcHJrcKl5z1ZEPpjHGAucbTi8e7tDlJS
oaAYoUzbh9v+m7a1TGce7a2f9v2dFRLW/hmaBqbk1FIVDeYKw9+IZaNuSu1W1eBn
K/pgopwlnpBElFOIO3mRjIJ3cSFmOsLkOYFVRYkjcDa2i/HV3mAyFIHjm7fg4p+X
FMsucJ1ElCEaakfGuKMHwyNzEe6NJGh8eiDTXmhuapVvmqivtQMJJSDakyMy+1GT
SUjWQCUKCjspL6GWaopo8GoCZGC787Eph9hcDGsjRPaalJYkFWkD/3c9/GA148BZ
211w+tUOhoE6k56uCgLvN9E39WQv0gsgBe4mSdpgKk4EiEocEsRWMQYgmFnQiKbe
X5URqC4DizqH5C7Hz4fTPH9LxHbXMZcRxeupPJHcJDR02hmwW++qGYqugP4NyZrP
Olqqw8GUGRUagAmcZMT2Z3GeQE9iW195V7inUaM1fLxamZjEPILH524zMSaywq6z
3qbc07fZynhuBquBy4ErDI2oKpUpeoB8EImE2ZoXV4kV4P70UOQdN18Ug0dHPfvA
M9kN4bWqfWN5M2wWThALF3zI2JELkWj50oD/dIb3IXI0p7d9/iEoEh0m5f7j2YyG
aGkOHLdH7rgmb8qx+4nQglwSFOw1M+RIixITjCpAccs5EUitYpw=
=vJHW
-----END PGP SIGNATURE-----

--cZmmoQzVPj1RTwcvtr6jtzPlHZtnRNM6E--
