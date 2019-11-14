Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbfKNHYQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 02:24:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAE7NDQM075188
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 02:24:15 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w8xdvy2nk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 02:24:14 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 07:24:12 -0000
Subject: Re: [kvm-unit-tests PATCH v4] s390x: Load reset psw on diag308 reset
References: <e54ce8f8-7ed5-3eee-6715-8b5051cb49fb@redhat.com>
 <20191113112403.7664-1-frankja@linux.ibm.com>
 <f8393e14-79a3-694e-d457-dff20b28f62a@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 08:24:08 +0100
MIME-Version: 1.0
In-Reply-To: <f8393e14-79a3-694e-d457-dff20b28f62a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iaxrfKDy2nUFpdjLT4yFZCIYS14RWew5Q"
Message-Id: <0cc2e15a-79c5-455b-9846-987d23c90df5@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iaxrfKDy2nUFpdjLT4yFZCIYS14RWew5Q
Content-Type: multipart/mixed; boundary="aU0Vsa7hKHTMa0qhu5iSzf4yH2KXniFQM"

--aU0Vsa7hKHTMa0qhu5iSzf4yH2KXniFQM
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/13/19 7:06 PM, David Hildenbrand wrote:
> On 13.11.19 12:24, Janosch Frank wrote:
>> On a diag308 subcode 0 CRs will be reset, so we need a PSW mask
>> without DAT. Also we need to set the short psw indication to be
>> compliant with the architecture.
>>
>> Let's therefore define a reset PSW mask with 64 bit addressing and
>> short PSW indication that is compliant with architecture and use it.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
> Queued to
>=20
> https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next
>=20
> I'll most probably wait a bit for the SCLP stuff to settle to send a=20
> pull request!
>=20

Thanks!
I got some more things in my queue that I need to flush but I'm also
waiting a bit for sclp and IO to settle down :)


--aU0Vsa7hKHTMa0qhu5iSzf4yH2KXniFQM--

--iaxrfKDy2nUFpdjLT4yFZCIYS14RWew5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NARkACgkQ41TmuOI4
ufjnWw//fPTkpRJE7GGrlsYYM+RS3jfD+tn4ICeTFeRwfCmsXJ9V2r/2bxUbayWH
eIzfcMT8T3aMqpDGDYbxHxPKWV+EBEBcjHRNmNiTg95/erzwmSx9Su1FRseRSFfh
Y91Ix/dMhjKk8bYtJhzMAwhHfk9keyVzTF5nKeZWIEQZD6rUTw1LOkLEOnbGwHvs
cZMxqg3Sc1LM/xxnKdrY7096p13PYoyYfRAlCxRGDuVPdvEtzsvSetxCIbicjcgu
ohOpKLkXMN2AkJei6a7Kr9m3mlKePhgSkQ4CEE6vHd9yE8LuHqT0P5gP13K2jIXD
IdXY0KkuHswsHUcwgNEK9MQei3xhHbtgj2L0bAzKP/IjBNvkSPZGpbv+OU7YOcIe
giGKkFcg2vD9w7fWsoGPQQENjoN9NwBYnWOjrQ+Zbl9fiociN6Hs3axvLQpZqoQt
k8EYlR9Rc+Z8MLA0Upp/zLcg7EM6bRnoJeX4JrUMslFnV2MfdaPls7LkFo19+LD6
lZKyKBJSDSeK9vv3ADrhMaO1YAN1JSYYHZ4ddqcoNd/mK05YWTP2ELMW3an6drNO
Vx+uT+79GI9Z4p0RkmKZtIwt1toYN7ui1S6u3aPO8YKQE48VHP7q+slagxza6JJu
srNO9hV1px0LYN3dSHaM1LT1brlIVcef8G4UHh4EijuFgx18l2Q=
=D+1T
-----END PGP SIGNATURE-----

--iaxrfKDy2nUFpdjLT4yFZCIYS14RWew5Q--
