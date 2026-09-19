Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C91FDA61
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779165; cv=none; b=ECzqVqRfhD6VysoaRsWsPoOkiZ9ndMBd8RnBpab5qL/DXjt3oPHZZbe99rEX9tp4m9cy9VmfM/jBpdGvXwVTAMHWPQDhZtdrzHQrfPibBokFvUffacR7zI0hK+cbScrvO1PJlqe+REBGic9S9CAmn58/slNVdlB0SEppo/rWwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779165; c=relaxed/simple;
	bh=1+tICd8l4w/ZQtWsM+cqMHiUDY+F8+QorQvE/NNQhdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fx+41wwZiFoNJGCyvXxYIkGmbtdRX0hoc9V2wZAg9AhqaZ2shmKo6AMUtrVQ1i6aC86nYX5zpxF6CBuNQ2+pu8OPmsVPiji2GqEZ6xVQ9BlG1XxcxaaBaroxBOjphSbNBx3usKbpp4Qm4XjSCEb3eKAN7PHPSMap7Tv8Oz6/pks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGa53Wjw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGa53Wjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59101F000FF;
	Sat, 19 Sep 2026 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779164;
	bh=ICVz6grAmeHcH8Z+YiYPAmTdBiRLsKLLEE6wm+3kwGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KGa53Wjwm8nzn3sIA+EUcxzhx5F1QUTOb/ERk/R4qJix6qhKmb5cCqjvlGHYJcE7k
	 3kX8X/VeTMZQLRRCHhsAc0Cp9j1PcamQE5UXz2ANArZ5GXh4DoRbPbQqA5y2DJ/uqd
	 47X9wONsWg/yTbzykWnXme8G/KSbi0+Ut31Jecl1pmMrptoiy4IOCQBrpPs9bLmqgK
	 7kVv2/Fc4IcOjJ5+3U9auu9q7lJ9nctefImggtjZovyLrriIH6y+gGRG+89aIRFMHU
	 Y/m+6j0W+T+qvpkhIWXWw3ZzdCNZBAOJeeEtLHKH1KQoijca1C0reJzq8Wap9EFcrK
	 VyYDzRZ7cB8Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/12] mips: Get rid of custom mips ABIs for syscall
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-7-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-7-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:52:43 +0000
Message-Id: <20260919005243.B59101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: Unsynchronized MIPS syscall table causes build warning
--

commit 2ce69c55f672c9600f10db5f1b61c39c0604b9a1
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
mips: Get rid of custom mips ABIs for syscall tables

This commit replaces the MIPS-exclusive ABI names (n32, o32, n64) with the
standard "common" ABI name in the MIPS syscall tables. It simplifies and=20
unifies the tables without altering functionality.

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

[Severity: Low]
Does changing the ABI field to common here without a corresponding update=20
in tools/perf cause a build warning?

It looks like building perf will trigger a "Kernel ABI header differences"=
=20
warning from the check-headers.sh script because the synchronized copy at=20
tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl was not updated to=20
match this tree.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D7
