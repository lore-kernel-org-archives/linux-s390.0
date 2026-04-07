Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD843A782C;
	Tue,  7 Apr 2026 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556534; cv=none; b=S9+cBjnU5K39pZauzAeKR/qWTGQzuNho/3ZOgLmdN0Uc1L3bH5ah4c6mrCoiXZ5pVTW699LmX2WcCtnK0T7UySk+G3ZpqS8KjpWHpcQXL9vQKpWbOyQQJxf/rdBe4IytqWO1pJeQoa2LA4V8sRqFMIeLFUHhyk7zcCCy2R0yITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556534; c=relaxed/simple;
	bh=Buma9OP6UORjm+C2IWsGZvDJNdQfeIlGHgpczGX6clU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQL7lcequwPW6oBi3PNxs76Bo3nUiE1OeqKnn7DflhwyrcbKxcombXiUlfQ39UpwYcxvZ4jdRcq5lO1+LtSFBR1dBz3oppxiHm/hYypNW4MR2eGb8UjO6+4l08CNSMJijfNnZuF+/MBqDKj0BESWUebQ/0fQbfXBgABb3y3gQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FJ4h/yz0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FJ4h/yz0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmUP72211703;
	Tue, 7 Apr 2026 10:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7oPCF1WK0MJjWVRp0
	MyOFF4sObRxm4O89kOJ3CGj+Pk=; b=FJ4h/yz0/yBhMiLw89NanACx/pooCh1v0
	vcM5RN4KlQlrdYaQwOUZoryB0Hs4Af9E8cbyw+mG8KE17hc4wO7XZRxc3wotp+c7
	Tn4nnStKyPcJmvZG//+IKplL7dcoskzDpK6c1bNhIBaxhEdpWWEN3XfAfHojOMuG
	eQJfAw0cLQ1N41kfnLrr/mYZ7fQrOGHTvOGM1QPdmZ/8Vu3J6S+isOQDbKqIm1s+
	+HxoisdUe+3H1D9lxHCN8TNU5LhuY5/3NwQvWS4srBcbfSGZIse2jfKnaLMh7fkw
	5vTYJZE0V/+GBKuhF6ic5K/M9s1ptDy4zEdd6rqV8vSSFWPNSxdEg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ha3ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:08:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637991Bw013902;
	Tue, 7 Apr 2026 10:08:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf421ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:08:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637A8i0745941188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 10:08:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 989DB200AA;
	Tue,  7 Apr 2026 10:08:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63EDB200A5;
	Tue,  7 Apr 2026 10:08:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 10:08:44 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v3 3/3] perf addr2line: Remove global variable addr2line_timeout_ms
Date: Tue,  7 Apr 2026 12:08:35 +0200
Message-ID: <20260407100835.3488645-4-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407100835.3488645-1-tmricht@linux.ibm.com>
References: <20260407100835.3488645-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5MCBTYWx0ZWRfX3AZAalKj/8K8
 uK6vGHEYvb4FOTvnK3EyN+hMFZuWft4XxxJZEy4bMDRjjSQKYo5Wd0bYaE9iSY4s1eLTE2uAqOs
 DdIFreMvBthBfVDbjAoW9TVQfsOyhSBI5ktObedawxTtbMnHoflm6EO25eF3bcc1NYn4pWEgeDZ
 ZZuV1B7tKPZ+v82AP10howKaLGCAOs9w/qk6YMW2R9c3JxW9yYtD5x9LmNzuod1wIRSlAYhlI1X
 5CyzBw9XqOXkG40dv2tpYyZhxsznrpJVeT3d4WHerVU1oFsw7aq12BYdc3Zyx1X2as1bW1eJUAe
 uGbOel+tamYSwAXYLOkdMq8y69U6G+ZR8F9lBYkAjL5PwYfk9RZJ/hclWs+DbS8CJhmeEcXjMCb
 RHuyYd2tXr5atsOSSSNYr7fIXjGA2H8lHoJkl1vIZTdpGgROP2GKavbUZ3QIVS/qr/bRp7Vp/hB
 QNDLzEXbDhBv6i/iA3w==
X-Proofpoint-GUID: mDaSs_VhqiiHTbcFbFX_HMWIX0C1CLO6
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d4d7b1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=4Ms4tONn8Qn1zPKtktQA:9
X-Proofpoint-ORIG-GUID: hfx0O2xkeWtunIZfXm6DQkOAX-B1xwDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070090

Remove global variable addr2line_timeout_ms and add is as member
to symbol_conf structure.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/addr2line.c   | 8 ++++----
 tools/perf/util/addr2line.h   | 2 --
 tools/perf/util/config.c      | 3 +--
 tools/perf/util/symbol_conf.h | 1 +
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index e9f084db0802..1b7f66ece570 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -18,9 +18,6 @@
 
 #define MAX_INLINE_NEST 1024
 
-/* If addr2line doesn't return data for 5 seconds then timeout. */
-int addr2line_timeout_ms = 5 * 1000;
-
 static int filename_split(char *filename, unsigned int *line_nr)
 {
 	char *sep;
@@ -87,6 +84,9 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
 		return NULL;
 	}
 
+	if (!symbol_conf.addr2line_timeout_ms)
+		symbol_conf.addr2line_timeout_ms = 5 * 1000;
+
 	return a2l;
 }
 
@@ -335,7 +335,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 		goto out;
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
-	io.timeout_ms = addr2line_timeout_ms;
+	io.timeout_ms = symbol_conf.addr2line_timeout_ms;
 	switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr, /*first=*/true,
 				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
diff --git a/tools/perf/util/addr2line.h b/tools/perf/util/addr2line.h
index d35a47ba8dab..75989a92f16b 100644
--- a/tools/perf/util/addr2line.h
+++ b/tools/perf/util/addr2line.h
@@ -8,8 +8,6 @@ struct dso;
 struct inline_node;
 struct symbol;
 
-extern int addr2line_timeout_ms;
-
 int cmd__addr2line(const char *dso_name, u64 addr,
 		   char **file, unsigned int *line_nr,
 		   struct dso *dso,
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 8e30def2b1f7..087002fb1b9b 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -19,7 +19,6 @@
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/stat.h"  /* perf_stat__set_big_num */
 #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
-#include "util/addr2line.h"  /* addr2line_timeout_ms */
 #include "srcline.h"
 #include "build-id.h"
 #include "debug.h"
@@ -459,7 +458,7 @@ static int perf_default_core_config(const char *var, const char *value)
 		proc_map_timeout = strtoul(value, NULL, 10);
 
 	if (!strcmp(var, "core.addr2line-timeout"))
-		addr2line_timeout_ms = strtoul(value, NULL, 10);
+		symbol_conf.addr2line_timeout_ms = strtoul(value, NULL, 10);
 
 	if (!strcmp(var, "core.addr2line-disable-warn"))
 		symbol_conf.addr2line_disable_warn = perf_config_bool(var, value);
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 21a1f096d4f0..6cd454d7c98e 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -80,6 +80,7 @@ struct symbol_conf {
 			*bt_stop_list_str;
 	const char		*addr2line_path;
 	enum a2l_style	addr2line_style[MAX_A2L_STYLE];
+	int             addr2line_timeout_ms;
 	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
-- 
2.53.0

