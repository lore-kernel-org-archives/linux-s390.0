Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727151AbfIKIgr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Sep 2019 04:36:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8B8VcoC132458
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2019 04:36:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uxunkkqpf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2019 04:36:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Sep 2019 09:36:43 +0100
Subject: Re: [PATCH v2] KVM: s390: kvm_s390_vm_start_migration: check
 dirty_bitmap before using it as target for memset()
References: <20190911075218.29153-1-imammedo@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 11 Sep 2019 10:36:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190911075218.29153-1-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vRyjy3CQeEKOH3G9VNNkmYEGONAMZRI1Y"
Message-Id: <19baa04d-0d77-7a80-65e2-e00b0d096811@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vRyjy3CQeEKOH3G9VNNkmYEGONAMZRI1Y
Content-Type: multipart/mixed; boundary="dzBoqpYyJe1rGZE0BD3rqKHntsX41AMyO";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com,
 heiko.carstens@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Message-ID: <19baa04d-0d77-7a80-65e2-e00b0d096811@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: kvm_s390_vm_start_migration: check
 dirty_bitmap before using it as target for memset()
References: <20190911075218.29153-1-imammedo@redhat.com>
In-Reply-To: <20190911075218.29153-1-imammedo@redhat.com>

--dzBoqpYyJe1rGZE0BD3rqKHntsX41AMyO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/11/19 9:52 AM, Igor Mammedov wrote:
> If userspace doesn't set KVM_MEM_LOG_DIRTY_PAGES on memslot before call=
ing
> kvm_s390_vm_start_migration(), kernel will oops with:
>=20
>   Unable to handle kernel pointer dereference in virtual kernel address=
 space
>   Failing address: 0000000000000000 TEID: 0000000000000483
>   Fault in home space mode while using kernel ASCE.
>   AS:0000000002a2000b R2:00000001bff8c00b R3:00000001bff88007 S:0000000=
1bff91000 P:000000000000003d
>   Oops: 0004 ilc:2 [#1] SMP
>   ...
>   Call Trace:
>   ([<001fffff804ec552>] kvm_s390_vm_set_attr+0x347a/0x3828 [kvm])
>    [<001fffff804ecfc0>] kvm_arch_vm_ioctl+0x6c0/0x1998 [kvm]
>    [<001fffff804b67e4>] kvm_vm_ioctl+0x51c/0x11a8 [kvm]
>    [<00000000008ba572>] do_vfs_ioctl+0x1d2/0xe58
>    [<00000000008bb284>] ksys_ioctl+0x8c/0xb8
>    [<00000000008bb2e2>] sys_ioctl+0x32/0x40
>    [<000000000175552c>] system_call+0x2b8/0x2d8
>   INFO: lockdep is turned off.
>   Last Breaking-Event-Address:
>    [<0000000000dbaf60>] __memset+0xc/0xa0
>=20
> due to ms->dirty_bitmap being NULL, which might crash the host.
>=20
> Make sure that ms->dirty_bitmap is set before using it or
> return -ENIVAL otherwise.

Fixed that while picking and added my reviewed-by, as well as the others
you removed.
Thanks for your patch.


--dzBoqpYyJe1rGZE0BD3rqKHntsX41AMyO--

--vRyjy3CQeEKOH3G9VNNkmYEGONAMZRI1Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl14shYACgkQ41TmuOI4
ufhBAhAAoOSaWNtX+nzRWC/HmJHPpeav8+63Qo91vK6EVOpXq/A4mKa1Hcb/IMbg
wrXMAxEg3ODpSBTHJzp9t9MjQwdHO8SKfJvcMAJhGHzeEuLycUSBbBdOns1UFwtl
xa1Xcxlk3j8jVCqeQZCQHayj2iSKVlCeF6BVhvmtbMjMBwlUdrkjG3Fc1nX0XngU
BrE+Of03FCmOe0PBa6OU5IsWyGDb6hO30uY7rdf79jPeb15TQqyEJtzSfoLcc4qh
3+6z9QVmJfC/he2kb7KB7K8KDzBTIp8QQUan4R/XGDKqVGkoIB/WPdkkVXNxoGSf
Zy7i531iDZ8eexEwWP2dUSC681r7fermJUS7JWGmvuR15iGhfIvEkliQKG2kmQQ8
U9aeCtrW6hC2/zXbfJ3RZUl4/Km668cUMolgn2lSbta2p2ASsKZ/YsNFkVQYX9t2
cowNHv59ClN87LHRRzQDJj5lUVvncLG8oc7BK9o4Azo3y2iT8Hko7J2TJx1rHXjZ
yUgSTsVOVhMXEdcGCmwgIZ964EAW0L2NnqXFrf8qUfo04yMgWwOPbThDYwx2o4XI
mT6XsfiqUo+TIrqxJObH9cJEWJHT6ld3+AWqyWuApnZ/11lLT7Ue1Y2PO/xhLhHE
qhUXYZgF1gQyRY2N1LD5w+GqZWtclRDf+/hA0d2tJrpzf49dKd4=
=6bmL
-----END PGP SIGNATURE-----

--vRyjy3CQeEKOH3G9VNNkmYEGONAMZRI1Y--
