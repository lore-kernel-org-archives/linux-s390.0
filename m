Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B4274FE1;
	Mon, 19 May 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666377; cv=none; b=B5uFJvtz4iqVxiduc9+CloQ+fawZKirAksbQ6zmmUkF5lVwSAGl2VmDSXBq14DHlfXRgczLH8uD0WmQ0JaMTkgdFn85qC7ojpSH07vtxL6xno0ZFHTcQjX49h4Nc6piqkSuLJo1QgOe5fgLBmFnuaDs67WhmwQEtPXR97Bz8tdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666377; c=relaxed/simple;
	bh=fX2FOmzNAsmhlnXLcQUmdKuNRSxOKuAfmQQEWHbmBmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6zNmHmd4mTTxmtbPoVraBY3s5gDm2gLppUZjES7uI+vBD8mosQyqNEUcsI3OOiPFoXHKB1Q4f72vkuZYpSUM2jo/zzTOVZqlWH4ey0jIgb+C4UGox4UZ3Fpw6W3SJqVigzEx897HpFJsZSWq3PXayTfOTrZjA03CU42Uo58rlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W5m6YK79; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W5m6YK79"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JAEoqo008407;
	Mon, 19 May 2025 14:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7DedDk76hhq5mRBEyU1IMe5tXBiNp9OW7EFP+5NFG
	tA=; b=W5m6YK79iTGh+a6e8o5Dc0PBAbmTARYNM1HHTqvwpmkbbZ7M/K+XPmzMo
	7SJTWES0GVkzimLITuG9BOynC7HCShAduakcZqlFJFp/NDwk3i5DJOei8OgCVyuT
	CespWs66aob7A5nOl2LkincymV8u7HTru3vcrelVzptCvfJyi4ROOKgTDyRxzRCy
	kVYuHQ0FOqc0slDUSdF8EPU/2makwcrttU0wU32C+vDn5v6DDAjxAic2xeWSgWMI
	jkmiprqhpUCiwgf7YsSxa2UFAX18nQhgjK2+EMmCtsazHtSj/e10aJSwcuM/n44R
	S9M7qvohnolsTed9xzXJK7T43AsDg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46r2qhsa6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 14:52:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDOYpn013862;
	Mon, 19 May 2025 14:52:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q4st7brh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 14:52:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54JEqlVE43319746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 14:52:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5322820094;
	Mon, 19 May 2025 14:52:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2E1D20093;
	Mon, 19 May 2025 14:52:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 May 2025 14:52:46 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH v2] perf ftrace: Use process/session specific trace settings
Date: Mon, 19 May 2025 16:52:35 +0200
Message-ID: <20250519145235.56006-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzNSBTYWx0ZWRfX/qX3CXP7+sn4 72kTmqPEuDGlNDEZvM45iJy+Fn6qtu9HIkrSNWp0DdF/WaQmiMtwY3gCxHdMVKOA0xnZ51zkRCF ZDuloxke6NuPWU2Z4QRFQ0x/CakUvaOb4o9X/d5w1LPCMau8WrCEafKJjdACTRbJ1Z7wogrzJuR
 eL8UwylAmFMLRltt08BXmHA+qjgt8uyGDFHOfro7TH/bDWdt/hgS/CJ9PrKxO1/fSF8/0XocguW xtiSWfFLhnHPT2+EG/6+ddjlMEwjqzWqTwWdFX65+sW5HJlxNeiWwAMU10LGR1NuJ0c1gHDNv1g zCF4JbJWwQVQoAn4vhU1n3W8JLvhjazR2ax9Lum6mvbmY7bkbSvGe3/UtK32Mf36uGrBwmmjZIZ
 ef5wmffnYIFMO4NP5Dr7Tcezlu4i/EhK9lHmFl3EGcsUUNpx9neiUxdev+Frv9vfvVGFUMBM
X-Proofpoint-ORIG-GUID: lOT_mJisdR7AV9UoYvIL8WQHArwH31KN
X-Proofpoint-GUID: lOT_mJisdR7AV9UoYvIL8WQHArwH31KN
X-Authority-Analysis: v=2.4 cv=P406hjAu c=1 sm=1 tr=0 ts=682b45c4 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=A9Wz8rmv4LPDD7f-p2MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190135

V1 --> V2: Add Suggestion from Arnaldo Cavalho de Melo confirmed by
           Steven Rostedt. Use rmdir(../tracing/instances/dir) to stop
	   process/session specific tracing and delete all 
	   process/session specific setings.

Executing perf ftrace commands ftrace, profile and latency
leave tracing disabled as can seen in this output:

 # echo 1 > /sys/kernel/debug/tracing/tracing_on
 # cat /sys/kernel/debug/tracing/tracing_on
 1
 # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
 # cat /sys/kernel/debug/tracing/tracing_on
 0
 #

The tracing_on file is not restored to its value before the command.
Fix this behavior and restore the trace setting to what
is was before the invocation of the command.
On Fedora 41 and 42 tracing is turned on by default.

This patch use the .../tracing/instances/XXX subdirectory feature.
Each perf ftrace invocation creates its own session/process
specific subdirectory and does not change the global state
in the .../tracing directory itself.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 tools/perf/builtin-ftrace.c | 105 +++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7caa18d5ffc3..3faf96e7185e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -38,6 +38,8 @@
 #include "util/units.h"
 #include "util/parse-sublevel-options.h"
 
+#include <sys/stat.h>
+
 #define DEFAULT_TRACER  "function_graph"
 
 static volatile sig_atomic_t workload_exec_errno;
@@ -45,6 +47,8 @@ static volatile sig_atomic_t done;
 
 static struct stats latency_stats;  /* for tracepoints */
 
