Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930947D954;
	Sat, 28 Feb 2026 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300015; cv=none; b=rOFYeF97uNeMYk7s6tWzHG3Gd3dnegf/PY3ySpZ/tThBvcmFi3hPkIAi6CFFU1fUuNlKhvr4ORBZPkhY9QJxTgtoHXw4ql1uwIvaODMdcwqW29ZfNoo0cKp8Esin86NgQPskDuHk2fIcECKj0oDlaqAbVxALbFAIf+r1SOFohdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300015; c=relaxed/simple;
	bh=bjZvF3HoqucTEu5JA0Fv2fjutW/UGHafxWfYSwNBAoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swUQtKvp4KHquEg2S5l4TazYOq9pA3F6/arYkVWb1HMPHmEUwZsDEsqUMF4UVMbXCdcnfi+24eYJw/UUvblNxDgFmT/0dChwP8mpAdD934ieuRBd5+Vopu2wNDs67n5El2DY0I7uIdvWE9Ig4iLP3Wxl6MHeORtZS0wTXggiJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3ZnkdMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3ZnkdMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB158C2BC87;
	Sat, 28 Feb 2026 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300015;
	bh=bjZvF3HoqucTEu5JA0Fv2fjutW/UGHafxWfYSwNBAoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3ZnkdMt7cBUTvqnJNtrERsWlS0JgGXC5nSZNtjcsyvNkveM/5Oa8pLRCUe7TDIQs
	 +w8ttn/gH40YUA0DkTofcJi2eE/eMWmBnJZmtwvVMNnEkM+vgKmtwF30D3CoSLblsW
	 fNIeTAJkSvKOFfFEBujlNCIzFJpbdIChKYqhx15qZyAcqJbM+sjmNdYsll6qxl14Z9
	 WHbPtGIF70uYMIGYVL/6rcWHfC2J7jUCctwnpwKrygZvxB/WvQI67abn/5cnYF5fzS
	 rwqw+bNGm4vgzjC3Gv3JvKw3gGEBZNZbs3mA9lzahH0IUgT/a4yRVO4vbaHo0yQGwE
	 JNEsswcoAByhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Jan Polensky <japo@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ian Rogers <irogers@google.com>,
	linux-s390@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 028/844] perf test: Fix test case perftool-testsuite_report for s390
Date: Sat, 28 Feb 2026 12:19:01 -0500
Message-ID: <20260228173244.1509663-29-sashal@kernel.org>
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

[ Upstream commit 3d012b8614ee020666f3dd15af9f65dc487e3f5f ]

Test case perftool-testsuite_report fails on s390 for some time
now.

Root cause is a time out which is too tight for large s390 machines.
The time out value addr2line_timeout_ms is per default set to 1 second.

This is the maximum time the function read_addr2line_record() waits for
a reply from the forked off tool addr2line, which is started as a child
in interactive mode.

It reads stdin (an address in hexadecimal) and replies on stdout with
function name, file name and line number. This might take more than one
second.

However one second is not always enough and the reply from addr2line
tool is not received. Function read_addr2line_record() fails and emits
a warning, which is not expected by the test case. It fails.

Output before:

 # perf test -F 133
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
 ==================
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.087 MB \
	/tmp/perftool-testsuite_report.FHz/perf_report/perf.data.1 \
	(207 samples) ]
 ==================
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
 ## [ PASS ] ## perf_report :: setup SUMMARY
 -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
 Line did not match any pattern: "cmd__addr2line /usr/lib/debug/lib/modules/
 	6.19.0-20260205.rc8.git366.9845cf73f7db.300.fc43.s390x+next/
	vmlinux: could not read first record"
 Line did not match any pattern: "cmd__addr2line /usr/lib/debug/lib/modules/
	6.19.0-20260205.rc8.git366.9845cf73f7db.300.fc43.s390x+next/
	vmlinux: could not read first record"
 -- [ FAIL ] -- perf_report :: test_basic :: basic execution
	(output regexp parsing)
 ....
 133: perftool-testsuite_report      : FAILED!

Output after:

 # ./perf test -F 133
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
 ==================
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.087 MB \
	 /tmp/perftool-testsuite_report.Mlp/perf_report/perf.data.1
	 (188 samples) ]
 ==================
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
 ## [ PASS ] ## perf_report :: setup SUMMARY
 -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
 -- [ PASS ] -- perf_report :: test_basic :: basic execution
 -- [ PASS ] -- perf_report :: test_basic :: number of samples
 -- [ PASS ] -- perf_report :: test_basic :: header
 -- [ PASS ] -- perf_report :: test_basic :: header timestamp
 -- [ PASS ] -- perf_report :: test_basic :: show CPU utilization
 -- [ PASS ] -- perf_report :: test_basic :: pid
 -- [ PASS ] -- perf_report :: test_basic :: non-existing symbol
 -- [ PASS ] -- perf_report :: test_basic :: symbol filter
 -- [ PASS ] -- perf_report :: test_basic :: latency header
 -- [ PASS ] -- perf_report :: test_basic :: default report for latency profile
 -- [ PASS ] -- perf_report :: test_basic :: latency report for latency profile
 -- [ PASS ] -- perf_report :: test_basic :: parallelism histogram
 ## [ PASS ] ## perf_report :: test_basic SUMMARY
 133: perftool-testsuite_report      : Ok
 #

Fixes: 257046a36750a6db ("perf srcline: Fallback between addr2line implementations")
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-s390@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/addr2line.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index f2d94a3272d71..a8b39f4f202b6 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -18,8 +18,8 @@
 
 #define MAX_INLINE_NEST 1024
 
-/* If addr2line doesn't return data for 1 second then timeout. */
-int addr2line_timeout_ms = 1 * 1000;
+/* If addr2line doesn't return data for 5 seconds then timeout. */
+int addr2line_timeout_ms = 5 * 1000;
 
 static int filename_split(char *filename, unsigned int *line_nr)
 {
-- 
2.51.0

