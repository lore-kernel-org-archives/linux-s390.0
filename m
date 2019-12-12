Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728292AbfLLJly (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 04:41:54 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC9bDOZ116626
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:41:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8m0va1f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:41:53 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Dec 2019 09:41:50 -0000
Subject: Re: [kvm-unit-tests PATCH v4 3/9] s390x: interrupt registration
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-4-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Dec 2019 10:41:46 +0100
MIME-Version: 1.0
In-Reply-To: <1576079170-7244-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zy3TEy30G995UOfSB60JunZ1ONvHGBzTf"
Message-Id: <a60310e3-baac-65b7-ee4f-d2ec913c3600@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zy3TEy30G995UOfSB60JunZ1ONvHGBzTf
Content-Type: multipart/mixed; boundary="wzG6iB0pil0CAClRnOW8ff3W43EJGMKuC"

--wzG6iB0pil0CAClRnOW8ff3W43EJGMKuC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 4:46 PM, Pierre Morel wrote:
> Define two functions to register and to unregister a call back for IO
> Interrupt handling.
>=20
> Per default we keep the old behavior, so does a successful unregister
> of the callback.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Nearly forgot this:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


--wzG6iB0pil0CAClRnOW8ff3W43EJGMKuC--

--zy3TEy30G995UOfSB60JunZ1ONvHGBzTf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3yC1oACgkQ41TmuOI4
ufhT4g/+O3yd7KgNbAnhaSQg98CibKGSk1cJk7eBsEC2BOdp1mVHgms8OlbfReI7
kbMsa2MYZr6T/u95nFk5RLEG+7dqaymNQkQDFJeF6g8saofbcftarVTXK9Od2Rzp
WkyMLo8mg803n+zrJJ/bhGAHHZ0MsWygE+7/hDeItNZ1cFVMqJBTcIRL6ZlCLvih
eEYhofuaJg7/EpDYyK2+Kn0ODXXCSi0Wbn49RjsC73qrkQN/06g4DgR/gfmoaPrc
GGJg36gd7kqjXLJ3rK+78pXR1dSbvhjhqGL8TXtZSRwWYD5tQlQ4pnJPDtf0lcFX
xEybSHO6eLUbgSQHqqMXjm5JgzWj11lDyc1Sa9SqKWJtF8/+pyqTPFpI8ZKWMPY5
4R9YbSsXLbEHHwYGVFS+E/9J3wweYrZUsrHPikoiEQ2zfisXryecjHm7YBFnc/Hy
7RfnezTtaW/u83lta4na64hShPXdc4eoSmEEtGYjTs+PyrGmkLVvJ6vOx0iSGxcR
1cJ1ryHB1cNoLnJtH7MbZoJH+qt91hL70hvCyknibdhQdAPmouhDeKvQc5G7DkB+
NbZClJO3BFAHDmm3rpWYMn3feELthh3HY9fcRDm9Et/aZj3GJ3AzkF85uS+SmJTg
VUg1FoXrKTOR5KmaJAG0xdbzkTUoHexa2XDpcTGY4/ZBSFpVn/w=
=JdYQ
-----END PGP SIGNATURE-----

--zy3TEy30G995UOfSB60JunZ1ONvHGBzTf--
