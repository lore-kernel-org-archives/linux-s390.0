Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDE38B7DB;
	Tue,  7 Apr 2026 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557887; cv=none; b=L55bZEMz7VcZAEM2CQLNWKd+cNhhTONA2JI/7zHu0mtVGWS1ROhZYBZQtatoPbKXgZT2vAlhWlGEENU/Xo+MVFJJcMvq0Z3oTDkcsE53XT5eqEzeoDUYVhONV6zYuYfbGadevKebzk+dHWeEic3mogflYQUcO5JmcSiSGvP0/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557887; c=relaxed/simple;
	bh=OwR/etfBC7wQiPvBrNl3qQJ4kiVO153rG2KqBxAE9/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpX+TD/XkpPywIxS+Uqq8or7aEzyW/yDdvREQJgRhypl9H046u8S8w+PHyV1y0zssABuYKFtbrUwWj3kub6Qe2bSgkas4/XcxQk0bfF3D5hHY/jJ/Jz63rzypwM6Rms2c7e3vIizV55ayDHezCrTdlXN1DO6Av8wTzpzpAlMGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cqgp0VYa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cqgp0VYa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LlueD2591301;
	Tue, 7 Apr 2026 10:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tYVTMXR2tIb8FF7Xj
	A8qKhppXWNCUyTP16s1kfR5hh8=; b=cqgp0VYaJZxFXyCXV4FsoDb4sEBX9KNv1
	85CaC6O+9l5D/whEVJQRLM5qmnET0jtlQiDDF6MvJsYHydlQJb916e7F7EQd9/RT
	0Ayl6CW/qoMAsTPlZpaxtMRlAy11CRdmU5m2kERRQaSzQ37DdLgZ/WZJxcISpOX6
	rk3uDnhP/ovyjZUvP0+S3LHUpwGIqNADkK4YmG93L6xqKXKWYk7JaqN96gFqFNq4
	s2N1lONKG1ErX3taQiUTSYDc6igr1yeLWjTb7XW9/VmiSZQN+9WI8un+JHX2ieGY
	WYFq4ZGcFnFzkaoXKDL0Wspg6iySy6cyf5WfInBOe3Mn5Qz6MGG7g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e2efq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:31:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63793upj007881;
	Tue, 7 Apr 2026 10:31:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2a7as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:31:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637AVITZ20119938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 10:31:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF823200A7;
	Tue,  7 Apr 2026 10:08:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4D4200A6;
	Tue,  7 Apr 2026 10:08:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 10:08:43 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v3 2/3] perf config: Make symbol_conf::addr2line_disable_warn configurable
Date: Tue,  7 Apr 2026 12:08:34 +0200
Message-ID: <20260407100835.3488645-3-tmricht@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 3G5SyTnT-FO-ZqPGHG5Lsi8ebWaF5exn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5NSBTYWx0ZWRfX9T3/arNp9rLb
 kD+rgBBHZXcdIAzttDNUfJeow05N85QJyMhtXuc7DDDCsk1d0h1ouKojPXAI8oEifnQmsFQd+Bw
 vhO+q5FUU2TPTcBja6CBvniSptYMKf0aykLuIuQbzEUn+25IKFXeE5P6zVBJ/r/37Qjaw+ua0m/
 zEcOLl9qvPSN3sQPRJ9njoIQs439f0HMes5ble/4go14rpmq395Hcbqi5em7SBUz1Xv+7cxzrIr
 8O5/DfnA9k4YTTrA4D0VkOyyAI5u5coGhHkHPcu+EaHecNN8Ew3O8DytwkgclI1lszbFHOVlke/
 HVjzB0pK2k8xb5UBPxcvFYNIK8tDDPPSyHTxENpqUVzN3t1tKhpYgrc8y3NRUy//7WprOjADvkT
 ttViHXT+SoCd4d4VOZY3szq6KMKpvSMa6ErYv2cC5gzmBtzOZK34uwyobV9dEZEdDXmXwrlHID2
 7/+Ez1KoR65o9ndD0tQ==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d4dcfb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=DK11Rftqn3b6i-WP93oA:9
X-Proofpoint-GUID: MYZpoxdiShXyf-vFBEJpoJukC57LhwYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070095

Make symbol_conf::addr2line_disable_warn configurable by reading
the perfconfig file.
Use section core and addr2line-disable-warn = value.
Update documentation.

Example:
 # perf config -l
 core.addr2line-timeout=5000
 core.addr2line-disable-warn=1
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-config.txt | 6 ++++++
 tools/perf/util/config.c                 | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 642d1c490d9e..9b223f892829 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -210,6 +210,12 @@ core.*::
 		Sets a timeout (in milliseconds) for parsing /proc/<pid>/maps files.
 		Can be overridden by the --proc-map-timeout option on supported
 		subcommands. The default timeout is 500ms.
+	addr2line-disable-warn::
+		When set to 'true' disable all warnings from 'addr2line' output.
+		Default setting is 'false' to show these warnings.
+	addr2line-timeout::
+		Sets a timeout (in milliseconds) for parsing 'addr2line'
+		output.  The default timeout is 5s.
 
 tui.*, gtk.*::
 	Subcommands that can be configured here are 'top', 'report' and 'annotate'.
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 0452fbc6c085..8e30def2b1f7 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -461,6 +461,9 @@ static int perf_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.addr2line-timeout"))
 		addr2line_timeout_ms = strtoul(value, NULL, 10);
 
+	if (!strcmp(var, "core.addr2line-disable-warn"))
+		symbol_conf.addr2line_disable_warn = perf_config_bool(var, value);
+
 	/* Add other config variables here. */
 	return 0;
 }
-- 
2.53.0

