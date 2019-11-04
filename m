Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62150 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727682AbfKDIlg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 03:41:36 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA48bTMq003547
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 03:41:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w14m31e7v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 03:41:32 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 4 Nov 2019 08:41:27 -0000
Subject: Re: [RFC 04/37] KVM: s390: protvirt: Add initial lifecycle handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-5-frankja@linux.ibm.com>
 <d87e2322-2dc6-0633-b64b-e3286186ea4c@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 4 Nov 2019 09:41:23 +0100
MIME-Version: 1.0
In-Reply-To: <d87e2322-2dc6-0633-b64b-e3286186ea4c@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cmgjGry7htCKaf8L3hCrXC6JvZwASoIyh"
Message-Id: <44dde437-a73b-8a57-ab7f-c2d9e9ea4b4e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cmgjGry7htCKaf8L3hCrXC6JvZwASoIyh
Content-Type: multipart/mixed; boundary="M4JPJqBAkan5Ymz4Lu2q2exZXUYC2Qx3r"

--M4JPJqBAkan5Ymz4Lu2q2exZXUYC2Qx3r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/4/19 9:18 AM, Christian Borntraeger wrote:
>=20
>=20
> On 24.10.19 13:40, Janosch Frank wrote:
>> Let's add a KVM interface to create and destroy protected VMs.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  24 +++-
>>  arch/s390/include/asm/uv.h       | 110 ++++++++++++++
>>  arch/s390/kvm/Makefile           |   2 +-
>>  arch/s390/kvm/kvm-s390.c         | 173 +++++++++++++++++++++-
>>  arch/s390/kvm/kvm-s390.h         |  47 ++++++
>>  arch/s390/kvm/pv.c               | 237 ++++++++++++++++++++++++++++++=
+
>>  include/uapi/linux/kvm.h         |  33 +++++
>>  7 files changed, 622 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/s390/kvm/pv.c
> [...]
>=20
>> +	case KVM_PV_VM_UNPACK: {
>> +		struct kvm_s390_pv_unp unp =3D {};
>> +
>> +		r =3D -EFAULT;
>> +		if (copy_from_user(&unp, argp, sizeof(unp)))
>> +			break;
>> +
>> +		r =3D kvm_s390_pv_unpack(kvm, unp.addr, unp.size, unp.tweak);
>> +		break;
>> +	}
>=20
>=20
>=20
> [....]
>=20
>> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned =
long size,
>> +		       unsigned long tweak)
>> +{
>> +	int i, rc =3D 0;
>> +	struct uv_cb_unp uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_UNPACK_IMG,
>> +		.header.len =3D sizeof(uvcb),
>> +		.guest_handle =3D kvm_s390_pv_handle(kvm),
>> +		.tweak[0] =3D tweak
>> +	};
>> +
>> +	if (addr & ~PAGE_MASK || size & ~PAGE_MASK)
>> +		return -EINVAL;
>> +
>> +
>> +	VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
>> +		 addr, size);
>=20
> Does it make sense to check for addr and addr+size to be within the mem=
ory
> size of the guest? The uv_call or gmap_fault will fail later on, but we=
=20
> could do an early exit if the the site is wrong.=20

Yeah, Marc already brought that up because of a testcase of his.
I'll add a check, but before that I need to understand what makes us
loop so long that we get RCU warnings.

>=20
>=20
>=20
>=20
>> +	for (i =3D 0; i < size / PAGE_SIZE; i++) {
>> +		uvcb.gaddr =3D addr + i * PAGE_SIZE;
>> +		uvcb.tweak[1] =3D i * PAGE_SIZE;
>=20
>=20
>> +retry:
>=20
>> +		rc =3D uv_call(0, (u64)&uvcb);
>> +		if (!rc)
>> +			continue;
>> +		/* If not yet mapped fault and retry */
>> +		if (uvcb.header.rc =3D=3D 0x10a) {
>> +			rc =3D gmap_fault(kvm->arch.gmap, uvcb.gaddr,
>> +					FAULT_FLAG_WRITE);
>> +			if (rc)
>> +				return rc;
>> +			goto retry;
>> +		}
>> +		VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx rc %x rrc %x=
",
>> +			 uvcb.gaddr, uvcb.header.rc, uvcb.header.rrc);
>> +		break;
>> +	}
> [...]
>=20



--M4JPJqBAkan5Ymz4Lu2q2exZXUYC2Qx3r--

--cmgjGry7htCKaf8L3hCrXC6JvZwASoIyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2/5DMACgkQ41TmuOI4
ufgNxg/+JxkvbvHXrscDwohfLjwfM+h/g+/GSON95MHAjYH84YuNYTgW7Jcd1GM5
96VCYbAq3J0WlRKf7LV1vAOoyiVuRev1v2g++inBRGEHA1PmseShfQiaWSsxQTWg
pJ/dC4W6blmw83LuK3lW8upQNhcD55D7M5g1rMdTeSmdn4pitAjqinRViu0pO7hb
zr1YTufhw5AtfznamFcQWCbZbkXW2vEPNUJ+r65d9Jma/Gd/7h086e+Cqprnf49p
1oY+VkgRjazA6OHJ4L9r2vs4G5yI+yuVSUV/Y+eZdR3V+suNGF9fbd+YWxeXkRkO
/ShQwgOFGFFHDWsXlDx/SLQXmSuHe7YHi4GRoT88NOm4dtfYKlWZ4/UC8nzwtbku
iPL2tAeQiCkNZdvjAqh7UIvP2s3ZEOfPY7Z9qgwZxagxYf9Dmb3W/xVq1Gg2Mly1
vG5KxSbUqrx/pH16wcnteX31ZURDRYwf0J0OxWdBAggkfoULmYSCYVHGVoIQbjWn
bXR72tm05k8yyJh4/O9EiydlwlyRhduGciicAxH3iKw7+tZPO73seL1dBOmBWMJq
K+GCOZpfOvj1yzX9Dmxtmtj+mT9RDuF7Chk3Qhc1H6x7RvkxjvylVGYvvBFtIzS3
Ec6F6ZRN1ofsxYBmpNgNpjF3CbuiZU7HgU4Lo6edGr1mEtyOwiU=
=mlqE
-----END PGP SIGNATURE-----

--cmgjGry7htCKaf8L3hCrXC6JvZwASoIyh--
