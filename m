Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbfLBLLU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 06:11:20 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2B73ZF095307
        for <linux-s390@vger.kernel.org>; Mon, 2 Dec 2019 06:11:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6mxqbsd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Dec 2019 06:11:16 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 2 Dec 2019 11:11:15 -0000
Subject: Re: [kvm-unit-tests PATCH v2 2/9] s390x: Define the PSW bits
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-3-git-send-email-pmorel@linux.ibm.com>
 <489b43a4-6f71-71bf-b936-e4c94e52387b@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 2 Dec 2019 12:11:10 +0100
MIME-Version: 1.0
In-Reply-To: <489b43a4-6f71-71bf-b936-e4c94e52387b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kFDLF9V7ytEpy2gEToBd54ww1nCuKRV0e"
Message-Id: <7daddc03-35ec-f376-c80a-a849f9e11714@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kFDLF9V7ytEpy2gEToBd54ww1nCuKRV0e
Content-Type: multipart/mixed; boundary="HPOffbTyHtg6DBIPGpKtVfAjV546SPotP"

--HPOffbTyHtg6DBIPGpKtVfAjV546SPotP
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/28/19 3:36 PM, David Hildenbrand wrote:
> On 28.11.19 13:46, Pierre Morel wrote:
>> Let's define the PSW bits  explicitly, it will clarify their
>> usage.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  lib/s390x/asm/arch_bits.h | 20 ++++++++++++++++++++
>>  lib/s390x/asm/arch_def.h  |  6 ++----
>=20
> I'm sorry, but I don't really see a reason to move these 4/5 defines to=

> a separate header. Can you just keep them in arch_def.h and extend?
>=20
> (none of your other patches touch arch_bits.h - and it is somewhat a
> weird name. Where to put something new: arch_def.h or arch_bits.h? I
> would have understood "psw.h", but even that, I don't consider necessar=
y)
>=20

On a related note:
I'd still like to split up the file soonish, maybe moving the functions
into a new file?

@Thomas/David: What's your opinion on that?


--HPOffbTyHtg6DBIPGpKtVfAjV546SPotP--

--kFDLF9V7ytEpy2gEToBd54ww1nCuKRV0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3k8U4ACgkQ41TmuOI4
ufiFDBAAlRvhLgwlf5tiQVjkJB5ZW2dqMQOmUmqK9/goww6YK2ZStUaWGPu4Ie1j
wlP/Z21Z91MzKyHBqrF5l7GPdZPZpe1PvDfbd3KJ7O6Yt5Yf5AeI/1BxdjUmK0za
MHReGxtkZzKIZhBz/eyKMc/aHSrDBwWssgyp+bx5U3t7eXlj9vVWYrBSaQx4CJmN
26hYVuSk/q10hAESSmAtXA34iTWxonH2d3M9bIWkv6RMoeYFiEYklwrviAKPl/bx
Sks5e0XFjdf1k7QWQbXBtqa5UFA/nxWylwh7uvHSTs2XpcHxmIWNAw1UHs+Rdmc9
mUd6pcs3YgbSsIO9Rw361j7kWV6zneogOFpIWfv9WFZItTmJbVODIBlP1fWZRz3L
ObhbUUUodpTd0QZlfTff/wW8HtWDc/S/dXdkGZFKnSZXaVY3+b3yiz7G3u4C23ez
1WB1I222EVG++xBHOreHb543MeY0h549HrCKNnWYM6nzeVlFDREedVL3sGRDi84e
NP4UU10r+cnY7JEi8XAjgXpc9TUuFpUZnUXOGghg29c59ZOO4573XtgM4u/op7rf
cJnsHHfqr31p9on0FEZ/h4u8mH6y8Q7MViMP0eSNuspC24g9SBYhjGEyx8vQQI+6
Yj7z4/GRsTesdJkMF8FWVmZR+QLXm7aQ0gC1VYtFSmYJqX3mRlA=
=CIqY
-----END PGP SIGNATURE-----

--kFDLF9V7ytEpy2gEToBd54ww1nCuKRV0e--
