Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5430D413
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778522; cv=none; b=urX0+JJMEvyDgB4l7xRn6kfNkWZWxvH8YcMfeHVwM7u9w2azHr29qwd2HT5rpPHNOS2946oCbd32H6opXPsjrZCR+W1y1sld8bEgMt4k6YcD/pK0SyNv+qmW+uGE+P/3ISA9GjbbUFQbfnDG4oOAt++cW64dk+wj1eoGCPXoP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778522; c=relaxed/simple;
	bh=vSdwBpi6IV6rx1O7IoSBML6uNHDYurmLm4cwIJuyLbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O5vlH1ksukNRSJWTeZX6qN2ATHzUG57xOffpEzg5q3/5aKDx68oFtD6StT5hUA3QZK7unQS6yAU6uHZr/sDWaS/amfBNABGjC/SARUejOT2qzz9W+5AV/1UOkcp8KgpULY+5dVu/pPDquXzBNpT9kAadRyB08lwzYCctx7mK5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZVbxg1f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZVbxg1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244001F000FF;
	Sat, 19 Sep 2026 00:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778517;
	bh=nUgLGUWy4lrK1TZwxNBicMKNPzCUUsJn17AQCsdgJuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZVbxg1fNjbU4p45aL5kciyIFW1HZeO1YtYBDmGCMXYnxC1ftm3lEQFNiYi+Hy5he
	 9WWBaxrwjH3nIWRoZDZC/ItFnrpxvfekDroIQhKdrQLERt1d86bF7fYgGLmWkSGWQp
	 X2O6Fs8vsWAH0HCqBErOpKSjZ9ue9l1N5I8KN4UpesH1IRSULs0G7Fiz1sQj1B27B5
	 zGzncu4s99pbK9Bmt7iHwstBov10XjUKs+0BQSqUWck+QK8/gHsnBQwAwZfXGFpvgm
	 Tyc1gpmOLNV0JF+QmmJAMUXoJI90DyQNLeATEydpdk61t/2mJb7CKxytZ11aQqc1Mi
	 eE+pYuA2LGmKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/12] syscalls: Create unified partial table for all
 archs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-2-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-2-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:41:56 +0000
Message-Id: <20260919004157.244001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] syscall tables: validation breaks for architectures with syscall=
 numbers > 472
- [Medium] syscall tables: build fails under set -e if grep matches no ABIs
- [Medium] syscall tables: default execution without --abis breaks on dupli=
cate clone3
- [Low] syscall tables: temporary file leak on script failure
--

commit 1a47a0eaef6bf764943feb1f3af3a9d960c27697
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Create unified partial table for all archs

Creates a new unified syscall table and modifies generation scripts to use =
it.
Introduces special ABIs for clone3 variants.

> diff --git a/scripts/syscall_common.tbl b/scripts/syscall_common.tbl
> new file mode 100644
> index 0000000000000..8085030eb869e
> --- /dev/null
> +++ b/scripts/syscall_common.tbl
[ ... ]
> +434	common	pidfd_open			sys_pidfd_open
> +435	clone3	clone3				sys_clone3
> +435	__clone3	clone3			__sys_clone3

[Severity: Medium]
Will default execution without an explicit ABI filter break on these duplic=
ate
clone3 entries?

The script permits omitting the --abis flag, which falls back to matching
all lines. Processing both of these mutually exclusive entries causes
syscalltbl.sh to erroneously fail its duplicate number validation.

[ ... ]
> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> index bad1ab606a0fb..8f7dfcf19a4c5 100755
> --- a/scripts/syscallhdr.sh
> +++ b/scripts/syscallhdr.sh
[ ... ]
> +max=3D0
> +# gen_hdr(infile)
> +gen_hdr() {
> +	input=3D$1
> +	tmpfile=3D$(mktemp)

[Severity: Low]
Does this temporary file leak on script failure? File creation occurs witho=
ut
a guaranteed cleanup mechanism on error paths.

> =20
> -	max=3D0
> -	while read nr abi name native compat ; do
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile

[Severity: Medium]
Since this script uses set -e, will executing grep as a standalone command
uncontrollably abort the script if no matching lines are found?

> +	while read nr abi name native compat; do
> =20
>  		max=3D$nr

[Severity: Medium]
Does this unconditionally overwrite max, discarding higher syscall numbers =
seen
in previously processed architecture-specific tables?

[ ... ]
> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index c4b1f85c2dd63..70da0039ab22f 100755
> --- a/scripts/syscalltbl.sh
> +++ b/scripts/syscalltbl.sh
[ ... ]
>  nxt=3D0
> =20
> -grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
> +# gen_tbl(infile)
> +gen_tbl() {
> +	input=3D$1
> +	tmpfile=3D$(mktemp)

[Severity: Low]
Does this temporary file leak if the script aborts early? There is no
cleanup mechanism on error paths.

> =20
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile

[Severity: Medium]
If this grep finds no matches, will it exit with 1 and instantly kill the
build script under set -e?

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
Does the global nxt state bleed across sequentially processed files?

If an architecture that has syscall numbers greater than the highest number=
 in
the common table uses this script with --common-tbl, sequential processing
starts at a lower number than the end of the previous arch table, causing
this sorted order validation to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D2
