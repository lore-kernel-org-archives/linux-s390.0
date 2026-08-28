Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D1390613
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959774; cv=none; b=iE4Bv78JioDI7yhPbVoo29DD7uZO3LXj+czK5AMsLcBbheG4XXMtXWY7xRCAUDe8T95xdxYZrvhKFlwrS6c2Vq9R0YQm0PMgOQwbEQqA9h1+pODRKYHUg9ASwEZiJMON+WFCzKUv4wSAwNCKfY2oXLunEd0lu9t2UKeU9f8thco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959774; c=relaxed/simple;
	bh=uQXhRIXO00FGNZ1Ds8Igzc7uwedpm7rfJWLL78JX4Ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FOfcnj85i8fAuphcG/Fr14u316H9GkirNmHh+Fq2AX6p6tzv/j1FYu4wnYrkRve2VuRFhjA2TyoXWiUEHXUhZhslUBGakE3lCbFMp80zkWeqeaMrjucqB2q1QOMD+VgDtOdUSymoVSvIaLmqHOYA/X1RZgnNKi30WO+KfSqipK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMLGri9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMLGri9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F441F000E9;
	Fri, 28 Aug 2026 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787959772;
	bh=87Ttur3mNRhXmyPzoXndX0woU8X04N1DyFQTf8r8Dc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMLGri9E2G105JsIViw3IA1xae+ATnjIhAEMftbzwRS1DXx2g5pyO90+QSWcbnnOq
	 H1pfK8oSfC9Ea9fYpFJYGPgn/HthJQkhpexQZJB0Ikiv/g1xrCHsq0bHM36ifA/mBy
	 I6Q5yttmXkOwwd7UZRHwOaOl01Zc/ibAJg4hzGlDWR9PPKsqFMHG0E7/Qc2CoKBqkg
	 v9eP50wtz29mjZqf6Ls7iozQMmh+7IlOfgMiQFBtmVst80Bd3ITLvU/yTxLrw1jFm7
	 u0+WiyZVQG4wlBYP7AiLONjsl4xNCdlaRCvYpkLU13Cs1f5piqe+QAPn1Ty/MbFioP
	 TDQTxIEpObzkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/13] mips: Get rid of custom mips ABIs for syscall
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260828-tonyk-syscall_table-v6-8-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-8-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:29:31 +0000
Message-Id: <20260828232932.43F441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] MIPS syscall table modifications and renames break perf ABI trac=
king.
--

commit a8e9328861b9ab6474113d3cd1414e8d440494b3
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Subject: mips: Get rid of custom mips ABIs for syscall tables

This commit replaces the MIPS-exclusive ABI names (n32, o32, n64) with
"common" across the syscall tables to simplify and unify them. There are
no functional changes intended.

> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel=
/syscalls/syscall_n64.tbl
> index 83dc93a0712f1..4341b2fd96dad 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -5,385 +5,385 @@
>  # The format is:
>  # <number> <abi> <name> <entry point>
>  #
> -# The <abi> is always "n64" for this file.
> +# The <abi> is always "common" for this file.
>  #
> -0	n64	read				sys_read
> +0	common	read				sys_read

[Severity: Medium]
Will this change cause a 'Kernel ABI header differences' warning when
building perf?

Running make in tools/perf/ checks the kernel's syscall_n64.tbl against
its own vendored copy in tools/perf/arch/mips/entry/syscalls/. Because
this patch updates the ABI field to common without synchronizing the
tools/perf/ copy, the two will fall out of sync.

Additionally, if this file is later renamed or replaced in the series
(for example, unified into syscall_n.tbl), will tools/perf/check-headers.sh
also need to be updated to track the new name? If the check script silently
skips missing original files, perf might permanently lose tracking and fall
back to using an outdated copy of the table, failing to decode any new
MIPS syscalls added in the future.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D8
