Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729AD20767B;
	Tue, 18 Mar 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291528; cv=none; b=bdspNd5Sfqc9cZlIWUbn8rIJ75JkcmXymQTStp7xF00FlrBRWt/6xuJWP2AuzeLQh1CQzmdahdgUQGrMVZPl2MTO9i+fY1Qowo1QTZGuh10iGtdYKxr/JDUELB7qd6fh8XsQJXsnoBuyiiDmvmwpu4e+VZD6OBwKrzaRSnDECes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291528; c=relaxed/simple;
	bh=gw1CkZCUSJJRiD55ucyuEfQMpZXRW58FgQY4xMEkpHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpJMqejVYQS8xgww6vYYn3oj+8euOKbo7zzswWYhqjr1sB+viQMSkqciZWgV/oAMGksqPxqFTM8N6Ckaw74M/s06kwhFH2gy1Nb7hiiIh3nvMBCK7ddapwkZKTBhIV5Nm2TVMEE7X8/D+4L0AINNa5Ppv1gVHpY0vGvzhqaImrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eocsYKiY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eocsYKiY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I3jxR5006543;
	Tue, 18 Mar 2025 09:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=j4XTY++tLs86D6JKv
	WNNHYglmdGOpzp/fWosOOL6OzY=; b=eocsYKiY42mzv6Q49Ewu/A1ZpOkfqNqbs
	z/gDZu+JLA7uvy+Uw1O2MWGr5Zii+je6ip2yfNW+kljXChZiZUP/tU0onTyofYp5
	1VTcDNoTsTPD+xW+OBwlHi394Dz/uQL4gxISw/DQAQqUolBXVEc8qxhLPJiA5Jmv
	qhchv/34Pin5cVX28OP/TgGlhPxu+4Hu6TABBIw14eyEHKi2O865TyNIZfeD3sVr
	e3p5721++zCz+/mUB+JDsO9qRz8h2lK9N3dAAGIJg2xJhiNmNZF9o3iDskHtF4P3
	E3RtWMpbNCxToJ1+rrgnMqVMJgtqw67q3Tiv8ElHOPVxxXFVRifMQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45f179hj3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:52:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I8sAg4005524;
	Tue, 18 Mar 2025 09:52:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45f179hj3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:52:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8n0rv005738;
	Tue, 18 Mar 2025 09:51:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2asb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:51:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I9puaw43057564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:51:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BCE32004B;
	Tue, 18 Mar 2025 09:51:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D34FA2004D;
	Tue, 18 Mar 2025 09:51:55 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 09:51:55 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, acme@redhat.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] perf/bench: Double free of dynamic allocated memory
Date: Tue, 18 Mar 2025 10:51:32 +0100
Message-ID: <20250318095132.1502654-3-tmricht@linux.ibm.com>
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
X-Proofpoint-GUID: zBjE8s8u9cXJ_t82tKHOCspFtHbhKnCT
X-Proofpoint-ORIG-GUID: 2VHtyOkeHTE_j7yf-Pnli93EJvLxINJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180068

On s390 z/VM the command 'perf bench internals pmu-scan'
dumps core, as can be seen:

Output before:
 # ./perf bench internals pmu-scan
 # Running 'internals/pmu-scan' benchmark:
 Computing performance of sysfs PMU event scan for 100 times
 perf: /root/linux/tools/include/linux/refcount.h:131:
	refcount_sub_and_test: Assertion `!(new > val)' failed.
 Aborted (core dumped)
 #

The root cause is in

perf_pmus__scan()
+--> perf_pmu__create_placeholder_core_pmu()
     +--> cpu_map__online()

cpu_map__online() has a static variable

    static struct perf_cpu_map *online;

    if (!online)
        online = perf_cpu_map__new_online_cpus();

    return online;

which is allocated once when entered for the first time.

However perf_pmu__create_placeholder_core_pmu() is actually called
two times.
First time:
   run_pmu_scan()
   +--> save_result()
        +---> perf_pmus__scan_core()
              +--> pmu_read_sysfs()
	           +--> perf_pmu__create_placeholder_core_pmu()
	...
	+--> perf_pmus__destroy()

Second time:
    run_pmu_scan()
    +--> perf_pmus__scan()
         +--> pmu_read_sysfs()
	      +--> perf_pmu__create_placeholder_core_pmu()
	...
	+--> perf_pmus__destroy()

The second time the already allocated memory pointed to by variable
'online' is returned. However in between the first and second call
of perf_pmu__create_placeholder_core_pmu()
function save_result() also frees all PMUs:

save_result()
+--> perf_pmus__destroy()
     +--> perf_pmu__delete()
	  +--> perf_cpu_map__put()
	       +--> cpu_map__delete()

cpu_map__delete() deletes the perf_cpu_map pointed to by variable
online, but this static variable is not set to NULL. In the second
invocation of perf_pmu__create_placeholder_core_pmu() the same
memory locattion stored in variable online is returned.

Later on run_pmu_scan() calls perf_pmus__destroy() again and then
cpu_map__delete() frees the PMU "cpu->cpus" a second time causing
the core dump.

Avoid core dump and always allocate the online CPUs.

Output after:
 # ./perf bench internals pmu-scan
 # Running 'internals/pmu-scan' benchmark:
 Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 7.970 usec (+- 0.147 usec)
  Average PMU scanning took: 60.415 usec (+- 3.986 usec)
 #

Background: s390 z/VM system do not support PMUs for sampling and
counting. In this case dummy events are created by the perf tool
and the PMUs "tool" and "fake" are created and freed.

Fixes: a0c41caebab2f ("perf pmu: Add CPU map for "cpu" PMUs")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 5c329ad614e9..ab9e7a266af9 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -691,12 +691,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 
 struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 {
-	static struct perf_cpu_map *online;
-
-	if (!online)
-		online = perf_cpu_map__new_online_cpus(); /* from /sys/devices/system/cpu/online */
-
-	return online;
+	return perf_cpu_map__new_online_cpus(); /* from /sys/devices/system/cpu/online */
 }
 
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b)
-- 
2.48.1

