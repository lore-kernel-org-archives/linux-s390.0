Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF41397
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787960068; cv=none; b=LwgYOyd/GJCIUugxVvDfe+sPoDgScVD/K1vWIrsIp4bKM/egGmyPQNBk3+yZ9OmkXV5tzxwPo+kWynI9+PdP/xJImE4QBXvWpak1MmfdOzDyjJhc7xqZJj2PsC2AZNH+vI0PYuOc/bzSNdDX0md/xR0Ry9AR5W9IJpRwsw5OTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787960068; c=relaxed/simple;
	bh=mPxWLCf8MNko0nKEwyDoBQDyfHUUWYqS96fK35e2+PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b3R9JbxWEV9He+B5TIC26fLBqNujfT4HMV2m4FRNOT8bHuhhY7BooOe9oxhpeClFlsOcBe6vcm7xfsYlbVYt8NeVlhrbt+q0czFKsfSuFzwkCkSqQ9k+2P4tCzO05H1O7axVh80zi4R4x6oY7cgHBkHTIRzJraj5zU3qKMgun3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+5utl7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+5utl7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100041F000E9;
	Fri, 28 Aug 2026 23:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787960067;
	bh=4zqRtqbBdijHx++seyX8g5IKP8m1nteY2C1o0btI16w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+5utl7BFXt05Nsf6CTxET8Gu2ICttFMk2YCDvT6SiCPYJSah0ES3zQ7G5h1WlvJy
	 HGaypyOT1ukavz2v8WKw5nd0fl3jNu5kgcw3yRQpBrLCyUCTWe/RIA7xzTgSIEOu2Y
	 VyZEeYs2TF+raRNS47DZlWnEJZXovg0izIzPc89bCHm7EWb2od13agq9dOS4WK8bMQ
	 NVlUSz3eZRc8fdVoazWR69VKla+FHN5zcLmR/8fc6HXkp2C8ZUrQaMfsLDkmnFipcE
	 IVRzJ7vVulkgqn2ozPYnTe3sigjFcdeiHB7NL5avonI6ibB//6RRlYJK7aJFyHelru
	 EGGlpyqqfAGnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/13] syscalls: Add an option for offsetting the
 common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-10-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-10-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:34:26 +0000
Message-Id: <20260828233427.100041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The script `scripts/syscalltbl.sh` inadvertently includes dead code=
 checking for an uninitialized `$offset` variable, which can break the buil=
d if inherited from the environment.
--

commit 4e263c69abbb8a963d9217a6ad52a5803ed295f2
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

syscalls: Add an option for offsetting the common table

This commit adds a --common-offset option to the scripts generating syscall
headers and tables. This allows the common syscall table to be offset by a
specified value. It is intended to help architectures like alpha reuse the
common table.

> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index f5b95b19ac92d..eaad7be4c3936 100755
> --- a/scripts/syscalltbl.sh
> +++ b/scripts/syscalltbl.sh
[ ... ]
> @@ -59,14 +64,23 @@ outfile=3D"$2"
> =20
>  nxt=3D0
> =20
> -# gen_tbl(infile)
> +# gen_tbl(infile, offset_nr)
>  gen_tbl() {
>  	input=3D$1
>  	tmpfile=3D$(mktemp -p .)
> +	offset_nr=3D$2
> =20
>  	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
>  	while read nr abi name native compat noreturn; do
> =20
> +                if [ -n "$offset_nr" ]; then
> +                        nr=3D$((nr + offset_nr))
> +                fi
> +
> +		if [ -n "$offset" ]; then
> +			nr=3D"($offset + $nr)"
> +		fi

[Severity: Low]
Does this code inadvertently use an uninitialized $offset variable?

The script scripts/syscalltbl.sh does not initialize the $offset variable
like scripts/syscallhdr.sh does. If an offset environment variable happens
to be exported by the user or CI, this condition evaluates to true, and nr
is modified into a string.

The subsequent check [ $nxt -gt $nr ] strictly requires an integer and would
fail with a shell syntax error, halting the build.

Was this block copied from scripts/syscallhdr.sh by mistake?

> +
>  		if [ $nxt -gt $nr ]; then
>  			echo "error: $input: syscall table is not sorted or duplicates the sa=
me syscall number" >&2
>  			exit 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D10
