Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FE395D8B
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556952; cv=none; b=bf34FLzphRE5tZ+JJuKIWp6kRFI+bcph3jWnu+19gvY4INU087AR6J+qPLi0Q3CbWDvKJtF4DRz+hDYK3Rw0rgTqtSY/A7Oh0BLI7Q4SFQcx79MdC2GrrnCfFMtjvkhrfgi/uOgT+5pOMB/0LtGaQE5UW+fsLXWAijG7o7U5qqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556952; c=relaxed/simple;
	bh=Zc4/mOblbRWn3CSZCdaYYlJKm3oEABbvH/UvuNVMHHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tQIcb4Hu0y7OI8Km4ChBm+Z1nJQxnrKmYXLet0IruwpM+1/UqORf/Mzw5c15maI6knxAWdL1XJK+BMSoJmc7h9Ywss2u55T42ofni1+L2U6V9S2EzmY61LS5N7oI7tnjnRObYF/i97ACZJlOUp1A2+EB4Vc4XJb5BDrGy/HG168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYu85xb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYu85xb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196D61F000E9;
	Wed, 12 Aug 2026 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556950;
	bh=TXu+as0S70J8fqm0gxE5kNNRp1HsvVY/Mas7WdeGTZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FYu85xb8/u6nXkyeJKv4Mbp4Nrex57Idu1HggSiO11wUNM4IyjDsA2AmIXqviaJ5F
	 HKknO4HTW0tQ9WYFD2+YmCiyzTpFd6Uv4uXQjaZiiQTh3eWntJvrT2+qHNzuSLZaMo
	 vp+NSeEC/SX8Ba3lFtnyhJpsT3NHGS7csPrNMZCHoblV9ORiNkVny7xCAeYmmZKkST
	 kxyKBoJL+BDx7cGGyS3XW34uwnjxaWeVuslVssgHU6NwH2aKH3WtQ1rr1ml1MAzK97
	 lRtRwpEf9oRgOg7TkGK+LRsHUi8yT/yELemGY2ASJLYaB1IuLROu8N6h+BFypLg7nb
	 kHh+vHX8IiGqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/13] syscalls: Create unified partial table for all
 archs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-2-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-2-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:49:09 +0000
Message-Id: <20260812174910.196D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The use of bash process substitution `< <(...)` in a `#!/bin/sh` s=
cript will cause syntax errors on systems using strict POSIX shells like `d=
ash`.
--

--- Patch [2]: [PATCH v5 02/13] syscalls: Create unified partial table for =
all archs ---
commit 47d67094b1a192ac92926cb745138546b214b614
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Create unified partial table for all archs

This commit introduces a shared syscall table for system calls common to all
architectures. It also modifies the generation scripts to support combining=
 a
main table with the common table.

> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> index bad1ab606a0fb..54e09d3e686c4 100755
> --- a/scripts/syscallhdr.sh
> +++ b/scripts/syscallhdr.sh

[ ... ]

> @@ -84,15 +111,20 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$infile"=
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
> +	done < <(grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input")

[Severity: High]
Does this < <(...) process substitution in gen_hdr() break POSIX shell
compatibility?

Because this script is executed with #!/bin/sh, using bashisms like < <(...)
will cause a syntax error on systems where /bin/sh is a strict POSIX shell
like dash, breaking the build.

> +}
> =20

[ ... ]

> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index c4b1f85c2dd63..91c135143b22f 100755
> --- a/scripts/syscalltbl.sh
> +++ b/scripts/syscalltbl.sh

[ ... ]

> @@ -88,5 +97,13 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
>  			echo "__SYSCALL($nr, sys_ni_syscall)"
>  		fi
>  		nxt=3D$((nr + 1))
> -	done
> -} > "$outfile"
> +
> +	done < <(grep -E "^[0-9]+[[:space:]]+$abis" "$input")

[Severity: High]
Similarly, does this process substitution in gen_tbl() cause a syntax error=
 on
dash or other strict POSIX shells?

> +
> +}
> +
> +gen_tbl $infile  > "$outfile"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D2
