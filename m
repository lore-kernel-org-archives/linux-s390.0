Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30213 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726716AbgAIMmq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 07:42:46 -0500
Subject: Re: [kvm-unit-tests PATCH v5 4/4] s390x: SCLP unit test
References: <20200108161317.268928-1-imbrenda@linux.ibm.com>
 <20200108161317.268928-5-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2ca46041-2135-3847-4f22-e1cdebe01936@redhat.com>
Date: Thu, 9 Jan 2020 13:42:34 +0100
MIME-Version: 1.0
In-Reply-To: <20200108161317.268928-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 08/01/2020 17.13, Claudio Imbrenda wrote:
> SCLP unit test. Testing the following:
>=20
> * Correctly ignoring instruction bits that should be ignored
> * Privileged instruction check
> * Check for addressing exceptions
> * Specification exceptions:
>   - SCCB size less than 8
>   - SCCB unaligned
>   - SCCB overlaps prefix or lowcore
>   - SCCB address higher than 2GB
> * Return codes for
>   - Invalid command
>   - SCCB too short (but at least 8)
>   - SCCB page boundary violation
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  s390x/Makefile      |   1 +
>  s390x/sclp.c        | 462 ++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |   8 +
>  3 files changed, 471 insertions(+)
>  create mode 100644 s390x/sclp.c
[...]
> +/**
> + * Test SCCBs whose address is in the lowcore or prefix area.
> + */
> +static void test_sccb_prefix(void)
> +{
> +	uint8_t scratch[2 * PAGE_SIZE];
> +	uint32_t prefix, new_prefix;
> +	int offset;
> +
> +	/*
> +	 * copy the current lowcore to the future new location, otherwise we
> +	 * will not have a valid lowcore after setting the new prefix.
> +	 */
> +	memcpy(prefix_buf, 0, 2 * PAGE_SIZE);
> +	/* save the current prefix (it's probably going to be 0) */
> +	prefix =3D stpx();
> +	/*
> +	 * save the current content of absolute pages 0 and 1, so we can
> +	 * restore them after we trash them later on
> +	 */
> +	memcpy(scratch, (void *)(intptr_t)prefix, 2 * PAGE_SIZE);
> +	/* set the new prefix to prefix_buf */
> +	new_prefix =3D (uint32_t)(intptr_t)prefix_buf;
> +	spx(new_prefix);
> +
> +	/*
> +	 * testing with SCCB addresses in the lowcore; since we can't
> +	 * actually trash the lowcore (unsurprisingly, things break if we
> +	 * do), this will be a read-only test.
> +	 */
> +	for (offset =3D 0; offset < 2 * PAGE_SIZE; offset +=3D 8)
> +		if (!test_one_sccb(valid_code, MKPTR(offset), 0, PGM_BIT_SPEC, 0))
> +			break;
> +	report(offset =3D=3D 2 * PAGE_SIZE, "SCCB low pages");
> +
> +	/*
> +	 * this will trash the contents of the two pages at absolute
> +	 * address 0; we will need to restore them later.
> +	 */

I'm still a bit confused by this comment - will SCLP really trash the
contents here, or will there be a specification exception (since
PGM_BIT_SPEC is given below)? ... maybe you could clarify the comment in
case you respin again (or it could be fixed when picking up the patch)?

> +	for (offset =3D 0; offset < 2 * PAGE_SIZE; offset +=3D 8)
> +		if (!test_one_simple(valid_code, MKPTR(new_prefix + offset), 8, 8, P=
GM_BIT_SPEC, 0))
> +			break;
> +	report(offset =3D=3D 2 * PAGE_SIZE, "SCCB prefix pages");
> +
> +	/* restore the previous contents of absolute pages 0 and 1 */
> +	memcpy(prefix_buf, 0, 2 * PAGE_SIZE);
> +	/* restore the prefix to the original value */
> +	spx(prefix);
> +}

Remaining parts look ok to me now, so with the comment clarified:

Reviewed-by: Thomas Huth <thuth@redhat.com>
