Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715554758;
	Wed, 19 Mar 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387321; cv=none; b=Ks4zApasanvyP2gTSh6F0gzRRdQYY85WnCYHHng8L33tbrQjrEjxT+2MaGjZqkKZYIHBs80P8Hw32vTwPjZcNCIj93+Ixpj31LMndh+QTdZGNQjzcmrn/M15ZeN7HGvnvY5Lc5souTVNoa8PPrhioiHQxM68uI50/2SR0KBKmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387321; c=relaxed/simple;
	bh=0FzWDBd98dxI71a410BhQiuVY3pWY7ArwaxozkDWYZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3sTzs87Ao/a116+eaSYLYti4LFYKcRNi8ssE9ebhlLoVx+5VCTFw2GAZTLIC7FK01yOZyECmwlHlXoAoJBtPLEG/JrTQsu/VgGMpQIHDX3ioshYc4GooaszKPFb1a1Ryf0TsTX8qO5j3tCWZYRnMXfAaYwXVZkcIyMwJ2ds3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Chk3At+u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Chk3At+u"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCRwWd011898;
	Wed, 19 Mar 2025 12:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vSuyuRK6lsbWMylQNVNOOEkrUuB1K90NKyOR2jOsa
	Xc=; b=Chk3At+uhyCmiqUioJLazRsbtEHkDE6arZgnNW99bAp91Tz7qVs6ZbeqB
	J7QiAVRrgRgbg7UMaW/eaSYchrmgnMb6IdaEoRab3zDhC9ffUq5cVq5fSUzkD0cU
	Q/Pp/RdS8WS5AEZSnaNSNfXG+MiGpaa/knaVDFR7xst/ymDq2EzuIxMJZs0VeoXD
	n3kQ1r1A7Od6b5Ml7xLfFv23PASYsxa3QStykkhlBH9HDn1soOUMlAIeRV0A0j0D
	EIUyRUxTenTv3pXV4foN9Xrw6SQldijjrS8yi5Wk3Re551JfQuSKc/cQkISfzAF/
	3EtmwMedTHFkslgsX3DvqMiiI9Tbw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy2002u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:28:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52JCRxlk011910;
	Wed, 19 Mar 2025 12:28:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy2002r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:28:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JAQeYh005752;
	Wed, 19 Mar 2025 12:28:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2h4cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:28:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JCSWLc19726770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 12:28:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F2B62004B;
	Wed, 19 Mar 2025 12:28:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39F6220049;
	Wed, 19 Mar 2025 12:28:32 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 12:28:32 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, james.clark@linaro.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf pmu: Handle memory failure in tool_pmu__new()
Date: Wed, 19 Mar 2025 13:28:20 +0100
Message-ID: <20250319122820.2898333-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W5WuXAnPb3e35S1bzccStjqSJnkXXomf
X-Proofpoint-GUID: BDiH3Be6LrLJTu4d4pPAi2PXqgxvDCuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=755 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190085

On linux-next
commit 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
allocated PMU named "tool" dynamicly. However that allocation
can fail and a NULL pointer is returned. That case is currently
not handled and would result in an invalid address reference.
Add a check for NULL pointer.

Fixes: 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c     | 3 ++-
 tools/perf/util/tool_pmu.c | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 9b5a63ecb249..b99292de7669 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -265,7 +265,8 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
 		tool_pmu = tool_pmu__new();
-		list_add_tail(&tool_pmu->list, &other_pmus);
+		if (tool_pmu)
+			list_add_tail(&tool_pmu->list, &other_pmus);
 	}
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index b60ac390d52d..97b327d1ce4a 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -495,12 +495,20 @@ struct perf_pmu *tool_pmu__new(void)
 {
 	struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
 
+	if (!tool)
+		goto out;
 	tool->name = strdup("tool");
+	if (!tool->name) {
+		zfree(&tool);
+		goto out;
+	}
+
 	tool->type = PERF_PMU_TYPE_TOOL;
 	INIT_LIST_HEAD(&tool->aliases);
 	INIT_LIST_HEAD(&tool->caps);
 	INIT_LIST_HEAD(&tool->format);
 	tool->events_table = find_core_events_table("common", "common");
 
+out:
 	return tool;
 }
-- 
2.48.1

