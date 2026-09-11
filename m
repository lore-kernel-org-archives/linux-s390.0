Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850E406804
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121543; cv=none; b=UtfXh04L5GiE1PnH0RA7GR9ZcHyakAbyZRoe0hNYrVPHpYkqtnxi2WOg0bwKVJCSFuS3H7AxwP4Xn9fyvwMvPXZkHMXHZeeFuaiHvbimFFU/MrcL+vdtwOJ0N4yld6zELVxTdAT2X5Jxo+s/5lvJdFscSZlHaZOyqgx5ACgthzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121543; c=relaxed/simple;
	bh=s71JqJxflMdvVXIcnsxkNxgmxhFiwmWEyOuncAIiU2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L/CrvsEUBYM+FRlarxszeAuWhH5f9sdYju2g9xexQPfQ5Ajom8kfwKABAC2UG0bOyHqJJl8G+q/F0XXd6rDW6tuprz0Njn9vBeBlAqw6zp2DbZjV98n1FY315wtY8n7h5kutN7s9W96lzT4lmRYyOBcFAKjPgQJcTfYM5LmHpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScRxq6vy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScRxq6vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BE01F000FF;
	Fri, 11 Sep 2026 10:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789121542;
	bh=JXc4XgNfHMDPGXJrtAxTniw9hlcBfY+orpqqRxTBjOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ScRxq6vyZqHgvAh3NZnx5sPOYlI7gjQCsOJ+03KP+dBnpsFsAsOwWeuBT+6AedFQ8
	 VyMxlJDYFjia02aUXydqtrjGrFy72QnYKuqdcMofWeXNpcZLoYIj5qdyJm6q+O6ASC
	 mlG9sj6WJyJyScR0XWPPzV+Y5wvg84PTqbfzcxqwCLmbw1m5bfyvze5BhfoA6PwrNg
	 5x+r1UTBpdR6dQopqa3HbOVNcZnF6ccCOqmQ6Lj83K5a0LOgPrxH9lexy8goZeddrf
	 ewqoiwsR+i6bZH+TzCH98prNWZkzJ8B20A5/aH1ncQxNSVzOOv8aCTUi0QMMzW0R85
	 g/eNxw4nGX2TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH ping2 linux-next] perf test: probe_vfs_getname add
 do_getname() probing fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260911100455.2131629-1-tmricht@linux.ibm.com>
References: <20260911100455.2131629-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 10:12:21 +0000
Message-Id: <20260911101221.A4BE01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The fallback probe for `do_getname` incorrectly uses `result->in=
ame:string` instead of `result->name:string`, leading to string truncation =
or out-of-bounds reads for long filenames.
- [Medium] The new `do_getname` probe logic omits the fallback to reading t=
he user-space pointer (`filename:ustring`) if the `result` struct is optimi=
zed out by the compiler, reducing test robustness.
--

commit ad303146f8b0a504f7736915a5ea288cabae2ca8
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: probe_vfs_getname add do_getname() probing fallback

This commit extends the vfs_getname perf test to fall back to probing
do_getname() if getname_flags() cannot be probed. This accounts for
recent kernel changes that altered the getname_flags() implementation.

> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf=
/tests/shell/lib/probe_vfs_getname.sh
> index 88cd0e26d5f67..9156a79212b9e 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh

[ ... ]

> @@ -28,12 +30,24 @@ add_probe_vfs_getname() {
>  			line=3D$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re=
" | sed -r "s/$result_aname_re/\1/")
>  		fi
> =20
> +		if [ -z "$line" ] ; then
> +			do_getname=3D1
> +			result_iname_re=3D"[[:space:]]+([[:digit:]]+)[[:space:]]+initname\(re=
sult\);"
> +			line=3D$(perf probe -L do_getname 2>&1 | grep -E "$result_iname_re" |=
 sed -r "s/$result_iname_re/\1/")
> +		fi
> +
>  		if [ -z "$line" ] ; then
>  			echo "Could not find probeable line"
>  			return 2
>  		fi
> =20
> -		perf probe -q       "vfs_getname=3Dgetname_flags:${line} pathname=3Dre=
sult->name:string" || \
> +		if [ "$do_getname" -eq 1 ]
> +		then
> +			param=3D"vfs_getname=3Ddo_getname:${line} pathname=3Dresult->iname:st=
ring"

[Severity: Medium]
Will tracing result->iname as a string cause out-of-bounds reads or
truncated output for long filenames?

Looking at getname_long() in fs/namei.c, when a filename >=3D
EMBEDDED_NAME_MAX is processed, a separate buffer is allocated for
name->name:

	memcpy(p, &name->iname, EMBEDDED_NAME_MAX);
	len =3D strncpy_from_user(p + EMBEDDED_NAME_MAX,
				filename + EMBEDDED_NAME_MAX,
				PATH_MAX - EMBEDDED_NAME_MAX);
	if (unlikely(len < 0))
		return len;
	if (unlikely(len =3D=3D PATH_MAX - EMBEDDED_NAME_MAX))
		return -ENAMETOOLONG;
	name->name =3D no_free_ptr(p);

This leaves name->iname completely filled without a null terminator. Should
this probe use pathname=3Dresult->name:string instead to safely handle both
short and long filenames?

> +			perf probe -q "$param" || perf probe $add_probe_verbose "$param" || r=
eturn 1

[Severity: Medium]
Does this fallback logic miss the user-space pointer retry?

The original code for getname_flags falls back to tracing the user-space
pointer (filename:ustring) if probing the result struct fails (which can
happen if the compiler optimizes the struct out).

In this new do_getname block, if the first probe fails, it retries the
exact same parameter with $add_probe_verbose rather than falling back to
pathname=3Dfilename:ustring. Can this cause spurious test failures on
environments where debug info for the result pointer is optimized out?

> +			return 0
> +		fi
> +		perf probe -q "vfs_getname=3Dgetname_flags:${line} pathname=3Dresult->=
name:string" || \
>  		perf probe $add_probe_verbose "vfs_getname=3Dgetname_flags:${line} pat=
hname=3Dfilename:ustring" || return 1
>  	fi
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911100455.2131=
629-1-tmricht@linux.ibm.com?part=3D1
