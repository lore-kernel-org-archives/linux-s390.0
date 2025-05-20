Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBD268691;
	Tue, 20 May 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733868; cv=none; b=jjiJxpfMWxQEFZrATmAqnZVbAVIpBYsHVxxcuIFPaJXc2f8tVxgoKMK3gLvBSIx491HsITon7rN5Aqiu2oJ25OM2BwXyd+jDD30B7NCPE8LWccoG0ciSWjCziXC61z1Hia4NBb7q7I0qjVpFNm7Q4351lF6pJ107KC6QhI/qWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733868; c=relaxed/simple;
	bh=SCLbx9GFy7d7CnZXnLmXasqmq14/PEkApJTWQyszZ18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7pFt41jWZtdga2NDXmhNkf9SoJDhJC/FNNpTmAuRlUuZ3FDv6UfbQ1y1cQSn+scdyvtpx4qb9dpBeKpTQUDf5yzNeBhwWt0GYRV/949cOfMwmN8PEWnvw3CPc7wJNTbLpAWrJPOTpQpnXPHzea4reKUde40rRkFDRQ+Mt9l+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QKHOg8z7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QKHOg8z7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6IsNG017739;
	Tue, 20 May 2025 09:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3DSu+w3eltf1Nxd2R29kNYI25+AxkEhtg6Bsbe6Uz
	p8=; b=QKHOg8z7VeLCf8PWdejxbqosQnldRQx+ohY4S6FazHq4cwf8agu8slmhF
	QWyL5Z3GvbyELc0VANXMUYz9Iga/LxZi92330gUD/BUgLm84UF67dppRgrOZ2SRS
	jKBGGtj4OsPkJbMrHFNX/guz13YUqwlOH8tL7U830foPcuJUfyqNZWctDUR3zoe9
	kVOcPXNY7Bmo25X2NQeqTrTQMywQ0zd+ccP10tpTPo0n0gRpIiWn8nEi/hl8B2RD
	YqrrmfFhbAa+RpYVCknZdku+cxo9Icj6OIqoSN6D+j18Cdd8gGFXcbCTVf9fYS6f
	T1iLK4tnLaCKjAQNcpDCF8l5ZfobA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbsrv5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:37:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K5geCK013843;
	Tue, 20 May 2025 09:37:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q4stbc2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:37:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54K9bXGZ57278952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 09:37:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17B0F2007D;
	Tue, 20 May 2025 09:37:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6CFC200A5;
	Tue, 20 May 2025 09:37:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 May 2025 09:37:32 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH V3] perf ftrace: Use process/session specific trace settings
Date: Tue, 20 May 2025 11:37:26 +0200
Message-ID: <20250520093726.2009696-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3OSBTYWx0ZWRfX/CMLalBJetBh VTn6cIPAAiXoN2R/YW7BZ3QSE+Wl93ltY73uYk7ZuqVMj4dALS73UNj/AryRgVuuABrbDIrs+w/ Ru3YqQSmTGzaKVg5n+rLmeRGnklkW+wVG17S0FV9370V0kpwCJL8xWJoMcDbdcxVroMSyuJ0dyf
 J0Z+sqLMAeeUt9DMq+nz+dXIdXpcgA6GSn/SkFjtz2NNkPCnbwbHdOJ3A5W+H4tQGVA/rpV7NQ7 NcCvZbp23K2DMqz863lolPJpq8yPFNoetbsNIUIX8l5jEfcNfvLjd4UBtXJ5zrucjxPlzzdCvD7 l1rxJnpWH5ZFMcNvR2KlEp9g/9F78VbrffQ9YdGAO6TcWx+rnsQAtkLVtr6MBetswFp+LEpJiIU
 Vi8T65d/4K9G3luFxDHNagHkDrA0QKAVfhVxOmHe1BLYNu1oPi4QwWCcGjJQA3OueJZSDNxs
X-Proofpoint-ORIG-GUID: Gb260Rby6sTEFFnGqpAxtI8i_HQzDIWd
X-Proofpoint-GUID: Gb260Rby6sTEFFnGqpAxtI8i_HQzDIWd
X-Authority-Analysis: v=2.4 cv=DsxW+H/+ c=1 sm=1 tr=0 ts=682c4d62 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=zoYe_zYKS422fMV--hgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200079

V2 --> V3: Use Arnaldo's proposal for the commit message.
           Add Namhyung's review comments.
V1 --> V2: Add Suggestion from Arnaldo Cavalho de Melo confirmed by
           Steven Rostedt. Use rmdir(../tracing/instances/dir) to stop
	   process/session specific tracing and delete all
	   process/session specific setings.

