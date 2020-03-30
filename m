Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730107AbgC3NKB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 09:10:01 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UD3ZbK037265
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 09:10:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3020qrufcs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 09:09:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 30 Mar 2020 14:09:49 +0100
Subject: Re: [kvm-unit-tests PATCH] s390x: Add stsi 3.2.2 tests
From: Janosch Frank <frankja@linux.ibm.com>
References: <20200330122035.19607-1-frankja@linux.ibm.com>
 <df745d0c-5d24-ee03-8600-ec495f1a5af6@redhat.com>
 <d42ac187-9f8f-81eb-c9b4-4d585fdef236@linux.ibm.com>
Date: Mon, 30 Mar 2020 15:09:54 +0200
MIME-Version: 1.0
In-Reply-To: <d42ac187-9f8f-81eb-c9b4-4d585fdef236@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yjt8yAzxRyEZUygNtV7i8jz9mz0BMlDpw"
Message-Id: <727e1ed5-99ea-e559-ca9c-0f067cbcc153@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yjt8yAzxRyEZUygNtV7i8jz9mz0BMlDpw
Content-Type: multipart/mixed; boundary="EcJ0nNRUwSBidzZBJo5uQKry2GiKqCxui"

--EcJ0nNRUwSBidzZBJo5uQKry2GiKqCxui
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/30/20 3:03 PM, Janosch Frank wrote:
> On 3/30/20 2:50 PM, David Hildenbrand wrote:
>> On 30.03.20 14:20, Janosch Frank wrote:
>>> +	report(data->vm[0].total_cpus =3D=3D smp_query_num_cpus(), "cpu # t=
otal");
>>> +	report(data->vm[0].conf_cpus =3D=3D smp_query_num_cpus(), "cpu # co=
nfigured");
>>> +	report(data->vm[0].standby_cpus =3D=3D 0, "cpu # standby");
>>> +	report(data->vm[0].reserved_cpus =3D=3D 0, "cpu # reserved");
>>
>> IIRC, using -smp 1,maxcpus=3DX, you could also test the reported reser=
ved
>> CPUs.
>=20
> Will try that

Just like I thought, QEMU does not manipulate cpu counts and KVM
pre-sets standby and reserved to 0. So we have absolutely no change when
adding the smp parameter.

>=20
>>
>>
>> Also passes under TCG, nice :)
>>
>=20
>=20



--EcJ0nNRUwSBidzZBJo5uQKry2GiKqCxui--

--yjt8yAzxRyEZUygNtV7i8jz9mz0BMlDpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6B76IACgkQ41TmuOI4
ufiSvQ/+Ld3L9iNMizy2ltaQ3knlEut9vaT+TcJp+qpgUZrr9QkCvsCtMEpDyNhh
8OZLpLTk2+nALga1jfJB8y+tTP4gT4ur1hYyxS9P5rE/j0AfnuYPvwWbWsMrDQBP
MR0E8mZ4wd8C4B3zSmXIsQCaWJwmPmLzyNByZ/4D13VDj7/Y1nW8l3pAi5VxLhIU
fzuY2PO/2w7f+YrAQFl+YUmMBp6X0dFd8Kihhp8VuAZW7NhnugaojmB9JJlCfPEZ
z0860T7XBTFCQ4b3TYIUFBE00/N34cho3v9Z0c2aFRAveE+dvLjHopz8FvYJ3fc2
6bvIRnxLoQY+UUpjZ7SErTJ7tDq1a1BGpCUAfN4yyqviETswATkEtprXgQqOuNBg
STIAEJ+boeI+W/YverYYZdiNqebMvpkWYj0w/R5CFOJFi1bGjEbZGG74QkClG4FJ
E2yndP8Q5vLp05fUYO27BAOyQ6yvIFFsSHzNsH1ivdWa4RPCDjoWUrCx/OYKLgu+
BeMinxU1i1GTnC7iPvOaR5UOh449K+gF5q+Tyc2YUMtLRxRJRZ6u5IattCz6qHjG
+wdXoJYulG/psBb2bhi5DSfQrxyDjxAF8tkq994ekn0hcwgo8W3hsuAxoppQCeMV
JQ4RqsPn3f+6JqqHNrqeRdODBEHdhFqK0yjtFUnBlEYBLVIQs+0=
=EzCZ
-----END PGP SIGNATURE-----

--yjt8yAzxRyEZUygNtV7i8jz9mz0BMlDpw--
