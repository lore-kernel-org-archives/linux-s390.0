Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED1494A18;
	Wed,  2 Sep 2026 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350315; cv=none; b=WND/IcEyN6GnuWPREYIVrX5IlPTjU687b/oDXAdVqqtqX0TkWhkwq2RnrMh/L2VF3OXsbkM2STQvDlhVrMEadsOUI8kdDZiecoW+ACFORHgPpg1B1yUHaZzPiRqf6iO2UhOLZgsq+ccDtdQkMv+Mh8s0v5ROp4lEljAP89bJQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350315; c=relaxed/simple;
	bh=UUfwfNqktlxtdnd2W17t9yflv2VwEb6JxVZxKsgzzpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AfRPHoSIWiUT320+TQi6Mj/w8HL3zELKLhCCC9LlpujaaS0AAmDTVdUdhgS4RGDdc8BSGsLCJnnD4X7f2DVNEqq3iwZz4V3nbOkEKVAN40Wfw6WROwFWeVKCeH80VBJjQVv7Kgy5H4vNJ+X+ZzdescKBoZ212CdH2QWaUzApBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIXsnsLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIXsnsLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EA31F00A3D;
	Wed,  2 Sep 2026 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788350299;
	bh=ZJX8Qcm+S/0Md1qb7kbd9T4ioiVOhDI24Vn5NRKV174=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TIXsnsLV+/B/D668j5bkNl78reTQK2tcK+sH9XCm4aB7tX3X5p0sjzVZ8IQRXtDDv
	 U9j/gLcPsgqGNGnWUrQYq3QAY3lJjKMRr8Bul4p9jOZ/cNeg7fdtR96HWNy5Rx//z6
	 QYXX0pf/imo+oKZVvcALRinq4pgSc4qLzYpo13ATlf32wnjrdmqGW+Z+fJR0OkulQm
	 GvRyICqVJPMYF+uh2RC9im1ajBbno8hmA1b2E6ztrYQSRqTEXVJZn4OJoQZuPWy7xn
	 et0fsNX15hV6nWF3Ww5L0XMpp/3iswCyf2YhFx1fHOg4En7KCXXN9U136G4zv+b0Dn
	 vtssUikQEeJyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: perf stat tests fails on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-perf-users@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260902115218.2977412-1-tmricht@linux.ibm.com>
References: <20260902115218.2977412-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:58:18 +0000
Message-Id: <20260902115818.D0EA31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Code Fix: Replace with `if grep -q 'No supported events found' "=
${stat_output}"; then`. Standalone `grep -q` under `set -e` causes unexpect=
ed script abort.
--

commit 4b80c04b99f0ab66b8227b70f1041582e256987c
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: perf stat tests fails on s390

This commit fixes a failure in the 'perf stat tests' on s390 z/VM by skippi=
ng
the test if the cycles and instructions events are unsupported. It checks t=
he
output of the failed perf stat command for 'No supported events found' to
determine if the test should be skipped.

> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index 298ce454b45a1..41bac99300a16 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -583,6 +583,11 @@ test_hide_zero_events_stat() {
>    # Check that --metric-only works with --hide-zero-events
>    if ! perf stat --hide-zero-events --metric-only -e instructions,cycles=
 true > "${stat_output}" 2>&1
>    then
> +    grep -q 'No supported events found' "${stat_output}"
> +    if [ $? -eq 0 ]; then

[Severity: Medium]
In test_hide_zero_events_stat(), will this standalone grep cause the script
to abort unexpectedly?

If the script is running with 'set -e' and the perf stat command fails for
any reason other than unsupported events, grep will not find a match and wi=
ll
return a non-zero exit code.

This non-zero exit directly forces a script abort, making the subsequent
'$?' condition and fallback error handlers unreachable.

Should this be combined into the if statement directly?

    if grep -q 'No supported events found' "${stat_output}"; then
        echo "Hide zero events stat test [Skipped - events not supported]"
        return
    fi

> +      echo "Hide zero events stat test [Skipped - events not supported]"
> +      return
> +    fi
>      echo "Hide zero events stat test [Failed - metric-only command faile=
d]"
>      err=3D1
>      return

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902115218.2977=
412-1-tmricht@linux.ibm.com?part=3D1
