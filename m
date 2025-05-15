Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B939296FC8;
	Thu, 15 May 2025 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290899; cv=none; b=cX47sEGNcc2w1nQgKBcUilNF62MMDWxpL6u+NwCky3yP6ptkAhrUUK6dqqkGOf/EiCosVi87xkRBABCjfQgY+PxCO16IFUx9YktJMr29FpFcRe2G+6rvakqw9VbipHOZaQiq+jl1SUarA6rfPsM4HtL7T7qK13QRLnx96HFbynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290899; c=relaxed/simple;
	bh=n71QVhN4fQP9N7cpZ7JHQO5yCtlXjiP3svvxPrAkgWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aejN2eqUTMg8P4vl0Piao2Tcy+PA66wQ2wXF567YsBb0XjvvohYksKsx65eNTEAyVU8r9svsN03++NYgMd4Rdep9XW5RmHzTVqhz1Vo/oWZIAHTg6getNEeYarLC33QG1qzOlcdtdlXCah4toVvEhOf7skEfuqSyDgGM2ZiHwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aKKXZsli; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aKKXZsli"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EM4WhL004251;
	Thu, 15 May 2025 06:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ilqngs9o98RWxztFbRc42XvuL8kNsUV9/ftKEW5S8
	Cs=; b=aKKXZsliJOrnYcxOD2MZuDqtnPwybqyiIiUgt+qat1/Z8eX7H/IADqfFC
	7VeyuLBKPlvXzS1R0yONcR8NWF7DcbHQC7MppymCUg5PSy+J9InQ0Qx6zQpkDAtO
	8nF1N/Xtivfp1x/SC9bX4KHFQqLIJaBF5I3zVxIfhz+hokzv/PgDaq/NPt9z7qYx
	2HQN7vEXRRK7W1LYllQjx4dbA3qSNdUaDVMwMke6/alY2S1elAiVfQbYp/6evAQw
	Tlk/H12MSyBdxwlkyg5ixvr35qa/pt9zLRl/+ob/pOngcW3LLwqUe/U8aXaRSqMS
	9qj5LnifitSMRbyDJiFti5iMWjupA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3c99y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 06:34:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54F32RrS026656;
	Thu, 15 May 2025 06:34:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpgph6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 06:34:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54F6YhWh52953368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 06:34:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3379C200BB;
	Thu, 15 May 2025 06:34:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 366AB201F1;
	Thu, 15 May 2025 06:34:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 May 2025 06:34:13 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH] perf ftrace: Restore to original trace settings on exit
Date: Thu, 15 May 2025 08:34:07 +0200
Message-ID: <20250515063407.3025338-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FlNzHUI9n733Ve7cY8OdV3pqwzf9NrTK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1OCBTYWx0ZWRfXwXLQqqj/lDjN Hhmu43wipkxuquemksBLECy1myCSJf9DlZtZgK4p+CbBGxWi60KQpEtaJ2++E5d7jt4V874fPbm tKMIIXq/lgfPf6t++TMeO2u+p3E0X27lIqwK6ZwVjWWnjifly7NFVpSS7LYmWItaIbESZDNvUVN
 6MeL3KBgpW+QGENPkY9g4FqhYv+ceto3RrsQyegtJktTffX7IfXjxHpR/QTajVjb8JyP+8OV7v2 IV8sDskMDM4stZw+1oeme1paSDEd5T5AoFu9DuwOBBG9HfXnjvWtNp8rm8nHivXlMJfM+kW4qeh KKiuTZcQzwlurVVrBdJSSWjNA6tGh1a5nLH/traeUuDdXKxPSsaPOpmobEj6z72i94Q7bFDY2A6
 Cb5b/ZdTBHggXeRS24wRtpGmecyzohtt7tmweAqLXaiytleYS5nOJc82suJew5humTJIPEas
X-Proofpoint-ORIG-GUID: FlNzHUI9n733Ve7cY8OdV3pqwzf9NrTK
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=68258b08 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=f-qP7UiU29b3Nm1CaBMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150058

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

The root cause is function reset_tracing_files() which
writes zero (0) into file tracing_on.

Read tracing files on start of the program and
restore these values just before exit.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 tools/perf/builtin-ftrace.c | 226 ++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7caa18d5ffc3..11ead75fe0f7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -299,6 +299,228 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	return 0;
 }
 