Executing 'perf ftrace' commands 'ftrace', 'profile' and 'latency' leave
tracing disabled as can seen in this output:

 # echo 1 > /sys/kernel/debug/tracing/tracing_on
 # cat /sys/kernel/debug/tracing/tracing_on
 1
 # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
 # cat /sys/kernel/debug/tracing/tracing_on
 0
 #

The 'tracing_on' file is not restored to its value before the command.

To fix that this patch uses the .../tracing/instances/XXX subdirectory
feature.

Each 'perf ftrace' invocation creates its own session/process
specific subdirectory and does not change the global state
in the .../tracing directory itself.

Use rmdir(../tracing/instances/dir) to stop process/session specific
tracing and delete all process/session specific setings.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 tools/perf/builtin-ftrace.c | 101 +++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7caa18d5ffc3..bba36ebc2aa7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -19,6 +19,7 @@
 #include <ctype.h>
 #include <linux/capability.h>
 #include <linux/string.h>
+#include <sys/stat.h>
 
 #include "debug.h"
 #include <subcmd/pager.h>
@@ -45,6 +46,8 @@ static volatile sig_atomic_t done;
 
 static struct stats latency_stats;  /* for tracepoints */
 
+static char tracing_instance[PATH_MAX];	/* Trace instance directory */
+
 static void sig_handler(int sig __maybe_unused)
 {
 	done = true;
@@ -100,6 +103,34 @@ static bool is_ftrace_supported(void)
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
+ * called at the  beginning to a process specific tracing subdirectory.
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
+	free(file);
+	file = get_tracing_file(name);
+	return file;
+}
+
 static int __write_tracing_file(const char *name, const char *val, bool append)
 {
 	char *file;
@@ -109,7 +140,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
 	char errbuf[512];
 	char *val_copy;
 
-	file = get_tracing_file(name);
+	file = get_tracing_instance_file(name);
 	if (!file) {
 		pr_debug("cannot get tracing file: %s\n", name);
 		return -1;
@@ -167,7 +198,7 @@ static int read_tracing_file_to_stdout(const char *name)
 	int fd;
 	int ret = -1;
 
-	file = get_tracing_file(name);
+	file = get_tracing_instance_file(name);
 	if (!file) {
 		pr_debug("cannot get tracing file: %s\n", name);
 		return -1;
@@ -209,7 +240,7 @@ static int read_tracing_file_by_line(const char *name,
 	char *file;
 	FILE *fp;
 
-	file = get_tracing_file(name);
+	file = get_tracing_instance_file(name);
 	if (!file) {
 		pr_debug("cannot get tracing file: %s\n", name);
 		return -1;
@@ -299,6 +330,39 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	return 0;
 }
 
+/* Remove .../tracing/instances/XXX subdirectory created with
+ * init_tracing_instance().
+ */
+static void exit_tracing_instance(void)
+{
+	if (rmdir(tracing_instance))
+		pr_err("failed to delete tracing/instances directory\n");
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
+		goto error;
+	strncpy(tracing_instance, path, sizeof(tracing_instance) - 1);
+	put_tracing_file(path);
+	path = mkdtemp(tracing_instance);
+	if (!path)
+		goto error;
+	return 0;
+
+error:
+	pr_err("failed to create tracing/instances directory\n");
+	return -1;
+}
+
 static int set_tracing_pid(struct perf_ftrace *ftrace)
 {
 	int i;
@@ -629,14 +693,17 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	select_tracer(ftrace);
 
+	if (init_tracing_instance() < 0)
+		goto out;
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
@@ -924,6 +991,9 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
 	if (ftrace->target.use_bpf)
 		return perf_ftrace__latency_prepare_bpf(ftrace);
 
+	if (init_tracing_instance() < 0)
+		return -1;
+
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
 		return -1;
@@ -942,7 +1012,7 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
-	trace_file = get_tracing_file("trace_pipe");
+	trace_file = get_tracing_instance_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
 		return -1;
@@ -993,7 +1063,7 @@ static int cleanup_func_latency(struct perf_ftrace *ftrace)
 	if (ftrace->target.use_bpf)
 		return perf_ftrace__latency_cleanup_bpf(ftrace);
 
-	reset_tracing_files(ftrace);
+	exit_tracing_instance();
 	return 0;
 }
 
@@ -1304,17 +1374,20 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
 		goto out;
 	}
 
+	if (init_tracing_instance() < 0)
+		goto out;
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
@@ -1323,7 +1396,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
 
 	setup_pager();
 
-	trace_file = get_tracing_file("trace_pipe");
+	trace_file = get_tracing_instance_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
 		goto out_reset;
@@ -1385,7 +1458,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
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

