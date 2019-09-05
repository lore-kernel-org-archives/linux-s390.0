Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728072AbfIEIA5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 04:00:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x857w270126523
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 04:00:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2utx990j86-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 04:00:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 09:00:54 +0100
Subject: Re: [PATCH v2 0/2] KVM: s390: Check for invalid bits in
 kvm_valid_regs and kvm_dirty_regs
References: <20190904085200.29021-1-thuth@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 5 Sep 2019 10:00:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190904085200.29021-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gWQIJdATOdynDAV4K9Mg2r9rVWfgCdA9I"
Message-Id: <60703ff3-201d-23bd-3e9d-354e53b49252@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gWQIJdATOdynDAV4K9Mg2r9rVWfgCdA9I
Content-Type: multipart/mixed; boundary="TQSoxuGeU5g53gbhIQUIOVsdkGjjKBeCS";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <60703ff3-201d-23bd-3e9d-354e53b49252@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] KVM: s390: Check for invalid bits in
 kvm_valid_regs and kvm_dirty_regs
References: <20190904085200.29021-1-thuth@redhat.com>
In-Reply-To: <20190904085200.29021-1-thuth@redhat.com>

--TQSoxuGeU5g53gbhIQUIOVsdkGjjKBeCS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/4/19 10:51 AM, Thomas Huth wrote:
> Avoid invalid bits in kvm_valid_regs and kvm_dirty_regs on s390x.
>=20
> v2:
>  - Split the single patch from v1 into two separate patches
>    (I've kept the Reviewed-bys from v1, but if you don't agree with the=

>     patch description of the 2nd patch, please complain)
>=20
> Thomas Huth (2):
>   KVM: s390: Disallow invalid bits in kvm_valid_regs and kvm_dirty_regs=

>   KVM: selftests: Test invalid bits in kvm_valid_regs and kvm_dirty_reg=
s
>     on s390x
>=20
>  arch/s390/include/uapi/asm/kvm.h              |  6 ++++
>  arch/s390/kvm/kvm-s390.c                      |  4 +++
>  .../selftests/kvm/s390x/sync_regs_test.c      | 30 +++++++++++++++++++=

>  3 files changed, 40 insertions(+)
>=20

Thanks, both are picked


--TQSoxuGeU5g53gbhIQUIOVsdkGjjKBeCS--

--gWQIJdATOdynDAV4K9Mg2r9rVWfgCdA9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1wwLEACgkQ41TmuOI4
ufixCA/+Odhx7Sghxgy98iYZjSMipxnr1NBPClrMVaRiiNkMWt27H1RPnXt3Y/4/
/RG7rTZgrHaaRN0hMS9AXJHUsbqPunp67gdEeJc99NHYBIRtq5xZCW0zOxX4etXo
TFhuGSSmJ7LUOTwtOotA+7bNvxJJfph1CdKNIbSVZmPjQw7GxY5gz7ax0fsFc5bM
3v43lWsZTA2Ar/FnJvhgLiHhvD08ZJ15zFqowDMUvkNyK5c4BCYaNfwkCrRrhrxE
mzMvGkbHadJnxhoSDkvG+OSuOSkIUDx5KCaDDG5RaLkOa2yTEpdo76uDLoa3AR+T
jjlpyLyv+pGnxfQxOwqpMEq+AJbmtYVNF1dYGz/T/v3t8jvJ/v1Ux17Ze1dT4kIc
SEWJu9jrIgdGjDfteLewVRX/DvsJBNHSCvXBeGnghfePQIskEtZPpcuANq32uU04
KqozbsmuL6Oj5r0+TCSc5SzdMQ+6UYY+wIgitApJaRQXXlBr1RoMZ6arxFuGFTJg
QAihxEzF2zMr2FtRTl8eAx3IQHP9KDQKa0+t4qYgmwvbePxj7gtOQFsUtupjyqAL
z7rQ/21eW0bJl7ScRZV0M7et7AhIc/PCChTfJSrOTNUnE+XfDEEW3RZB60JPBUGM
5FE+C3Oa2XDqkulzPgu5oGkHchNJptq3Vb8ug+aSOH6y1elAi6Y=
=fh8O
-----END PGP SIGNATURE-----

--gWQIJdATOdynDAV4K9Mg2r9rVWfgCdA9I--
