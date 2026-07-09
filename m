Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4F3C1F5B;
	Thu,  9 Jul 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582937; cv=none; b=O37Ge7yJc9zjyr9+EXWRawOTW2aDP9aOS3TU6/b0dfQMeqAbwoD/uTZIDuabI/ZOtIGD9p4ylT3oY4dTOjuKS6eLR4fefVGNq+iE7iYUfbWuYhNWZjnaKr0Q8F49QmtSzsfzJ65PR6/BNaw3fS9U5Bf7e7zDz5H+kna5ozR/HTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582937; c=relaxed/simple;
	bh=TiGN7VUSZCUiD/nMf39RROduPFOG9QGyyOxlHTG5shk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IJh+rCuVxPug1smxPHsxNFuQ9Ut8FIN197VkvlYqTmI2xWcwCJX3iBYkOurbKyixDQh1qi4SmwYuaTPIQ/IzO4xOs1DVUKl2sBBDsR28csIZrFj3SjVI9bZFa1f4XbTDGY6WB3eG74civ08//xlg/8Yu4uhV6y0gaGI70/VqtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZmCkIgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZmCkIgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594AE1F000E9;
	Thu,  9 Jul 2026 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783582935;
	bh=PcTUsyRcWz0/MptQOb6h6C538Pf85Z4mtd8pVsDuN/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZmCkIgCLUUDiJERu55D5iNyCSOHq11g8FpgOoV5oVX2fIuMCDf8LhNP8i+HgwJ9W
	 BntTNKjes038Bs665RVzUegv/H2IXXwl/5iNTtrN14wY72Hxj/5mmjgjy2TMp80B+m
	 Rdl6jRnikHYvojQAJALRJcZU4yf7i3j0sIpqXnfDGbBR1i8OEuFNOkoly8vC3P6ahA
	 QLEVl7INQK3pfRgOWNJHsuJu3P2rBDfCXZ954v7gLChcbUEdN5luRnPEyfRH7asYWC
	 fty8Gd9tjwcVinomhwHgcztP0NxCsYgS471bysD0xa7hSet2SAIf0UpFNIQpt3/W5c
	 SBUmDBgiQmgdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf test: perftool-testsuite-report fails on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709073024.3778237-1-tmricht@linux.ibm.com>
References: <20260709073024.3778237-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:42:14 +0000
Message-Id: <20260709074215.594AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized `perf_config_tmp` leads to arbitrary file deletion v=
ia environment injection on non-s390x architectures.
--

--- Patch [1]: [PATCH v2] perf test: perftool-testsuite-report fails on s39=
0 ---
commit f7fabccf09a26131ccc43cc43ec7cc1971402aa3
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: perftool-testsuite-report fails on s390

This commit addresses a timeout failure in the perftool-testsuite-report
test on s390 architectures. It creates a temporary perf configuration file
to suppress addr2line warnings specifically for s390x systems.

> diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/=
perf/tests/shell/perftool-testsuite_report.sh
> --- a/tools/perf/tests/shell/perftool-testsuite_report.sh
> +++ b/tools/perf/tests/shell/perftool-testsuite_report.sh
> @@ -6,6 +6,14 @@ test -d "$(dirname "$0")/base_report" || exit 2
>  cd "$(dirname "$0")/base_report" || exit 2
>  status=3D0
> =20
> +# On s390 the default timeout for addr2line is too short, disable warnin=
gs
> +if [ $(uname -m) =3D s390x ]
> +then
> +	perf_config_tmp=3D$(mktemp /tmp/.perfconfig_XXXXX)
> +	export PERF_CONFIG=3D"${perf_config_tmp}"
> +	perf config 'core.addr2line-disable-warn =3D true'
> +fi
> +
>  PERFSUITE_RUN_DIR=3D$(mktemp -d /tmp/"$(basename "$0" .sh)".XXX)

[ ... ]

> @@ -19,5 +27,6 @@ if ! [ "$PERFTEST_KEEP_LOGS" =3D "y" ]; then
>  	rm -rf "$PERFSUITE_RUN_DIR"
>  fi
> =20
> +[ -n "${perf_config_tmp}" ] && rm -f "${perf_config_tmp}"

[Severity: High]
Could this lead to unintended file deletion on non-s390x architectures?

Since perf_config_tmp is only conditionally initialized if the architecture
is s390x, any value passed in via the environment will be retained on other
systems.

If a user or orchestration environment sets perf_config_tmp before running
the script, this cleanup path will execute rm -f against that arbitrary
file path.

Would it be safer to explicitly initialize perf_config_tmp to an empty
string at the start of the script?

>  test $status -ne 0 && exit 1
>  exit 0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709073024.3778=
237-1-tmricht@linux.ibm.com?part=3D1
