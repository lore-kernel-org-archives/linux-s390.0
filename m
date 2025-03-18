Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F0207A16;
	Tue, 18 Mar 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291531; cv=none; b=C+DDYzztSPW4dVIBNlgbD8L/M9CohLd/VKPaonVmMEmw0sRDz/cxJjCLIByblaR4bIR5RSE2eVxKYwcyCS9MvS5loMca0kypGes5AMerrnCUIDpPaV2S0kT7jjPjQDhQZLQ+ol2ap1R414FvPO8vXfohB1eG24C+mbScBZDhB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291531; c=relaxed/simple;
	bh=0YVURChpVNoTirygDVnHF8D/yvp8IgZBGg/GV+vDz/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKbwJazkhT8h4HgJIFQy61Eoe2vfYrRcURzlwFnHDVhuonFscAJa9hte/kq//XwBP4eInhJFkJzzM4I4uD0EA0XwOe9ML+JyQtSdVmeqU/PqagpWNdzIQULp2RYHOqVYDfNOf7lGykbk5wg7/Ukl7PsM9078Y1fjY+oyQUw8hMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E1+8WlTX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E1+8WlTX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I3jm2m005934;
	Tue, 18 Mar 2025 09:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J6tM6zRdF7QdI3sWH
	YEx3tMZexZAew/0+UceFbXw+fw=; b=E1+8WlTXpgvh0LH4PQhHavGJIvkZNW0Hb
	SErx3q12OsoJ59DpF0Zp2/eXDS1F8TdwLPEoZjoVTU9hxSsCTbOxZT6+HXmCFDZx
	3hTf6wAV5UTqEOb10qANAtp59nucySCGjaXxm7blucRddNj4dk7DJWdYx9yzS5yY
	Q5lJwTjVcZ7PqPFBSNef7hZVt1pvXOFCb3sHCjOdp7l+qyY6Q8nYeyprmZBn9p9p
	sUCKw5lJFUCXnLbbk5q3iCYAIJxZ5N/blKnELQkCQNgoK5T7tFItrKlRt2UNMc3G
	s8mycVXqgIk4Wtn6l6tSYCFqFFRss6EO8F3RU6gY220ZkWd3TJJ1w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45f179hj39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:51:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I9jp9Y022355;
	Tue, 18 Mar 2025 09:51:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45f179hj37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:51:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7RXoL012451;
	Tue, 18 Mar 2025 09:51:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvnu5p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:51:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I9prkJ12911084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:51:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E749E20043;
	Tue, 18 Mar 2025 09:51:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA38920040;
	Tue, 18 Mar 2025 09:51:52 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 09:51:52 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, acme@redhat.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2] perf/bench: Fix perf bench internals pmu-scan core dump
Date: Tue, 18 Mar 2025 10:51:31 +0100
Message-ID: <20250318095132.1502654-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250318095132.1502654-1-tmricht@linux.ibm.com>
References: <20250318095132.1502654-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sh1T0VrDKBp51vig9hpgBO_5Zx3iky0F
X-Proofpoint-ORIG-GUID: pI2CckExotsV3fwA7rzOdjMSCfTHm2qT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180068

On s390 z/VM systems the command 'perf bench internals pmu-scan'
dumps core, as can be seen:

 # ./perf bench internals pmu-scan
 # Running 'internals/pmu-scan' benchmark:
 Computing performance of sysfs PMU event scan for 100 times
 double free or corruption (out)
 Aborted (core dumped)
 # gdb ./perf core.xxxx
 ....
 #9  0x00000000012fb57a in perf_pmu__delete (pmu=0x160e370 <tool>)
     at util/pmu.c:2318
 #10 0x00000000012fbfca in perf_pmus__destroy () at util/pmus.c:103
 #11 0x0000000001186f72 in save_result () at bench/pmu-scan.c:71
 #12 0x00000000011873c2 in run_pmu_scan () at bench/pmu-scan.c:140
 #13 0x00000000011876a8 in bench_pmu_scan (argc=0, argv=0x3fff3a77338)
     at bench/pmu-scan.c:183
 #14 0x0000000001174556 in run_bench (coll_name=0x14709ba "internals",
     bench_name=0x1470700 "pmu-scan", fn=0x1187620 <bench_pmu_scan>,
     argc=1, argv=0x3fff3a77338) at builtin-bench.c:229
 #15 0x0000000001174a1e in cmd_bench (argc=2, argv=0x3fff3a77330)
     at builtin-bench.c:330
 ...

The root cause is in PMU buildup. The PMUs are constructed via

  run_bench()
  +--> bench_pmu_scan()
       +--> run_pmu_scan()
	    +--> save_result()
	         +--> perf_pmus__scan()
	              +--> pmu_read_sysfs()
	                   +--> perf_pmus__tool_pmu()

perf_pmus__tool_pmu() returns a pointer to a static defined variable:

  static struct perf_pmu tool = {
                .name = "tool",
                .type = PERF_PMU_TYPE_TOOL,
                .aliases = LIST_HEAD_INIT(tool.aliases),
                .caps = LIST_HEAD_INIT(tool.caps),
                .format = LIST_HEAD_INIT(tool.format),
  };

and that PMU is added to the list of other_cpus in file
./util/pmus.c, function pmu_read_sysfs().

Later on after the list of PMUs is constructed,
that list is removed again via:

   save_result()
   +--> perf_pmus__destroy()
	+--> perf_pmu__delete()

This works fine until the PMU named "tool" is deleted.
Its name is a constant pointer possibly located in read-only data
section and can not be freed using zfree().

Remedy this and check for dynamic memory allocation for the PMU.

Background: s390 z/VM system do not support PMUs for sampling and
counting. In this case dummy events are created by the perf tool
and the PMUs "tool" and "fake" are created and freed.

Fixes: efe98a7a3977 ("perf pmu: Use zfree() to reduce chances of use after free")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6206c8fe2bf9..59cec4d2909e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2315,10 +2315,13 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 	perf_cpu_map__put(pmu->cpus);
 
-	zfree(&pmu->name);
-	zfree(&pmu->alias_name);
-	zfree(&pmu->id);
-	free(pmu);
+	/* Static variables can not be free'ed */
+	if (pmu->type != PERF_PMU_TYPE_TOOL && pmu->type != PERF_PMU_TYPE_FAKE) {
+		zfree(&pmu->alias_name);
+		zfree(&pmu->id);
+		zfree(&pmu->name);
+		free(pmu);
+	}
 }
 
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
-- 
2.48.1

