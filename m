Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgEOIxW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 04:53:22 -0400
Subject: Re: [kvm-unit-tests PATCH v6 07/10] s390x: css: msch, enable test
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-8-git-send-email-pmorel@linux.ibm.com>
 <cff917e0-f7e0-fd48-eda5-0cbe8173ae8a@linux.ibm.com>
 <abafd691-d9ab-33b2-c522-d37fecc3e881@linux.ibm.com>
 <20200514140808.269f6485.cohuck@redhat.com>
 <de18eab3-4d0a-1b86-f6c4-27aaa7bba6bf@linux.ibm.com>
 <20200515102548.0f43419d.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <e0d0d9f5-c780-404a-6cc8-31cbb077cf6f@linux.ibm.com>
Date: Fri, 15 May 2020 10:53:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200515102548.0f43419d.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TBPAekG58od7S0E9YdejM3MOwIQgWsSbz"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TBPAekG58od7S0E9YdejM3MOwIQgWsSbz
Content-Type: multipart/mixed; boundary="ulXHkJguE55szB728VdhNLGcWEQ1dkoyY"

--ulXHkJguE55szB728VdhNLGcWEQ1dkoyY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/15/20 10:25 AM, Cornelia Huck wrote:
> On Fri, 15 May 2020 09:11:52 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> On 2020-05-14 14:08, Cornelia Huck wrote:
>>> On Tue, 28 Apr 2020 10:27:36 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>  =20
>>>> On 2020-04-27 15:11, Janosch Frank wrote: =20
>>>>> On 4/24/20 12:45 PM, Pierre Morel wrote: =20
>>>  =20
>>>>>> This is NOT a routine to really enable the channel, no retry is do=
ne,
>>>>>> in case of error, a report is made. =20
>>>>>
>>>>> Would we expect needing retries for the pong device? =20
>>>>
>>>> Yes it can be that we need to retry some instructions if we want the=
m to
>>>> succeed.
>>>> This is the case for example if we develop a driver for an operating=
 system.
>>>> When working with firmware, sometime, things do not work at the firs=
t
>>>> time. Mostly due to races in silicium, firmware or hypervisor or bet=
ween
>>>> them all.
>>>>
>>>> Since our purpose is to detect such problems we do not retry
>>>> instructions but report the error.
>>>>
>>>> If we detect such problem we may in the future enhance the tests. =20
>>>
>>> I think I've seen retries needed on z/VM in the past; do you know if
>>> that still happens?
>>>  =20
>>
>> I did not try the tests under z/VM, nor direct on an LPAR, only under =

>> QEMU/KVM.
>> Under QEMU/KVM, I did not encounter any need for retry, 100% of the=20
>> enabled succeeded on first try.
>=20
> Yep, QEMU/KVM should be fine. Do you plan to run this on anything else?=

>=20

I'd like to have it compatible with z/VM / LPAR as well if it isn't too
much work. You never know when you need it and having tests for all
hypervisors has been quite a help in the past.


--ulXHkJguE55szB728VdhNLGcWEQ1dkoyY--

--TBPAekG58od7S0E9YdejM3MOwIQgWsSbz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6+WHsACgkQ41TmuOI4
ufgRJg/9EJC83gtV3QKiqLQTcAo/mogQMOmZuYguxwXk3VZKFg+OdKZQuqq+plQR
jUs2dhHfhUURDm38nSRStYgjsPsYAqAZvXGHMb2rPK4GX8jyrCtKOO7QhWvlthAv
tQfusgPmSfpcL1p/L2dtIefOJ+5V4OVX9UmaWcjDZsusfB6ZHbnH7bcZMh4HRn7K
JeN99Q46j9b8V4Uug/Jyk35AvqcWqQRnGJ7aVCcWGTEby6dU1I8Q9PV0aZpZt5kI
URbqNHhION+fX9jEIhFFWGXlXA+wJVXifZn1vlL+gof31jbYAO7AWSAh1zdo3zMC
U/qLtcVZkODpp70fN6bADcXs8OUVGf/eaAavH/CjUqcTJJTyhH7PeOSR5QI3I7aD
7xyRqx789aAJMXmH/9YNK2qUNE/JOE3r06hi/mmnBwbrb1IynHRBB+I9uigB80ae
iBBxa/3aBBuUBbyydodntFeArdziZJJuU/TXovbmSBs79qayi+HZN3hKMEvqx606
y/oCDaVPRIoHbSuY2We5uU5I3GYgpWSooYjaKTLKo3m5UdNWPmQCxX/O9ipN+9zy
mnz9S6LAAoN+P5Pzpy1y+6p5+PEkq8FDuBA41N1TcOfWkINmeTDWRJMMpV4FcKhl
pN+MYffa98xgUadMNOCLyviZAXeT/7CDBDP764wHH7CscGt1Fp4=
=m650
-----END PGP SIGNATURE-----

--TBPAekG58od7S0E9YdejM3MOwIQgWsSbz--
