Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbfICH4P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 03:56:15 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x837tx3R038976
        for <linux-s390@vger.kernel.org>; Tue, 3 Sep 2019 03:56:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usgqde5s0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2019 03:56:01 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 3 Sep 2019 08:54:02 +0100
Subject: Re: [kvm-unit-tests PATCH 1/6] s390x: Use interrupts in SCLP and add
 locking
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-2-frankja@linux.ibm.com>
 <74d31bb9-4941-01f3-571b-8a89a05402c8@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 3 Sep 2019 09:53:57 +0200
MIME-Version: 1.0
In-Reply-To: <74d31bb9-4941-01f3-571b-8a89a05402c8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SpJOkMZbvakFnXVoieMqmFxOlrPb2ujq6"
Message-Id: <4309b6ea-e479-f25d-276a-6d8260d4f19f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SpJOkMZbvakFnXVoieMqmFxOlrPb2ujq6
Content-Type: multipart/mixed; boundary="JKILaMc7ZmIPmvQPdNRMnIiRLccDQuIvz";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <4309b6ea-e479-f25d-276a-6d8260d4f19f@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 1/6] s390x: Use interrupts in SCLP and add
 locking
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-2-frankja@linux.ibm.com>
 <74d31bb9-4941-01f3-571b-8a89a05402c8@redhat.com>
In-Reply-To: <74d31bb9-4941-01f3-571b-8a89a05402c8@redhat.com>

--JKILaMc7ZmIPmvQPdNRMnIiRLccDQuIvz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/30/19 2:21 PM, David Hildenbrand wrote:
> On 29.08.19 14:14, Janosch Frank wrote:
>> We need to properly implement interrupt handling for SCLP, because on
>> z/VM and LPAR SCLP calls are not synchronous!
>>
>> Also with smp CPUs have to compete for sclp. Let's add some locking,
>> so they execute sclp calls in an orderly fashion and don't compete for=

>> the data buffer.

[...]

>> +
>> +void sclp_mark_busy(void)
>> +{
>> +	/*
>> +	 * With multiple CPUs we might need to wait for another CPU's
>> +	 * request before grabbing the busy indication.
>> +	 */
>> +retry_wait:
>> +	sclp_wait_busy();
>> +	spin_lock(&sclp_lock);
>> +	if (sclp_busy) {
>> +		spin_unlock(&sclp_lock);
>> +		goto retry_wait;
>> +	}
>> +	sclp_busy =3D true;
>> +	spin_unlock(&sclp_lock);
>=20
> while (true) {
> 	sclp_wait_busy();
> 	spin_lock(&sclp_lock);
> 	if (!sclp_busy) {
> 		sclp_busy =3D true
> 		spin_unlock(&sclp_lock);
> 		break;
> 	}
> 	spin_unlock(&sclp_lock);
> }
>=20
> Or can we simply switch to an atomic_t for sclp_busy and implement
> cmpxchg using __sync_bool_compare_and_swap/ __sync_val_compare_and_swap=
 ?
>=20
> I guess then we can drop the lock. But maybe I am missing something :)

If you want to add it and it works, I'm open for it :)
Until then I'm taking your suggestion.

>=20
>> +}
[...]
>>  extern char _sccb[];
>> +void sclp_handle_ext(void);
>> +void sclp_wait_busy(void);
>> +void sclp_mark_busy(void);
>=20
> I wonder if we can find better names ...
>=20
> sclp_prepare()
> sclp_finalize()
>=20
> or sth like that.

Hmm, IMHO my names are a bit better, since they clearly state, that we
wait until the other user has finished.



--JKILaMc7ZmIPmvQPdNRMnIiRLccDQuIvz--

--SpJOkMZbvakFnXVoieMqmFxOlrPb2ujq6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1uHBYACgkQ41TmuOI4
ufixkg//VLcO4Ts4MtRRyMays08mkXBmk+5ppjPOzsbhNeitS1wND83wd6QrZyRe
bi8tznbHvqBHfTa7kr3/b+Uid4bliklER5snDjGQmrT/QjfxFtWBL4cLtvj65ilL
e3fuAwCgPqQb+uRdqJm9mXXnbG/s3iDBcySS424QZzlNjVoKgnT9VmWR6O0quIg8
0vBG+DmqAO1RX9fSP7d8VRwYJgDABpF/ZYa6HxBlSSS9psEn+P1k9nrqDvUYwdKH
Bv0nBFdAaXOtpmAKWuzRc8C7CkoKqsiR2P0MffIphDYmydEVC9U+bAcRFyySkdrd
nqBBXdGbQ02HTxi8HQDZDm4g2hKDoWdpm8KyjvxIH4hEJGO0QFojQ/T2MuPumoCH
Y0vYGcIiDXWZbv3NshfdiB6cSGDNJUBkE2d+Gw1gjdz4rszY94V2IoiyQlKfwRUU
AO0RJpA0EnUi6a4sE/84862N1BOkILOKD03AooWeZkDH+QUVF2eA4kZC+e9JvpoA
+PEvqFwhJHgFnh8AODeyBsl/SzlC/NlIR+5OZIaAf/Ewpa8jDfZOaE2fQKNtiM3h
SXNLIFxMRSFTaB8JSujAkcgq15bPj5WGz1UzcuI+83a+VzcUys6SS78DEccoCOT8
rt6w+O1qhnga/oy3eNZkR6rBJYMgZ93fFQkaduQFYgfSxmfcbsk=
=RhfB
-----END PGP SIGNATURE-----

--SpJOkMZbvakFnXVoieMqmFxOlrPb2ujq6--
