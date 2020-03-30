Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgC3NaP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 09:30:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UD3XRY173654
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 09:30:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30206x5b6u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 09:30:13 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 30 Mar 2020 14:30:00 +0100
Subject: Re: [kvm-unit-tests PATCH] s390x: Add stsi 3.2.2 tests
References: <20200330122035.19607-1-frankja@linux.ibm.com>
 <df745d0c-5d24-ee03-8600-ec495f1a5af6@redhat.com>
 <d42ac187-9f8f-81eb-c9b4-4d585fdef236@linux.ibm.com>
 <727e1ed5-99ea-e559-ca9c-0f067cbcc153@linux.ibm.com>
 <ab811a78-fe3c-1c6b-bb6d-85466e040ac6@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 30 Mar 2020 15:30:08 +0200
MIME-Version: 1.0
In-Reply-To: <ab811a78-fe3c-1c6b-bb6d-85466e040ac6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kH8bu86yVBFnOlrxnyJudRcInGHUbdEWI"
Message-Id: <2104b9a7-2ae0-6964-0eef-25ba7cca3119@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kH8bu86yVBFnOlrxnyJudRcInGHUbdEWI
Content-Type: multipart/mixed; boundary="bXdmGyT9SUxowwpXP4EzbkroHDrf9J5J1"

--bXdmGyT9SUxowwpXP4EzbkroHDrf9J5J1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/30/20 3:15 PM, David Hildenbrand wrote:
> On 30.03.20 15:09, Janosch Frank wrote:
>> On 3/30/20 3:03 PM, Janosch Frank wrote:
>>> On 3/30/20 2:50 PM, David Hildenbrand wrote:
>>>> On 30.03.20 14:20, Janosch Frank wrote:
>>>>> +	report(data->vm[0].total_cpus =3D=3D smp_query_num_cpus(), "cpu #=
 total");
>>>>> +	report(data->vm[0].conf_cpus =3D=3D smp_query_num_cpus(), "cpu # =
configured");
>>>>> +	report(data->vm[0].standby_cpus =3D=3D 0, "cpu # standby");
>>>>> +	report(data->vm[0].reserved_cpus =3D=3D 0, "cpu # reserved");
>>>>
>>>> IIRC, using -smp 1,maxcpus=3DX, you could also test the reported res=
erved
>>>> CPUs.
>>>
>>> Will try that
>>
>> Just like I thought, QEMU does not manipulate cpu counts and KVM
>> pre-sets standby and reserved to 0. So we have absolutely no change wh=
en
>> adding the smp parameter.
>=20
> Well, for TCG it is properly implemented. Is this a BUG in KVM's STSI c=
ode?
>=20

KVM tracks online cpus and created cpus, but only reports the online
ones in stsi.
Will QEMU register/create a reserved CPU with KVM?

To fix this we could also fix-up the cpu reporting in QEMU after KVM
wrote its results.

@Christian: Guidance?


--bXdmGyT9SUxowwpXP4EzbkroHDrf9J5J1--

--kH8bu86yVBFnOlrxnyJudRcInGHUbdEWI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6B9GAACgkQ41TmuOI4
ufjtlw//Q0eDOo3bni0wOgfGCirXsYj/cnafz4rQPSoFiSeRI1rHy8iRT4Ni8yOP
92a4a5Kl003p1dWVDjCQPsebnDWWnSUTroK/WwcSFn6IlzPtkSShGWgkVUSjyMJG
8A5OOlv5LE3cmaPBzx9PABvvlkrQJBTGzhMNHOyCY1JFOpUexNIbkJ+Qh1sPWvTj
mHERXaVNbwDUO35zCag+9A66+LrbUNF9WvIQJ/OvypJLeHGb8zNzVr5uQNgYCriU
M1IRzYb7W4f8L/Vm/Jy1WUlKvVa2koaGaml//eY3llH5j8qNpMhL9D/asG67MMdS
zLgm9nrNq9HEEIDvJLv57fE2ONnHrK9VkknmrOCgtwSkU3fECTd97YtjR+xJ4YZ8
JAL0TEP9rSB+WFecvKh14BB+NIxQ8lTj3QvdW4EIHNAa5pHdp2zrsyk3j/15N4LR
orXkuGo+mtWaBt3FpuAx/lSZZcLg/v6kJqHZLPfiTd5+5R21doAutSwLg8a5Za8S
Byx53sTFY88/JNi+DZYxhm3YSyY5UuxloY8MVh5M3UQ+QpL1K5yUpuiyeJLvjxYG
1Bbmqt+H50LDD4kQLeYEIHOh2TDnBrte62/Gpv7r/xPLvya7bsFdtnV03FWNjjBY
7q9zL3jLsPv32CTDeu2JLqKDb293uWbqNKMqliFwXerqEaNb93U=
=cxFM
-----END PGP SIGNATURE-----

--kH8bu86yVBFnOlrxnyJudRcInGHUbdEWI--
