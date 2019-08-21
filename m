Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfHUItI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 04:49:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7L8lSDU133693
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 04:49:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh290sfrt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 04:49:06 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 21 Aug 2019 09:49:04 +0100
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <09b66729-1263-381f-9af5-9f68332c5415@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 21 Aug 2019 10:48:59 +0200
MIME-Version: 1.0
In-Reply-To: <09b66729-1263-381f-9af5-9f68332c5415@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y87oDXBon2H9nMnO7swaOISdkcSbYBh0z"
Message-Id: <35c4aa37-c0c8-4f27-66e0-23145fe48182@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y87oDXBon2H9nMnO7swaOISdkcSbYBh0z
Content-Type: multipart/mixed; boundary="z1Pw1ILUq8QtPx4DZbPPIL30CoEIRLzOb";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <35c4aa37-c0c8-4f27-66e0-23145fe48182@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <09b66729-1263-381f-9af5-9f68332c5415@redhat.com>
In-Reply-To: <09b66729-1263-381f-9af5-9f68332c5415@redhat.com>

--z1Pw1ILUq8QtPx4DZbPPIL30CoEIRLzOb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 9:04 PM, David Hildenbrand wrote:
> On 20.08.19 12:55, Janosch Frank wrote:
>> The first patch allows for CECSIM booting via PSW restart.
>> The other ones add diag288 and STSI tests.
>>
>> I chose to start with these since they are low controversy. My queue
>> still contains the sclp patches and a simple smp library with
>> tests. They will follow later.
>=20
> On which branch do these patches apply? I fail to am 2+3 on master (wel=
l
> I didn't try too hard to resolve ;) ). Do you have a branch somewhere?
>=20

That is currently on top of master (24efc22), the only merge conflicts
might be s390x/Makefile or unittests.conf if your branch is not clean.
I'm trying to get a public github account for that and qemu.


--z1Pw1ILUq8QtPx4DZbPPIL30CoEIRLzOb--

--y87oDXBon2H9nMnO7swaOISdkcSbYBh0z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1dBXsACgkQ41TmuOI4
ufiCSxAAzcJjg80PM6sWakbdynK7EjezrYyg4HpGzsMpH/U0rr3h8Pc1wFqYSzUa
qtqd9YpCbli+Abe3mIjCvVCLtk1urFeX+YumaREoj1GynRQt66x0An0+N+Fk+ejZ
2Q9MxM793kzG2LJ4+Xpz4Rz81fBXyxfiVVQHt7SsHsbfRJ+usiw4cnNbj1vzLTCj
CkzVXP3q26OSVGWIZtK/96Xfx/agD8GGuB3GbMoJTu+PN9L/+0SG0s0+rXQFio5e
cGMeaKr1BdFxxeLp3NUhHq3thNlaHsJfkaFqwAFlFMw0taCs7JSapbHq25RiR1ta
Y1EDgNE8YN5mFEH12QJx0Kt6u6LkWNpp7tpXznkTRooBkQPBkPx8qZKmsSLhOmkz
VvvkBKpQEvLrwmbXiXmmnXXrJSWv3Kjg4E04m/jz6PQrQo4aiYHvWbq0GCaAcgmm
xcPEaj0tXujC+pNZt7iSgHG7PabSRSeYU+GG8yC7snJVSWAe/1SEPC95rwgccvdv
UOWQwbR2D7a1o3sgKuOFf8B7+EzCzlJaU7NOo5AXBvz5syhzINhkn6nT400ZGrBS
Im2lxIVcuHKZ3PUt2BGk8bba6OCJCIeOiyN7MflQUCzK80FRX0erpISJJCst32Gi
hX9dgfK9bBMJrB+Bg+fkdG7c2F+iBM8wCCOurQ099UBOJlVTUhg=
=XMb1
-----END PGP SIGNATURE-----

--y87oDXBon2H9nMnO7swaOISdkcSbYBh0z--
