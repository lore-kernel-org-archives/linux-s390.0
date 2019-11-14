Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbfKNQS6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 11:18:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEG6Tic080761
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:18:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w9a5a8gq0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:18:56 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 16:18:55 -0000
Subject: Re: [RFC 17/37] DOCUMENTATION: protvirt: Instruction emulation
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-18-frankja@linux.ibm.com>
 <20191114161526.1100f4fe.cohuck@redhat.com>
 <20191114162024.13f17aa9@p-imbrenda.boeblingen.de.ibm.com>
 <20191114164136.0be3f058.cohuck@redhat.com>
 <b94125ec-256c-7d7b-929e-fdbabcacb142@linux.ibm.com>
 <20191114170313.3606d554.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 17:18:49 +0100
MIME-Version: 1.0
In-Reply-To: <20191114170313.3606d554.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jSzyJHTUhJUIhYKSXHyzpzQKxIQBAjmA7"
Message-Id: <fb7bd025-e486-39b1-3ac0-ab1e80a46489@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jSzyJHTUhJUIhYKSXHyzpzQKxIQBAjmA7
Content-Type: multipart/mixed; boundary="YwqOWWR8alc2c7qxtq0Q0iLwV1d7IXMU3"

--YwqOWWR8alc2c7qxtq0Q0iLwV1d7IXMU3
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/14/19 5:03 PM, Cornelia Huck wrote:
> On Thu, 14 Nov 2019 16:55:46 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 11/14/19 4:41 PM, Cornelia Huck wrote:
>>> On Thu, 14 Nov 2019 16:20:24 +0100
>>> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>>>  =20
>>>> On Thu, 14 Nov 2019 16:15:26 +0100
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>> =20
>>>>> On Thu, 24 Oct 2019 07:40:39 -0400
>>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>>>>>> +The Secure Instruction Data Area contains instruction storage
>>>>>> +data. Data for diag 500 is exempt from that and has to be moved
>>>>>> +through shared buffers to KVM.     =20
>>>>>
>>>>> I find this paragraph a bit confusing. What does that imply for dia=
g
>>>>> 500 interception? Data is still present in gprs 1-4?   =20
>>>>
>>>> no registers are leaked in the registers. registers are always only
>>>> exposed through the state description. =20
>>>
>>> So, what is so special about diag 500, then? =20
>>
>> That's mostly a confusion on my side.
>> The SIDAD is 4k max, so we can only move IO "management" data over it
>> like ORBs and stuff. My intention was to point out, that the data whic=
h
>> is to be transferred (disk contents, etc.) can't go over the SIDAD but=

>> needs to be in a shared page.
>>
>> diag500 was mostly a notification mechanism without a lot of data, rig=
ht?
>=20
> Yes; the main information in there are the schid identifying the
> subchannel, the virtqueue number, and a cookie value, all of which fit
> into the registers.
>=20
> So this goes via the sidad as well?
>=20

Only referenced data goes over the SIDA, register values go into offset
0x380 of the SIE state description.

If an instruction has an address in a register, we will receive a bogus
address and the referenced data in the SIDA.

SCLP has a code and an address as register values.
We will get the code and a bogus address in the register area.
The SCCB will be in the SIDA.


--YwqOWWR8alc2c7qxtq0Q0iLwV1d7IXMU3--

--jSzyJHTUhJUIhYKSXHyzpzQKxIQBAjmA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NfmkACgkQ41TmuOI4
ufi48Q//e0H4EvQzO9zWoLAuCgPrQAya+QuTueDJ222Jovon5WsD+TqnFapFhxLL
hMxTupw9OVFftzRJIhGQKHWU8RlRejJxd7nQ0vI4XMrGPDpw4wVKrzzEyIeU0uvk
szs0Z1HyIgbp70b/k2ZUPCRDDgKw83jAqPhyK1ggSBK8rMg59drCHb7Ahkc2xTJi
uspkJRa5H0g2gvo1OZ6ES6UCPv/eshcTtY5l3baIzUDEjNo5aqD1a4QqJk120TC5
UQM1YjXf2PAPQeVMKtIakMzIPmCvzMUEKplYrDoeBDFyzxW+AzzWAjbpqEKLu0f8
ylUnktsB+6w88MDT+kEPiW5kg9ljoz/gaLnD6zYd0ifSQkC8TvmFCt1itlsQRAx3
FTbZtQsDP4f+wu7MQeimx7q6+YdGXYmb7s0tlc59g1k2RX5KgZGKQeels6B5j/Ub
PYZGEmCbyX/y97UrRGVEIaNSRCBjn8pYKARCz+bYjUYDm7GQRPPLs5rA1iSe3BG0
kp1efOktq4MBGjxHFFLZL0mhdpyxjraErjrKX8JFdu6eE93qWZDmTYwOAccLGEKt
a5BBNlHtzeCvlEvh2pSrEvLeahiQa+OWU81Kpa5Tea+01yVBRlviKGOfislxN2Wv
hWJq4VK9qAX5w+c9PLiu9MxdhVrXMSWrx73gsLrLfFVeJXsFsgk=
=M3Vx
-----END PGP SIGNATURE-----

--jSzyJHTUhJUIhYKSXHyzpzQKxIQBAjmA7--
