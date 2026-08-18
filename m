Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC8227EA7;
	Tue, 18 Aug 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065341; cv=none; b=Pz4KcCgm6n0S2aVbny9XaLQLZa1HAASYd3TNyEKu3CcU77GLC4CNJ6RiXCKxZOXI7v9kQQor/AOWrA0z0+mEIh/2NokVfZ+Tvh5W5VszInhhfawPa3DMxw2+pOgoECHv4lGkT0O8UpslGC8kQ52xGcjNDpLMek2Gtv4+csrARys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065341; c=relaxed/simple;
	bh=sgBATjSZU41+mnYocfpPcm8zyuE4sQO+C9SQPv10K/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ElORRDLTSzOsreGrXD9oaGMaUf1gqlvDI4P9faBzdg0zd4VEqiIvKvgMUKO4f+bSinKkq6yJl0dChpCe+MDJS5MQBDHfNRv3IQazoacLj9eZ9zND2Tj9eDhls4CCe5gKZ/mnKcCahu5nSWPbmRNIllY1DN3xVPrvrc5kqDpRoaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OocFN1kh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OocFN1kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373FB1F000E9;
	Tue, 18 Aug 2026 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065340;
	bh=WtI80FUe29f58baGm6MDmQ6msmi7QxYmNDK/H88HJF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OocFN1khkXzQadcEET3NHxtb/zDSSoml+mBf91+X2CEIEeIJjJdBP5wV6VfRCXDdl
	 us3T1B9TWZMpdMTcLBya6dT+faNCGt9vhM7VRcvanUfkNGDv7WYi6o4pcU5cvqWSMN
	 GVMLr3nY4YuTU7aZMiNBU1drJnjeTjvGawLWz907kcF5fNrMB8hcKa9YpGliSIEN9C
	 hTX1SO3s+hfXu2ARe4kQjQsBuNiuYchhLZv64NZ3Bi0Fm/GFqfqh0Xx+QKmJPNntU0
	 d2IAXcGxBKdQxuhXbhVy1/EETygLV4hKk8SnXbFSEkYc9M2jjqvm+nBrZ9rsg55fpp
	 uqlgI8YX+CTmA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 07/25] unwind_user/eh_frame: Add support for
 reading .eh_frame_hdr section
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260818144954.2320378-8-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-8-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:02:19 +0000
Message-Id: <20260818150220.373FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Integer overflow in binary search table size calculation allows =
bypassing `.eh_frame_hdr` bounds check.
- [Medium] The `read_encoded_pointer` function incorrectly overwrites the c=
omputed base address when handling the `DW_EH_PE_absptr` format combined wi=
th relative application flags.
--

--- Patch [7]: [RFC PATCH v1 07/25] unwind_user/eh_frame: Add support for r=
eading .eh_frame_hdr section ---
commit 0ca4af16fa2ddbd53ffc639d7ba44b189726700c
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add support for reading .eh_frame_hdr section

This commit adds basic infrastructure for reading the .eh_frame_hdr
section from userspace in preparation for .eh_frame based stack unwinding.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> new file mode 100644
> index 0000000000000..8d2b638145bd4
> --- /dev/null
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
> +static __always_inline int read_encoded_pointer(struct eh_frame_section =
*sec,
> +						unsigned long *addr,
> +						unsigned long end,
> +						u8 encoding,
> +						unsigned long *value)
> +{
> +	unsigned long cur =3D *addr;
> +	u8 format =3D DW_EH_PE_format(encoding);
> +	u8 application =3D DW_EH_PE_application(encoding);
> +	unsigned long result =3D 0;
> +	int ret;
> +
> +	if (encoding =3D=3D DW_EH_PE_omit)
> +		return -EINVAL;
> +
> +	/* Determine base address based on application */
> +	switch (application) {
> +	case 0:
> +		/* Absolute */
> +		break;
> +	case DW_EH_PE_pcrel:
> +		result =3D *addr;
> +		break;
> +	case DW_EH_PE_datarel:
> +		result =3D sec->eh_frame_hdr_start;
> +		break;
> +	case DW_EH_PE_textrel:
> +		result =3D sec->text_start;
> +		break;
> +	case DW_EH_PE_funcrel:
> +	case DW_EH_PE_aligned:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Read value based on format */
> +	switch (format) {
> +	case DW_EH_PE_absptr:
> +		UNSAFE_GET_USER_INC(result, cur, end, Efault);
> +		break;

[Severity: Medium]
Does this overwrite the base address that was just computed for relative
encodings?

When handling DW_EH_PE_absptr in combination with relative application flags
like DW_EH_PE_pcrel, the base address is stored in the result variable abov=
e.
However, UNSAFE_GET_USER_INC directly assigns the read value to result
instead of adding it, which will discard the base address.

Should this read into a temporary variable and add it to result, similar to
how the other formats are handled?

> +	case DW_EH_PE_uleb128: {
> +		unsigned long tmp;
> +		ret =3D read_uleb128(&cur, end, &tmp);
> +		if (ret)
> +			return ret;
> +		result +=3D tmp;
> +		break;
> +	}
[ ... ]
> +static int eh_frame_read_header(struct eh_frame_section *sec)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	void __user *eh_frame_hdr =3D (void __user *)sec->eh_frame_hdr_start;
> +	unsigned long cur =3D sec->eh_frame_hdr_start, end =3D sec->eh_frame_hd=
r_end;
> +	unsigned long eh_frame_start, eh_frame_vma_end, table_start, table_end;
> +	u8 version, eh_frame_ptr_enc, fde_count_enc, table_enc;
> +	unsigned long fde_count;
> +	int entry_size;
> +	int ret;
[ ... ]
> +		/* Read FDE count */
> +		ret =3D read_encoded_pointer(sec, &cur, end,
> +					   fde_count_enc, &fde_count);
> +		if (ret)
> +			return ret;
> +
> +		/* Determine binary search table start and end */
> +		table_start =3D cur;
> +		entry_size =3D 2 * encoded_pointer_size(table_enc);
> +		if (!entry_size)
> +			return -EINVAL;
> +		table_end =3D table_start + fde_count * entry_size;
> +		if (table_end > sec->eh_frame_hdr_end)
> +			return -EINVAL;

[Severity: Medium]
Can a maliciously large fde_count cause an integer overflow here?

Since fde_count is parsed from the untrusted user eh_frame_hdr section,
the multiplication of fde_count * entry_size could wrap around to a small
positive value.

This would bypass the bounds check against sec->eh_frame_hdr_end and
potentially allow the kernel to trust an arbitrarily large fde_count,
leading to out-of-bounds kernel memory reads when performing binary searche=
s.

Would it be safer to use check_mul_overflow() and check_add_overflow() for
these bounds calculations?

> +	}
> +
> +end:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D7
