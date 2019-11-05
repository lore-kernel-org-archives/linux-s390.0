Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390423AbfKESir (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 13:38:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5IcVVL146560
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 13:38:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w3dfhtcgs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 13:38:45 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 5 Nov 2019 18:37:38 -0000
Subject: Re: [kvm-unit-tests PATCH 0/2] s390x: Improve architectural
 compliance for diag308
References: <20191105162828.2490-1-frankja@linux.ibm.com>
 <70BDB5DE-489D-4718-B6C2-0EABD89414D2@redhat.com>
 <0560e27d-dac8-a569-2e3f-f8188724c822@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 5 Nov 2019 19:37:33 +0100
MIME-Version: 1.0
In-Reply-To: <0560e27d-dac8-a569-2e3f-f8188724c822@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lDvsFhYLqksJ9htjUDiZIGGfuoNmYiGhy"
Message-Id: <2cb61837-dc0e-2b9f-cf40-1abb430af404@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lDvsFhYLqksJ9htjUDiZIGGfuoNmYiGhy
Content-Type: multipart/mixed; boundary="hiK6TBRwoasKh5T0lZd7EpwsS64YJ1iVb"

--hiK6TBRwoasKh5T0lZd7EpwsS64YJ1iVb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/5/19 7:23 PM, Christian Borntraeger wrote:
>=20
>=20
> On 05.11.19 18:34, David Hildenbrand wrote:
>>
>>
>>> Am 05.11.2019 um 17:29 schrieb Janosch Frank <frankja@linux.ibm.com>:=

>>>
>>> =EF=BB=BFWhen testing diag308 subcodes 0/1 on lpar with virtual mem s=
et up, I
>>> experienced spec PGMs and addressing PGMs due to the tests not settin=
g
>>> short psw bit 12 and leaving the DAT bit on.
>>>
>>> The problem was not found under KVM/QEMU, because Qemu just ignores
>>> all cpu mask bits... I'm working on a fix for that too.
>>>
>>
>> I don=E2=80=98t have access to documentation. Is what LPAR does docume=
nted behavior or is this completely undocumented and therefore undefined =
behavior? Then we should remove these test cases completely instead.
>=20
> Yes. It was just that KVM/QEMU never looked at the mask and just used a=
 default
> one. The short PSW on address 0 clearly contains a mask and we should b=
etter set
> it.

Yeah, we're currently reviewing the QEMU patch to fix this, I'll send it
out tomorrow.

>>
>>> Janosch Frank (2):
>>>  s390x: Add CR save area
>>>  s390x: Remove DAT and add short indication psw bits on diag308 reset=

>>>
>>> lib/s390x/asm-offsets.c  |  3 ++-
>>> lib/s390x/asm/arch_def.h |  5 +++--
>>> lib/s390x/interrupt.c    |  4 ++--
>>> lib/s390x/smp.c          |  2 +-
>>> s390x/cstart64.S         | 29 ++++++++++++++++++++---------
>>> 5 files changed, 28 insertions(+), 15 deletions(-)
>>>
>>> --=20
>>> 2.20.1
>>>



--hiK6TBRwoasKh5T0lZd7EpwsS64YJ1iVb--

--lDvsFhYLqksJ9htjUDiZIGGfuoNmYiGhy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3BwW0ACgkQ41TmuOI4
ufjJ1Q/9EpHnSJULLtzLNF3Yndqa3ythbwbA+v27tqA/cz7f9ghddFdQ5I90fpG0
GcpVa3NW14lnKEmBTATYYe+Ba3iZliy33P3rlSPlGCFJInqVLwDe7Q0yB3jHGioV
wc73Th15sE/p7EFxmsUeSEmvG8MwAvLQvvu+gNrUaPBv+hnYhHR0O+ZILn1l30Pd
+n1rJa6VE5Iz6zSX8JYkP7TK94DxHlvBP5TvINEkb8coxM92Vc9LpeGPNx2+I+mK
UWXmL8QlzvX/c0j+nimq15Rk7w1eCxxEM/GXg0buFAd2eliYZYciU805Fv4gXob5
2+XbI5vJipWuW3pIU0SLmIMeuLuEBkMSozosw1WL4rz419mMB5zuhXHRh6zkliJP
2usMrPkVv5L2Bw1WIywUWbVJMosyAqmaAgH36JBG7y9feFKhdVeGm5afSeqTvWuE
MwnCmjpXiMk8cV38ktC5hGZjfFtT6K66aBo9yXiIBwVRp3PIo43cYbjt5sV8atf8
niHG7gGEOrC28FhVqTJxzaQwzxCMF2OiLq7HUbFycih5HJoYEtQRaRkp/1ephSt8
Ve6mF8+vuorIsImvRfe68SX9pt3aXDC4LbBArUtsqVdSha7VGdu1L38MTkR87wbT
KwboSCt/p6LXhSCJhBa3mQHAhT+a94Sq2OPULLj27W8DE4KmP+c=
=zEjd
-----END PGP SIGNATURE-----

--lDvsFhYLqksJ9htjUDiZIGGfuoNmYiGhy--
