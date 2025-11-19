Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112B346780;
	Wed, 19 Nov 2025 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549309; cv=none; b=KoQpKyVcwFSNXMudHLmsS0Ssx+VaR35j45RPj4CyDyDK1rWsDMVrCgQN+tMZDT5u7PLMNBsVmkz20d/EEBm+nJIQSQzF6c7Qv8fcDG/cuMLFrK6vF44MDtrMKFzldBdbolPb8MtdHFNv0u9ilOnJW+RSWFkOWS6ycWfbnNO95wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549309; c=relaxed/simple;
	bh=kMT0ZzWp63kDA17ol75ffzc2At9Ul8sk3tSyxXVumcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C896b2Js3CGoGAgJe8cw4S31xFk7JBdRifLJBBgSGR93vn18FMKFd6DM3wVjdaz4SuWfpg91EuzthZGy1jYh9rHx9Y0mhlB9JWlZxqTgUAJEaNj8ZjT8TRvIqcRN+ckGarOP0M35SSEyJwHe6F9vTBYDqlYmiPjkiMsViyZJBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jyYqwpdB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jyYqwpdB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ6UUZO003110;
	Wed, 19 Nov 2025 10:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=t3PwjL3QmlNiCI+JRw2jGFl0WLlmDkeiR7GE4NHOK
	zA=; b=jyYqwpdBpDJkk7COLVQSLvCGh56DTbMYRqzfNXUa9YsCzL1lypcmrwSCI
	OblYPufhZR0+OeaKAM/UjzkbKkzY+IehdIHo2pO0I3XtHN8V+eni2wZ0xLuDsMuu
	LtIv2GUDYRuEepXNKKlJI0rCa64sKU6ETWCWxCCyYliDJIrbeFFRYp2WXxgcqikm
	gJoIVzWCWUpddtqoWeI05L+CDoiK5/2KzHwVcFMwn8/YmVSCw9Zce7Jbx3o6ctEF
	oc/wEP+hZllNe2U9iGiMt3AyXkBb6VqRZt37rJdjHQwqWzRXg0SdVPQab2zK41LK
	ufSsa8W/Ev7kYld8iHcXufHc5PdSw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1fxpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:48:03 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJAcqg3017085;
	Wed, 19 Nov 2025 10:48:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1fxpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:48:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8vL2i017335;
	Wed, 19 Nov 2025 10:48:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1quu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:48:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJAlwZg43319552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 10:47:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0323C20043;
	Wed, 19 Nov 2025 10:47:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF8C920040;
	Wed, 19 Nov 2025 10:47:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 10:47:57 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH linux-next] perf tests: Handle s390 metrics in perf all metrics test
Date: Wed, 19 Nov 2025 11:47:51 +0100
Message-ID: <20251119104751.51960-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691da063 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=LEUDr0dq1Xqas2V5W20A:9
X-Proofpoint-GUID: 18ZAZuQdO48430WzIPKsEDHMCr-EBQcf
X-Proofpoint-ORIG-GUID: rbYlv0U9DC6xYfBPlXq05gduhZAXCZQd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX51MjMo/Q/9FD
 5HJ5L7mjkOvSA3/+aR4H0Y2/vpHxMxKSvox36bsjpDmKolZnFVRs7/8Gx3GxNmhYics8ylXC6mg
 9B2aO3XthB7t3aoPSyh9BeOzsLn9cjH/mG2hQwW1HXUbHhGsGWHRTUHpAZC1kCakJcQLpcAfhCa
 RR1Uw7B56U7ykTU5J4uvjj5z/uA36go/Uap694sktA3GNcJaFw56n7hGZBoS/zWGVNVdfLHidnn
 h7v2zQ1ro6uNnOSj4h59CMVUkpkD3kh2xBlJ41DRcub/tdvEuDOeIqi+tCLqPwyiR+DPw3+MVqL
 0LRgHQo2e89HNFQGID/5vAMdYwh6EN08YR1upT+pE2SO95Z9/Dl6P7MfTsHFMCAhJaE95QLvkme
 +Kob3hEXNGKlcmL339xuvuxw90YeKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

This test case fails on s390 because some counters metrics
are not available and the metric defined on them fail.
Add s390x specific list of metrics to be skipped.

Add an extra line to display which metric has been skipped.
It is shown with the verbose option turned on.

Also return "Ok" instead of "Skipped" when no errors
have been detected, but some metric have been skipped.
The seems more logical otherwise "Skipped" means all
metric tests have been skipped instead of just a few.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index a7edf01b3943..b86b36a49228 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -7,6 +7,10 @@ ParanoidAndNotRoot()
   [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
 }
 
+# Ignore metric which are not supported on s390x
+[ "$(uname -m)" = "s390x" ] && ignore="|branch_miss_rate|l1d_miss_rate|llc_miss_rate|\
+		dtlb_miss_rate|itlb_miss_rate|l1i_miss_rate|l1_prefetch_miss_rate"
+
 test_prog="sleep 0.01"
 system_wide_flag="-a"
 if ParanoidAndNotRoot 0
@@ -27,9 +31,10 @@ for m in $(perf list --raw-dump metrics); do
   fi
   if [[ "$result" =~ "Cannot resolve IDs for" || "$result" =~ "No supported events found" ]]
   then
-    if [[ "$m" == @(l1_prefetch_miss_rate|stalled_cycles_per_instruction) ]]
+    if [[ "$m" == @(l1_prefetch_miss_rate|stalled_cycles_per_instruction$ignore) ]]
     then
       # Default metrics that may use unsupported events.
+      echo "Skipped metric $m"
       continue
     fi
     echo "Metric contains missing events"
@@ -106,4 +111,5 @@ for m in $(perf list --raw-dump metrics); do
   err=1
 done
 
+[ "$err" -eq 2 ] && err=0
 exit "$err"
-- 
2.51.1

