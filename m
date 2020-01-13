Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43681 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726163AbgAMLAJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Jan 2020 06:00:09 -0500
Subject: Re: [kvm-unit-tests PATCH v7 4/4] s390x: SCLP unit test
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
 <20200110184050.191506-5-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
Date: Mon, 13 Jan 2020 12:00:00 +0100
MIME-Version: 1.0
In-Reply-To: <20200110184050.191506-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

> +/**
> + * Test some bits in the instruction format that are specified to be i=
gnored.
> + */
> +static void test_instbits(void)
> +{
> +	SCCBHeader *h =3D (SCCBHeader *)pagebuf;
> +	int cc;
> +
> +	expect_pgm_int();
> +	sclp_mark_busy();
> +	h->length =3D 8;
> +	sclp_setup_int();
> +
> +	asm volatile(
> +		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc %1,%2 */
> +		"       ipm     %0\n"
> +		"       srl     %0,28"
> +		: "=3D&d" (cc) : "d" (valid_code), "a" (__pa(pagebuf))
> +		: "cc", "memory");
> +	if (lc->pgm_int_code) {
> +		sclp_handle_ext();
> +		cc =3D 1;
> +	} else if (!cc)
> +	=09

I wonder if something like the following would be possible:

expect_pgm_int();
...
asm volatiole();
...
sclp_wait_busy();
check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);

We would have to clear "sclp_busy" when we get a progam interrupt on a
servc instruction - shouldn't be too hard to add to the program
exception handler.

> +	report(cc =3D=3D 0, "Instruction format ignored bits");
> +}
> +
> +/**
> + * Find a valid READ INFO command code; not all codes are always allow=
ed, and
> + * probing should be performed in the right order.
> + */
> +static void find_valid_sclp_code(void)
> +{
> +	const unsigned int commands[] =3D { SCLP_CMDW_READ_SCP_INFO_FORCED,
> +					  SCLP_CMDW_READ_SCP_INFO };
> +	SCCBHeader *h =3D (SCCBHeader *)pagebuf;
> +	int i, cc;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
> +		sclp_mark_busy();
> +		memset(h, 0, sizeof(*h));
> +		h->length =3D 4096;
> +
> +		valid_code =3D commands[i];
> +		cc =3D sclp_service_call(commands[i], h);
> +		if (cc)
> +			break;
> +		if (h->response_code =3D=3D SCLP_RC_NORMAL_READ_COMPLETION)
> +			return;
> +		if (h->response_code !=3D SCLP_RC_INVALID_SCLP_COMMAND)
> +			break;
> +	}
> +	valid_code =3D 0;

This can be dropped because ...

> +	report_abort("READ_SCP_INFO failed");

... you abort here.


--=20
Thanks,

David / dhildenb
