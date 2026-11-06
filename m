Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997225;
	b=gas6BPNNwqJgkkCT5j3cZq34FW33kHOKBcY4MOSNTTtuXv1TZKDx+u96gkoffw2YfzaA
	 749O6TmEACf5gsVEb63/mQJaW8RYgPd8T6l68ctVhsr/ZOuUktFzDjPqj94iRTeLwbgoG
	 2J3KzNFIsns+jEBoc7IfHMT67V82wEYXuTCa+lKWpJli0KT8CN2vJR7KR10fyBBFe4/kI
	 NxmfwVVSeM6Z5xw84LMlK/qkc0x6uZhQ92DMrEddtWzeKb+OuAb/3W+4308iW2z82kBIo
	 TV+qXAFTX52Tui87FXglU6ZfgckFEk07h0LQiEB6H2wk8GjQIi0dxhnbA2qIyb9Zpew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z6IU49XWVLXmp5ObaZtq/UrMcH0Z7jLgrOzSGwNJ8Js=;
	b=1NM/u5Faglaf0wazdVAf74MAroV4FVv5HAd9b6RgOwp3HY7O7SXR9MQWeRHNVj2at3l+
	 aoV7tNMhGYvDUUjv40OjcTo/y4YV/IBxnaGKkTZu3DyVEKfE0u/4k+xOypP6+UJwgAnLH
	 EAUWVDY+mby/ANkOYM3FTpaIGgVJugrqfoUfwWdYlv4NhmqA18yf/80ew8dxPV4wqpRCz
	 7T3WHkLuDewe9g14pL6T4Qe0La2574kjaIsDQRTF0r/AwJSUxoucy6v+IDlN5VQQ4kUQl
	 3GsYMgvGc+RxTlP7nUUtOzejulzyM8ia5cqvgeQaqJRcnpXOuJvA7J8yCgTnXIVNhEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bb7gIoiO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86B606A32E;
	Fri,  6 Nov 2026 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bb7gIoiO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E4C1F0089F;
	Fri,  6 Nov 2026 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997225;
	bh=z6IU49XWVLXmp5ObaZtq/UrMcH0Z7jLgrOzSGwNJ8Js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bb7gIoiOZuXkkfT9+xPuonQD46x1EKuHgiSdFec5DePhHr+7+PRSKdOYSkH+KBELg
	 KxZKvZeEbKB/AAjtA7Ov14SWDPpDgVKSsMpL8XOkDVH8eMheh08Xdq42A+ytun8WmC
	 lNdjMMjYRp2ye+8RdJSFx+0BoddGCdxD/EjqFq9Ne656gGesZc4ktDyyG2fuaxeTER
	 iRh++uXxP8RsBW+M3ZDXjwg4zl/LR8AjqM0QCiHFVocoBXk9UKTMo1eYndDqcGvf5d
	 YmM5q9VkDX4sKangYPRAnXM01NSO2Oodwa+ccafIpPnoHGPCtLqK9FWIIH+fdQypzv
	 s8cr5uFjOYy7Q==
Message-ID: <sashiko-outbox-202226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/15] syscalls: Avoid matching substrings in the ABI
 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Arnd Bergmanon" <arnd@arndb.de>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-13-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-13-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:44 +0000
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

commit a315ea4d793f1941d3f493720c8515e41d764ee1
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Avoid matching substrings in the ABI parsing

This commit updates the grep regular expressions in scripts/syscallhdr.sh
and scripts/syscalltbl.sh to require trailing whitespace after the ABI
pattern so that ABI names do not match as substrings, and appends "|| true"
to prevent the scripts from exiting early when grep finds no matches.

> diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
> index cf6bba3019b12..cf35ff05b8242 100755
> --- a/scripts/syscallhdr.sh
> +++ b/scripts/syscallhdr.sh
> @@ -109,7 +109,7 @@ gen_hdr() {
>  	tmpfile=3D$(mktemp)
>  	offset_nr=3D$2
> =20
> -	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
> +	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis+[[:space:]]" "$input" > $tmpf=
ile || true
>  	while read nr abi name native compat; do
> =20
>  		if [ -n "$offset_nr" ]; then
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
What happens in gen_hdr() in scripts/syscallhdr.sh and gen_tbl() in
scripts/syscalltbl.sh when --abis is not passed on the command line?

Both scripts initialize abis to an empty string by default when --abis is
omitted:

    # default unless specified by options
    abis=3D

Architectures such as m68k, microblaze, sh, and xtensa invoke syscallhdr.sh
and syscalltbl.sh without --abis, for example in
arch/m68k/kernel/syscalls/Makefile:

    cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --emit-nr $< $@

    quiet_cmd_systbl =3D SYSTBL  $@
          cmd_systbl =3D $(CONFIG_SHELL) $(systbl) $< $@

When abis is empty, the pattern in gen_hdr() and gen_tbl() expands to:

    ^[0-9A-Fa-fXx]+[[:space:]]++[[:space:]]

Because there is no subpattern to match the ABI column (such as common) and
the syscall number is separated from the ABI name by a single tab character,
grep matches zero lines (or rejects ++ as an invalid ERE repetition). With
"|| true" suppressing the non-zero exit status from grep, wouldn't gen_hdr()
and gen_tbl() read an empty tmpfile and silently generate empty syscall
headers and syscall tables for those architectures?

Also, when --abis is specified, the option parser constructs a parenthesized
group:

    --abis)
        abis=3D"($(echo "${2%,}" | tr ',' '|'))"

Writing "$abis+[[:space:]]" places the "+" quantifier on the "$abis" group
rather than on "[[:space:]]", expanding to "(abc)+[[:space:]]" or
"(common|64)+[[:space:]]", which matches repeated or concatenated ABI names
such as "abcabc" or "common64".

Should abis instead default to a pattern that matches any non-whitespace
token (such as "[^[:space:]]+"), or should the "[[:space:]]+" suffix be
included inside abis only when --abis is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D13
