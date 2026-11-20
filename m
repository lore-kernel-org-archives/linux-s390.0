Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206226;
	b=JfO/BEqA6RIAs/aqtDN5pwru+3FTuMwO0jwdUj1Mc6VZTtdV0e0RaKS1urNShdIA0x01
	 2bwSYnWae2tVaLX23kgARmX3G1h2Cxdem5r/d0O1TPX2chE1XnZ5fDzoc5/9NKKAmTQ/R
	 buV93BH0IrhvBkPpcNTFLxhvDIqjpCtaOMdncTWeNOtxnwztM0hiAWIs0un0pdrPLfcBF
	 9APv2Wh2tRzmJBJN3M7W5nwYYGq/xwxQlwCNL6xCXRij65ekFa+hTRrjoyIEibyADtkaL
	 fnrsEN7t5ZUAPH7BulHNtbbShmgMBFFPAhQRt7uJ5DrHwh36qcswsRUGzFbDmxUY1zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P+3KjbvPrSMSpGkYM4nGg66MtVNXtf6m9cvlU1bxYnI=;
	b=FRKYEZL3Fj+Y4yPL+prEQ9oLzw8mOWcJS1U30b3dMTW7+JgOGG1kY50ZcJR9Izb5Nv9Q
	 lFN/yAxZ5sxqqEZmG2YEOFdCVU3YzBhqplnSlZBKYSLjjkFal69H/yJw+Fl4B744fRqi0
	 VcFphZmA7vNMX1wXaE9Ltyx/5l7OZyuRhJrSTK34SgKENCzCFR6G6vIcKVaX0EPF2+P7k
	 +ikDuqqleUOfJz6IDN43YrlhGcV2nYcm3QNISJyI9WM2sjpqXevBqPo7jitq8InJx1uLV
	 iMvYHW5fuLB1ftJ+BxPa/vFcvjUOwqX2YRLQc/yihb1dEBvMa4oFwBgfCOy2TSC+zEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoZtPXM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C7606A6D2;
	Fri, 20 Nov 2026 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoZtPXM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296241F000C4;
	Fri, 20 Nov 2026 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206226;
	bh=P+3KjbvPrSMSpGkYM4nGg66MtVNXtf6m9cvlU1bxYnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DoZtPXM5JigttgqN4LUMTrh8WhBWxhLLLGdUH7+2Vrek6bTE7ecT3vKYUp3Fabj5z
	 CrIhYL/Rm9tk/3gH5bvZ9SnduQQ+oWYckzfsHX+N4cbcF+KtXMDCDou763TwM2j0ck
	 RG302uBA5xB+SJZXKV1gdDDsQdJPVlONDpOLrAo9huYYAk/vubGblqFenM3My4V1QN
	 m7g/6X3LTqX78cJZXPZuVBDJuESAz+l1IklBGJlAZPiu9J934UmRWk20ThemCmYuBz
	 n3B03uC6L43o+L9ibx2QpcNwfeTZpQmx6pW6LTrkqE6LLqQlKCJYUpGC4MIt617wEe
	 EtqC8SqS4SuGA==
Message-ID: <sashiko-outbox-226053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/16] syscalls: Avoid matching substrings in the
 ABI parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Arnd Bergmanon" <arnd@arndb.de>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, linux-perf-users@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Magnus Lindholm" <linmag7@gmail.com>, nathan@kernel.org, nsc@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119-tonyk-syscall_table-v10-12-a7c9ebd900f6@igalia.com>
References: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
 <20261119-tonyk-syscall_table-v10-12-a7c9ebd900f6@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:23:44 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] syscalls: gen_hdr() and gen_tbl() regex breaks empty --abis and
  repeats $abis
--

commit f6d8a94774818a17d8d32b3ba41a79a1af1107a1
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Avoid matching substrings in the ABI parsing

This commit updates the grep patterns in scripts/syscallhdr.sh and
scripts/syscalltbl.sh to require trailing whitespace after $abis and
appends "|| true" so the scripts continue to cleanup when grep finds no
matches.

> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> index f2d670f45ec86..6372dbb1cb715 100755
> --- a/scripts/syscallhdr.sh
> +++ b/scripts/syscallhdr.sh
> @@ -109,7 +109,7 @@ gen_hdr() {
>  	tmpfile=3D$(mktemp)
>  	offset_nr=3D$2
> =20
> -	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis+[[:space:]]" "$input" > $tmpf=
ile || true
> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index 1e9cac32c02d2..403a604e7c760 100755
> --- a/scripts/syscalltbl.sh
> +++ b/scripts/syscalltbl.sh
> @@ -70,7 +70,7 @@ gen_tbl() {
>  	tmpfile=3D$(mktemp)
>  	offset_nr=3D$2
> =20
> -	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis+[[:space:]]" "$input" > $tmpf=
ile || true

[Severity: High]
Does this regex match any lines when --abis is omitted?

When --abis is not passed (such as on m68k, microblaze, sh, and xtensa),
abis defaults to an empty string and the pattern expands to
"^[0-9A-Fa-fXx]+[[:space:]]++[[:space:]]".  That pattern has nothing to
match the ABI column, so grep matches zero lines, "|| true" suppresses the
exit status, and gen_hdr() and gen_tbl() silently generate an empty
syscall_table.h and a unistd header without any __NR_* definitions,
breaking the build on those architectures.

In addition, when --abis is passed, "$abis+[[:space:]]" puts the "+"
quantifier on the parenthesized $abis group rather than on [[:space:]],
matching repeated ABI names instead of one or more trailing whitespace
characters.  Initializing abis to "[^[:space:]]+" by default (or only
requiring trailing whitespace when $abis is non-empty) and moving "+" to
"[[:space:]]+" would avoid both regressions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-tonyk-sysc=
all_table-v10-0-a7c9ebd900f6@igalia.com?part=3D12
