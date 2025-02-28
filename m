Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7C1C1F05;
	Fri, 28 Feb 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723785; cv=none; b=MyE67gLSj4OX9zGi5LGtAqaFWPq77vWLmP3l5I6EJhRHhW3V1B2JCupSqS4tl1GHi9N35yYE2Nx8+LdqnJCSHLh0V7owPq8tJxywum+nUCV8T3m5+TW8eOmaM+veECKvKaNamxVvW1xFH0ZpXFaNXri+KAjY0Fop0DImzuZD420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723785; c=relaxed/simple;
	bh=UtukjhqwGE0Hd8fZJV2n1uZQXu3dhW86zoX/NQCG38Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJ+9VL11Rvf0ztkcnNfV3Nh4pXLKzL7fUTkz4i9rxlPpN+xB+ayexVWXV4KK0I+dmoDTyKNyqCVV2Fu/l7sDXOhbCuQlV0ltiV9y1CH3fqIgRW7dOUgBLYQjHvfrow0U/PqbjgJcHAcDbuTBntV1ePqxufMscdt/1C49yikGaS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E8sgEQ21; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E8sgEQ21"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMoAVp015771;
	Fri, 28 Feb 2025 06:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=at2Cnga4f2JPFrAj6Uq/CQvl4vfboJ7HHptuh4+ln
	Dg=; b=E8sgEQ2187zol8L3njf5nh9uQbzzP9jTPrnVOe96NgEw5EedaUMUbcnHU
	lH/Fkhr1+2BlhJSTNAyWOS6APsDPEzn5qmcK5iwe1DLnoazwKaHWMFx/CWhv49sx
	wWArwXvDvThuG1tEprohLItfeaY7aiKxBMm9OhehzK2J5KIWxJM/Hq3XlmshPnEf
	upAQNLQkdKJmpWvJlm3lLIhN/+f9zNwHsRfVbDMrgab6rrPGEFIbhNL0xN7OsSFB
	l2mIiufBDPhWFvh7OzjSZUGs6IDLdtZJhTkYxJRmPw0YdpJBxEoW4BKJH1rhzhsF
	NWwIDVsJsa7dQwZ8gI1SwJ0prjbtw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45316a9mxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:22:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S5pigP012565;
	Fri, 28 Feb 2025 06:22:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwt578d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:22:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51S6MnF532506600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:22:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22D6A20043;
	Fri, 28 Feb 2025 06:22:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED85E20040;
	Fri, 28 Feb 2025 06:22:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 06:22:48 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: Skip leader sampling for s390
Date: Fri, 28 Feb 2025 07:22:41 +0100
Message-ID: <20250228062241.303309-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b-UWM9UWIsRBaQOJaLwYWM5LfZ1D-jg6
X-Proofpoint-GUID: b-UWM9UWIsRBaQOJaLwYWM5LfZ1D-jg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280041

In tree linux-next
the perf test case 114 'perf record tests' has a subtest
named 'Basic leader sampling test' which always fails on s390.
Root cause is this invocation

 # perf record -vv -e '{cycles,cycles}:Su' -- perf test -w brstack

 ...
 In the debug output the following 2 event are installed:

 ------------------------------------------------------------
 perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
  read_format                      ID|GROUP|LOST
  disabled                         1
  exclude_kernel                   1
  exclude_hv                       1
  freq                             1
  sample_id_all                    1
 ------------------------------------------------------------
 sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
 ------------------------------------------------------------
 perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
  read_format                      ID|GROUP|LOST
  exclude_kernel                   1
  exclude_hv                       1
  sample_id_all                    1
 ------------------------------------------------------------
 sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8 = 6
 ...

The first event is the group leader and is installed as sampling event.
The secound one is group member and is installed as counting event.

Namhyung Kim confirms this observation:
> Yep, the syntax '{event1,event2}:S' is for group leader sampling which
> reduces the overhead of PMU interrupts.  The idea is that those events
> are scheduled together so sampling is enabled only for the leader
> (usually the first) event and it reads counts from the member events
> using PERF_SAMPLE_READ.
>
> So they should have the same counts if it uses the same events in a
> group.

However this does not work on s390. s390 has one dedicated sampling PMU
which supports only one event. A different PMU is used for counting.
Both run concurrently using different setups and frequencies.

On s390x a sampling event is setup using a preset trigger and a large
buffer. The hardware
 - writes a samples (64 bytes) into this buffer
   when a given number of CPU instructions has been executed.
 - and triggers an interrupt when the buffer gets full.
The trigger has just a few possible values.

On s390x the counting event cycles is used to read out the numer of
CPU cycles executed.

On s390 above invocation created 2 events executed on 2 different
PMU and the result are diffent values from two independently running
PMUs which do not match in a consistent and reliably as on Intel:

 # ./perf record  -e '{cycles,cycles}:Su' -- perf test -w brstack
   ...
 # ./perf script
   perf 2799437 92568.845118:  5508000 cycles:  3ffbcb898b6 do_lookup_x+0x196
   perf 2799437 92568.845119:  1377000 cycles:  3ffbcb898b6 do_lookup_x+0x196
   perf 2799437 92568.845120:  4131000 cycles:  3ffbcb897e8 do_lookup_x+0xc8
   perf 2799437 92568.845121:  1377000 cycles:  3ffbcb8a37c _dl_lookup_symbol
   perf 2799437 92568.845122:  1377000 cycles:  3ffbcb89558 check_match+0x18
   perf 2799437 92568.845123:  2754000 cycles:  3ffbcb89b2a do_lookup_x+0x40a
   perf 2799437 92568.845124:  1377000 cycles:  3ffbcb89b1e do_lookup_x+0x3fe

As can be seen the result match very often but not all the time
make this test on s390 failing very, very often.

This patch bypasses this test on s390.

Output before:
 # ./perf test 114
 114: perf record tests                       : FAILED!
 #

Output after:
 # ./perf test 114
 114: perf record tests                       : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/shell/record.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index ba8d873d3ca7..98b69820bc5f 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -231,6 +231,12 @@ test_cgroup() {
 
 test_leader_sampling() {
   echo "Basic leader sampling test"
+  if [ "$(uname -m)" = s390x ]
+  then
+    echo "Leader sampling skipped"
+    ((skipped+=1))
+    return
+  fi
   if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
     perf test -w brstack 2> /dev/null
   then
-- 
2.45.2

