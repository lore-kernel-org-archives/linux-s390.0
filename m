Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86E330B1A;
	Thu, 13 Nov 2025 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022557; cv=none; b=kxL08yZ14x9VthebmnVgvWz1qeYP4aQTvZAFufU6dWtqq2XGwiXj1WtlaNmZpFLhMcWZW1GnBbbHIpmUx6onBx6PPNTntgc+dGgrx/KC1RJsyjEOqOtEbtgmovBpXxHfNEiCVGVA/V7/gXyP+Gp2YwFKT3xKAeoUDG8Y06FACRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022557; c=relaxed/simple;
	bh=7hMQ+mno9Y5n3nOfnDEY/SMSS/iXAH+7VO2WKBVSNs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYFqufNYqU1wxKvdvP4P6hhzCBIBQKgGCKkOsvZ/QXSs0GC4Z/TjDPVnqpJ2+bfl8W2r6n9eNikS9wuuwOL6jI93eEjJqL8EaYVHe09utep++lAf9Ytm+Jupecz7aK9adUyAZ2VHJtOAvIC2cOEoxhaBh8BI9YVsE1i5wV6KvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BOB8kM4a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BOB8kM4a"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACIVCAC007740;
	Thu, 13 Nov 2025 08:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4zdvesLttmWF+7BiAE2jf3zs1qt1baNFMfNaYviEv
	1w=; b=BOB8kM4aWHpBP0R9Ofd1cOCBrd9dmMpN7B235vIvoOqZb48pAJWf2IVim
	WBlWkXrjRmIL6nAa8UUjMC9QgTXcumuB548TYpreqh6AMDCDZI980hitlt18RD8C
	SW3bhkPit65dFMb5LbUX3xp0g87YMUpwNOjVD3xvxvEz1jedhwJix2i9QvMz0i/0
	UIhYLH0q+atsA2VUgvifUWw/pQ0G1iIQmVSoFwhmsBBHsaqcSX6dW5LeHZq/HcQw
	eXZmwHMFvUP8ts/F+lMZJAdZQdGSXMcCxihoP9JotTg5McI85hqJOZtAIGdQTuXs
	6+wDuGNRo09hG8GpS1EVDBlrytfoA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8ev88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:29:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AD8RVbO024959;
	Thu, 13 Nov 2025 08:29:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8ev85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:29:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8R3U1014859;
	Thu, 13 Nov 2025 08:29:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpkcshu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:29:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD8T7j040894774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:29:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36E0220040;
	Thu, 13 Nov 2025 08:29:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07A0320043;
	Thu, 13 Nov 2025 08:29:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 08:29:06 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH linux-next] perf stat: Regression perf stat -T cpi fails on s390 z/VM guest systems
Date: Thu, 13 Nov 2025 09:28:51 +0100
Message-ID: <20251113082852.2902356-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX56jhHZRfXwqN
 YwpPZOblhwAhfW1oRi0QzzB4VYJsEzdec6wuRpBwutVZgu8v2f9kHza0oDWz2atn1doOBvuXiI0
 sBkOaCpoEo2+nraVKMH3rDpk5uh5weIkNScCcwvAZymoyIek1P9OQdLyax+QVX2YfaNvHFeu3Y1
 rwjjTSO8I2SpKzZc0cKNJ9QpBbQG6DzPMy6jYt1Sb03kiuy6y4BTOq1kt0bGYSN/aPjL/ANzPMH
 kkMjeNaJWRUaxUMObJ40eROLCfleOd0eUQ4I5INi3LPx/P6hanc73i/Jdrq4RTeoyqiG9oOqKcZ
 8RqV5oaTjCAIw86sy2p3p2JU+GziOOuA7eNwHeTcbSCB0bumrmKTqvTM5adYX4frf7IdZHBSc5b
 prHDh4IRIQZTkI/qfIM+Er624ybR/Q==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=691596d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=1ivgOJDEaqisGwhKzeIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DmDJlubNOYXC9cTf-kSwEtj-8tCa7IJD
X-Proofpoint-GUID: 9KhmGPdBgR6jbY4QKIwk-3jfrvjzHz_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

On s390 z/VM systems (linux guest on s390 LPAR) this happens:

 # perf test 96 97
 96: perf all metricgroups test        : FAILED!
 97: perf all metrics test             : FAILED!

This test works on the linux repo:
 # perf test 95 96
 95: perf all metricgroups test        : Ok
 96: perf all metrics test             : Ok

On both systems the command
 # ./perf list --raw-dump metric
 cpi est_cpi finite_cpi l1mp l2p l3p l4lp l4rp memp prbstate scpl1m \
	tlb_miss tlb_percent transaction
shows the same list of available metrics.

On z/VM the CPU Measurement facilities do not exist:

 # ll  /sys/devices/cpum_cf/events
 ls: cannot access '/sys/devices/cpum_cf/events': No such file or directory
 #

The json files for s390 define the metric 'cpi' in
arch/s390/cf_z16/transaction.json:

  {
    "BriefDescription": "Cycles per Instruction",
    "MetricName": "cpi",
    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS \
                                if has_event(INSTRUCTIONS) else 0"
  },

The macro has_event(INSTRUCTIONS) now refers to a legacy event which
always exists. It is always true even when the hardware does not
support this event. Change the has_event(xxx) to check for a hardware
event not available, for example CPU_CYCLES.

Fixes: 0012e0fa221b ("perf jevents: Add legacy-hardware and legacy-cache json")
Suggested by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/pmu-events/arch/s390/cf_z16/transaction.json | 8 ++++----
 tools/perf/pmu-events/arch/s390/cf_z17/transaction.json | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
index 3ab1d3a6638c..26c550621d6a 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
@@ -7,17 +7,17 @@
   {
     "BriefDescription": "Cycles per Instruction",
     "MetricName": "cpi",
-    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Problem State Instruction Ratio",
     "MetricName": "prbstate",
-    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Level One Miss per 100 Instructions",
     "MetricName": "l1mp",
-    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 2 cache",
@@ -52,7 +52,7 @@
   {
     "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
     "MetricName": "est_cpi",
-    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
index 74df533c8b6f..4d296e0c8934 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
@@ -7,17 +7,17 @@
   {
     "BriefDescription": "Cycles per Instruction",
     "MetricName": "cpi",
-    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Problem State Instruction Ratio",
     "MetricName": "prbstate",
-    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Level One Miss per 100 Instructions",
     "MetricName": "l1mp",
-    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 2 cache",
@@ -52,7 +52,7 @@
   {
     "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
     "MetricName": "est_cpi",
-    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
-- 
2.51.1