+static char tracing_instance[PATH_MAX];	/* Trace instance directory */
+
 static void sig_handler(int sig __maybe_unused)
 {
 	done = true;
@@ -100,6 +104,34 @@ static bool is_ftrace_supported(void)
 	return supported;
 }
 
+/*
+ * Wrapper to test if a file in directory .../tracing/instances/XXX
+ * exists. If so return the .../tracing/instances/XXX file for use.
+ * Otherwise the file exists only in directory .../tracing and
+ * is applicable to all instances, for example file available_filter_functions.
+ * Return that file name in this case.
+ *
+ * This functions works similar to get_tracing_file() and expects its caller
+ * to free the returned file name.
+ *
+ * The global variable tracing_instance is set in init_tracing_instance()
+ * called a the  beginning to a process specific tracing subdirectory.
+ */
+static char *get_tracing_instance_file(const char *name)
+{
+	char *file;
+
+	if (asprintf(&file, "%s/%s", tracing_instance, name) < 0)
+		return NULL;
+
+	if (!access(file, F_OK))
+		return file;
+
+	put_tracing_file(file);
+	file = get_tracing_file(name);
+	return file;
+}
+
 static int __write_tracing_file(const char *name, const char *val, bool append)
 {
 	char *file;
@@ -109,7 +141,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
 	char errbuf[512];
 	char *val_copy;
 
-	file = get_tracing_file(name);
+	file = get_tracing_instance_file(name);
 	if (!file) {
 		pr_debug("cannot get tracing file: %s\n", name);
 		return -1;
@@ -167,7 +199,7 @@ static int read_tracing_file_to_stdout(const char *name)
 	int fd;
 	int ret = -1;
 
-	file = get_tracing_file(name);
+	file = get_tracing_instance_file(name);
 	if (!file) {
 		pr_debug("cannot get tracing file: %s\n", name);
 		return -1;
@@ -209,7 +241,7 @@ static int read_tracing_file_by_line(const char *name,
 	char *file;
 	FILE *fp;
 
-	file = get_tracing_file(name);
+	file = get_tracing_instance_file(name);
 	if (!file) {
 		pr_debug("cannot get tracing file: %s\n", name);
 		return -1;
@@ -299,6 +331,36 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	return 0;
 }
 
+/* Remove .../tracing/instances/XXX subdirectory created with
+ * init_tracing_instance().
+ */
+static void exit_tracing_instance(void)
+{
+	rmdir(tracing_instance);
+}
+
+/* Create subdirectory within .../tracing/instances/XXX to have session
+ * or process specific setup. To delete this setup, simply remove the
+ * subdirectory.
+ */
+static int init_tracing_instance(void)
+{
+	char dirname[] = "instances/perf-ftrace-XXXXXX";
+	char *path;
+
+	path = get_tracing_file(dirname);
+	if (!path)
+		return -1;
+	strcpy(tracing_instance, path);
+	put_tracing_file(path);
+	path = mkdtemp(tracing_instance);
+	if (!path) {
+		pr_err("failed to create tracing/instances directory\n");
+		return -1;
+	}
+	return 0;
+}
+
 static int set_tracing_pid(struct perf_ftrace *ftrace)
 {
 	int i;
@@ -629,14 +691,19 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	select_tracer(ftrace);
 
+	if (init_tracing_instance() < 0) {
+		pr_err("failed to create tracing/instances\n");
+		goto out;
+	}
+
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
-		goto out;
+		goto out_reset;
 	}
 
 	/* reset ftrace buffer */
 	if (write_tracing_file("trace", "0") < 0)
-		goto out;
+		goto out_reset;
 
 	if (set_tracing_options(ftrace) < 0)
 		goto out_reset;
@@ -648,7 +715,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	setup_pager();
 
-	trace_file = get_tracing_file("trace_pipe");
+	trace_file = get_tracing_instance_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
 		goto out_reset;
@@ -723,7 +790,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 out_close_fd:
 	close(trace_fd);
 out_reset:
-	reset_tracing_files(ftrace);
+	exit_tracing_instance();
 out:
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
@@ -924,6 +991,11 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
 	if (ftrace->target.use_bpf)
 		return perf_ftrace__latency_prepare_bpf(ftrace);
 
+	if (init_tracing_instance() < 0) {
+		pr_err("failed to create tracing/instances\n");
+		return -1;
+	}
+
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
 		return -1;
@@ -942,7 +1014,7 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
-	trace_file = get_tracing_file("trace_pipe");
+	trace_file = get_tracing_instance_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
 		return -1;
@@ -993,7 +1065,7 @@ static int cleanup_func_latency(struct perf_ftrace *ftrace)
 	if (ftrace->target.use_bpf)
 		return perf_ftrace__latency_cleanup_bpf(ftrace);
 
-	reset_tracing_files(ftrace);
+	exit_tracing_instance();
 	return 0;
 }
 
@@ -1304,17 +1376,22 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
 		goto out;
 	}
 
+	if (init_tracing_instance() < 0) {
+		pr_err("failed to create tracing/instances\n");
+		goto out;
+	}
+
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
-		goto out;
+		goto out_reset;
 	}
 
 	/* reset ftrace buffer */
 	if (write_tracing_file("trace", "0") < 0)
-		goto out;
+		goto out_reset;
 
 	if (set_tracing_options(ftrace) < 0)
-		return -1;
+		goto out_reset;
 
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
@@ -1323,7 +1400,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
 
 	setup_pager();
 
-	trace_file = get_tracing_file("trace_pipe");
+	trace_file = get_tracing_instance_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
 		goto out_reset;
@@ -1385,7 +1462,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
 out_close_fd:
 	close(trace_fd);
 out_reset:
-	reset_tracing_files(ftrace);
+	exit_tracing_instance();
 out:
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
-- 
2.49.0

