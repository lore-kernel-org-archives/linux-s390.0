Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33280 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729641AbgAVJzg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Jan 2020 04:55:36 -0500
Subject: Re: [kvm-unit-tests PATCH v8 6/6] s390x: SCLP unit test
References: <20200120184256.188698-1-imbrenda@linux.ibm.com>
 <20200120184256.188698-7-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <58aa7974-2b03-494a-63c3-f8db1faff749@redhat.com>
Date: Wed, 22 Jan 2020 10:55:29 +0100
MIME-Version: 1.0
In-Reply-To: <20200120184256.188698-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

[...]

>  all: directories test_cases test_cases_binary
> diff --git a/s390x/sclp.c b/s390x/sclp.c
> new file mode 100644
> index 0000000..215347e
> --- /dev/null
> +++ b/s390x/sclp.c
> @@ -0,0 +1,474 @@
> +/*
> + * Service Call tests
> + *
> + * Copyright (c) 2019 IBM Corp

Should be 2020 now. Will fix that up.

[...]

> +/**
> + * Perform one test at the given address, optionally using the SCCB te=
mplate,
> + * checking for the expected program interrupts and return codes.
> + *
> + * The parameter buf_len indicates the number of bytes of the template=
 that
> + * should be copied to the test address, and should be 0 when the test
> + * address is invalid, in which case nothing is copied.
> + *
> + * The template is used to simplify tests where the same buffer conten=
t is
> + * used many times in a row, at different addresses.
> + *
> + * Returns true in case of success or false in case of failure
> + */
> +static bool test_one_sccb(uint32_t cmd, uint8_t *addr, uint16_t buf_le=
n, uint64_t exp_pgm, uint16_t exp_rc)
> +{
> +	SCCBHeader *h =3D (SCCBHeader *)addr;
> +	int res, pgm;
> +
> +	/* Copy the template to the test address if needed */
> +	if (buf_len)
> +		memcpy(addr, sccb_template, buf_len);
> +	if (exp_pgm !=3D PGM_NONE)
> +		expect_pgm_int();

I still dislike the handling here. Any caller can simply do a

expect_pgm_int();
test_one_sccb(...)
check_pgm_int_code(PGM_);

Same thing goes for exp_rc. We really should drop exp_rc and exp_pgm
handling from the function completely and handle it in the caller. That
makes the tests actually readable.

But I feel like I am repeating myself. I'll queue this patch with the
2020 fixed up and might send a fixup myself (if I find some spare minutes=
).

--=20
Thanks,

David / dhildenb
