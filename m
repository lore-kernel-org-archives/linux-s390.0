Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B339FCDD;
	Tue, 18 Aug 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065867; cv=none; b=DwnfLAz9dYSezSRLRvTvx3JYV386j8t4wFCiAeUwzwEcEXGPUcSJNb9pgu41kBSaTa5cv1PQnjXFxGmHYloBtXpTLw2OfqN2hoSn2DE41fZEHP2cnKVvDFHSrSzf9SmIb2RZjDaMjN631KaewpIa9UWieWDLJGi+DXqCHKBHp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065867; c=relaxed/simple;
	bh=PHmzjw0O9LGtYG4sKbAKPqkJOIx7v8e4aBIKVXFD5B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C51ivLo7Pxha6EP17sBGIi2ZLWDZPj7k1x6nWqXP2gSkBInsk4tO996ziklPKYIThCX8Ms30rRr5xTt6Uj/FzaOAMbEMo7+jBWLU5KY8Eqw4l+hsOzfnbAfhFRnFgGatrwbBdkFG27oi2kxhm8+Itx7PdYLxHN/AfPwL/iXM0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYlHrxTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYlHrxTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053861F000E9;
	Tue, 18 Aug 2026 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065865;
	bh=sEKe314O2lyW5fuIx6n0phOMacwvhGo+OkLzaGTisMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kYlHrxTkKON0LSxM1vs7+8ad4UZQjfuEzny6hMa3uZDqG5d8zHYzfMJwZ94sly8r1
	 Z0iFO9QzLN6MftwyoHozLkDA5uJdm3i4jXCIuSDP2fXwe5/Bc6od5nRkor2tJAbMK9
	 V1gYHh3CfB5T2PJakp6R3SPkUUxXu0ZpxqV48YxAG7wDiHcYTPGKgh3VMUlRmlQPWG
	 LZLJkKrY67QmIdUe0X3fM73THd1ThmBvZ1PfkVJViU8l7ix87YXyUlLD/1p2f1kne3
	 N7iOkm/OjGrUNCaIaPOOQlWeWBnpgQwrUHtlgMyy3ctOC6hZ/rAxRJw0Sd9jV99Fol
	 LYPnEmg2x4bUg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 15/25] unwind_user/eh_frame: Duplicate registered
 .eh_frame[_hdr] section data on clone/fork
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-16-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-16-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:11:04 +0000
Message-Id: <20260818151105.053861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Mixing `guard(srcu)` with `goto`-based error cleanup in `eh_frame_d=
up_mm()` violates kernel cleanup guidelines.
- [Low] Compilation failure in `eh_frame_validate_section()` when `CONFIG_E=
H_FRAME_VALIDATION` is enabled.
--

--- Patch [15]: [RFC PATCH v1 15/25] unwind_user/eh_frame: Duplicate regist=
ered .eh_frame[_hdr] section data on clone/fork ---
commit 5bac3cc6bbe2eca53f4122c35113146b44210ee7
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Duplicate registered .eh_frame[_hdr] section data on =
clone/fork

This commit ensures that a process's registered .eh_frame_hdr sections are
duplicated in the per-mm maple tree during virtual memory duplication. This
enables stack tracing for child processes using eh_frame.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index c9161229196ce..7f572d1711d3f 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c

[ ... ]

> +int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
> +{
> +	struct eh_frame_section *sec, *oldsec;
> +	unsigned long index =3D 0;
> +	int ret;
> +
> +	guard(srcu)(&eh_frame_srcu);
> +
> +	mt_for_each(&oldmm->eh_frame_mt, oldsec, index, ULONG_MAX) {
> +		sec =3D kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
> +		if (!sec)
> +			return -ENOMEM;
> +
> +		__eh_frame_dup_section(sec, oldsec);
> +
> +		ret =3D mtree_insert_range(&mm->eh_frame_mt,
> +					 sec->text_start,
> +					 sec->text_end - 1,
> +					 sec, GFP_KERNEL_ACCOUNT);
> +		if (ret)
> +			goto err_free;
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	free_section(sec);
> +	return ret;
> +}

[Severity: Low]
This isn't a bug, but does this function mix scope-based cleanup with
traditional goto-based error handling?

The kernel's cleanup guidelines specify that usage of goto and cleanup
helpers like guard() should not be mixed in the same function. Could this
be converted to use scope-based cleanup entirely, or avoid guard() to keep
the style consistent?

[ ... ]

Additionally, looking at eh_frame_validate_section() in the same file:

> 	if (!sec->has_binary_search_table)
> 		return 0;

[Severity: Low]
Can this cause a compilation failure when CONFIG_EH_FRAME_VALIDATION is
enabled?

It appears the function attempts to access sec->has_binary_search_table,
but this boolean member is not declared in struct eh_frame_section in
include/linux/eh_frame.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D15
