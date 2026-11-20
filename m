Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206228;
	b=hnGW6wUX8oyy9Kk9OS5C7zCgEKVGty5yYjiQMy3hIlo3au1mdpMbTRlbt/usM7Oz7GRM
	 007wQs/TztsNCERdeAAYeuniWKmgiZfBwH3En/4oy1TtHw4NZqZcC2bKoD/plfAFfmG+S
	 kXRR0tfAlQtwyQ62klpK/S7aUiAUSIYydCbfmnScV3BrsA0Bmd2x0O4SwY6G0wJhsXk+a
	 YubRqD5dcWOobPVJornJtzDDgyIMJvARoZCPCVYHwIHsd0v8GpL3lhuKvLu1D02RdXORa
	 H4Yp/iUoWpvN4X3tgVsWjIfG3vTC1we97tdUkG2vhuCt7Fsmn//DDOrO2560svMYGwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qn/G3NK612ga2tPlKPik86puYrQY5a+E3I1AsiT+/Vc=;
	b=1ZtDih4dlz1Yt4ZZubIdfb9Z47MUVFYEJkAmdB547wbLbUU0DBPeTqYBNS23iCd0oULY
	 AXsXJ1vT9nST3Az4Ii0myvUIYixXHr3PWp6EzR475QiYqEtPExmzsPTf6ZJxzgpq4E6hG
	 1ZZ9x9iJQx8OqEyuHTHjujFBIG+q7b96ajxG4bU32pitof/zcE9BkYs+wCj2JSSCi2R+l
	 d+S0XhD5m2Putj8goEnTKS9vtJS457RSaSL2HYyX4hg8mrS3LtL3F6Q2pLWRH3Qavs1Ri
	 deDDodEX+/HHyy3o7jFo10auvD2zMvVp5S762R54pS2rlL0ke00muOx6V3142ueIVVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IepDOpIj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D56606A32A;
	Fri, 20 Nov 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IepDOpIj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906C61F000C4;
	Fri, 20 Nov 2026 20:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206227;
	bh=qn/G3NK612ga2tPlKPik86puYrQY5a+E3I1AsiT+/Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IepDOpIjkDYtQ0N74HIntiAwfzdPIRfemHpEZWXnuydbl6bdSw+ATQwmZ/WPr7Xez
	 ah2af6m7GS7q18/yMDImNP37Pfz1CYilV6VPFM8DiD92yoXP7+tCyoTL10hTPmRrPB
	 8uDiMHe6iEeDcqGTRNzQQEeg734kgpE+qzYMcVWwhPlTOHzdUkkuIC32GItC3Gfzzm
	 Zxf0NVUkG0jq+YXnWSXsE9Yyvm/Lwj1SyGKhIbqvVK38eJZdTC4vo8/CFotKZ0OKV3
	 AzSnUim0oeMAzYwKvg/GY3RwvENZl8VRAler5wqflgTZsZvtelwu5v3p2m+rCzdVPg
	 4VPiI02X7YZRw==
Message-ID: <sashiko-outbox-226057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/16] perf: Synchronize syscall tables with shared
 table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Arnd Bergmanon" <arnd@arndb.de>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, linux-perf-users@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Magnus Lindholm" <linmag7@gmail.com>, nathan@kernel.org, nsc@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119-tonyk-syscall_table-v10-16-a7c9ebd900f6@igalia.com>
References: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
 <20261119-tonyk-syscall_table-v10-16-a7c9ebd900f6@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:23:46 +0000
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
- [Low] perf build: missing syscall_common.tbl prerequisite in
  syscall_tbl_data
--

commit b6aa45cdacf2e688edb9fc5934e6ecc0b534dbae
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

perf: Synchronize syscall tables with shared table

This commit synchronizes the perf syscall tables with the common syscall
table infrastructure by moving shared entries to
tools/scripts/syscall_common.tbl and passing it to syscalltbl.sh.

> diff --git a/tools/perf/trace/beauty/syscalltbl.sh b/tools/perf/trace/bea=
uty/syscalltbl.sh
> index adc29af6e8917..cda2ea21a6ba8 100755
> --- a/tools/perf/trace/beauty/syscalltbl.sh
> +++ b/tools/perf/trace/beauty/syscalltbl.sh
> @@ -104,20 +104,20 @@ cat >> "$outfile" <<EOF
> =20
>  #if defined(ALL_SYSCALLTBL) || defined(__arm__) || defined(__aarch64__)
>  EOF
> -build_tables "$tools_dir/perf/arch/arm/entry/syscalls/syscall.tbl" "$out=
file" common,32,oabi EM_ARM
> -build_tables "$tools_dir/perf/arch/arm64/entry/syscalls/syscall_64.tbl" =
"$outfile" common,64,renameat,rlimit,memfd_secret EM_AARCH64
> +build_tables "$tools_dir/perf/arch/arm/entry/syscalls/syscall.tbl" "$out=
file" common,32,oabi,clone3 EM_ARM "$tools_dir/scripts/syscall_common.tbl"
> +build_tables "$tools_dir/perf/arch/arm64/entry/syscalls/syscall_64.tbl" =
"$outfile" common,64,renameat,rlimit,memfd_secret,clone3 EM_AARCH64 "$tools=
_dir/scripts/syscall_common.tbl"

[Severity: Low]
Should $(srctree)/tools/scripts/syscall_common.tbl also be added to
syscall_tbl_data in tools/perf/trace/beauty/Build?

tools/perf/trace/beauty/Build {
    ...
syscall_tbl_data :=3D $(srctree)/tools/scripts/syscall.tbl \
	$(wildcard $(srctree)/tools/perf/arch/*/entry/syscalls/syscall*.tbl)

$(syscall_array): $(syscall_tbl) $(syscall_tbl_data)
    ...
}

Without it in syscall_tbl_data, incremental perf builds will not
regenerate trace/beauty/generated/syscalltbl.c when
tools/scripts/syscall_common.tbl changes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-tonyk-sysc=
all_table-v10-0-a7c9ebd900f6@igalia.com?part=3D16
