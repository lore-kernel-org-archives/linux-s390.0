Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgA3LeV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 06:34:21 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UBPA40090693
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:34:20 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtfh1uuya-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:34:19 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 30 Jan 2020 11:34:18 -0000
Subject: Re: [PATCH v8 4/4] selftests: KVM: testing the local IRQs resets
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-5-frankja@linux.ibm.com>
 <20200130115543.1f06a840.cohuck@redhat.com>
 <bd7dc770-4613-5af5-e695-aabc70f84c16@linux.ibm.com>
 <20200130122849.763bd678.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 30 Jan 2020 12:34:13 +0100
MIME-Version: 1.0
In-Reply-To: <20200130122849.763bd678.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="atFBXkbxP4CNkdt1r5mpoH6vOYPWKoQhY"
Message-Id: <710336e7-6de8-0cba-cf24-ac99bc610285@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--atFBXkbxP4CNkdt1r5mpoH6vOYPWKoQhY
Content-Type: multipart/mixed; boundary="uQIK95FJQs2r4L2mcsGyCB33o7BhgcPCn"

--uQIK95FJQs2r4L2mcsGyCB33o7BhgcPCn
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/30/20 12:28 PM, Cornelia Huck wrote:
> /*
>  * irqs contains the number of retrieved interrupts. Any interrupt
>  * (notably, the emergency call interrupt we have injected) should
>  * be cleared by the resets, so this should be 0.
>  */

Sounds even better, thanks!


--uQIK95FJQs2r4L2mcsGyCB33o7BhgcPCn--

--atFBXkbxP4CNkdt1r5mpoH6vOYPWKoQhY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4yvzUACgkQ41TmuOI4
ufimGQ//cTw8JdvcRCImFDhUtO5GnYWk976nw2h1D9aiZwOjfDI/JceUcDDiPzJO
67SWJpmqKgFNiSh4sOkIWwxn1YWvHkLjKqDzOZGeX2isQH98TZtMNb7ZNxkDOMtz
avG7xo0ZcwW1bAYhSMoc5WCOkh0I6941ncdKJFh9vMACTCMHJN1qgWKM6Z0Catxk
ZsH6Zwo3mSmoGFW92WbFyXP6flj0weSZoMQ4YTF0YEf7UJb7zlffFxPkPRNwmkEO
MRhttBqUatQzdpDGXWOLVBdUcNL6FbKUfbOfPgTFYaNaI7rLr/s6gyUtBO89YI4u
qA1TTGMn/IvSi2nFMI4+A202vC+oqaFA98+c8VbI3bwqaroDJeRNKECEF3qZ+03D
oMfpoQCV/dxChFdBvLQb2bCHN8fmV7zeSON0dydagNHfexs3t63mt46VOZbWmjgR
J/gh1FadPyaiB64utM+u6YZFz2UC8z6/8eRDva2SDyKnSEGh0WAdT5AxUcFrwYED
dnQZvosrRp1dNEhB9bcJyHJpPS8Gi8sQxrf/jK/L6chAV32G7/4O8T40hZMPYJMO
fYZL+6wLT5agdJJnCc+609JoUmxKsAcFL+t+Jvxsxi8xzOcedy/zFSYKn1AUFo6s
MkDjjAUKDenGlcV7HnNmpLfP9mAVXYM6ANd2NOxJ9pbKdtska5Y=
=sGE2
-----END PGP SIGNATURE-----

--atFBXkbxP4CNkdt1r5mpoH6vOYPWKoQhY--
