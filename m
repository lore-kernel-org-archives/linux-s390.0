Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729862AbgC3NDd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 09:03:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UD3QrQ080750
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 09:03:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022nm9q4g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 09:03:30 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 30 Mar 2020 14:03:09 +0100
Subject: Re: [kvm-unit-tests PATCH] s390x: Add stsi 3.2.2 tests
References: <20200330122035.19607-1-frankja@linux.ibm.com>
 <df745d0c-5d24-ee03-8600-ec495f1a5af6@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 30 Mar 2020 15:03:13 +0200
MIME-Version: 1.0
In-Reply-To: <df745d0c-5d24-ee03-8600-ec495f1a5af6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pu0xtyhmss64rHR4JzOqUai8TJ8gNYzdC"
Message-Id: <d42ac187-9f8f-81eb-c9b4-4d585fdef236@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pu0xtyhmss64rHR4JzOqUai8TJ8gNYzdC
Content-Type: multipart/mixed; boundary="w4f2RwHtuaJaFFzH4tMmqwy9sQPEkeWpN"

--w4f2RwHtuaJaFFzH4tMmqwy9sQPEkeWpN
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/30/20 2:50 PM, David Hildenbrand wrote:
> On 30.03.20 14:20, Janosch Frank wrote:
>> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
>> a bit more thorough.
>>
>> In this test we set a custom name and uuid through the QEMU command
>> line. Both parameters will be passed to the guest on a stsi subcode
>> 3.2.2 call and will then be checked.
>>
>> We also compare the total and configured cpu numbers against the smp
>> reported numbers.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/stsi.c        | 62 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |  1 +
>>  2 files changed, 63 insertions(+)
>>
>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>> index e9206bca137d2edb..10e588a78cc05186 100644
>> --- a/s390x/stsi.c
>> +++ b/s390x/stsi.c
>> @@ -14,7 +14,28 @@
>>  #include <asm/page.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/interrupt.h>
>> +#include <smp.h>
>> =20
>> +struct stsi_322 {
>> +    uint8_t  reserved[31];
>> +    uint8_t  count;
>> +    struct {
>> +        uint8_t  reserved2[4];
>=20
> I dislike aligning the members using double-spaces ...

Time to fix target/s390x/cpu.h then :)

>=20
>> +        uint16_t total_cpus;
>> +        uint16_t conf_cpus;
>> +        uint16_t standby_cpus;
>> +        uint16_t reserved_cpus;
>> +        uint8_t  name[8];
>> +        uint32_t caf;
>> +        uint8_t  cpi[16];
>> +        uint8_t reserved5[3];
>=20
> ... e.g., here it's not aligned anymore. Just use single spaces.
>=20
>> +        uint8_t ext_name_encoding;
>> +        uint32_t reserved3;
>> +        uint8_t uuid[16];
>> +    } vm[8];
>> +    uint8_t reserved4[1504];
>> +    uint8_t ext_names[8][256];
>> +};
>>  static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZ=
E * 2)));
>> =20
>>  static void test_specs(void)
>> @@ -76,11 +97,52 @@ static void test_fc(void)
>>  	report(stsi_get_fc(pagebuf) >=3D 2, "query fc >=3D 2");
>>  }
>> =20
>> +static void test_3_2_2(void)
>> +{
>> +	int rc;
>> +	/* EBCDIC for "kvm-unit" */
>> +	uint8_t vm_name[] =3D { 0x92, 0xa5, 0x94, 0x60, 0xa4, 0x95, 0x89, 0x=
a3 };
>> +	uint8_t uuid[] =3D { 0x0f, 0xb8, 0x4a, 0x86, 0x72, 0x7c,
>> +			   0x11, 0xea, 0xbc, 0x55, 0x02, 0x42, 0xac, 0x13,
>> +			   0x00, 0x03 };
>> +	/* EBCDIC for "KVM/" */
>> +	uint8_t cpi_kvm[] =3D { 0xd2, 0xe5, 0xd4, 0x61 };
>=20
> All of these can be const.
>=20
>> +	const char *vm_name_ext =3D "kvm-unit-test";
>> +	struct stsi_322 *data =3D (void *)pagebuf;
>> +
>> +	/* Is the function code available at all? */
>> +	if (stsi_get_fc(pagebuf) < 3)
>=20
> Maybe report_skip() ?

Ack

>=20
>> +		return;
>> +
>> +	report_prefix_push("3.2.2");
>> +	rc =3D stsi(pagebuf, 3, 2, 2);
>> +	report(!rc, "call");
>> +
>> +	/* For now we concentrate on KVM/QEMU */
>> +	if (memcmp(&data->vm[0].cpi, cpi_kvm, sizeof(cpi_kvm)))
>=20
> Maybe report_skip() ?

Ack

>=20
>> +		goto out;
>> +
>> +	report(data->vm[0].total_cpus =3D=3D smp_query_num_cpus(), "cpu # to=
tal");
>> +	report(data->vm[0].conf_cpus =3D=3D smp_query_num_cpus(), "cpu # con=
figured");
>> +	report(data->vm[0].standby_cpus =3D=3D 0, "cpu # standby");
>> +	report(data->vm[0].reserved_cpus =3D=3D 0, "cpu # reserved");
>=20
> IIRC, using -smp 1,maxcpus=3DX, you could also test the reported reserv=
ed
> CPUs.

Will try that

>=20
>=20
> Also passes under TCG, nice :)
>=20



--w4f2RwHtuaJaFFzH4tMmqwy9sQPEkeWpN--

--pu0xtyhmss64rHR4JzOqUai8TJ8gNYzdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6B7hEACgkQ41TmuOI4
ufj2jA/9FyNzmXRAjy+yC4t/APP7CtEF+qXfcInh3iDeDKhwQueEkbpJ3dOS3CGz
9y6LjqHRRLl4CAsSpS25Xv0OtzuSMQTeDdvj5Zz4h8FDt0mb18zuhIQG9IS8Pmnj
sDofb6CWdTzGXHTbkrxLJNIxTw5U3xOeUy2yWFKo4nZF+HQD5D2lrxEOD4iPb6Jl
dA44o24Er62JCvZlF6W52NCtZvKhpdq+X3XqI6F6uGsb09GY6MCtNgwVjFWw9Cwx
UaY4MO5bLyMYOJr929jYO8LGnrnUwB8UuXixeAzrc2Ro3KddtgilUVCkZDUQYQEq
Ha+5c0TxRBQqKxmrOWNnpvKWxJHYmaLABZY0jC2VIgYWtw2UrSBuqMWT288d86H9
lrhAh8KRee8HfTbQS64LYc2cyyr4UsQey8nKDU4wiNGEXO6rmLh5gZ3g9Hxmkzio
xmGH8j0/Cj9JrGopWLjCEEffkxXgBTBT5kYonRaXot6QH6+D2cyiiEsmdkywG2AK
zSSFNYhTW/0LmeaVszdLYbKReVyWXK3BGyXHojwNM/57FqcsibgDVhg+fBurZ/hg
yNlgXRQwa//RlFCr5yEmSvYpL932zFhoeIF8OG0AH9FOE6UDUa/5tgbNBgwX6ANR
vMRowjDspq+C6U6rZ9vp0vnkBdP5U28YAA0JO9w9bRU7Syaaxdo=
=nKva
-----END PGP SIGNATURE-----

--pu0xtyhmss64rHR4JzOqUai8TJ8gNYzdC--
