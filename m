Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206225;
	b=IyIEgxDPvBKC7HFhwfbiuEiU6p0ZgJoQ0hTGJuI1cx3RrJ6Q1Xpi8AD26zL/Wowpshww
	 zFH/pnX3zKrsF0TpPndWTEVKdQf0A4cPPyDOUEghAIDYjXH8jlBbq48MUs8YtSwwAan5U
	 287Do+zCK8ow346FwlXWv+YFT3GHBS3nWjfmoDswbAY6imqHIkqd+MkUFZLu8fI5XtHR+
	 5cus7Cmq/ND8y6CYbOgoKZqR2ohxNmbWLCWv9RRf6SrLDlJ1ShDYEmbOeK6iBCLbl9DrQ
	 xcxbXg9DxpO7c6QIk5jOEhkbz2YK6a5TmRjrkiM2VIlToO1RoShh80zUkLjTXdhxOUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KEYiBc1XjEbR3CQxbZcQGPLYtP8W2IuZQxHxW8BKFwM=;
	b=lhhuIoV5kdDToc/wNmm9cuj0Lss87Ad15piHVhdc9u1H3cGj3AgJviFlp5P2GonH6aPH
	 j35sJyEAFZh4LMo4hRrMvIkP3DnjGRRRvW4KCX6jbDE71uT3fFXihcX+cvuT2delKB4SJ
	 M3ELFFbCL6w6arCX7qcijzSROjJVL0o0xNPTQ6AUPRNTrKSzDnlCbKh0LRnLv4ZkA7ZO8
	 SpN5QHbe7CznRvrZFtiIaMkWBMFU922kc46Twij+MwVoA5FXkztxHAJgPcHp6cFqWIzbn
	 vXBcz/SdOHYpTXKlsmYLCD48AwD5weQ4lVdKZhyx4L3FWjPor65VSlV2kiZuTcxf7tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atpT7sro;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087DF606A320;
	Fri, 20 Nov 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atpT7sro
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96701F000C0;
	Fri, 20 Nov 2026 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206224;
	bh=KEYiBc1XjEbR3CQxbZcQGPLYtP8W2IuZQxHxW8BKFwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atpT7sro8YgB0dHVBt8x703ctb2QCvDseefAX2YTskJZpofRPJO37A3OXtGiK/gON
	 afNq/anjdZRaNfeBaIoGoego3qFaJkF6Xqi7MjyiTNhzi6d36LckyqrVllCwdzaDR7
	 38iASBnxST8iQDnvWHUWgWPFJvnqs/fMKSOF8/K7b/FWXvBqKqBg010P94qaYs5RiI
	 tDLluATlCL93N3k35RWtZc1mOBzcE8UUgBM7zYyO2GkwHfLSOgg5PUQd73woIkA5cL
	 coI3IfnDcTsbZtXfLvyut0alo5WOtDZHxnODsyusML/k0zvmRcpl5VDRdvDKic5THx
	 0Zj9EK0h6V6rw==
Message-ID: <sashiko-outbox-226043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/16] syscalls: Create unified partial table for
 all archs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Arnd Bergmanon" <arnd@arndb.de>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, linux-perf-users@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Magnus Lindholm" <linmag7@gmail.com>, nathan@kernel.org, nsc@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119-tonyk-syscall_table-v10-2-a7c9ebd900f6@igalia.com>
References: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
 <20261119-tonyk-syscall_table-v10-2-a7c9ebd900f6@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:23:43 +0000
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
- [Low] syscalls: inaccurate comments for ABI names and emit_nr()
  parameter order
--

commit c623dfa13f12a7f67002b068bc004d808cd6477b
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Create unified partial table for all archs

This commit adds scripts/syscall_common.tbl for syscall numbers shared acro=
ss
architectures and updates scripts/syscallhdr.sh and scripts/syscalltbl.sh to
accept a --common-tbl option.

> diff --git a/scripts/syscall_common.tbl b/scripts/syscall_common.tbl
> new file mode 100644
> index 0000000000000..8085030eb869e
> --- /dev/null
> +++ b/scripts/syscall_common.tbl
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> +#
> +# syscall numbers shared by all architectures
> +#
> +# The format is:
> +# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
> +#
> +# The abi can be "32", "clone3", "__cln3" and "memfd_secret"
> +#
> +# clone3 stands for the common clone3 entry, used by most archs. Some ar=
chs have
> +# their special entry and should use "__clone3".

[ ... ]

> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> index bad1ab606a0fb..8f7dfcf19a4c5 100755
> --- a/scripts/syscallhdr.sh
> +++ b/scripts/syscallhdr.sh

[ ... ]

> @@ -69,13 +76,35 @@ guard=3D_UAPI_ASM_$(basename "$outfile" |
>  	sed -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
>  	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g')
> =20
> -grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$infile" | {
> +emit_start_guard() {
>  	echo "#ifndef $guard"
>  	echo "#define $guard"
>  	echo
> +}
> +
> +# emit_nr(prefix, nr)
> +emit_nr() {
> +	local nr=3D$1
> +	local prefix=3D$2

[Severity: Low]
In scripts/syscall_common.tbl, the header comment lists "__cln3" instead of
"__clone3" and omits the "common" ABI used by most entries in the table.
Also, in scripts/syscallhdr.sh, the comment above emit_nr() documents the
arguments as (prefix, nr), whereas emit_nr() takes nr as $1 and prefix as $=
2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-tonyk-sysc=
all_table-v10-0-a7c9ebd900f6@igalia.com?part=3D2
