Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEA25B088
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689436; cv=none; b=L9EveFg4gzkC9Uq1VKKK7PhUN9vP5A4nlh5IeOKwP904bkgjLraRKv08DfLhgpx807Ak7lwUmF1sAFeTe4EQ48Gx7Z2ueUI9vDaxYVBpVpHWqVFUJo3fLsduqcdFXagBuqzDxTDk3gGgQ2kNwgJ7hFAo6f+1YOTGSPF0fZqkNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689436; c=relaxed/simple;
	bh=jhynp74a0dEGMlCtN6ybFqKJHIoTjDR08Ofm7rcUp74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G01XGJ8rMVjFb7IXyyw4PYRJgL4aaHtVHUarFqj2KVBlPLMzUjYwlFA1pRqEmKcvkdsmk3DmxnQKtzfpfZ6HZAVZNDDpXrTqBvtkSc/NgiLlrskPG86JgWzQFA37In9Sjr15fMDDAJNwZ5TX5Kf/1d2E9ZGA7aAMcitgYKQM8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lfd2FxXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lfd2FxXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD9E1F000FF;
	Thu, 17 Sep 2026 23:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689434;
	bh=+kzopS7fhibmZlwxDyNUtocq3C6BVgw3c9ru9JbCzFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lfd2FxXf0Q/avqE0EvmbDxgc2vIWtpg9lMtU9+awWY5wde37Gvq6QtNB9rNmTUWdR
	 MXYTkpA3MczLFO4j5N4/dImFE109Fcfq81ooq+UcUl+5elCIX44mecXqIRAjNjAZ0i
	 I8kl4UCUvs2I4mCMGHcgoCMklCl4mx7FM+rDRw7/CGuZpqMKJOfCYpYUwxCBUmNXQL
	 FjlH045cb7sK7tne0l2XSdc1kEmNII6BB3ggzbKAhb5eCWlxrRJ/CpKw23fY5NE+lN
	 KiTSvlOY5uY1R22HCMUH+NQyOlE92F5S61W5PYDieey0+PvOsCE48FfBXvydNxQGUh
	 +5F8ucgGk2Txg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/13] syscalls: Create unified partial table for all
 archs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-2-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-2-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:57:13 +0000
Message-Id: <20260917235714.1DD9E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] scripts: unconditional max assignment in gen_hdr() truncates sys=
call bounds
- [Low] scripts: global nxt variable in gen_tbl() prevents processing overl=
apping tables
- [Low] scripts: unhandled grep exit status under set -e aborts build and l=
eaks files
--

commit ee189db3abdfc2d74c8d015dc09705528a8d78b7
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Create unified partial table for all archs

This commit creates a unified partial table for syscalls shared across all
architectures. It adapts generation scripts to use this table, allowing eve=
ry
new syscall to be added to a single file. It also creates special ABIs and
Makefiles flags to support different architectural entry points.

> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> index bad1ab606a0fb..8f7dfcf19a4c5 100755
> --- a/scripts/syscallhdr.sh
> +++ b/scripts/syscallhdr.sh
[ ... ]
> @@ -69,13 +76,35 @@ guard=3D_UAPI_ASM_$(basename "$outfile" |
>  	sed -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
>  	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g')
[ ... ]
> +max=3D0
> +# gen_hdr(infile)
> +gen_hdr() {
> +	input=3D$1
> +	tmpfile=3D$(mktemp)
> =20
> -	max=3D0
> -	while read nr abi name native compat ; do
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile

[Severity: Low]
Does this unhandled grep exit status abort the build and leak files?

Since this script runs under set -e, if the specified ABI has no entries in=
 the
parsed table, grep returns exit status 1.

Due to set -e, the shell will immediately kill the script, bypassing the
rm $tmpfile cleanup at the end of the function.

> +	while read nr abi name native compat; do
> =20
>  		max=3D$nr

[Severity: Medium]
Will this unconditional max assignment truncate the syscall bounds?

gen_hdr() sequentially processes the arch-specific table and then the common
table. The global max variable is unconditionally assigned max=3D$nr.

Because the common table is processed last, its maximum number will permane=
ntly
overwrite any higher maximum previously read from the arch table.

> =20
> @@ -84,15 +113,21 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$infile"=
 | {
>  		fi
> =20
>  		echo "#define __NR_$prefix$name $nr"
> -	done
> =20
> -	if [ -n "$emit_nr" ]; then
> -		echo
> -		echo "#ifdef __KERNEL__"
> -		echo "#define __NR_${prefix}syscalls $(($max + 1))"
> -		echo "#endif"
> -	fi
> +	done < $tmpfile
> +	rm $tmpfile
> +}
[ ... ]
> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index c4b1f85c2dd63..70da0039ab22f 100755
> --- a/scripts/syscalltbl.sh
> +++ b/scripts/syscalltbl.sh
[ ... ]
> @@ -52,12 +59,16 @@ outfile=3D"$2"
> =20
>  nxt=3D0
> =20
> -grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
> +# gen_tbl(infile)
> +gen_tbl() {
> +	input=3D$1
> +	tmpfile=3D$(mktemp)
> =20
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile

[Severity: Low]
Can this unhandled grep exit status abort the build and leak files?

Similar to gen_hdr(), this script also runs under set -e. If the grep comma=
nd
finds zero matches, it exits with 1, which causes set -e to kill the script
here before the cleanup routine can run.

>  	while read nr abi name native compat noreturn; do
> =20
>  		if [ $nxt -gt $nr ]; then
> -			echo "error: $infile: syscall table is not sorted or duplicates the s=
ame syscall number" >&2
> +			echo "error: $input: syscall table is not sorted or duplicates the sa=
me syscall number" >&2
>  			exit 1
>  		fi

[Severity: Low]
Does this global nxt variable in gen_tbl() prevent processing overlapping
tables?

The validation check enforces a strict monotonic increase in syscall number=
s.
gen_tbl() maintains a global nxt variable across sequential file invocation=
s.

If the first file's maximum exceeds the second file's minimum, processing t=
he
second file will immediately fail this validation check and exit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D2
