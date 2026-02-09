Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5137F8C6;
	Mon,  9 Feb 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651197; cv=none; b=e8zlen4CMJlGdYihIG1G0h3u8pw9f41E06aZQipNpxypRdcMcXGPyCwGcxomdd/2Ox7BDNdkcltwUqndH9MIMQ0vMgOhJVX6mc72YVyU3wEEca6rEwQ8dSfr7wztCC9NWyDn6erqcv9tynQCwz5ir1++rgagSTD66pPGfxDYXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651197; c=relaxed/simple;
	bh=CmPuQBpQF8fa4MEOF/RUrhZWPWN2Y3Qx12OPXF8w5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfNd7osM+C6AWQAI1/RtIb1qTD7EENi2eMEl6wRGAxHIdKzT+lfbF43azu0Sgpv8W18g8XApSs8Li6SzWfhvjrJQ8BVQ3BnLI4N9SUnwscVw0hed5pw2yRVKfyD5HPrKY7Z/oRj+NMFZ3X9uTbGQKkNslbhyIwj6TiJG//HL55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AMWoS0Bg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AMWoS0Bg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619F9UaU198637;
	Mon, 9 Feb 2026 15:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ARyn3B9i4SUdiU7TjeJlfIBtSQ5yQZQ36laaiLpX1
	rY=; b=AMWoS0BgaMA2Otak6DR1l+SIuUtGu1BxwohnAtxrjAiCXbk2AKE6yOJrM
	+Xjh/GWVJj1e56NhtqUd3lkEqOLrFgAWR7j7OqX5jRzRwPeKsm13966q7uLN3Vwk
	XL3mDKnYRLR5ZbkxZ0KPDBTEHTtyhsHp3wYqQByRRfQIPwsGEcMz7tqqbUowEu3G
	ynDZdGuCcQdwbnweZFKrx7/bNadukzkd4Vdkt1rS3ODQAV2WNkC7bu4wAjVD5Psl
	m3TISCXakAXm7cEBuzqchT5rWdnfBx2trRz+oMFgzSEfb5WdpllPu5fM4pEtJDSZ
	oITFHEvCY/DyLcNaCsts/lV+jdlWA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696u7uc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 15:33:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 619CUnB2008883;
	Mon, 9 Feb 2026 15:33:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3y5t4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 15:33:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619FX7OR46268768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 15:33:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADCEE20043;
	Mon,  9 Feb 2026 15:33:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E3E20040;
	Mon,  9 Feb 2026 15:33:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 15:33:07 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH linux-next] perf test: Fix test case perftool-testsuite_report for s390
Date: Mon,  9 Feb 2026 16:32:56 +0100
Message-ID: <20260209153256.601599-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=6989fe39 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=_79wvyOUd3vZcLf8ia0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEyOCBTYWx0ZWRfX7b5Ndm2qHwHF
 PyyWIceLhlZD/oeZC7U0v9bhBUlWaIERGZ3okJVcGOI9tRJpV56PpM0q/dXwdzUpz5nM0jGDYk3
 8CMawW3SA2FS4SiU2Qvpb0M5SMBMdmAJ/W3ZSlBm7BGcJzMqWZmsse2HKn9ShkE/Y2EXeez1u2L
 RguAZ7MrSiLhUwMuxq/68LLZ72Erf7KOuedvmtBtucJbh/NxP4aAcC83HhRuzaWH7TQ6JGjmcVg
 RqAoP56CjBFc6rDT6vYa1VLGujjuIGrNeXtBdJyUkzfHpGk+hUhEqaCpRgCDTizm+jVkjSgh1wX
 Rmu8qzidJLOQ80JpqaEFPgVh74aCdlpeGI659Xo7cNOhjCJnq5JaZ0piEpAl5cm4mjr+qaHANtT
 tgPbO6YF59hqLchLNsCTUGqMcgi2kJ+pkXB0x1q1Ae1CmmU9uKVlr00prP8NV7wFzwjl+6pIJXb
 U1qRtxT0BmDGCgmWsMw==
X-Proofpoint-ORIG-GUID: BuGQbWZji_0V9zhCh5EQxvsOXd9rbC3C
X-Proofpoint-GUID: etUubJAOtcZcaNO8eGgDmZDXeXpTdINp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090128

Test case perftool-testsuite_report fails on s390 for some time
now. Root cause is a time out which is too tight for large s390 machines.
The time out value addr2line_timeout_ms is per default set to 1 second.
This is the maximum time the function read_addr2line_record() waits
for a reply from the forked off tool addr2line, which is started as a
child in interactive mode. It reads stdin (an address in hexadecimal)
and replies on stdout with function name, file name and line
number. This might take more than one second.

However one second is not always enough and the reply from addr2line
tool is not received. Function read_addr2line_record() fails and emits
a warning, which is not expected by the test case. It fails.

Output before:
 # perf test -F 133
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
 ==================
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.087 MB \
	/tmp/perftool-testsuite_report.FHz/perf_report/perf.data.1 \
	(207 samples) ]
 ==================
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
 ## [ PASS ] ## perf_report :: setup SUMMARY
 -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
 Line did not match any pattern: "cmd__addr2line /usr/lib/debug/lib/modules/
 	6.19.0-20260205.rc8.git366.9845cf73f7db.300.fc43.s390x+next/
	vmlinux: could not read first record"
 Line did not match any pattern: "cmd__addr2line /usr/lib/debug/lib/modules/
	6.19.0-20260205.rc8.git366.9845cf73f7db.300.fc43.s390x+next/
	vmlinux: could not read first record"
 -- [ FAIL ] -- perf_report :: test_basic :: basic execution
	(output regexp parsing)
 ....
 133: perftool-testsuite_report      : FAILED!

Output after:
 # ./perf test -F 133
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
 ==================
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.087 MB \
	 /tmp/perftool-testsuite_report.Mlp/perf_report/perf.data.1
	 (188 samples) ]
 ==================
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
 ## [ PASS ] ## perf_report :: setup SUMMARY
 -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
 -- [ PASS ] -- perf_report :: test_basic :: basic execution
 -- [ PASS ] -- perf_report :: test_basic :: number of samples
 -- [ PASS ] -- perf_report :: test_basic :: header
 -- [ PASS ] -- perf_report :: test_basic :: header timestamp
 -- [ PASS ] -- perf_report :: test_basic :: show CPU utilization
 -- [ PASS ] -- perf_report :: test_basic :: pid
 -- [ PASS ] -- perf_report :: test_basic :: non-existing symbol
 -- [ PASS ] -- perf_report :: test_basic :: symbol filter
 -- [ PASS ] -- perf_report :: test_basic :: latency header
 -- [ PASS ] -- perf_report :: test_basic :: default report for latency profile
 -- [ PASS ] -- perf_report :: test_basic :: latency report for latency profile
 -- [ PASS ] -- perf_report :: test_basic :: parallelism histogram
 ## [ PASS ] ## perf_report :: test_basic SUMMARY
 133: perftool-testsuite_report      : Ok
 #

Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/util/addr2line.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index 0f1499350d47..31c0391fffa3 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -18,8 +18,8 @@
 
 #define MAX_INLINE_NEST 1024
 
-/* If addr2line doesn't return data for 1 second then timeout. */
-int addr2line_timeout_ms = 1 * 1000;
+/* If addr2line doesn't return data for 5 seconds then timeout. */
+int addr2line_timeout_ms = 5 * 1000;
 
 static int filename_split(char *filename, unsigned int *line_nr)
 {
-- 
2.53.0

