Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C633F8AD;
	Sat, 28 Feb 2026 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299973; cv=none; b=PhIVgU0AKKesETrwqh7D9k2nLyKJKQqT6MbmVs6zhIy2BoExosWbtPL/yydIwQk1aJ88tCMr/aVMp/JqNOj2+jM2kg0BXkkQLGxRDeE27W8w72MGm/EM0rkHJo4qg3EDD2irf1B9A1mhe3pC8jQrot8Klrjxn1lri3dB+AbaSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299973; c=relaxed/simple;
	bh=fCv7ZEH1PEoB19yCk3SZZ78NeJRkIno69JE/9P62NwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L35HhHdHzyXqIJBMZLXIKFJpLrqwUHfz25eNGQ3eTI3xMswuDKtRI7533ZyUvn0kbqwE3XZWgldUykeRAxdxNtUr7j3M+fQYLs+N++4ilvVfENMY6HvTS0vPlyJjRvee1TY2YdlHk0kTbWT/qCNg8m5CfL19XWYHr6Tq/2AiYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQvclS1z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQvclS1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E26DC116D0;
	Sat, 28 Feb 2026 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299973;
	bh=fCv7ZEH1PEoB19yCk3SZZ78NeJRkIno69JE/9P62NwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQvclS1z0PeYriOeXdsrEOzIbGd5/wgJb1aQ18SLgAWDC3M2MqHnVz4j2Br2+wcSh
	 RPq8Xq4mTq98NudwDgWXzaWZ16l/Qa+S0PxI4/lcnj5T/PWJcer1gtb9y33CxlSp+w
	 a+mYeUA7c2WNl123KqHeF3iC29mERf7u+qg0R8h1mDXkWZm8ZP5n92kKshWhiRyupv
	 O7ByBUxraRMf6SC20hvGVcAMfX1KUk8Qck3wMzjyZjEuhyzpb7exkJA5fNXNbrAAve
	 2+AKJiHGqnbm4tADOf+mDvxKmSO3F+eAypMcdyg1a3NXKp4fV5ckm46E9hLqgmWgwO
	 8fEESOhfEp4oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Polensky <japo@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 005/844] perf test stat tests: Fix for virtualized machines
Date: Sat, 28 Feb 2026 12:18:38 -0500
Message-ID: <20260228173244.1509663-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit e272628902c1c96731e2d9f62a7fc77767686eb0 ]

On s390 'perf test's 'perf stat tests', subtest test_hybrid fails for
z/VM systems.  The root cause is this statement:

  $(perf stat -a -- sleep 0.1 2>&1 |\
                  grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]* -c)

The 'perf stat' output on a s390 z/VM system is

  # perf stat -a -- sleep 0.1 2>&1
  Performance counter stats for 'system wide':

        56      context-switches  #     46.3 cs/sec  cs_per_second
  1,210.41 msec cpu-clock         #     11.9 CPUs  CPUs_utilized
        12      cpu-migrations    #      9.9 migrations/sec ...
        81      page-faults       #     66.9 faults/sec ...

        0.100891009 seconds time elapsed

The grep command does not match any single line and exits with error
code 1.

As the bash script is executed with 'set -e', it aborts with the first
error code being non-zero.

Fix this and use 'wc -l' to count matching lines instead of 'grep ... -c'.

Output before:

  # perf test 102
  102: perf stat tests                      : FAILED!
  #

Output after:

  # perf test 102
  102: perf stat tests                      : Ok
  #

Fixes: bb6e7cb11d97ce19 ("perf tools: Add fallback for exclude_guest")
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/stat.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 0b2f0f88ca166..792a0b79f6b86 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -233,7 +233,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  "  | wc -l)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.51.0

