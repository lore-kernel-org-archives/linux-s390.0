Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F074F3EDC;
	Tue, 22 Sep 2026 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088191; cv=none; b=gKXWuYt6+qlDpmKyjyP+IBE6YulOWxjL2oFTB5uzONJXp3LZ/ApprG0AFU8Oq3nJ6qxzyPXjvaOtxQBPAYnh3FEDOjjKBQhPj0EeN6ROTVxnsGQUbA63TmbU1AJbrFELO90BwOBXFqf+sEyyAZfeWDISfrn+zideOcX3sJCKdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088191; c=relaxed/simple;
	bh=4mj7Vzz5zDMP2KzdsKhKBXEVPBO4bkLy1+oWAOeLUMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeqLl+fikFx2PyjDZySsjwq/SDIeztvGHtISHJlvfMgSscZuSyOQq0RR5DvoImTxHmamcf8TbjHbW5HbhmYXPBhZbdv2MW6cr08q9maGsTGRcoRS+l4W11MgnLk+L/gYcT/oY27tI1dMMHsR6GNK8tk4aW6VHZEWvRrR1wEJfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mf0lsJbC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mf0lsJbC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBZiVv151857;
	Tue, 22 Sep 2026 14:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zM3T+k5lvFtKrDLDyntQQOkesxdxGMnXZlmsLk7+3
	fE=; b=Mf0lsJbCP3ZWSVspIj918Q8cC+kTYHreviIoFSpAkJlwktqCavfieM0xg
	6N4oy7R9zsZ3wdDzx3LtAnsCP0CTWekXKo9uKL5zT54sSw4dP31XY7i1QJ2AE1IN
	2OnLAM2qDuStvDBXuA88T21Az0e98CFWynY8oKie9woRNbHyPV5VN60ZsozvGXoh
	T8/LjMGy0h3LzKLfNF492+pd3mdwl/Wcht8Q1dsXLGU4kOxJo32glT568ShxG39F
	KWn1xcrBod7m3+ckhIEK1wI1R7yGb+nm4+xCCPeFrxKGMy1p+8V1oyRyZl31OMgs
	ik6g52/Wkp3OdmhemtVSStENi1kzw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1e3cg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 14:43:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBWWQS2774601;
	Tue, 22 Sep 2026 14:43:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vjag6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 14:43:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MEh1Qb37749240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 14:43:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB94720043;
	Tue, 22 Sep 2026 14:43:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FED920040;
	Tue, 22 Sep 2026 14:43:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 14:43:01 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] perf evsel: Improve callchain warning for s390
Date: Tue, 22 Sep 2026 16:43:00 +0200
Message-ID: <20260922144300.1217524-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Sx5C3Mfj3crbMULlbd9kBHboE544xirR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIxMyBTYWx0ZWRfX43GEH3AT+frO
 HvqrZZpy9DJKDHZbE/J6n8IzFVUxr20WoeAFulFIRvOgOr4xaRIADtcsCld74qw3iuEv1uhMoNP
 lf+8pC/vIUOOz0Vpg9Kr/RDxw/dk4mEhJleP2jbgliYlBKsjpecuHs73C8sou7MhTx7soLXMtjQ
 lKnlqbbCxZGQ9RZipB6Xvn28+/o3vNPKNZI+uxsXPdyMwpIfMJnsoZLpv3SV7HJh0gtmzGEzvZk
 MDYrwZTOADb74mkDT7lLMsj1/qfxqxTS9uYzUXXx3rP8RIONbHnnH0vDM7II+rqbY0yfNDQuLni
 cmH7HQvvN+yz6zSXRdgNM+Lj2lKXvdtHzq/lj43Ja1LadWCLbayQPMygtzO9KPlc5U38gFR5frv
 M+pu24iVYASRiv+d3huJ7H04nhZtnn7TESxUyG6NswFTVjIDBznDcFZP1fYPCosOyuap92AN1Pn
 L86ZHGcEn61U1EHIi2A==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab293fa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=TOY_8snQAAAA:8 a=VnNF1IyMAAAA:8
 a=bSomeuANTSra_1gJXeoA:9 a=1-V9h6BHp-r8_tbamw7_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIxMyBTYWx0ZWRfXzux8wPlKNdXo
 qzaqJEHzCGyaR8GUolNKHQHEjUgT0OBKamGbIUgJbUyUpi/wLwiVI7aOUfb1PjZ2eUpWqLTncuk
 oQ4V73QQC4Rv/3jWv0Cao8Bakd0e2nY=
