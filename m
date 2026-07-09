Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7453D75C2;
	Thu,  9 Jul 2026 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578977; cv=none; b=PCtSKI+fMAKJyP/wrQFd6yU4Ovca7WoUYowZ9LzzbQsGML8+m2p1nuNsNQbaA/6qvB6a54aQRnIAluPlXvWHsYySLy7EU++qgUHMH2UYeW29Z+s1jKV9cj3/HYChC1AziRzAuKbOHFsr+cIAzGoZoEDlDg5nbQ/fyKEMbcxudvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578977; c=relaxed/simple;
	bh=hIKd/yYXx8ic1qCFRpxBNFQ+yyfryDF+DAlRXXXmY5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCHVUCc9kk6R8XZAdarozsuju/3ZbEqYvz/jsrhIVri5gLUj1lcInuEDuO7ZdD37E5JRFoGRAr6qCOZ3o+E2YO9p2rljJZyjjyXIZ+7IWqBIvsqyejbLy15aXbcdJk2m0dcXMyaBcQueRkwD7rV5G3aJOLojC7KXHK7lE/avJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmt6ShrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmt6ShrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DCC1F000E9;
	Thu,  9 Jul 2026 06:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783578966;
	bh=XFVw/ud5gV5sJPHi7cyqYaqLPYoS2/nf/WgIyDkET4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dmt6ShrD03rRtBSVUSOfFit2NhGzQF4AZ63P59HPPT6BXv3c13mhLY91dNHKC5KIy
	 TSm11DtTFvvaOalErsEHHaKeJOHyoutL/6D4OmmVF4ugmuidOm8znCfStHDsDL/S5k
	 N4liV9xI34h2KJR6IF3067qscAa8wpaNMapgbUFzYIIJDmcuo8Hn+T8aAK78aqBu7W
	 15TTF7jf6aNtnZakUELxtu5QJTfl+y2hij9W0rIO9w1rWYzGqrHPE2BPByYRY2UeVf
	 s5tbYRX78RECcSM/8BXk6cNewP7QPtqGYGgqeMScw/m/CGhZaz+81nJv4GqH0ZDsaG
	 yPHeSarc9tT+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: perftool-testsuite-report fails on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260709062724.2663228-1-tmricht@linux.ibm.com>
References: <20260709062724.2663228-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:36:05 +0000
Message-Id: <20260709063606.53DCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized variable `perf_config_tmp` is passed to `rm -f`, l=
eading to potential arbitrary file deletion via environment variable inject=
ion.
--

--- Patch [1]: [PATCH] perf test: perftool-testsuite-report fails on s390 -=
--
commit dcb55bb63ed0f15c0433bf20e85a5b7ffe77aedd
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: perftool-testsuite-report fails on s390

This commit fixes a test failure on s390 by creating a temporary perf
configuration file that disables addr2line warnings, working around a
timeout issue.

> diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/=
perf/tests/shell/perftool-testsuite_report.sh
> index a8cf75b4e77ec..997573f0e74c5 100755
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

[ ... ]

> @@ -19,5 +27,6 @@ if ! [ "$PERFTEST_KEEP_LOGS" =3D "y" ]; then
>  	rm -rf "$PERFSUITE_RUN_DIR"
>  fi
> =20
> +rm -f "${perf_config_tmp}"

[Severity: Medium]
Is it possible for perf_config_tmp to be read from the environment on
non-s390x architectures?

Since perf_config_tmp is only initialized inside the s390x if-block above,
if this script runs on another architecture, the variable remains
uninitialized locally. Could an inherited environment variable of the same
name cause an unintended file to be deleted here?

Additionally, executing rm -f "" on non-s390x systems is sloppy and can
sometimes produce spurious errors depending on the rm implementation. Would
it be better to unconditionally initialize the variable to empty at the sta=
rt
of the script, or check if it is set before calling rm?

>  test $status -ne 0 && exit 1
>  exit 0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709062724.2663=
228-1-tmricht@linux.ibm.com?part=3D1
