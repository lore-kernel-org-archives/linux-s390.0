Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731440AbfILMHp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 08:07:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CC3KRF177656
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 08:07:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uymh02vxq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 08:07:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Sep 2019 13:07:42 +0100
Subject: Re: [PATCH v2] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912115438.25761-1-thuth@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Sep 2019 14:07:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190912115438.25761-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JGrOCR7TtvjtOd5cvwdrnkY8RK1L075fd"
Message-Id: <3ad774f9-1cf3-b73e-576e-df6416484f9f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JGrOCR7TtvjtOd5cvwdrnkY8RK1L075fd
Content-Type: multipart/mixed; boundary="OfRPshFnZv9z4lHhfYdzcRqiDwP1BuIOX";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <3ad774f9-1cf3-b73e-576e-df6416484f9f@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912115438.25761-1-thuth@redhat.com>
In-Reply-To: <20190912115438.25761-1-thuth@redhat.com>

--OfRPshFnZv9z4lHhfYdzcRqiDwP1BuIOX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/12/19 1:54 PM, Thomas Huth wrote:
> When the userspace program runs the KVM_S390_INTERRUPT ioctl to inject
> an interrupt, we convert them from the legacy struct kvm_s390_interrupt=

> to the new struct kvm_s390_irq via the s390int_to_s390irq() function.
> However, this function does not take care of all types of interrupts
> that we can inject into the guest later (see do_inject_vcpu()). Since w=
e
> do not clear out the s390irq values before calling s390int_to_s390irq()=
,
> there is a chance that we copy random data from the kernel stack which
> could be leaked to the userspace later.
>=20
> Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
> interrupt: s390int_to_s390irq() does not handle it, and the function
> __inject_pfault_init() later copies irq->u.ext which contains the
> random kernel stack data. This data can then be leaked either to
> the guest memory in __deliver_pfault_init(), or the userspace might
> retrieve it directly with the KVM_S390_GET_IRQ_STATE ioctl.
>=20
> Fix it by handling that interrupt type in s390int_to_s390irq(), too,
> and by making sure that the s390irq struct is properly pre-initialized.=

> And while we're at it, make sure that s390int_to_s390irq() now
> directly returns -EINVAL for unknown interrupt types, so that we
> immediately get a proper error code in case we add more interrupt
> types to do_inject_vcpu() without updating s390int_to_s390irq()
> sometime in the future.
>=20
> Cc: stable@vger.kernel.org
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


--OfRPshFnZv9z4lHhfYdzcRqiDwP1BuIOX--

--JGrOCR7TtvjtOd5cvwdrnkY8RK1L075fd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl16NQkACgkQ41TmuOI4
ufhwZBAA0BcN6r2MsxgAAhGSxgymQBBLEXwe3SOh3u5699LiBObka48jiyG97MRf
/19Aq6lh630e+qkId+8lNrbzFRlfdScngXqRtvbe+mlMFmJFVXyvlnuuR73I9Xt9
n+6xLcnT5C4pgyVM3DAp3mi1Zw5ewQyXHQXpKi4POj+5cMic7ASDjiAiEy4ZP/vJ
52h9Q2Kahhquv02JVfzkfCSXYRP9lTXhj0qIU+1zxdsdznE14lXID1eUH9uc0sxn
bdGXDHW5aJlACS66dMoR3Wj6vL/NA6blCnIfVngJNOsLpuHgjRNZAOP32QRZoj92
E1u5fLV+qtwp1utbgEi9uqQT6xpt7/V1mumvaOYTRTWEl8Qcu50tDvRSN9+6V6c/
DCR5KVphPDVTH76rMEA9OWWc1kWoH0Mp1N1YpQ3/ewfF2Hktdc7h4tmPE8c34Xr/
PcXNgO/pe5I/qgSYwd0G+iX0zvIL+Ap61riz/utIzbPT2LvVvLKVIHSdPWVbiToJ
81ooV8RYPFsBuNW+0eW6lG8thDGfLxSyVApkrEGLXdPHgJlA0bK9FasCufrkMapL
hlD0VBHuewnodvX2u15pP2xPCIS2SH/aeNSnZ66PkXV8Pnv/PBRFH8X1G0uP22NQ
oWl4hXBDIZnCl1+x+S7N2gQjmWdkKIytMpOoPV6YYhjpO/Kpl1M=
=BLI9
-----END PGP SIGNATURE-----

--JGrOCR7TtvjtOd5cvwdrnkY8RK1L075fd--
