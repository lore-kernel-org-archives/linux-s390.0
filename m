Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A56367F3D;
	Mon, 29 Jun 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731572; cv=none; b=T/vSXYJqoAo+hl7ITkECxoNiEfIc8fVWq3Px9SXRp5IH9Is6Yvc+ifIemcAJgfg6RYUS1DNa4VzouLx6nvWYdv40vOdx5zoiwywwQUILNYwaTQZvYh6P1Wnh9/H5xzUCFAGlL6LK3mvbK1MG2I1DL09cS9bgoHbek8TgNjpbdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731572; c=relaxed/simple;
	bh=UaLVnCW0bh1fFtDkIdk6yIQF4UJRzKaXoycfeOauR5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V5trmjiGZ1lxDJrzNPZejQuZQxjOhpuiCRoIUqMwoAfsp/L1BzCvypVEdnQ6yYN+CiE1Pwk8LNuKrVwqSJj6PfW0P8szxKR/9zc+PDJ4y3uWfTity8NpRHjdypSG6E/bgikGN29WFMaoZOOJYYGNIvqH7JXAF9dv6hM/B1tmpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+Pq5SBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+Pq5SBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0441F000E9;
	Mon, 29 Jun 2026 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782731571;
	bh=Z0bF1K3hnvCJDpOSmbIFKXZAiSiuT7COVZlBiPHamEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+Pq5SBG+U+hWRwQs11VCz7drFA1SzRMYHTGEGOiEX59i4h6hVv3sgvGQ8SXzl9UR
	 6Np+CQT3bWrs429OtrWomznmH1eUd8dUCaLBm1xcfvxLgtEjdPPDvRJgl6+HHpa4V2
	 Z5+EyvPOeMVsl07w/BT71nLaYWH+Pifb33PhCz6X5qtUGwWF4+5z4+TTU51+yoi209
	 39RmrJF9JBdrPM713CMlpUoK3DR5Dljw547YkA72idHXmX/NsfODZCrm+LR3tQ8FqV
	 +8G8ScliPaOvLc8EAVWAiCcCiXOsIU2htAtpOn1S81Sn7Kri4pq8o551gI5F1jw/dR
	 FI+HFb6MbPk3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 linux-next] perf test: Skip failing 'perf test aslr'
 test case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20260629110559.1283453-1-tmricht@linux.ibm.com>
References: <20260629110559.1283453-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 11:12:50 +0000
Message-Id: <20260629111251.0E0441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Commit message contradicts script behavior regarding test skip e=
xit code, hiding skipped status from the test runner.
--

commit 0ec9bd8ca22ab0ece501382558440bfde5e6fdd0
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: Skip failing 'perf test aslr' test case

This commit addresses a failure in the 'perf test aslr' test case on s390
due to missing dwarf call-graph support in perf inject. It modifies
the script to drop the stack user sample and emit a skip message instead of
failing.

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> index c00461828ea79..d83c2591db8f6 100755
> --- a/tools/perf/tests/shell/inject_aslr.sh
> +++ b/tools/perf/tests/shell/inject_aslr.sh
> @@ -135,8 +135,14 @@ test_callchain_aslr() {
>      echo "Callchain ASLR test [Failed - no noploop samples in original f=
ile]"
>      err=3D1
>    elif [ -z "$new_addr" ]; then
> -    echo "Callchain ASLR test [Failed - could not find remapped address]"
> -    err=3D1
> +    if perf evlist -v -i "${data}" | grep -q 'sample_type:.*STACK_USER';=
 then
> +      echo "Dropping stack user sample as possible ASLR leak"
> +      echo "Call-graph dwarf not supported with 'perf inject --aslr'"
> +      echo "Callchain ASLR test [Skip]"

[Severity: Medium]
The commit message states "Since one subtest is skipped, the complete test =
is
reported as skipped." However, it appears err is not set to 2 (the standard=
 skip
code) here, meaning the script will exit with 0 (Ok) rather than being repo=
rted
as skipped by the test runner.

If setting err=3D2 was intentionally avoided because the script's cleanup
function currently assumes any non-zero exit code is a failure and leaves
temporary directories behind, would it be better to redesign the error
handling to support returning 2 without leaking temp files, or should the
commit message be corrected to reflect the actual exit status?

> +    else
> +      echo "Callchain ASLR test [Failed - could not find remapped addres=
s]"
> +      err=3D1
> +    fi
>    elif [ "$orig_addr" =3D "$new_addr" ]; then
>      echo "Callchain ASLR test [Failed - addresses are not remapped]"
>      err=3D1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629110559.1283=
453-1-tmricht@linux.ibm.com?part=3D1
