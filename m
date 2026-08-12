Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34E2F39C2
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556997; cv=none; b=gfE4QABhXst1AFvqwb/ZcqLKjAtBciQgMTic4Ri1ntY0FeoTqfMwF72vND/FNUrjpkDFjzgrurCkC/WALOdvlB6Z6DpZyauRxXm3yKCkPGV5VvgPsu6nZX3q6t1WECQKodUzju53p8YC0EIfc3ke0P6/OlQSwkg3dvydypVcfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556997; c=relaxed/simple;
	bh=MKvCUl91dkiosKsLu6tAU7M2rJiXNFxENCHtkImgBLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qUzeThB75Ly2Lv94R/wA83DjSrY1iSp9L5Rg12APpD3FV00dQFEFWd/C70DD57PUbLnNm78JmGbA6wMdV1rJhWKS4NgGUVuFj4mgfuyNhWg+I8x/cUgnuI9J/AFNEdjWj5ER4zxQhmsdOjAhLJ+ZNGpSgYpz+CquNTaDeDJ6mI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcJTd9DW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcJTd9DW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5031F000E9;
	Wed, 12 Aug 2026 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556996;
	bh=pqJ04BE1gm3U/7SJuZBSYUG1nD5CDw3EX83ZspuPMEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HcJTd9DWzqSfp/C6ouZxZCt1bwo/2FrWxr9rp67+Du9AWXN4RhY02XfwdEQfiUHNS
	 devU94EUFInA9jGp1lzqICbKhzC5Qw8gXOpTrauw+/mZkbFFHUcugqz/bgmJ5pV+xF
	 CrhTNDf5b4etw2u8sH8jlAGK/QaIfofIt1QvXDgTOx4/rVLF9UfI/8kpbFEcFl92G3
	 pzeFBHQek9OPKNtTkXMBIw8y8sJB5oexnydXZc1/N9g09cnBhSvoDRgnBicmIRf+a5
	 ICBRpjwvkJLkW9SwFzEnBUCenXRgGjLhdt0w+8k6STPFBu6/NpXARLG8nc4mOqSdQg
	 hI+a4sZfUQMLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/13] mips: Get rid of custom mips ABIs for syscall
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812-tonyk-syscall_table-v5-8-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-8-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:49:55 +0000
Message-Id: <20260812174956.0A5031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch modifies `arch/mips/kernel/syscalls/syscall_n64.tbl` (cha=
nging the ABI string to `common`) but fails to synchronize the mirrored cop=
y at `tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl`.
--

--- Patch [8]: [PATCH v5 08/13] mips: Get rid of custom mips ABIs for sysca=
ll tables ---
commit 0da0a7952278891a02bb3187b7d10490c780e9c7
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Date:   Wed Aug 12 17:38:39 2026 +0000

mips: Get rid of custom mips ABIs for syscall tables

This commit replaces the MIPS-exclusive ABI names (n32, o32, n64) with
"common" in the syscall tables. The goal is to simplify and unify the tables
without introducing any functional changes.

> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel=
/syscalls/syscall_n64.tbl
> index 630aab9e54259..9acc68729e218 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -5,384 +5,384 @@
>  # The format is:
>  # <number> <abi> <name> <entry point>
>  #
> -# The <abi> is always "n64" for this file.
> +# The <abi> is always "common" for this file.
>  #
> -0	n64	read				sys_read
> +0	common	read				sys_read

[Severity: Low]
Will this trigger a "Kernel ABI header differences" warning during the perf
build?

The kernel ABI header was modified to use "common" instead of "n64" here, b=
ut
it looks like the mirrored copy at=20
tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl was not synchronized.
When tools/perf/check-headers.sh runs during the perf build, it will detect
that the two files are out of sync.

Should the tools/perf/ copies of the syscall tables be updated in this patch
as well to prevent the build warning?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D8
