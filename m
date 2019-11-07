Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfKGPdG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Nov 2019 10:33:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7FRrlp117178
        for <linux-s390@vger.kernel.org>; Thu, 7 Nov 2019 10:33:05 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4np5gxu3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2019 10:33:05 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 7 Nov 2019 15:33:02 -0000
Subject: Re: [RFC 03/37] s390/protvirt: add ultravisor initialization
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-4-frankja@linux.ibm.com>
 <20191107162831.489e0591.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 7 Nov 2019 16:32:56 +0100
MIME-Version: 1.0
In-Reply-To: <20191107162831.489e0591.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JpbuKnP5e1iSLMr9fWmMMCNdvdwameHl3"
Message-Id: <357da80d-64a5-ce48-ccea-72073479fd92@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JpbuKnP5e1iSLMr9fWmMMCNdvdwameHl3
Content-Type: multipart/mixed; boundary="g5iiKXWAa131t1DMSKjuvaDP7c8Zpn49Z"

--g5iiKXWAa131t1DMSKjuvaDP7c8Zpn49Z
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/7/19 4:28 PM, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:25 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> From: Vasily Gorbik <gor@linux.ibm.com>
>>
>> Before being able to host protected virtual machines, donate some of
>> the memory to the ultravisor. Besides that the ultravisor might impose=

>> addressing limitations for memory used to back protected VM storage. T=
reat
>> that limit as protected virtualization host's virtual memory limit.
>>
>> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/uv.h | 16 ++++++++++++
>>  arch/s390/kernel/setup.c   |  3 +++
>>  arch/s390/kernel/uv.c      | 53 +++++++++++++++++++++++++++++++++++++=
+
>>  3 files changed, 72 insertions(+)
>=20
> (...)
>=20
>> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
>> index 35ce89695509..f7778493e829 100644
>> --- a/arch/s390/kernel/uv.c
>> +++ b/arch/s390/kernel/uv.c
>> @@ -45,4 +45,57 @@ static int __init prot_virt_setup(char *val)
>>  	return rc;
>>  }
>>  early_param("prot_virt", prot_virt_setup);
>> +
>> +static int __init uv_init(unsigned long stor_base, unsigned long stor=
_len)
>> +{
>> +	struct uv_cb_init uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_INIT_UV,
>> +		.header.len =3D sizeof(uvcb),
>> +		.stor_origin =3D stor_base,
>> +		.stor_len =3D stor_len,
>> +	};
>> +	int cc;
>> +
>> +	cc =3D uv_call(0, (uint64_t)&uvcb);
>> +	if (cc || uvcb.header.rc !=3D UVC_RC_EXECUTED) {
>> +		pr_err("Ultravisor init failed with cc: %d rc: 0x%hx\n", cc,
>> +		       uvcb.header.rc);
>> +		return -1;
>=20
> Is there any reasonable case where that call might fail if we have the
> facility installed? Bad stor_base, maybe?

Yes, wrong storage locations, length, etc...
Also if we are running with more than one CPU or the Ultravisor
encountered some internal error.

>=20
>> +	}
>> +	return 0;
>> +}
>> +
>> +void __init setup_uv(void)
>> +{
>> +	unsigned long uv_stor_base;
>> +
>> +	if (!prot_virt_host)
>> +		return;
>> +
>> +	uv_stor_base =3D (unsigned long)memblock_alloc_try_nid(
>> +		uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
>> +		MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
>> +	if (!uv_stor_base) {
>> +		pr_info("Failed to reserve %lu bytes for ultravisor base storage\n"=
,
>> +			uv_info.uv_base_stor_len);
>> +		goto fail;
>> +	}
>> +
>> +	if (uv_init(uv_stor_base, uv_info.uv_base_stor_len)) {
>> +		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
>> +		goto fail;
>> +	}
>> +
>> +	pr_info("Reserving %luMB as ultravisor base storage\n",
>> +		uv_info.uv_base_stor_len >> 20);
>> +	return;
>> +fail:
>> +	prot_virt_host =3D 0;
>=20
> So, what happens if the user requested protected virtualization and any=

> of the above failed? We turn off host support, so any attempt to start
> a protected virtualization guest on that host will fail (hopefully with=

> a meaningful error), I guess.
>=20

STFLE 161, and the associated diag308 subcodes 8-10 will not be
available to any VM. So yes, the stuv that starts a protected guest will
print a message.

> Is there any use case where we'd want to make failure to set this up
> fatal?

Not really.

>=20
>> +}
>> +
>> +void adjust_to_uv_max(unsigned long *vmax)
>> +{
>> +	if (prot_virt_host && *vmax > uv_info.max_sec_stor_addr)
>> +		*vmax =3D uv_info.max_sec_stor_addr;
>> +}
>>  #endif
>=20



--g5iiKXWAa131t1DMSKjuvaDP7c8Zpn49Z--

--JpbuKnP5e1iSLMr9fWmMMCNdvdwameHl3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3EOSgACgkQ41TmuOI4
ufjddxAAk1Rs3zetVKPU6WpKo7OxFN0s/FP97Ru+lm8JcO49baidUFjAr9x8llwA
0jeoKqAt+XqAzb7A7Wa8kg6k+yTKvXLzSOtG3bOe6vmwz4/PLTgCB9t/zpjKk24L
OqJ/1BV0M8xmTpn7fFYOXMnaI2Es3hQkX3HLGBgwe8xGzSji6OBvtdEfrJ82/QWu
mI0aueASgUBcU93eKBViyfXFN+qdR5qz6+D3t1fVfecyPctL6nRngVjEztAlL2KZ
KuqpNvhKajNzWH+NXD3ZluXxjGtTruvVK9ilNCMQ2z5pF8pwR7Qfruz4ayurfbQk
XzIlTCvv0H7z4qxR8lWpRRcqr4Y4kftZP1aXg1IQOHCru9/3WjWfI1jj4fcf8Jnm
lvpXLsk9dvHWAwJRUmwgiQjoxTj8lXbXMgXQk5tXP+xUlIjSSqjaozMjG5Ek9Iqs
bh6s/gxITYMU5VizXnxCk0IYBrCPyvUe0Ehu+g7/yDgO6j+AVt9gMQYZ16XZMpR+
j87aX6k/qGYXS9RnxqR0rmz/hgjMYdHQTgAHFtm+n5B40IMyDQbndniAsxMMhLrf
RUQ9SHIqn8FImGBr/ECmVmVW9ha2viUkF3D+sULbKL2MQineDuK+DaGFH3gw+iTp
1Ah3lBVsIH9CbQIPqmgKT1M57pdT/HxGl7uJeT3+BlbuY2ppTtc=
=7e7D
-----END PGP SIGNATURE-----

--JpbuKnP5e1iSLMr9fWmMMCNdvdwameHl3--