X-Proofpoint-GUID: S1ORB89rBLmxiwEQKDB4dZoWoCVB4OJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220213

On s390 the kernel uses s390 back chain instead of frame pointers for
stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
USER_STACKTRACE support").  This is because frame pointers on s390
cannot be used for stack tracing. [1]

This requires user space to maintain a s390 back chain.  For instance
user space to be built with compiler option '-mbackchain' (instead of
'-fno-omit-frame-pointer' used on other architectures, which should
better not be used on s390 [1]).  Only few distributions and users build
user space with '-mbackchain'.  Therefore '--call-graph fp' may in
practice not produce the expected results.

Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
changed the default '-g' option to 'dwarf' on s390 and added a warning
for s390 that wrongly claimed that "Framepointer unwinding lacks kernel
support".  This warning resulted from a misinterpretation of comments
in s390 cpumsf_pmu_event_init().

The restriction in cpumsf_pmu_event_init() applies to callchain sampling
with the s390 CPU Measurement Sampling Facility (CPUMSF) hardware PMU.
CPUMSF events, such as 'cycles', do not support callchain sampling.
This is independent of whether perf uses the 'fp' or 'dwarf' call-graph
mode.  The CPUMSF PMU provides samples collected asynchronously, making
it impossible to associate a callchain to the historic IPs.  Therefore
callchains can only be used with software events on s390.

Remove the incorrect warning.  The kernel supports the 'fp' call-graph
mode on s390 by walking the back chain.  Do not replace it with a
hint to use 'dwarf' when the resulting callchain is incomplete.  Such a
suggestion could imply that 'fp' is inherently inferior.  The same
general limitation exists on other architectures when user space is not
built with frame pointers (i.e. '-fno-omit-frame-pointers').

Instead, warn on s390 when callchain sampling is requested with an event
provided by the CPUMCF or CPUMSF hardware PMUs, because that combination
is not supported.

Update the perf record documentation to state that 'dwarf' is the
default call-graph mode on s390 and that 'fp' uses back chain instead
of frame pointers on s390.

Note that '--call-graph fp' may also be useful for other applications,
such as OpenJDK maintaining a s390 back chain (does not require JVM
option '-XX:+PreserveFramePointer' on s390):

  $ perf record --call-graph fp ... -- \
    java -XX:+UnlockDiagnosticVMOptions -XX:+DumpPerfMapAtExit ...

[1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
     https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/

Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v3:
    - Updated warning message.
    - Rebased on v7.3-rc4.

 tools/perf/Documentation/perf-record.txt | 7 ++++++-
 tools/perf/util/evsel.c                  | 6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 178f483140ed..dc72606cb25d 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -293,7 +293,7 @@ OPTIONS
 
 --call-graph::
 	Setup and enable call-graph (stack chain/backtrace) recording,
-	implies -g.  Default is "fp" (for user space).
+	implies -g.  Default is "fp" for user space (s390 uses "dwarf").
 
 	The unwinding method used for kernel space is dependent on the
 	unwinder used by the active kernel configuration, i.e
@@ -329,6 +329,11 @@ OPTIONS
 	enable deferred user callchain which will collect user-space callchains
 	when the thread returns to the user space.
 
+	On s390, the "fp" method uses back chain instead of frame pointers,
+	which requires user space to maintain a back chain (e.g. compiler
+	option -mbackchain).  Without a maintained back chain this produces
+	bogus call graphs.  In that case use "dwarf" instead.
+
 -q::
 --quiet::
 	Don't print any warnings or messages, useful for scripting.
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4cb455f4a7d..55297b8dab37 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1092,9 +1092,9 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
 	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
 
-	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
-		pr_warning_once(
-			"Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
+	if (EM_HOST == EM_S390 && evsel->pmu && !perf_pmu__is_software(evsel->pmu)) {
+		pr_warning_once("Cannot use hardware PMU 'cpum_cf' / 'cpum_sf' event with callchain. "
+				"Use a software 'cpu-clock' / 'task-clock' event.\n");
 	}
 
 	evsel__set_sample_bit(evsel, CALLCHAIN);

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

