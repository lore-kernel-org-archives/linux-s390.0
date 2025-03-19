Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1025333A;
	Wed, 19 Mar 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376576; cv=none; b=q04A0hVI0z/ElIcZ7jbBL5XFS+S/vGrptqU2Gpsr6/RwArNgRZEHzTN0VcvQJkSwEDw8M2il2op9tmNjsG+7/iHqIVgYqhnQ74xbrxjFfrpjwAUFuw4jQ7LXvLdzKJHnHQSb6+v+ymyivYN6VP0ZUMl355JeoYEEVUdh7QeB/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376576; c=relaxed/simple;
	bh=LU1gsbIDhdyBf4eDHN7WyT1kpp6qaf69WMlHLFZKJCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciw0WzGXNxeI63f0yBkU6N7ureDaeJ9hwP3m5cujwNyiU2dtwo8RWtEiY7r4xszkXlfhyaJ66Y3wGOWb2gYi2nzVZ/n9gx9I0Uh0yWVXtq9+7p33s7b1pFhXwG/oZC2y10iHX+iauSc5n8bMekir64ZQN8B1C0POZsX6spgYEgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r4eTpdqX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r4eTpdqX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J3k744019295;
	Wed, 19 Mar 2025 09:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YUOhoa8ilDjouEmZsFPjxh2jSt0fSWfP6/hRUBfcT
	WQ=; b=r4eTpdqXvEEPo7EwH15smsBeRTb7KPsG8fXxqCpUT6+ij2l6pyvLAfoXn
	J0ewiAZ9qSkE59qIvT2SsSbeUgF6PQRRffLlsnaqTT0mmfZxfiVTpe9hdCCuORS4
	IG7QTwfmoCu79iXQMvTgqt2J9mJQoR4wGcwXFBOvf0IAK/Z+ViuQXnF6L00TAlJB
	HaERNailhjyOf7BKk5zrbasTSX9Sud/GToWjsFgybVu2DVPxsO1LeKmEC5jWLMeU
	8rtFZWXu6pZ97/AjuF088AsCnrl2Yp/BNfGhbOMeUPbMpGL+dxz/Dwf9mCAoqrsX
	3a6BrazDn4sf7b1pkW6IWsRA+F6kQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fpa9hf0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 09:29:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52J9STiJ020130;
	Wed, 19 Mar 2025 09:29:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fpa9hf0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 09:29:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52J7hkV3005579;
	Wed, 19 Mar 2025 09:29:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm900xsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 09:29:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52J9TPxM51708248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 09:29:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBCF22004B;
	Wed, 19 Mar 2025 09:29:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD42B20040;
	Wed, 19 Mar 2025 09:29:25 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 09:29:25 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, james.clark@linaro.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf pmu: Handle memory failure in tool_pmu__new()
Date: Wed, 19 Mar 2025 10:28:47 +0100
Message-ID: <20250319092847.1192988-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NSgzYODzPye7ayUOHkpyibdnxNjJSu1z
X-Proofpoint-ORIG-GUID: gzQNFEQn-ZERgH5BvmFQeQ_5mzgnixSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=744
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190065

On linux-next
commit 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
allocated PMU named "tool" dynamicly. However that allocation
can fail and a NULL pointer is returned. That case is currently
not handled and would result in an invalid address reference.
Add a check for NULL pointer.

Fixes: 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmus.c     | 3 ++-
 tools/perf/util/tool_pmu.c | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index b60ac390d52d..d764c4734be6 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -495,12 +495,21 @@ struct perf_pmu *tool_pmu__new(void)
 {
 	struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
 
+	if (!tool)
+		goto out;
 	tool->name = strdup("tool");
+	if (!tool->name) {
+		zfree(tool);
+		tool = NULL;
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

