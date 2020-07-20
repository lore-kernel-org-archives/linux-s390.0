Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728058AbgGTLmo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jul 2020 07:42:44 -0400
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Ultavisor guest API test
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-4-frankja@linux.ibm.com>
 <20200720124938.556220fe@ibm-vm>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <36472fe5-9c74-12c0-8a67-1aea09995aba@linux.ibm.com>
Date: Mon, 20 Jul 2020 13:42:35 +0200
MIME-Version: 1.0
In-Reply-To: <20200720124938.556220fe@ibm-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Czr7U9lTXJz9JceWpQwYktjrdbGJ48k4f"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Czr7U9lTXJz9JceWpQwYktjrdbGJ48k4f
Content-Type: multipart/mixed; boundary="z9AO3NxIdeO7k4GIr24FDkgCCwN6PMKC7"

--z9AO3NxIdeO7k4GIr24FDkgCCwN6PMKC7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/20/20 12:49 PM, Claudio Imbrenda wrote:
> On Fri, 17 Jul 2020 10:58:13 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Test the error conditions of guest 2 Ultravisor calls, namely:
>>      * Query Ultravisor information
>>      * Set shared access
>>      * Remove shared access
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/asm/uv.h  |  68 +++++++++++++++++++
>>  s390x/Makefile      |   1 +
>>  s390x/unittests.cfg |   3 +
>>  s390x/uv-guest.c    | 156
>> ++++++++++++++++++++++++++++++++++++++++++++ 4 files changed, 228
>> insertions(+) create mode 100644 lib/s390x/asm/uv.h
>>  create mode 100644 s390x/uv-guest.c
>>
>> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
>> new file mode 100644
>> index 0000000..14ab5cc
>> --- /dev/null
>> +++ b/lib/s390x/asm/uv.h
>> @@ -0,0 +1,68 @@
>> +/*
>> + * s390x Ultravisor related definitions
>> + *
>> + * Copyright (c) 2020 IBM Corp
>> + *
>> + * Authors:
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify
>> it
>> + * under the terms of the GNU General Public License version 2.
>> + */
>> +#ifndef UV_H
>> +#define UV_H
>> +
>> +#define UVC_RC_EXECUTED		0x0001
>> +#define UVC_RC_INV_CMD		0x0002
>> +#define UVC_RC_INV_STATE	0x0003
>> +#define UVC_RC_INV_LEN		0x0005
>> +#define UVC_RC_NO_RESUME	0x0007
>> +
>> +#define UVC_CMD_QUI			0x0001
>> +#define UVC_CMD_SET_SHARED_ACCESS	0x1000
>> +#define UVC_CMD_REMOVE_SHARED_ACCESS	0x1001
>> +
>> +/* Bits in installed uv calls */
>> +enum uv_cmds_inst {
>> +	BIT_UVC_CMD_QUI =3D 0,
>> +	BIT_UVC_CMD_SET_SHARED_ACCESS =3D 8,
>> +	BIT_UVC_CMD_REMOVE_SHARED_ACCESS =3D 9,
>> +};
>> +
>> +struct uv_cb_header {
>> +	u16 len;
>> +	u16 cmd;	/* Command Code */
>> +	u16 rc;		/* Response Code */
>> +	u16 rrc;	/* Return Reason Code */
>> +} __attribute__((packed))  __attribute__((aligned(8)));
>> +
>> +struct uv_cb_qui {
>> +	struct uv_cb_header header;
>> +	u64 reserved08;
>> +	u64 inst_calls_list[4];
>> +	u64 reserved30[15];
>> +} __attribute__((packed))  __attribute__((aligned(8)));
>> +
>> +struct uv_cb_share {
>> +	struct uv_cb_header header;
>> +	u64 reserved08[3];
>> +	u64 paddr;
>> +	u64 reserved28;
>> +} __attribute__((packed))  __attribute__((aligned(8)));
>> +
>> +static inline int uv_call(unsigned long r1, unsigned long r2)
>> +{
>> +	int cc;
>> +
>> +	asm volatile(
>> +		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
>> +		"		brc	3,0b\n"
>> +		"		ipm	%[cc]\n"
>> +		"		srl	%[cc],28\n"
>> +		: [cc] "=3Dd" (cc)
>> +		: [r1] "a" (r1), [r2] "a" (r2)
>> +		: "memory", "cc");
>> +	return cc;
>> +}
>> +
>> +#endif
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index 0f54bf4..c2213ad 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -18,6 +18,7 @@ tests +=3D $(TEST_DIR)/skrf.elf
>>  tests +=3D $(TEST_DIR)/smp.elf
>>  tests +=3D $(TEST_DIR)/sclp.elf
>>  tests +=3D $(TEST_DIR)/css.elf
>> +tests +=3D $(TEST_DIR)/uv-guest.elf
>>  tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
>> =20
>>  all: directories test_cases test_cases_binary
>> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
>> index b35269b..38c3257 100644
>> --- a/s390x/unittests.cfg
>> +++ b/s390x/unittests.cfg
>> @@ -92,3 +92,6 @@ extra_params =3D -device virtio-net-ccw
>>  [skrf]
>>  file =3D skrf.elf
>>  smp =3D 2
>> +
>> +[uv-guest]
>> +file =3D uv-guest.elf
>> \ No newline at end of file
>> diff --git a/s390x/uv-guest.c b/s390x/uv-guest.c
>> new file mode 100644
>> index 0000000..0cb5fae
>> --- /dev/null
>> +++ b/s390x/uv-guest.c
>> @@ -0,0 +1,156 @@
>> +/*
>> + * Guest Ultravisor Call tests
>> + *
>> + * Copyright (c) 2020 IBM Corp
>> + *
>> + * Authors:
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify
>> it
>> + * under the terms of the GNU General Public License version 2.
>> + */
>> +
>> +#include <libcflat.h>
>> +#include <alloc_page.h>
>> +#include <asm/page.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/interrupt.h>
>> +#include <asm/facility.h>
>> +#include <asm/uv.h>
>> +
>> +static inline int share(unsigned long addr, u16 cmd)
>> +{
>> +	struct uv_cb_share uvcb =3D {
>> +		.header.cmd =3D cmd,
>> +		.header.len =3D sizeof(uvcb),
>> +		.paddr =3D addr
>> +	};
>> +
>> +	uv_call(0, (u64)&uvcb);
>> +	return uvcb.header.rc;
>> +}
>> +
>> +static inline int uv_set_shared(unsigned long addr)
>> +{
>> +	return share(addr, UVC_CMD_SET_SHARED_ACCESS);
>> +}
>> +
>> +static inline int uv_remove_shared(unsigned long addr)
>> +{
>> +	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
>> +}
>> +
>> +static void test_priv(void)
>> +{
>> +	struct uv_cb_header uvcb =3D {};
>> +
>> +	report_prefix_push("privileged");
>> +
>> +	report_prefix_push("query");
>> +	expect_pgm_int();
>> +	uvcb.cmd =3D UVC_CMD_QUI;
>> +	uvcb.len =3D sizeof(struct uv_cb_qui);
>> +	enter_pstate();
>> +	uv_call(0, (u64)&uvcb);
>> +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>> +	report_prefix_pop();
>> +
>> +	report_prefix_push("share");
>> +	expect_pgm_int();
>> +	enter_pstate();
>> +	uv_set_shared(0x42000);
>> +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>> +	report_prefix_pop();
>> +
>> +	report_prefix_push("unshare");
>> +	expect_pgm_int();
>> +	enter_pstate();
>> +	uv_remove_shared(0x42000);
>=20
> I don't like using a hardwired address here (and above). Things can get=

> messy if the address ends up outside memory or overlapping code.
>=20
> I think the best approach would be to declare a page aligned buffer and=

> use that (or even allocate a page)=20

Sure, will do

>=20
>> +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>> +	report_prefix_pop();
>> +
>> +	report_prefix_pop();
>> +}
>> +
>> +static void test_query(void)
>> +{
>> +	struct uv_cb_qui uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_QUI,
>> +		.header.len =3D sizeof(uvcb) - 8,
>> +	};
>> +
>> +	report_prefix_push("query");
>> +	uv_call(0, (u64)&uvcb);
>> +	report(uvcb.header.rc =3D=3D UVC_RC_INV_LEN, "length");
>> +
>> +	uvcb.header.len =3D sizeof(uvcb);
>> +	uv_call(0, (u64)&uvcb);
>> +	report(uvcb.header.rc =3D=3D UVC_RC_EXECUTED, "successful
>> query"); +
>> +	/*
>> +	 * These bits have been introduced with the very first
>> +	 * Ultravisor version and are expected to always be available
>> +	 * because they are basic building blocks.
>> +	 */
>> +	report(uvcb.inst_calls_list[0] & (1UL << (63 -
>> BIT_UVC_CMD_QUI)),
>> +	       "query indicated");
>> +	report(uvcb.inst_calls_list[0] & (1UL << (63 -
>> BIT_UVC_CMD_SET_SHARED_ACCESS)),
>> +	       "share indicated");
>> +	report(uvcb.inst_calls_list[0] & (1UL << (63 -
>> BIT_UVC_CMD_REMOVE_SHARED_ACCESS)),
>> +	       "unshare indicated");
>> +	report_prefix_pop();
>> +}
>> +
>> +static void test_sharing(void)
>> +{
>> +	unsigned long mem =3D (unsigned long)alloc_page();
>> +	struct uv_cb_share uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_SET_SHARED_ACCESS,
>> +		.header.len =3D sizeof(uvcb) - 8,
>> +	};
>> +
>> +	report_prefix_push("share");
>> +	uv_call(0, (u64)&uvcb);
>> +	report(uvcb.header.rc =3D=3D UVC_RC_INV_LEN, "length");
>> +	report(uv_set_shared(mem) =3D=3D UVC_RC_EXECUTED, "share");
>> +	report_prefix_pop();
>> +
>> +	report_prefix_push("unshare");
>> +	uvcb.header.cmd =3D UVC_CMD_REMOVE_SHARED_ACCESS;
>> +	uv_call(0, (u64)&uvcb);
>> +	report(uvcb.header.rc =3D=3D UVC_RC_INV_LEN, "length");
>> +	report(uv_remove_shared(mem) =3D=3D UVC_RC_EXECUTED, "unshare");
>> +	free_page((void *)mem);
>> +	report_prefix_pop();
>> +
>> +	report_prefix_pop();
>> +}
>> +
>> +static void test_invalid(void)
>> +{
>> +	struct uv_cb_header uvcb =3D {
>> +		.len =3D 16,
>> +		.cmd =3D 0x4242,
>> +	};
>> +
>> +	uv_call(0, (u64)&uvcb);
>> +	report(uvcb.rc =3D=3D UVC_RC_INV_CMD, "invalid command");
>> +}
>> +
>> +int main(void)
>> +{
>> +	bool has_uvc =3D test_facility(158);
>> +
>> +	report_prefix_push("uvc");
>> +	if (!has_uvc) {
>> +		report_skip("Ultravisor call facility is not
>> available");
>> +		goto done;
>> +	}
>> +
>> +	test_priv();
>> +	test_invalid();
>> +	test_query();
>> +	test_sharing();
>> +done:
>> +	return report_summary();
>> +}
>=20
> once the above comment is addressed:
> Claudio Imbrenda <imbrenda@linux.ibm.com>
>=20
?


--z9AO3NxIdeO7k4GIr24FDkgCCwN6PMKC7--

--Czr7U9lTXJz9JceWpQwYktjrdbGJ48k4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8VgysACgkQ41TmuOI4
ufi0DBAAr9BlpqaNkx1PTsi1jM11Yej8x6BNVHU0lhEi27ePG9rz2F7J06cUcmvM
MbXB+8hD/j6nUUJGkUY+LUgqd/A6S1lWjqQNMKu5QsgNslUKQF30t7Tdb8mZiQDh
xRoNRk7m564dzuw/dOVWduhuefDZWaNW5x6b9a5Y4GHlAOUq27B5XGLC+p++hDbl
39F/IMWIP2GaE9ey8JeuBI2nmi2+LZz6upwWBQ9xMNN2HThGW/GtrV9Aey647YRb
gwvD0cl0tOytNv8rn36Ba8AGQHmzdGn21dp69QhiyCU+NTs5RuYfqxoB+U2pVjPn
1kAkJjo6IRTQsxPHAR3utDTb5UI0+1aoZtQvMGPitkhCIivY5zagxnAuWchdb5rp
M4UrcY7PoRizRZvQ9lS20VAWD0z9u52u3FxOM8SFVKqX+u9dd6Tt10heBgJVn8aJ
sZ+IN8LXhrww26Xi4eUfQF2jxXU/9qwSHeMrpnV8VDIPs3H2dnVgYVX7AI6An+KO
KxUe99HARx+Zjh3R002VRERDZP26WY7A2qjIV5yXYyMjkKLCliBP7BiGkR1Z+PGO
tzyGbvgdEGjUsZq7ly+jFVndYH1jILmrrZ7ofRu/sFwZJZu3Tp3e3BJvF6aWSIuN
UakLYRS0R/zZ3MHRoqNpiRLpffc53wKOspKtnHrzFQY8EbQJ15s=
=kDVc
-----END PGP SIGNATURE-----

--Czr7U9lTXJz9JceWpQwYktjrdbGJ48k4f--
