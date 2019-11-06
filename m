Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727587AbfKFVCu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 16:02:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6L2SLP119972
        for <linux-s390@vger.kernel.org>; Wed, 6 Nov 2019 16:02:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w44wj9jj2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 16:02:48 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 6 Nov 2019 21:02:46 -0000
Subject: Re: [RFC 30/37] DOCUMENTATION: protvirt: Diag 308 IPL
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-31-frankja@linux.ibm.com>
 <20191106174855.13a50f42.cohuck@redhat.com>
 <6dd98dfe-63ce-374c-9b04-00cdeceee905@linux.ibm.com>
 <20191106183754.68e1be0f.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 6 Nov 2019 22:02:41 +0100
MIME-Version: 1.0
In-Reply-To: <20191106183754.68e1be0f.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hM6Atjmfk5LcNjOGA2W09xwKsacok9Z8h"
Message-Id: <faacad49-3f91-08f3-d1ee-d31f31ac38bb@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hM6Atjmfk5LcNjOGA2W09xwKsacok9Z8h
Content-Type: multipart/mixed; boundary="60Pawfj5gM70ZLs6qG26ti3g2nsMRxfMw"

--60Pawfj5gM70ZLs6qG26ti3g2nsMRxfMw
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/6/19 6:37 PM, Cornelia Huck wrote:
> On Wed, 6 Nov 2019 18:05:22 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 11/6/19 5:48 PM, Cornelia Huck wrote:
>>> On Thu, 24 Oct 2019 07:40:52 -0400
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>  =20
>>>> Description of changes that are necessary to move a KVM VM into
>>>> Protected Virtualization mode.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  Documentation/virtual/kvm/s390-pv-boot.txt | 62 +++++++++++++++++++=
+++
>>>>  1 file changed, 62 insertions(+)
>>>>  create mode 100644 Documentation/virtual/kvm/s390-pv-boot.txt
>=20
>>> So... what do we IPL from? Is there still a need for the bios?
>>>
>>> (Sorry, I'm a bit confused here.)
>>>  =20
>>
>> We load a blob via the bios (all methods are supported) and that blob
>> moves itself into protected mode. I.e. it has a small unprotected stub=
,
>> the rest is an encrypted kernel.
>>
>=20
> Ok. The magic is in the loaded kernel, and we don't need modifications
> to the bios?
>=20

Yes.

The order is:
* We load a blob via the bios or direct kernel boot.
* That blob consists of a small stub, a header and an encrypted blob
glued together
* The small stub does the diag 308 subcode 8 and 10.
* Subcode 8 basically passes the header that describes the encrypted
blob to the Ultravisor (well rather registers it with qemu to pass on lat=
er)
* Subcode 10 tells QEMU to move the VM into protected mode
* A lot of APIs in KVM and the Ultravisor are called
* The protected VM starts
* A memory mover copies the now unencrypted, but protected kernel to its
intended place and jumps into the entry function
* Linux boots and detects, that it is protected and needs to use bounce
buffers


--60Pawfj5gM70ZLs6qG26ti3g2nsMRxfMw--

--hM6Atjmfk5LcNjOGA2W09xwKsacok9Z8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3DNPEACgkQ41TmuOI4
ufjSIxAAiU2LrRGOd8DpOV5hNf0gF7VcbOnOgRTpjFf4Hn5ODy/0EAldaX+CiBKx
BCTsofQooRs8cEsE1fq7UiZPzOtAinDsvwm3DrO9VLp4EkA00f5hPxmB+yQZWZnS
uu+1YzrK5Bxkd97y4Qq4syk2e7UeMFJov94K6Enj6zh/Fad1aPsWQGx4OPnev7IL
d7HAjJFRZ37cLNVnLtHUg7NLohsy7NoAMm54cXwIacyDk6HgtVpUrAQ2zIDuU07Z
cM7KPjtS7ACxx2KcJvh5z2pEdfui2N0yQWM7oVBYzhFzSdc70qU58F0yMqBmxN/o
y4PkD7s+iH3tRFLngrpJz468HP+7XPkto8FfTyQPsw6N1G7U6PdTusfYm5gq+bQ1
G9mMwZ018KqjZZzhLtRmKiduyBS3/joDiQgkSisxN3mYn+7S4ipES7W7CKfVsw2d
5TY8+2DVQ1sgmPWOt692l788EbkPHN2Ic+7C09+CrT6dRmXoOpXlHs72V12dMZe2
zU/uVhcFsBNtrmi39qEvlrgQTaVvXEENhAR2EhH4kuum5t6vfSwsNKSFDQ1fuOUb
2V+2uiDengD2/oScrPpIrQeZSg+mpA/0ydRBtPlA6+kN6lqpG8qM1GeZmhENPbM6
+Anx7BFxRaeUWPieFOTaj7t/VpbGhvF9T1E+H/NXiszXakPEsMY=
=z4Z/
-----END PGP SIGNATURE-----

--hM6Atjmfk5LcNjOGA2W09xwKsacok9Z8h--
