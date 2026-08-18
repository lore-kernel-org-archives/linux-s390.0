Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5839E184;
	Tue, 18 Aug 2026 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065566; cv=none; b=CmcQC4o3DSzBAtk3o/W9qVu8KUbSnXuujOnlINN/tVN/DO3ed8zF+ZTO9Yyen6J16XyIZLZ3cQ75A+A5i5djtSYUkR5mOIQBn9TVRVTlIW9+hG4u2iM64f1Dsp83eM5YXuwnKGWuQjwI2V3+8nrMVzpT9lE6GSdEdMHUyBRIjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065566; c=relaxed/simple;
	bh=mnTlio/8q3vYSd0HSa8Skp8HvdBo46imcjJHicYcvAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RodcT1TI7OUMgZdp//DMz+IBmh2MXKvCAGvnAceN/aDZAKQvRwG1PR88szD1LUoo55ikgTEb4Hf2HF8catkR4/zIZ0NRdV6ubz8xS3h1SbIPi/WV4+WZtb4o7apfGFiGtq/lSKlFKjwTlS0tnwCd372ZZJe8qN47pDoeInNtiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrwlo1pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrwlo1pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2E81F000E9;
	Tue, 18 Aug 2026 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065565;
	bh=r+Zi8HMdcOmbP+1uPSpwEsYlmUktgeyubQA4iprfa7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zrwlo1ppcQx3dk39Vf2Q6ouetppLYZgIrhDX2gZbamCd+ahOhMWBkIa5tGFLDHsb9
	 YXGy4/6iD+lLPH0OvNso9nXWnLUYcLphCJWPP07ocatgcegFcezS3139EJA5XaQKUw
	 fqBfabF4PkpfZqHCQSLrmNeWWqWW+JqH5eumsLHUGGaF7i4vP2iI6uOT4mZbCpoh/6
	 OElNNjMcXNUxfFOZxnwtkG1HPbaOoEOrPVPmKuYP2TLm+H9V/WkNhY7M7H6KAwudB9
	 pDN7HM9pDgP0p64NKaV6/Ez/KWnY0ztU5pb1iO2PKL+/iKqM4xlFkmHyh42P9UUxuQ
	 lZKH8rA9tO19A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 16/25] unwind_user/eh_frame: Add linear .eh_frame
 search fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-17-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-17-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:06:04 +0000
Message-Id: <20260818150605.0C2E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The fallback stub __find_fde_lsearch() returns 0 (success) ins=
tead of an error when CONFIG_EH_FRAME_LINEAR_SEARCH is disabled, causing th=
e unwinder to consume an uninitialized stack variable.
- [High] Enabling CONFIG_EH_FRAME_LINEAR_SEARCH unconditionally triggers li=
near validation and causes out-of-bounds reads, permanently breaking unwind=
ing for valid binaries lacking a zero terminator.
--

--- Patch [16]: [RFC PATCH v1 16/25] unwind_user/eh_frame: Add linear .eh_f=
rame search fallback ---
commit 4fc15aee544b13c1c7ff56efb01c804156c21a55
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add linear .eh_frame search fallback

This commit adds a linear search fallback for .eh_frame sections when
the .eh_frame_hdr lacks a binary search table. It also introduces validation
logic for the referenced .eh_frame section, guarded by a new config
option EH_FRAME_LINEAR_SEARCH.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index 7f572d1711d3f..ac288cec8021f 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
> @@ -590,6 +589,82 @@ static __always_inline int __find_fde(struct eh_fram=
e_section *sec,
>  	return -EFAULT;
>  }
> =20
> +#ifdef CONFIG_EH_FRAME_LINEAR_SEARCH
> +
> +static __always_inline int __find_fde_lsearch(struct eh_frame_section *s=
ec,
> +					      unsigned long ip,
> +					      struct eh_frame_fde *fde)
> +{
> +	unsigned long start =3D sec->eh_frame_start;
> +	unsigned long vma_end =3D sec->eh_frame_vma_end;
> +	unsigned long cur;
> +	int ret;
> +
> +	/* Linear search through .eh_frame */
> +	cur =3D start;
> +	while (cur >=3D start && cur < vma_end) {

[Severity: High]
Since the section header only provides the start address, this loop iterates
all the way to vma_end. As noted in the commit message, many binaries lack
a zero terminator.

If an unresolved IP is scanned, will this read past the actual section
boundary into padding or other sections, return -EINVAL on garbage data, and
subsequently cause the caller to permanently remove the section?

[ ... ]
> +		cur =3D entry_end;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +#else /* !CONFIG_EH_FRAME_LINEAR_SEARCH */
> +
> +static __always_inline int __find_fde_lsearch(struct eh_frame_section *s=
ec,
> +					      unsigned long ip,
> +					      struct eh_frame_fde *fde)
> +{
> +	return 0;
> +}

[Severity: Critical]
Does returning 0 here falsely indicate success when linear search is
disabled?

If a binary lacks a search table, __find_fde() will call this stub.
Returning 0 causes the caller, eh_frame_find(), to proceed with an
uninitialized fde stack variable:

kernel/unwind/eh_frame.c:eh_frame_find() {
    struct eh_frame_fde fde;
    ...
    ret =3D __find_fde(sec, ip, &fde);
    if (!ret)
        ret =3D __find_frame_row(sec, &fde, ip, frame);
    ...
}

Could this lead to corrupted stack traces or arbitrary memory reads by
consuming the uninitialized fde context? Should this return -ENOENT
instead?

[ ... ]
> @@ -1246,6 +1321,90 @@ static int eh_frame_validate_section(struct eh_fra=
me_section *sec)
>  	return -EFAULT;
>  }
> =20
> +static int eh_frame_validate_eh_frame(struct eh_frame_section *sec)
> +{
[ ... ]
> +static int eh_frame_validate_section(struct eh_frame_section *sec)
> +{
> +	int ret;
> +
> +	/*
> +	 * Validate .eh_frame_hdr binary search table
> +	 * (incl. all referenced FDE and CIE in .eh_frame).
> +	 */
> +	ret =3D eh_frame_validate_eh_frame_hdr(sec);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Validate .eh_frame CIE and FDE.  Skip if linear search
> +	 * is disabled, as many .eh_frame sections lack a zero
> +	 * terminator and the section end if unknown.
> +	 */
> +	if (IS_ENABLED(CONFIG_EH_FRAME_LINEAR_SEARCH)) {
> +		ret =3D eh_frame_validate_eh_frame(sec);
> +		if (ret)
> +			return ret;
> +	}

[Severity: High]
Does this unconditionally apply linear validation to all binaries when
CONFIG_EH_FRAME_LINEAR_SEARCH is enabled, even if they already have a valid
binary search table?

If the binary lacks a zero terminator, eh_frame_validate_eh_frame() will
read out of bounds up to vma_end, fail with -EINVAL, and reject the entire
section.

Will this permanently break unwinding for valid binaries that were
previously working fine via the binary search table?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D16
