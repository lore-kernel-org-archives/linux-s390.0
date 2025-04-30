Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5625D541;
	Wed, 30 Apr 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017818; cv=none; b=uhSIXx9aDtwl4ey61yfhxd9HD4qCSTPjXSckgOM03ziiA+g3+6sI/mDDtY+pKV0IFyUX4azjlwnk2FBy9JguonfPkjErDq464kA9Odrk9DjtO25xfenPrie5wzi/lLuIJjDC28S+EbeGYdldZmDMink1GCG2pYwMcJOutMzTYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017818; c=relaxed/simple;
	bh=uLcVteZSPDqe2u74CAvMKYQO5qHTff2Fkb3KFWwvD4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBz1Jp8mGt0E11bzFEVPrAKgVOFxKk052nAAWNmF7ncMi8EJhijQkMFiAp+jCWdknENZLtpob4XrMznAS6eiotgyfuK9lv/SMZmtYdjlxqNAy9fIjV9a5BqyY/Qd+9B71mIVb6pCIeUGW99zeWvqZinXcD3M4V4hyynt33Tu1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxzW83SP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxzW83SP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDA1C4CEE9;
	Wed, 30 Apr 2025 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746017817;
	bh=uLcVteZSPDqe2u74CAvMKYQO5qHTff2Fkb3KFWwvD4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxzW83SPf9ZZ4HFymch8b/+BMURaYyGgCYmOxJVXagSIhyQoSBlovI8WWsTUDRrir
	 E1UVkInW31z9/Davm3uR30FvsKSVTNsA4CnXtdPuFlPkfWYExc2HjBG+QexyPJtRXZ
	 jqJ9QZFz4emaAubh4vCZF4/5fAR5CDpY9ZorbPgtK10rP8MXJuDW41JKaVOR5xBs9+
	 LGU2tOGEmUE67eBZ6WgGrCzim01goK/ZPPadEunbAnhJyGLoBNsooezwExFafNJwCg
	 72klqPkgk3nqcNihBLuSk04VqJPxIPpJ+LmzQmy1rPtCSElK+fcbgYXRF87Qvs6G1H
	 qJJ3haj51R9fw==
Date: Wed, 30 Apr 2025 09:56:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	ctshao@google.com, irogers@google.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PING PATCH v3] perf test: Allow tolerance for leader sampling
 test
Message-ID: <aBIeFio2nkbzFj0b@x1>
References: <20250422110643.2900090-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422110643.2900090-1-tmricht@linux.ibm.com>

On Tue, Apr 22, 2025 at 01:06:43PM +0200, Thomas Richter wrote:
> V3: Added check for missing samples as suggested by Chun-Tse.
> V2: Changed bc invocation to return 0 on success and 1 on error.
 
> There is a known issue that the leader sampling is inconsistent, since
> throttle only affect leader, not the slave. The detail is in [1]. To
> maintain test coverage, this patch sets a tolerance rate of 80% to
> accommodate the throttled samples and prevent test failures due to
> throttling.
 
> [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

This doesn't apply to perf-tools-next:

⬢ [acme@toolbx perf-tools-next]$        git am ./v3_20250422_tmricht_perf_test_allow_tolerance_for_leader_sampling_test.mbx
Applying: perf test: Allow tolerance for leader sampling test
error: patch failed: tools/perf/tests/shell/record.sh:238
error: tools/perf/tests/shell/record.sh: patch does not apply
Patch failed at 0001 perf test: Allow tolerance for leader sampling test
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next]$

Are you proposing this for perf-tools, i.e. for this release cycles?

Namhyung, what do you think?

I think it is not applying in perf-tools-next due to this patch that
isn't in perf-tools:

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -5 perf-tools-next/perf-tools-next tools/perf/tests/shell/record.sh
be8aefad33760dd8 perf tests record: Cleanup improvements <<<<<<<<<<<<<<<<<<<<<<<<<<<<
90d97674d4ad0166 perf test: Use cycles event in perf record test for leader_sampling
859199431d768091 perf test: Fix perf record test for precise_max
180fd0c1eac7cd8c perf tests: Make leader sampling test work without branch event
2532be3d219d8819 perf test: Tag parallel failing shell tests with "(exclusive)"
⬢ [acme@toolbx perf-tools-next]$

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -5 perf-tools/perf-tools tools/perf/tests/shell/record.sh
90d97674d4ad0166 perf test: Use cycles event in perf record test for leader_sampling
859199431d768091 perf test: Fix perf record test for precise_max
180fd0c1eac7cd8c perf tests: Make leader sampling test work without branch event
2532be3d219d8819 perf test: Tag parallel failing shell tests with "(exclusive)"
36fae9f93e5f00eb perf test: Add precise_max subtest to the perf record shell test
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
