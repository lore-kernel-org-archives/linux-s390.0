Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730340AbfIYKYn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 06:24:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8PANxij064224
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 06:24:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v86ex00u9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 06:24:41 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 25 Sep 2019 11:24:40 +0100
Subject: Re: [kvm-unit-tests PATCH v3 6/6] s390x: SMP test
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-7-frankja@linux.ibm.com>
 <47f9b150-c0fd-e497-7ee5-5c138f9b48fe@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 25 Sep 2019 12:24:36 +0200
MIME-Version: 1.0
In-Reply-To: <47f9b150-c0fd-e497-7ee5-5c138f9b48fe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UMBD2CFW07rvHqIGjtxFOTe0BrA5nW76j"
Message-Id: <b7b069ff-f911-3ea4-7d4c-93a6a4a2394f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UMBD2CFW07rvHqIGjtxFOTe0BrA5nW76j
Content-Type: multipart/mixed; boundary="swoIA0p9FHn0bj5a5rOemuDvtM7Ec22nZ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <b7b069ff-f911-3ea4-7d4c-93a6a4a2394f@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 6/6] s390x: SMP test
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-7-frankja@linux.ibm.com>
 <47f9b150-c0fd-e497-7ee5-5c138f9b48fe@redhat.com>
In-Reply-To: <47f9b150-c0fd-e497-7ee5-5c138f9b48fe@redhat.com>

--swoIA0p9FHn0bj5a5rOemuDvtM7Ec22nZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/25/19 11:03 AM, David Hildenbrand wrote:
> On 20.09.19 10:03, Janosch Frank wrote:

>> +
>> +int main(void)
>> +{
>> +	report_prefix_push("smp");
>> +
>> +	if (smp_query_num_cpus() =3D=3D 1) {
>> +		report_abort("need at least 2 cpus for this test");
>> +		goto done;
>> +	}
>=20
> You should rather sense if CPU with the addr 1 is available. AFAIR, the=

> number of CPUs and the CPU addresses are two types of shoes.
>=20

Yes and no, if we don't have more than one cpu we certainly don't have
cpu 1. And for what I've seen up to now QEMU assigns cpus linearly.



--swoIA0p9FHn0bj5a5rOemuDvtM7Ec22nZ--

--UMBD2CFW07rvHqIGjtxFOTe0BrA5nW76j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2LQGQACgkQ41TmuOI4
ufg/ARAAs6Qe+4hNE+VwD2GCP18OC03mBXGvOq9XFV8zfT2sByVHT4eAwDU64kEq
1IDmWMSOXR2VRKKacsGqJQTW9rOAjrdNadl3tebZzr9ExxQC0RYpk0JbDoq4ZWkS
79zr/imYKwl0/JN39R5JvOD4ITfkxdg/dSw0ZExkayYI8Vu11ApGCpcetfUqZeZz
sMY1mO/VAO5lOwN+u1GVESNUR0KCcNraXmkQj6MSAL5s7ElGN8J90PWDDcwWsroT
komwtSZCdP3EB+mpY+fEFxzObKTg8yGSxsuPmQ9oueS6mqlodFHHj7SmT+0MYf7e
ZG5L3Sl0BeDnTMakuQwf9CNWIn2E18cTXz+SotE+Y3KKEnlhYElh4+90eloSmCfO
UNDqsZo82/VcbpPnf4hMUdrIdOna9TNvxXm4LosHk7eCV2Cy+qLZpB2joosp2XJY
e1vHv8DEcMpOPXFJAmvrVygBwJUWi3W60Xo4NdS8VojWSo9hnL0oQnPLNcOTt4G2
l0ica/z657eBubttg+/GLqIDY148VwRKI9cVBw4yzHoLTQWIj7yKccGXmJXBlcus
A3ZELeXbH2DPly9pHnkP2GE1o++rUpD1Hidq7SuRdMGcWNYcXavygnTKosMDmzsP
hhqA3rbXRgBueOYJWr/wWIpdqhXM9etSQQnjGEHZiCoBYJiw0XQ=
=Fsmn
-----END PGP SIGNATURE-----

--UMBD2CFW07rvHqIGjtxFOTe0BrA5nW76j--
