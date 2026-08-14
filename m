Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5893DA7C3
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710006; cv=none; b=QjOz+WMNnHMEGGCEndCjysDcRW3KAoJNxI7Fgq1lkW5/Yv6UV8V8qgpA6dYUjC32PJ2vIwsxO6B6ckIsRIwkxVgYxE49arYm1yC5gK+shpOc0CBHLYHOv9e4f3goFSxT1yqyXOkKOaJIVauGWiHjyI6t/W+ini6h8D+bSsEiEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710006; c=relaxed/simple;
	bh=5FbtwonHEWebeNTHxkengX8esPED8hhxd98jQbw5yy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBvSFnRHOn0IpFC5Mvmr2xC2KE+uEMXi19xY4iSYdI9uVOWzK10saFDZ2Toq4XGJ6IjFcqxAPQ3Fmy5ZRBk1l7Iby8j7yCKmFQ+KF3+3Tbnh3xwYWUFad5BwPQcLo4U7XzBZoYTJsGql1SfDH8JUSQe2MM+fO0OAuo/p2/9Gic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KmpSVxmO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KmpSVxmO"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1jVP3273910
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=i50Ta8YEv09agBQLkp5J6wOmEdz4B4LPWBzwiq6n2
	3A=; b=KmpSVxmOfmVOuiQMu9eD/BOotHK0QtNBU8L3kPkgSGeYuf/vQLy2bQ0bR
	nEnYFKStAR1Z6zI3vOPj5twoTKwR/6qMnFT9VDjutYrz2U4a5rmJzKMBVMJmV+UF
	prdwREG2Ms/VBnSA/FQMg+9np1UjC0vuXZfC2n/qmqeDR648o5Xj1q0IHVvY4ZeT
	IdTJp2DoKiIJsF9J2nHUJ5pnZ2ME5hCmsDRpWs/endCd6MZh1cOuyFvdnBAnKXFb
	GeA/TlISSRNsSaGpEivPidOMDrp6eDgjW0U1i3uG98i0Hgn0QtpYezVyUMTNOqz/
	1jGHDbqM8CikppiDvgRsfkAPpTCKw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0cp1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:20:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ECBfhY018670
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:20:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv9y3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:20:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ECJx7s50004272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 12:19:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93AEC2004B;
	Fri, 14 Aug 2026 12:19:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 744BF20040;
	Fri, 14 Aug 2026 12:19:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 12:19:59 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, japo@linux.ibm.com
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] s390/pai: Handle multiple PMU stop callback invocations
Date: Fri, 14 Aug 2026 14:19:58 +0200
Message-ID: <20260814121958.2408863-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfXxHfKJiiKXiht
 DDtOuA8ca/4vY/mzXC+1MnU5jXh1sdOX0+ms1zNrz0jQVvD1j8DxTt5/fhT6RKviChcgcUewYxa
 7r3O3Ij0+id8kOQDCg7JRaYWS0eEfTCdj2GU292Th2ERb6JkMAV7C38NYLkJddjSsyM9vUGDXwG
 S0Kzks11+aIgzaOlLr+bbLOgTNsNOY+QINxoEkz1lytHfrBO1iWIP+zUjOMD6KLZDc+8Zd7brWb
 golvOhaVxQgSeDVWQapyv4ofdsDxSIKbhAqbg1kSKe2zntvo/jOm3wQsLbDiJmPie7vWdCKHQds
 /lrUBvdgCj/tbLch2kFRXLPpU1AgFDkeA26fB6aKHWZc5tv8mrOmgoik5rNs9P44oFAIHxEzFCz
 XzlRePuHQ2HAgQFEG9DJgQ35jL1JtJIx8aFVXMhtzF9hOpp4d24nxzEnZG1wplfVPqlpcBrIOQW
 4R+zMbx79ZwIZIQ5hVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX+su8w6K2nNVz
 kbKCYs+L9GlPur8jb6k+smPKgbPxqP2m38TLkw2a5NRnvuw0dzvI7LP11z4ehVB9fyzkcw9SXFv
 QHXCy1hh1Z5Ldrx++FEnF/mPkDLB434=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7f07f4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=b6_6n78pCtPly934600A:9
X-Proofpoint-GUID: bm6XSrhvq9PSdJ_EVNWzkNMK0P5uzpjN
X-Proofpoint-ORIG-GUID: bm6XSrhvq9PSdJ_EVNWzkNMK0P5uzpjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091

Handle the following scenario:
The kernel protects itself against a very high sampling load and
throttles the sampling using:

  perf_event_throttle() --> PMU->stop()

Shortly later the scheduler may terminate the task and removes it from the
CPU. It again calls

  PMU->stop()

which results in two invocations of PMU->stop() called back to back.
Protect against this and check the PERF_HES_STOPPED bit on function
entry.  If it is already set return.
Clear bit PERF_HES_STOPPED in PMU->start().

Cc: stable@vger.kernel.org # v6.19+
Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 1e5a1f1cc68a..f6790f658f21 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -484,6 +484,7 @@ static void pai_start(struct perf_event *event, int flags,
 			cpump->event = event;
 		}
 	}
+	event->hw.state &= ~PERF_HES_STOPPED;
 }
 
 static void paicrypt_start(struct perf_event *event, int flags)
@@ -530,6 +531,13 @@ static void pai_stop(struct perf_event *event, int flags)
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
 
+	/* Cope with multiple invocations:
+	 *   1. perf_event_throttle() --> PMU->stop()
+	 *   2. task schedules out --> PMU->stop()
+	 * Check for event already stopped.
+	 */
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
 	if (!event->attr.sample_period) {	/* Counting */
 		pai_pmu[idx].pmu->read(event);
 	} else {				/* Sampling */
-- 
2.55.0

