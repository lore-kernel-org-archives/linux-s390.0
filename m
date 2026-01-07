Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78F325496;
	Wed,  7 Jan 2026 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779336; cv=none; b=F/tnn+p6eFX7BNQyvg1lwQ7zR1YW1PLDBTBM0OLV4DdAFgxlFet7cljCaflNQNtPmWN+BgOpQxl8xX4O3EKUBNldNOxtwcDse5u9N2ud22diKVcKgJg+ojFg5vRwGYbP9nggjEYkMnqjyH2/4EAbUKGG8azN77Vxxg633mwHNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779336; c=relaxed/simple;
	bh=oZKC028Z3QXIrAUDNuQLoBmqL7yRhPYrPJxt2Y4G4/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJ7SfFyrOjNiDjlq6PwQwjcxhWAbY+5vgeI2keJsX6IKzpK6kE08V76yKvepgGebOnSiLiQ82C/ccIONQkImy1sw9ERdrmoh++4LQQRKUIKKK6/PFIPZFpUhskn6BHa7UdNJQXuxbY4vxe3A+xRWR9iKXxgeI9h0THopesR2Lvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NljUXzVZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NljUXzVZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6074pf4W012994;
	Wed, 7 Jan 2026 09:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FBvZikJRdqdsJy7zDRmQHwGCKaTqRX/GR2ibMhY6/
	+4=; b=NljUXzVZ9tVzLVPrASgBadmiP7twlrXjyNA5qJ9yT+RjiceHqVKTxWpHT
	tOOM0f/jR/DywnMYUQQhiJjN/Sx3x1vJvowjdPKS7S/9XndvbDvy9ttWp65ILP63
	PCAbd9m3d7StIe6tNG960ZMZ1YK02ZbLPqNADFVDNCm/Sbn9tHZllu/hO0eOKZTl
	K7hHfotBCwowgRJ8+iAeIlhhk+RFi0Fpi5vWtLVN6RwgdepIwjVoGhKedZ+UaqI4
	yNLqmDfqKdwB2djKdOtBxLff4CFNf/xYJc/qV+/zXKjcRENr0/q7ZVVvZSeewaVg
	LoT1MO7XknyzZJIbjcSQUoy54L/bQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtq2jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 09:48:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6079ksar022785;
	Wed, 7 Jan 2026 09:48:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtq2jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 09:48:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60797jiq019177;
	Wed, 7 Jan 2026 09:48:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg5180bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 09:48:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6079mjIc28967386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 09:48:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 811732004B;
	Wed,  7 Jan 2026 09:48:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5099820043;
	Wed,  7 Jan 2026 09:48:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 09:48:45 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        james.clark@linaro.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix test perf stat tests for virtualized machines
Date: Wed,  7 Jan 2026 10:48:34 +0100
Message-ID: <20260107094835.131882-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695e2c02 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=ES110z2zfcq2d9H_b0wA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HniPeJF81023eeROaBqgkU8abRveXX9s
X-Proofpoint-ORIG-GUID: 7c6PyDHdwJlcuRClxOTQmvzCs5bVni2f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3OSBTYWx0ZWRfX2oBWz9grm2PY
 WxOaxFkIe7gRW1FOcbFtGX1TjJW7nx5s4BAkQYY3kySu/DygMvhNWz0eOfu9w36LCTli6R0CkEf
 vObR7xiZ0mM9ek50IwcJTMnm7xNtgkcBWHXrXvGoeqj8BkwEubWrmDIBau9RTITTdor+wy2Iu8d
 nKd+wBC6tbGhjralh9mUSHmvwE8RQ2PCf02Q/aY0o3v0ZseBUPxWqwjrI47Qv5AtXTkH/59X03M
 kgOVdaCeUFlW3OTnB+pjbcZceWfxL42PY4K1j33Rdw6E8ah4VzoO2TvvMbe+Cx3TZPjKeuSom8X
 v1okOCM1RwrS8zvTvNP49NIUIkWT0RyoGpeYxFKqizEX+raBLSqS81XrN/ksDag2W6GMurEMJk9
 wACCRBO/wVhuJKlLH70NwYp1gmzJrvQZ7U8MjtgdNWsCX+DK7/zqL6PrFMMki3kk7ZD7KgFZq6Y
 6UH82vWHHDajLZsiCZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070079

On s390 perf test 'perf stat tests', subtest test_hybrid fails
for z/VM systems.
The root cause is this statement:

  $(perf stat -a -- sleep 0.1 2>&1 |\
                  grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]* -c)

The perf stat output on a s390 z/VM system is

 # perf stat -a -- sleep 0.1 2>&1
 Performance counter stats for 'system wide':

       56      context-switches  #     46.3 cs/sec  cs_per_second
 1,210.41 msec cpu-clock         #     11.9 CPUs  CPUs_utilized
       12      cpu-migrations    #      9.9 migrations/sec ...
       81      page-faults       #     66.9 faults/sec ...

       0.100891009 seconds time elapsed

The grep command does not match any single line and exits with error
code 1. As the bash script is executed with set -e, it aborts with the
first error code being non-zero.

Fix this and use wc -l to count matching lines instead of grep ... -c.

Output before:
 # perf test 102
 102: perf stat tests                      : FAILED!
 #
Output after:
 # perf test 102
 102: perf stat tests                      : Ok
 #

Fixes: 65d11821910bd ("perf test: Add a test for default perf stat command")
Cc: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/stat.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 0b2f0f88ca16..792a0b79f6b8 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -233,7 +233,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  "  | wc -l)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.52.0

