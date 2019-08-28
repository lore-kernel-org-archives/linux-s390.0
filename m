Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbfH1OQG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 10:16:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SECwG0130614
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2019 10:16:05 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unsptvb81-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2019 10:16:04 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 28 Aug 2019 15:05:54 +0100
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: Add storage key removal
 facility
References: <20190828113615.4769-1-frankja@linux.ibm.com>
 <20190828113615.4769-5-frankja@linux.ibm.com>
 <3ea4cb74-4fe4-d2bd-7fe4-550df9c355e6@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 28 Aug 2019 16:05:49 +0200
MIME-Version: 1.0
In-Reply-To: <3ea4cb74-4fe4-d2bd-7fe4-550df9c355e6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0OeHyVKPrG7I45JLwqYqU9mJj98aEfbsk"
Message-Id: <6af2ff95-013b-c366-24f8-f178f7bcd40a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0OeHyVKPrG7I45JLwqYqU9mJj98aEfbsk
Content-Type: multipart/mixed; boundary="8kLzLtWtd2bGNrw40NJHlL4rYpDV5xxnX";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <6af2ff95-013b-c366-24f8-f178f7bcd40a@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: Add storage key removal
 facility
References: <20190828113615.4769-1-frankja@linux.ibm.com>
 <20190828113615.4769-5-frankja@linux.ibm.com>
 <3ea4cb74-4fe4-d2bd-7fe4-550df9c355e6@redhat.com>
In-Reply-To: <3ea4cb74-4fe4-d2bd-7fe4-550df9c355e6@redhat.com>

--8kLzLtWtd2bGNrw40NJHlL4rYpDV5xxnX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/28/19 2:02 PM, Thomas Huth wrote:
> On 28/08/2019 13.36, Janosch Frank wrote:
>> The storage key removal facility (stfle bit 169) makes all key related=

>> instructions result in a special operation exception if they handle a
>> key.
>>
>> Let's make sure that the skey and pfmf tests only run non key code
>> (pfmf) or not at all (skey).
>>
>> Also let's test this new facility. As lots of instructions are
>> affected by this, only some of them are tested for now.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/Makefile |   1 +
>>  s390x/pfmf.c   |  10 ++++
>>  s390x/skey.c   |   5 ++
>>  s390x/skrf.c   | 128 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
>>  4 files changed, 144 insertions(+)
>>  create mode 100644 s390x/skrf.c
> [...]
>> +static void test_mvcos(void)
>> +{
>> +	uint64_t r3 =3D 64;
>> +	uint8_t *src =3D pagebuf;
>> +	uint8_t *dst =3D pagebuf + PAGE_SIZE;
>> +	/* K bit set, as well as keys */
>> +	register unsigned long oac asm("0") =3D 0xf002f002;
>> +
>> +	report_prefix_push("mvcos");
>> +	expect_pgm_int();
>> +	asm volatile("mvcos	%[dst],%[src],%[len]"
>> +		     : [dst] "+Q" (*(dst))
>> +		     : [src] "Q" (*(src)), [len] "d" (r3), "d" (oac)
>=20
> Just a nit: I think you could write "*dst" instead of "*(dst)" and
> "*src" instead of "*(src)".
>=20
>> +		     : "cc", "memory");
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>> +	report_prefix_pop();
>> +}
>> +
>> +static void test_spka(void)
>> +{
>> +	report_prefix_push("spka");
>> +	expect_pgm_int();
>> +	asm volatile("spka	0xf0(0)\n");
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>> +	report_prefix_pop();
>> +}
>> +
>> +static void test_tprot(void)
>> +{
>> +	report_prefix_push("tprot");
>> +	expect_pgm_int();
>> +	asm volatile("tprot	%[addr],0xf0(0)\n"
>> +		     : : [addr] "a" (pagebuf) : );
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>> +	report_prefix_pop();
>> +}
>> +
>> +int main(void)
>> +{
>> +	report_prefix_push("skrf");
>> +	if (!test_facility(169)) {
>> +		report_skip("storage key removal facility not available\n");
>> +		goto done;
>> +	}
>> +
>> +	test_facilities();
>> +	test_skey();
>> +	test_pfmf();
>> +	test_psw_key();
>> +	test_mvcos();
>> +	test_spka();
>> +	test_tprot();
>> +
>> +done:
>> +	report_prefix_pop();
>> +	return report_summary();
>> +}
>=20
> I can't say much about the technical details here (since I don't have
> the doc for that "removal facility"), but apart from that, the patch
> looks fine to me now.
>=20
> Acked-by: Thomas Huth <thuth@redhat.com>
>=20
> (and I'll wait one or two more days for additional reviews before
> queuing the patches)
>=20
Great, thank you!


--8kLzLtWtd2bGNrw40NJHlL4rYpDV5xxnX--

--0OeHyVKPrG7I45JLwqYqU9mJj98aEfbsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1mij4ACgkQ41TmuOI4
ufiF+A/8CTRfNQHGz4yxL7kg2grYAK4c/grtUomEOtc1grxk6jOroOsHw/fM/T6X
DlZ9xL3+mowx0pb3rQOmVRXdRQ39hnw5FwpqG/nQGIokSrJVLPVI36KP0tYOCPsQ
wU4btPArWrQ/chqIxzgNerZEII+uC2JcobMG/tU41JDlDxpGQXiYkLjum78uaJfc
jQ/fFJE2Hl5ojeGUK056S/X6o1kBAwTrOxY4xPyEk5QYyJ4W7VbCimUmLrQtrLFM
0a6i9Zk5QvYWqc3cgltBEqcMGo7cWZxdiunhRzqnY5hnYHoHfLHkiPUlMHDOt7EG
5zduX87Ky/QRew4ewcSfVqCKog/8tu4UnCjQ3Va0yBq3xLbRofMK/UIpbHYkuRh+
SJM3OATx3dVYtbbyIrnMxsGtQ9fdvaP0croaoVnxFX/7SB3bfK+/ucFbrTq9I0Nz
iDEqZlIbMtACgZ6TJi1WLQJXo0UIDOqKAw2PEOplxV+1ewlk4aQSQ6fOw9+9+t6+
uDtLMn5INHZHt3/Y8Enn/0Me+GcN3M5vLWlX4n3dtKlCW6fUvGo/a8Xk+pS76c1L
tSTLcboRKiIkGYm+K6X+lBriLzByNkIuPeTO9n7hqcpPphDmaA3pFQ58deC39Rgt
C3NrYY4VitEEOkykCfc0WdoLLMQ6mbgTnIbauefM4mzf1LgDMDI=
=asiH
-----END PGP SIGNATURE-----

--0OeHyVKPrG7I45JLwqYqU9mJj98aEfbsk--
