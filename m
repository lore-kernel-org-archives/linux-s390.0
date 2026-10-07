Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E849738A
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371698; cv=none; b=kY2abiDC+4Mn+6WYYe7GvSwBqQRiODUM/NScjQmh3EZ7UoVh8Ci4Td3GQySb/nTmdxmMDBTKYJmPIU4Va5UyQXXSzmmQxflcL+RAtYLtPwqCmUp05hCT3WMlbHzppdUX/bRWcenBj3IKoj7tvO0H8RfI9wsPt7QVB+gOnkGWqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371698; c=relaxed/simple;
	bh=ngFHSjiK6vhUazFp7NEt1tzvv0jC+C6pHuzH8SSJSZA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Lb1iyhgAT92k4TZFaO1th6aoNl2Izzk4Egu6Imb+VeKeZn42k4CD330JUKzf1mtddRy6HTlUBF3JtcBp0XI51vkbq70hMGoYrpGqCHdk61DEDi8quYJJApmJcBxo3jnuySDY2ByJ8OI02Cs9ElmDqyP7Nd1siABZZcD9ZaI6imI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFeHVYA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFeHVYA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C5F1F0089B;
	Wed,  7 Oct 2026 11:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791371683;
	bh=xB6G7PKntM5eFFI5SWIT+T4AZZjgi6DyuXgpbXXzh9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BFeHVYA4oMGG4ddAdniAFj0KSlJDcYGo0azPGZh2RBilQ+omSsTl5oCnpBTO0FlHY
	 TWgmRhpe0B1V9kv9d7Lq+gZ6vMliLgC95mfRfTGlTEghV+li9aEsiJIvgf1P5pjM2Y
	 pKWTzLKbaPiV9daYlfEeBiCm6UYN9C93KaccHlHvf+xLcU1Y46Q4Tn5BZZi6GLR578
	 lauDo3gVffEAdK/h8wqW7M9NRMpxp3PPtdVVEKgEBKhGaGj7B3sa8lDzjD32TtNaou
	 JkAPRFdrClrvfIoh0cDXo+mwRjV6RTHRoyD7xgtDJFl50rfTzpu3XfGzn92rvmliJN
	 PtDcpEGcYvfzA==
Message-ID: <sashiko-outbox-162918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/pci: Adjust alignment in insn trace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261007-rpcit_trcfh_upstream-v1-1-8a2718cfb90b@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
 <20261007-rpcit_trcfh_upstream-v1-1-8a2718cfb90b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:14:42 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/pci: info leak of kernel stack memory in trace buffer due t=
o unnamed bit-fields
--

commit 9eddce7825c1b38a4a78855744726217e301528b
Author: Gerd Bayer <gbayer@linux.ibm.com>

s390/pci: Adjust alignment in insn trace

This patch adjusts the alignment of fields in the pci_error instruction
trace. It drops the packed attribute on struct zpci_err_insn_data and
adds unnamed bit-fields to explicitly pad the structure to 32 bytes for
easier human readability in hex dumps.

> diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
> index 35ceb1bea1c61..2ba787e2304b5 100644
> --- a/arch/s390/pci/pci_insn.c
> +++ b/arch/s390/pci/pci_insn.c
> @@ -18,11 +18,14 @@
>  #include <asm/asm.h>
> =20
>  #define ZPCI_INSN_BUSY_DELAY	1	/* 1 microsecond */
> +#define ZPCI_ERR_INSN_DATA_SIZE 32
> =20
>  struct zpci_err_insn_data {
>  	u8 insn;
>  	u8 cc;
>  	u8 status;
> +	u8: 8;
> +	u32: 32;
>  	union {
>  		struct {
>  			u64 req;
> @@ -33,7 +36,10 @@ struct zpci_err_insn_data {
>  			u64 len;
>  		};
>  	};
> -} __packed;
> +	u64: 64;
> +};
> +

[Severity: Medium]
Does this change unintentionally leak kernel stack memory into the s390dbf
debug trace ring buffer?

By using unnamed bit-fields for padding, these fields are explicitly
excluded from zero-initialization when using a designated initializer.

When zpci_err_insn_req() in arch/s390/pci/pci_insn.c initializes this
structure on the stack without an explicit memset(), the unnamed padding
bytes retain their uninitialized stack memory:

static inline void zpci_err_insn_req(...)
{
        struct zpci_err_insn_data data =3D {
                .insn =3D insn, .cc =3D cc, .status =3D status,
                .req =3D req, .offset =3D offset};

        zpci_err_hex_level(lvl, &data, sizeof(data));
}

The subsequent call to zpci_err_hex_level() will copy the entire 32-byte
structure to the trace buffer, exposing 13 bytes of uninitialized stack
data.

Will this also defeat the goal of having clean traces for humans, since
the hex dumps will contain random stack data instead of zeroes?

> +static_assert(sizeof(struct zpci_err_insn_data) <=3D ZPCI_ERR_INSN_DATA_=
SIZE);
> =20
>  static inline void zpci_err_insn_req(int lvl, u8 insn, u8 cc, u8 status,
>  				     u64 req, u64 offset)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-rpcit_trcf=
h_upstream-v1-0-8a2718cfb90b@linux.ibm.com?part=3D1
