Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7B3D969E;
	Thu,  9 Jul 2026 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588480; cv=none; b=jb1weMakRsBUGNiFHonD5ZsfFVYmW+HkCWgJ28JyO6kLlCyl6aGk68kxVEz32P0rMx+TDlMesetya1piNBdVo0MCIAQJ1eHtQ8jPc50I2cqFfFaVkuGgIyPs2V+egop+mf+CV1mhvd+DmYbsdtt79W5t6QzFwB54fveHosytt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588480; c=relaxed/simple;
	bh=FK9bcbFAMblVTeKXIJ82R5iorqNGE6tYV/bCQ43Sl0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PYAZT9Yy0sKakH/+RXZA9xKkujcGAD7NxlxKGWu9bxG0uqOFTvg5VByQp1qS14H6pROO4Inv49DDt1JUYHlD9CPNv3Uuzl2VAfAPzhWdJ9CR5D4Tnzg3DD1V5cEHOMBXZrQNgW994tVw2JQDtaPL/e3nDmnqhqFbcWaJDwQK8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBMIqoov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBMIqoov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6FF1F000E9;
	Thu,  9 Jul 2026 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588478;
	bh=ZbAnhSTlIfNNdVKXlTdpZBHPCS7yCKYNz1qGv93qbdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OBMIqoovglu7aruLafxMkO0cxo+YSWiPrI7aheGSK+BBiVh/ZuQfWLLXfqd7L+2Jg
	 ZJvyrqDEgXkEYmNRD4l3QKJVCy7sT9155lRdMnbjZfvWIrzDkJCJVEUTInLzH30WfE
	 CjhrHSV8bcFU7ZoPd2aAN7eYq7s6yKAHWfdUA1ZyH8iMZSHIMSPoj1QblUq89UDJtf
	 zVfqIO0dvZUq/p5Jf+bRaCp7rGagikjVs5fnLpgJBfkX6qV2WBpy9lAl4RaPeEkWgP
	 gKDxAACnCxwXTu1rtrICozuOYtDvYLu1CM/GBYBR438ePuC+PTrtmtTL8C1E6Ll4CN
	 f6HgjOdsNPKNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf test: perftool-testsuite-report fails on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20260709090136.1031645-1-tmricht@linux.ibm.com>
References: <20260709090136.1031645-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 09:14:37 +0000
Message-Id: <20260709091438.3A6FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a divergent configuration state where user/=
system configurations are strictly ignored on s390x but loaded on all other=
 architectures.
--

--- Patch [1]: [PATCH v3] perf test: perftool-testsuite-report fails on s39=
0 ---
commit 01af4a3a83b9a4ed0f3f18651c07cbbbdda377c8
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: perftool-testsuite-report fails on s390

This commit modifies the perftool-testsuite-report test script to address
failures on s390 caused by addr2line timeouts. It creates a temporary
perf configuration file to disable addr2line warnings specifically on the
s390x architecture.

> diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/=
perf/tests/shell/perftool-testsuite_report.sh
> index a8cf75b4e77ec..01116f8d71ce6 100755
> --- a/tools/perf/tests/shell/perftool-testsuite_report.sh
> +++ b/tools/perf/tests/shell/perftool-testsuite_report.sh
> @@ -6,6 +6,16 @@ test -d "$(dirname "$0")/base_report" || exit 2
>  cd "$(dirname "$0")/base_report" || exit 2
>  status=3D0
> =20
> +# On s390 the default timeout for addr2line is too short, disable warnin=
gs
> +if [ $(uname -m) =3D s390x ]
> +then
> +	perf_config_tmp=3D$(mktemp /tmp/.perfconfig_XXXXX)
> +	export PERF_CONFIG=3D"${perf_config_tmp}"

[Severity: Medium]
Does this introduce a divergent configuration state between architectures?

By exporting PERF_CONFIG to a temporary file on s390x, perf is instructed
to read only that file, ignoring the user's ~/.perfconfig and system
/etc/perfconfig.

On other architectures, PERF_CONFIG is left unmodified, meaning user and
system configurations are still applied. This architectural divergence
isolates the test environment on s390x but leaves it exposed to arbitrary
user settings on other platforms.

> +	perf config 'core.addr2line-disable-warn =3D true'
> +else
> +	perf_config_tmp=3D""
> +fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709090136.1031=
645-1-tmricht@linux.ibm.com?part=3D1
