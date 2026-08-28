Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5893AE6F3
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959873; cv=none; b=bkKGHXsyQei0GRrgNh7tIvKscVoll4pDvzzOBlh7eJPbrd0dj4WZle2Xf3DmKgnMUN0RCZW/Lu/9nSTSNa3HpkE5aUZgAaJqBNctQzAG61yF6HNC0B5erCSV6y+s8PA3X9PsH81Hsi/el6JQYjePhJ6C0I198RyoAjK9vE7risE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959873; c=relaxed/simple;
	bh=fCw0BgyicfwqfZz/VB2PoKw8W4DHeVDKTOfzm1D4jfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ID05r+FLewh6kwZRqIl3HrCk1DhaNgxd6TGipS/1SSSJGJBswZifNQG6pSykUw/2lRSc/uWZYY4kSURbQV3DsTZomVQ7CVuXNw8A+md9Yhbo8ZpQ92LNNva8G0ELXrZsSIEfqCJtpKON2oTa2YHIqvm9LkzTP4PcHqdgwKba80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDQMvYRy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDQMvYRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4BF1F000E9;
	Fri, 28 Aug 2026 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787959868;
	bh=4QNuJpGC8bjKpALBc44TdorPc/zy1ARU81FYYS5a8HU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LDQMvYRyllSNmBWmKhO18/YfLgZAWU8vGAJuJuDoZY3iiA6tQn7Uw8KEU3YuQVa3h
	 vpE+oYP7re+8glJSPSQhSjhiZgVbvJRJmtTq1GQGRSVyPJeGSs6jNCtAVBbsD/0Epr
	 thM+wsQwiJ68iZ6JPwGv7oaDhYduQDkg5sudxBnVjBBDBD7BUGVyG4fQjYurh+zGAH
	 iWq9PhQjJorY8bPZjMbQvuK5J/nnT8x9xYDu+Zc52drx3dp4SNVpxYJeyQJn88LSvM
	 GExSIvwbjKGYyCoCD8DEX/Kiw+wJ+9Lzqsa+4LbckG07WRs7g+QN4LB2EOUJOx4FEz
	 A+eZMoqM/QaCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] syscalls: Create unified partial table for all
 archs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-2-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-2-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:31:07 +0000
Message-Id: <20260828233108.2B4BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Usage of the GNU-specific `mktemp -p` flag breaks POSIX compliance=
 and cross-compilation on non-GNU platforms (e.g., macOS/BSD).
- [Medium] Unhandled `grep` exit status under `set -e` causes build aborts =
and temporary file leaks.
- [Medium] Global state overwrite in generation scripts prevents use with o=
verlapping syscall numbering (e.g., x86_64 legacy syscalls).
--

commit 09dd7fecb9d7d6c1b19fdd2e2a3af7850e945333
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Create unified partial table for all archs

To take advantage of the subset of syscall numbers that are guaranteed to
be shared, create a new table and adapt generation scripts to use it. In
that way, every new syscall can be added to a single file.

> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> index bad1ab606a0fb..a9b880070a3d2 100755
> --- a/scripts/syscallhdr.sh
> +++ b/scripts/syscallhdr.sh
[ ... ]
> @@ -69,13 +76,35 @@ guard=3D_UAPI_ASM_$(basename "$outfile" |
[ ... ]
> +max=3D0
> +# gen_hdr(infile)
> +gen_hdr() {
> +	input=3D$1
> +	tmpfile=3D$(mktemp -p .)

[Severity: High]
Does this mktemp call break the build on macOS or BSD? The -p flag is a
GNU-specific extension. On non-GNU platforms, mktemp -p is an illegal option
and fails, leaving tmpfile empty and causing a syntax error on the subseque=
nt
redirection, which instantly halts the build.

> =20
> -	max=3D0
> -	while read nr abi name native compat ; do
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile

[Severity: Medium]
Since this script runs with set -e, what happens if an architecture specifi=
es
an ABI but its local table has no matching syscalls? grep will exit with
status 1, immediately terminating the script and aborting the build. This a=
lso
bypasses the explicit rm $tmpfile command, permanently leaking temporary fi=
les
in the build directory.

> +	while read nr abi name native compat; do
> =20
>  		max=3D$nr

[Severity: Medium]
Will this overwrite truncate __NR_syscalls when processing overlapping tabl=
es?
If a native table (like x86_64 legacy) has higher syscall numbers than the
start of syscall_common.tbl, blindly overwriting max without checking if the
new number is larger will cause __NR_syscalls to be truncated to the end of
the common table.

[ ... ]
> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index c4b1f85c2dd63..f5b95b19ac92d 100755
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
> +	tmpfile=3D$(mktemp -p .)

[Severity: High]
Does this mktemp call break the build on macOS or BSD? The -p flag is a
GNU-specific extension. On non-GNU platforms, mktemp -p is an illegal option
and fails, leaving tmpfile empty and causing a syntax error on the subseque=
nt
redirection, which instantly halts the build.

> =20
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile

[Severity: Medium]
Since this script runs with set -e, what happens if an architecture specifi=
es
an ABI but its local table has no matching syscalls? grep will exit with
status 1, immediately terminating the script and aborting the build. This a=
lso
bypasses the explicit rm $tmpfile command, permanently leaking temporary fi=
les
in the build directory.

>  	while read nr abi name native compat noreturn; do
> =20
>  		if [ $nxt -gt $nr ]; then
> -			echo "error: $infile: syscall table is not sorted or duplicates the s=
ame syscall number" >&2
> +			echo "error: $input: syscall table is not sorted or duplicates the sa=
me syscall number" >&2
>  			exit 1
>  		fi

[Severity: Medium]
Will this global nxt check fail for architectures with legacy syscalls? If =
an
architecture has local syscall numbers that are higher than the start of the
common table, appending the common table sequentially will cause nxt to be
greater than the first common syscall, triggering this not sorted error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D2