+static int read_tracing_file(const char *name, char *buf, size_t size)
+{
+	int ret = -1;
+	char *file;
+	int fd;
+
+	file = get_tracing_file(name);
+	if (!file) {
+		pr_debug("cannot get tracing file: %s\n", name);
+		return -1;
+	}
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		pr_debug("cannot open tracing file: %s: %s\n",
+			 name, str_error_r(errno, buf, size));
+		goto out;
+	}
+
+	/* read contents to stdout */
+	while (true) {
+		int n = read(fd, buf, size);
+
+		if (n == 0)
+			break;
+		else if (n < 0)
+			goto out_close;
+		buf += n;
+		size -= n;
+	}
+	ret = 0;
+
+out_close:
+	close(fd);
+out:
+	put_tracing_file(file);
+	return ret;
+}
+
+static int read_tracing_option_file(const char *name, char *val, size_t size)
+{
+	char *file;
+	int ret;
+
+	if (asprintf(&file, "options/%s", name) < 0)
+		return -1;
+
+	ret = read_tracing_file(file, val, size);
+	free(file);
+	return ret;
+}
+
+/*
+ * Save the initial trace file setting to restore them after the tests.
+ * This ensures the setting are the same as before the invocation
+ * of the program.
+ */
+static struct trace_file_list {		/* List of tracing files */
+	const char *filename;		/* File name */
+	char *contents;			/* Contents to restore */
+	int (*read_fct)(const char *fn, char *buf, size_t buf_sz);		/* Read function */
+	int (*write_fct)(const char *fn, const char *buf);		/* Write function */
+} trace_file_list[] = {
+	[0] = {
+		.filename = "tracing_on",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+	[1] = {
+		.filename = "current_tracer",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+	[2] = {
+		.filename = "set_ftrace_pid",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+	[3] = {
+		.write_fct = write_tracing_file,
+		.read_fct = read_tracing_file,
+		.filename = "max_graph_depth",
+	},
+	[4] = {
+		.filename = "tracing_thresh",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+	[5] = {
+		.filename = "tracing_cpumask",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+	[6] = {
+		.filename = "set_ftrace_filter",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+	[7] = {
+		.filename = "set_ftrace_notrace",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+	[8] = {
+		.filename = "set_graph_function",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+	[9] = {
+		.filename = "set_graph_notrace",
+		.read_fct = read_tracing_file,
+		.write_fct = write_tracing_file,
+	},
+			/* Files in .../options/ directory */
+	[10] = {
+		.filename = "function-fork",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+	[11] = {
+		.filename = "func_stack_trace",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+	[12] = {
+		.filename = "sleep-time",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+	[13] = {
+		.filename = "funcgraph-irqs",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+	[14] = {
+		.filename = "funcgraph-proc",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+	[15] = {
+		.filename = "funcgraph-abstime",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+	[16] = {
+		.filename = "funcgraph-tail",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+	[17] = {
+		.filename = "latency-format",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+	[18] = {
+		.filename = "irq-info",
+		.read_fct = read_tracing_option_file,
+		.write_fct = write_tracing_option_file,
+	},
+};
+
+static void free_tracing_content(void)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(trace_file_list); ++i)
+		zfree(&trace_file_list[i].contents);
+}
+
+/*
+ * Return a copy of the input string.
+ * Remove a trailing newline. It will be appended in the write
+ * function when values are restored before program termination.
+ * Change "no pid" or comment sign '#' at the beginning and replace it
+ * by an empty string. This resets to the default behavior indicated
+ * by the output. Those strings are not accepted as file input.
+ */
+static char *copy_tracing_file(char *buf)
+{
+	char *c = strrchr(buf, '\n');
+
+	if (c)
+		*c = '\0';
+	if (*buf == '#' || !strncmp(buf, "no pid", 6))
+		*buf = '\0';
+	return strdup(buf);
+}
+
+static int save_tracing_files(void)
+{
+	char buf[4096];
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(trace_file_list); ++i) {
+		struct trace_file_list *tp = &trace_file_list[i];
+
+		memset(buf, 0, sizeof(buf));
+		if ((*tp->read_fct)(tp->filename, buf, sizeof(buf)) < 0)
+			goto out;
+		tp->contents = copy_tracing_file(buf);
+		if (!tp->contents)
+			goto out;
+	}
+	return 0;
+
+out:
+	free_tracing_content();
+	return -1;
+}
+
+static void restore_tracing_files(void)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(trace_file_list); ++i) {
+		struct trace_file_list *tp = &trace_file_list[i];
+
+		(*tp->write_fct)(tp->filename, tp->contents);
+	}
+	free_tracing_content();
+}
+
 static int set_tracing_pid(struct perf_ftrace *ftrace)
 {
 	int i;
@@ -1687,6 +1909,9 @@ int cmd_ftrace(int argc, const char **argv)
 	};
 	enum perf_ftrace_subcommand subcmd = PERF_FTRACE_NONE;
 
+	if (save_tracing_files())
+		return -1;
+
 	INIT_LIST_HEAD(&ftrace.filters);
 	INIT_LIST_HEAD(&ftrace.notrace);
 	INIT_LIST_HEAD(&ftrace.graph_funcs);
@@ -1839,5 +2064,6 @@ int cmd_ftrace(int argc, const char **argv)
 	delete_filter_func(&ftrace.graph_funcs);
 	delete_filter_func(&ftrace.nograph_funcs);
 
+	restore_tracing_files();
 	return ret;
 }
-- 
2.49.0

