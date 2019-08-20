Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726717AbfHTPV6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 11:21:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KF9wTJ122111
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 11:21:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugk8tgjtj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 11:21:56 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 20 Aug 2019 16:21:54 +0100
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Diag288 test
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <20190820105550.4991-3-frankja@linux.ibm.com>
 <6f25a51e-136e-1afb-215d-a2639fbd5510@redhat.com>
 <caf41bc6-6dcf-fa68-6b44-d8bcc1479acb@linux.ibm.com>
 <7e9f7043-14d9-8fc5-9302-cce8acdd5351@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 20 Aug 2019 17:21:51 +0200
MIME-Version: 1.0
In-Reply-To: <7e9f7043-14d9-8fc5-9302-cce8acdd5351@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KGIenJggKsyvV3ktyUQxtar3dawNrqlpr"
Message-Id: <56dad820-ea3c-27e0-c56c-7acc38632296@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KGIenJggKsyvV3ktyUQxtar3dawNrqlpr
Content-Type: multipart/mixed; boundary="MenTVVnVuYMPd55LzSSs1GcY7NAvaVN7W";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <56dad820-ea3c-27e0-c56c-7acc38632296@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Diag288 test
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <20190820105550.4991-3-frankja@linux.ibm.com>
 <6f25a51e-136e-1afb-215d-a2639fbd5510@redhat.com>
 <caf41bc6-6dcf-fa68-6b44-d8bcc1479acb@linux.ibm.com>
 <7e9f7043-14d9-8fc5-9302-cce8acdd5351@redhat.com>
In-Reply-To: <7e9f7043-14d9-8fc5-9302-cce8acdd5351@redhat.com>

--MenTVVnVuYMPd55LzSSs1GcY7NAvaVN7W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 2:55 PM, Thomas Huth wrote:
> On 8/20/19 2:25 PM, Janosch Frank wrote:
>> On 8/20/19 1:59 PM, Thomas Huth wrote:
>>> On 8/20/19 12:55 PM, Janosch Frank wrote:
[...]
>>> ... maybe we could also introduce such a variable as a global variabl=
e
>>> in lib/s390x/ since this is already the third or fourth time that we =
use
>>> it in the kvm-unit-tests...
>>
>> Sure I also thought about that, any particular place?
>=20
> No clue. Maybe lib/s390x/mmu.c ? Or a new file called lowcore.c ?
>=20
>>>> +static inline void diag288_uneven(void)
>>>> +{
>>>> +	register unsigned long fc asm("1") =3D 0;
>>>> +	register unsigned long time asm("1") =3D 15;
>>>
>>> So you're setting register 1 twice? And "time" is not really used in =
the
>>> inline assembly below? How's that supposed to work? Looks like a bug =
to
>>> me... if not, please explain with a comment in the code here.
>>
>> Well I'm waiting for a spec exception here, so it doesn't have to work=
=2E> I'll probably just remove the register variables and do a:
>>
>> "diag %r1,%r2,0x288"
>=20
> Yes, I think that's easier to understand.
>=20
> BTW, is there another documentation of diag 288 beside the "CP
> programming services" manual? At least my version of that specification=

> does not say that the fc register has to be even...

I used the non-public lpar documentation...

>=20
>>>> +static void test_bite(void)
>>>> +{
>>>> +	if (lc->restart_old_psw.addr) {
>>>> +		report("restart", true);
>>>> +		return;
>>>> +	}
>>>> +	lc->restart_new_psw.addr =3D (uint64_t)test_bite;
>>>> +	diag288(CODE_INIT, 15, ACTION_RESTART);
>>>> +	while(1) {};
>>>
>>> Should this maybe timeout after a minute or so?
>>
>> Well run_tests.sh does timeout externally.
>> Do you need it backed into the test?
>=20
> I sometimes also run the tests without the wrapper script, so in that
> case it would be convenient ... but I can also quit QEMU manually in
> that case, so it's not a big issue.

How about setting the clock comparator, that should trigger an
unexpected external interrupt?

>=20
>  Thomas
>=20



--MenTVVnVuYMPd55LzSSs1GcY7NAvaVN7W--

--KGIenJggKsyvV3ktyUQxtar3dawNrqlpr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1cEA8ACgkQ41TmuOI4
ufhoLw/+PBVaPVICGthwlZ0MYf2PxShJtfLYaioSsLKuuQcwezUrrWQwwIX1J4A6
Ez/fwEWDqh4QghPt+zhgxYYndmA6fT1Kvj80+ye26g8nHshhqlJS7p3/SEqj/Xoz
27uIRm0uUyZXvx3czYpViL60RqWXk+mgeeD13c5N4hGoPaUQ/3z/bjV/dKNNNeRZ
iPJkWVmvmHZncJqcdToKbLGRcWxH0Wrvh0P9HOzuMtYim62dWG9iqWgvwyI4gn1P
1Qf0PTcTtKrxt0zKD+pPoq6E7+KHuMJePsipPS+Fpef/W8163Gw1XILY6JqaiRrN
5150qoWBdVtriY6q0Y4C9nSbIrjMXPNmLDWRhqvdmPrXb8IpSmNLYTY/OuK+/iOC
Lfz1zvJS5MXJAT0OCFD4ytfBQhirZ9FNPyFVz5FYfID6HV8KkwsjjEbreltxSRgk
jT+Mx9aejWNvrTwf3yn6l0/aZTY1r17hNnlsAGJyv9prTZqRXXW/QJ8kfcM6dtx3
8RusQIOl9wyVoeOzRxMMj6eBrRbRtlktAGHbvSPqIsUaad7REimUtxclEM43kTIT
DPWls6oby3O2wNIY72B0tpPABq3Y4JbdlB+gXm1dIyGFsviOXK90xHQEVKAVoQMc
kOI82/wPrBAgvb6a1sFFtBY+L1HTCRDmLcbFOn7rDG5ucHyPPcY=
=OROU
-----END PGP SIGNATURE-----

--KGIenJggKsyvV3ktyUQxtar3dawNrqlpr--
