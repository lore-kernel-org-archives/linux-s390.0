Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E643C7A4
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777174; cv=none; b=B13VVU6m/jUrlRqnoN6/u4wdDB+XksU1p6ktbfw8+VxdYPprII339SCzeSa3+g0iO1MLEsinqjWZeMecSachXNTCtafA9r+CFAcme3ABsNKUu0ncXiLuoN5w13s8sHAJLC50s1zxhiTprtnCThGJjwKUU9SRnHW7+Llt6TvdLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777174; c=relaxed/simple;
	bh=PiIJhEzJQC+U2RXQdoGTffC6zNtxMoHC0O/L0yQeKs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0jlu1xUP3w1IUeZZtyi1oXfm6t3SCvZ0g0DZ/qB65hD7YfMi0mEUQTYPdl/IUVdKJCG3K7LvlTqNYKEZhU3xWX//8QNs7c0WiXLR+lienduxlC1Oyp1MVvGMCRlQxUCM547zMfDSdg1+0mncWuRHCSBFwa0J5k9xKuVzINw+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g28iOL7t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g28iOL7t"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687A20hn3973531;
	Mon, 7 Sep 2026 10:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dhOFUY/slb8lEyg5s/Y6m7TINfaVYhHeBbhsYaPcZ
	5o=; b=g28iOL7tbUYei/1aeYEBz8yYKbO5VhoKUS2wbaKPHMfzpFNaENIWvrcbP
	GZjuNqUPB/w13jXSWELyF2ySMrmd4NvUvCkWr8Ee9jpAKlQQ3WxBBA4FgaXjqRZY
	C2kjNs3t1L8uTbf993dx1w1BR2HQ398gmroP7DEBPOB85NeFpfmsBN0yLmIX4sWf
	oes3SZl5+aOWYEMP+yPlppjBUcBXl4gkWGPjHgWGMyxzaCrehhbI2obdVNUgjyXB
	WK4c8iI5nSBr7Nb8786ypJT8/97vHTGyQNiEKN4ca6OEhv8pF6RtCfHQdc3gXDsF
	UtQT+dNvV1lPF08YQ2kH9pXK5xV1A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjr3es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 10:32:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687AQHdo004941;
	Mon, 7 Sep 2026 10:32:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymg5684-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 10:32:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687AWdlY42271166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 10:32:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DEDC2004D;
	Mon,  7 Sep 2026 10:32:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 250632004B;
	Mon,  7 Sep 2026 10:32:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 10:32:39 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] perf/core: Allow list_del during perf_event_overflow()
Date: Mon,  7 Sep 2026 12:32:19 +0200
Message-ID: <20260907103219.3006700-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nZvamkAY_rzpPuAa_GwsGcSHijfQsaFB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExNSBTYWx0ZWRfX+Ho35EGMbPN5
 oSWMGsbTd6rrvDO64nu6M3PZT6DkPcikSKIWtVcmgLOLUcGv/kVQD6Xa5aQz7G9i5r6V8+isGuh
 Yp9MNyyWVJDq8Ti6SYy6fwfTXdzKqRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExNSBTYWx0ZWRfX2KZ36THyXC+m
 n9PHHdkGamteKvhORbuJ3JGkidqvoI5ZE8bcckD61laByLCkpCdBFTI0Ih44Yssh71Q+oYCgg9N
 o/HWs9cFzdyc4o+u80o+zMvJv27TaHsikqcxiWHUKI+lc/mxzD3YT1dgBUe47d9AtGrGunA0eAy
 O+VmsJ16y7d46/YK6jx7fcBmvnacPNNMe+SCdR/ODZUo9UGH0vaDEv2e7GQ1tFiEURMiU9pED9x
 N48S5or2aZjjBQfZF1G0YZ63DrNIROVaPLA1XgpuTH3IQvBa6tA7MBDqrOecbt94GdomXKYVZt6
 lzLuZNsxY9O6/Yg5XqrvDX2BsUCMbj7IFOs+Uburk5MMhXkEccur7zSViApq5iNDKnlCQrkWbTm
 mHGg44y3vs1zI8Qn6JzxZE5SWT3boBgtxRN99O892qIjzT587YTV05BNlb9wWF26/XA0G9/3un9
 EU2TTxem+dDciNzGm+g==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6a9e92cc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8
 a=tpjk3lqxN-sNga2Lk8kA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: nZvamkAY_rzpPuAa_GwsGcSHijfQsaFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070115

A PMU might use perf_sched_cb_inc() and perf_sched_cb_dec()
interface to get the PMU call back function pmu::sched_task
invoked at schedule in and schedule out. This is achieved
by walking along the list anchored by sched_cb_list.

The following scenario might lead to a list corruption.

   perf_pmu_sched_task()
      for_each_list_entry(..., &sched_cb_list)
      +--> __perf_pmu_sched_task()
           +--> event->pmu->sched_task())
                +--> PMU_push_sample()
                     +--> perf_event_overflow()
                          +--> __perf_event_overflow()
                               +--> pmu->stop()
                                    +--> perf_sched_cb_dec()
                                         remove entry from sched_cb_list
                                         while list node in use.

This happens when ioctl(fd, PERF_EVENT_IOC_REFRESH, xxx) has been
invoked and perf_event::event_limit hits zero.

Prevent the list corruption and convert for_each_list_entry()
to for_each_list_entry_safe().

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..cdd9518ac046 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3925,13 +3925,13 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 				bool sched_in)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
-	struct perf_cpu_pmu_context *cpc;
+	struct perf_cpu_pmu_context *cpc, *cpc2;
 
 	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
 	if (prev == next || cpuctx->task_ctx)
 		return;
 
-	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
+	list_for_each_entry_safe(cpc, cpc2, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
 		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
 }
 
-- 
2.55.0

