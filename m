Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390829AbfHWOli (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 10:41:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NEdtqe016668
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 10:41:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujghy4ne8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 10:41:37 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 23 Aug 2019 15:41:34 +0100
Subject: Re: [kvm-unit-tests PATCH] s390x: Add diag308 subcode 0 testing
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190822111100.4444-1-frankja@linux.ibm.com>
 <ffc7de14-7960-5423-d984-c18ab1dfa4b2@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 23 Aug 2019 16:41:29 +0200
MIME-Version: 1.0
In-Reply-To: <ffc7de14-7960-5423-d984-c18ab1dfa4b2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hd4Z68GNr1YqiR6yL7gsHmq3N1XT8ukbZ"
Message-Id: <137ffa8a-2a93-b31b-df47-6b27d566deef@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hd4Z68GNr1YqiR6yL7gsHmq3N1XT8ukbZ
Content-Type: multipart/mixed; boundary="WVpFpftxZvkmQYA0KfAMT0kCBRpV7oGWq";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <137ffa8a-2a93-b31b-df47-6b27d566deef@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH] s390x: Add diag308 subcode 0 testing
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190822111100.4444-1-frankja@linux.ibm.com>
 <ffc7de14-7960-5423-d984-c18ab1dfa4b2@redhat.com>
In-Reply-To: <ffc7de14-7960-5423-d984-c18ab1dfa4b2@redhat.com>

--WVpFpftxZvkmQYA0KfAMT0kCBRpV7oGWq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/19 4:12 PM, Thomas Huth wrote:
> On 8/22/19 1:11 PM, Janosch Frank wrote:
>> By adding a load reset routine to cstart.S we can also test the clear
>> reset done by subcode 0, as we now can restore our registers again.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>> I managed to extract this from another bigger test, so let's add it to=
 the bunch.
>> I'd be very happy about assembly review :-)
>=20
> FWIW, the assembly code looks fine to me.
>=20
>> ---
>>  s390x/cstart64.S | 27 +++++++++++++++++++++++++++
>>  s390x/diag308.c  | 31 ++++++++++---------------------
>>  2 files changed, 37 insertions(+), 21 deletions(-)
>>
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index dedfe80..47045e1 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -145,6 +145,33 @@ memsetxc:
>>  	.endm
>> =20
>>  .section .text
>> +/*
>> + * load_reset calling convention:
>> + * %r2 subcode (0 or 1)
>> + */
>> +.globl load_reset
>> +load_reset:
>=20
> Maybe rather name the function diag308_load_reset so that it is clear
> that it belongs to the diag308 test?

Sure

> Or are you going to re-use this function in other tests later?

I currently have no such plans
But I'm thinking about a way to check the CPU registers in combination
with smp. So it might be extended.

>=20
> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20

Thanks!



--WVpFpftxZvkmQYA0KfAMT0kCBRpV7oGWq--

--hd4Z68GNr1YqiR6yL7gsHmq3N1XT8ukbZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1f+xkACgkQ41TmuOI4
ufjwhg/9FHIFBTQAtWsg0n0Q0t9Mk9JSDpOX5N7qbD0FeW5z2MAX/cijuRCWoPVn
ZHWyXKHxzrP4orIF/j6u2y7STyCV4o5CA03yMBU4G4GjbEyHgy6inBoM0WCjSvBO
w20aZLv4UHMecdFCmIDkrLcAqENxnHz1GVgDVBdWJBCTcaE7D09/BPfiJ7Dj79/I
s210XhX94MpCyUeTs9mGfirAxuRlNicA0rpvYcSulH15x2lEss5N3Os3nlYkxDhP
0ffmm4glCmT27R4tJWYV3Bql5Yf69WjwpfBx/GptMwMrBVfIR4oIfz/jFyE5pTvw
gL7oOSxfPLUNgVtfP+sIGZaJu4xbZHxvHsmfk1ymTMAKvMOPhmb+HLuVmGwhd5/y
polclTNK6qgxRhwieRxwR98vwcPVe4aEy6Jr59shPv+1NxhZjwZs+xDtdm4awgO4
pG126EPOhU5XGxom7zVfxU1r8Xv6ARp3MrCZgcIZmfjyiVkjGntmkc7B9LadXGjS
8RQNbcfvnxsdHKSkf3wFRWjEdHvb+WN4dtV5c+ZrvCZ1EGK9uRvKVlpCkCmSrw3R
+SF4whihsseBU1i8yYkElznTBFQbXvCckHP63JX74zG4T2hevkBVB1pKfQjh/Eu9
yCoM+rfG8BM05y+ZgSCw0LkESE8ifUTahTQq1MqpsXhBrEi+occ=
=9LVC
-----END PGP SIGNATURE-----

--hd4Z68GNr1YqiR6yL7gsHmq3N1XT8ukbZ--
