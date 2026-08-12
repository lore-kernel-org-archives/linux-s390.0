Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED27147425C
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557418; cv=none; b=oplJaKK6dQKBqW7D4EuBj8nDpJNd0Uxd+emfMDJYqMxS+hlpsTlZ3rGOZOHn2HzUPrE9Iw3QklQZXhaEl32wu3DCc6q+2BJ2MWsFQWZkpUk1X743pLIkw2NftfIiH+outR5ckKSg0RVCQF2vqVKZztZnHq10oQ+/yTtB8daDY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557418; c=relaxed/simple;
	bh=5YpLh65P/vp6FtoUkOO5suISNPuZmP3839Gukoly+nE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cjExGI+jRBQBtQzoObh8Rpvv5FBEaX24Jj5e2AtOVoGMo4c+wi8oyaJeAiFfX4Aqe/Z8a4wasaGbq+WASqWKiNjZABrhMKUQaZ8Bs752INt64YSHlG6E85EBBekk44lQYd8rD27KpOQOe2L+mBjab6FI6gWe8Q41EHAoNQAeLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn3GnC11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn3GnC11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE8D1F000E9;
	Wed, 12 Aug 2026 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557416;
	bh=MKaqF6Wf0mS++/cQkiBGsqVfzIKtE0J95LPd7kla/Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mn3GnC112MZa2RSXSQVPlAtR2Vdn/E0pPAKQGiTaIdGpT4NzaNuDzyzvB/j3+yK5q
	 ynAeCJ6jOzbBLz+XTC1LR5Mp9n7tM1JVQDS5NsWvoOahWSi7jPG1d4YD0p9Dc0/oHU
	 7Gn1vnIhv5rLmWZWmMe+D8PlCpOYwSvsC9d2s/05fm326IslbZN+F677MLXEzwN3qe
	 NWtQXC0rW9msSzhh1Q5RZ3KHU9upOzLQ7r/EE48pN6sys1E0F4icjn7tdWXFuRI6UD
	 zQ9etFQmAk8mM9FHtTXY4odX/uUO6KqSuXtvIBJU4hB/UXI6Y8DgktELarh3yHJEV9
	 WbZNguQRRHOAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/13] syscalls: Add an option for offsetting the
 common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-10-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-10-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:56:55 +0000
Message-Id: <20260812175656.1BE8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The __NR_syscalls macro is calculated incorrectly when --common-of=
fset is used, leading to a severely truncated syscall table bound.
- [Low] Dead and potentially dangerous code block referencing an undefined =
`offset` variable in `syscalltbl.sh` due to a copy-paste error.
- [Low] Inconsistent indentation in `syscalltbl.sh` using spaces instead of=
 tabs.
--

--- Patch [10]: [PATCH v5 10/13] syscalls: Add an option for offsetting the=
 common table ---
commit ca05bec6578b785868c677c2b401096b6deb225e
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Add an option for offsetting the common table

This commit adds a new --common-offset option to the syscall header and tab=
le
generation scripts. It allows shifting the syscall numbers for a common tab=
le
by a given value, facilitating reuse for architectures like alpha.

> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> index 54e09d3e686c4..ce6819111c27d 100755
> --- a/scripts/syscallhdr.sh
> +++ b/scripts/syscallhdr.sh

[ ... ]

> @@ -98,18 +103,24 @@ emit_end_guard() {
>  }
> =20
>  max=3D0
> -# gen_hdr(infile)
> +# gen_hdr(infile, offset_nr)
>  gen_hdr() {
>  	input=3D$1
> +	offset_nr=3D$2
> =20
>  	while read nr abi name native compat; do
> =20
>  		max=3D$nr
> =20
> +		if [ -n "$offset_nr" ]; then
> +			nr=3D$((nr + offset_nr))
> +		fi

[Severity: High]
Will max be assigned the un-offset syscall number before the offset is
applied?

If max is calculated before the addition, the ultimately emitted __NR_sysca=
lls
macro could be smaller than the highest offsetted syscall number. Architect=
ures
using this to size their syscall tables or bound-check userspace calls might
reject valid syscalls.

> +
>  		if [ -n "$offset" ]; then
>  			nr=3D"($offset + $nr)"
>  		fi
> =20

[ ... ]

> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index 91c135143b22f..aea00834dd5ab 100755
> --- a/scripts/syscalltbl.sh
> +++ b/scripts/syscalltbl.sh

[ ... ]

> @@ -59,12 +64,21 @@ outfile=3D"$2"
> =20
>  nxt=3D0
> =20
> -# gen_tbl(infile)
> +# gen_tbl(infile, offset_nr)
>  gen_tbl() {
>  	input=3D$1
> +	offset_nr=3D$2
> =20
>  	while read nr abi name native compat noreturn; do
> =20
> +                if [ -n "$offset_nr" ]; then
> +                        nr=3D$((nr + offset_nr))
> +                fi

[Severity: Low]
This isn't a bug, but it looks like these lines are indented with spaces
instead of tabs. The surrounding script appears to use tabs.

> +
> +		if [ -n "$offset" ]; then
> +			nr=3D"($offset + $nr)"
> +		fi

[Severity: Low]
Is the offset variable defined in syscalltbl.sh?

It looks like the --offset argument is parsed in syscallhdr.sh but not in t=
his
script. If an environment variable named offset happens to be set in the bu=
ild
shell, could this cause a bash syntax error when injected into the arithmet=
ic
context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D10
