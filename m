Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbgA3NDJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 08:03:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UCwwe9042473
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 08:03:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xtpmu7ken-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 08:03:06 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 30 Jan 2020 13:03:04 -0000
Subject: Re: [PATCH v9] KVM: s390: Add new reset vcpu API
References: <9d64917a-2a0a-46e7-0d78-da2f31eb01c4@linux.ibm.com>
 <20200130125559.30032-1-frankja@linux.ibm.com>
 <9dfba609-8fb4-53a1-88ed-3ed98112200c@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 30 Jan 2020 14:02:59 +0100
MIME-Version: 1.0
In-Reply-To: <9dfba609-8fb4-53a1-88ed-3ed98112200c@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FWOwbfpGrJTU5a9jM4Jo2QYiEXV4MSHXQ"
Message-Id: <b52e8e3c-7366-7ac5-0fbc-beaceed977d8@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FWOwbfpGrJTU5a9jM4Jo2QYiEXV4MSHXQ
Content-Type: multipart/mixed; boundary="BSpQZfnOqgEZxTl95OcsNMgfrk0r1nzDw"

--BSpQZfnOqgEZxTl95OcsNMgfrk0r1nzDw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/30/20 1:59 PM, Christian Borntraeger wrote:
>=20
>=20
> On 30.01.20 13:55, Janosch Frank wrote:
>=20
>> +static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>> +{
>> +	/* Initial reset is a superset of the normal reset */
>> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>> +
>> +	/* this equals initial cpu reset in pop, but we don't switch to ESA =
*/
>> +	vcpu->arch.sie_block->gpsw.mask =3D 0;
>> +	vcpu->arch.sie_block->gpsw.addr =3D 0;
>> +	kvm_s390_set_prefix(vcpu, 0);
>> +	kvm_s390_set_cpu_timer(vcpu, 0);
>> +	vcpu->arch.sie_block->ckc =3D 0;
>> +	vcpu->arch.sie_block->todpr =3D 0;
>> +	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gc=
r));
>> +	vcpu->arch.sie_block->gcr[0] =3D CR0_INITIAL_MASK;
>> +	vcpu->arch.sie_block->gcr[14] =3D CR14_INITIAL_MASK;
>> +	vcpu->run->s.regs.fpc =3D 0;
>=20
>> +	current->thread.fpu.fpc =3D 0;
>=20
> This is still wrong.

Your fixpatch doesn't delete it :)
That hunk is not mine...



--BSpQZfnOqgEZxTl95OcsNMgfrk0r1nzDw--

--FWOwbfpGrJTU5a9jM4Jo2QYiEXV4MSHXQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4y1AMACgkQ41TmuOI4
ufgSwA//dWu5ektdesAFfVAtjUrwxngeu9EdB3kbSz8aRXoE+i9h1jQEdYuMAf41
7bZCgK5IM3fIT9T1g2mKnnwbLX8QhJTZpzd+S1oW1AApsANv9jDxMTo0q7zb63Ef
Jwe4akyv+soY5YbL4teeBE8mr1f1vujkFSbi12AQEFXk1XhtLvypAciCdyYMwKeH
LzdBjApKIySu8RJdhBtCHGNGUzNa2NyqHyiH9Y9mpOKSPsuPB+O/5seePEkbtejN
AYsIIC+M/1QJQZviKmOazIJQhJ5hrcSyCX1VvU430FlTJocsiQ2yANGlc22EDGUb
PatoUkB7HRFl0R+mdMwLExqYU6GDWBtkblgeHvvSXuCo0sMGsQFuBjoJRlcfjnWX
EJLFn+z56cTnn/gEf8Sk4/r2b5ZazoVRA3q+0KwwYkQmphaYsnjIyXIWlz8LMOLz
1cCvZ7j1R0GQwVS5t//0JDSWfSWoeVKJzHxp5uq5pYpIPgA2kfmkYA1wVPDIT6de
WptdUHDoUXoq9lo4wO3uv9RSh8NIvuIgPFMy1Wo63kWVrMJTF2LsZK/QCYOAsZFm
mjE+3kBEIhIAt7Lp1PUZWdjZUxAiX4A0I2Qwj10d525AIEBjAbC+TP78Y6JcVT/Q
ZWFqpeCXIz2XkpV3JMYVI0Z4iN5f3XJQk8tgbpANLsx1KY38r3c=
=rdW6
-----END PGP SIGNATURE-----

--FWOwbfpGrJTU5a9jM4Jo2QYiEXV4MSHXQ--
