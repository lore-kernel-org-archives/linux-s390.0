Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E822F8E85;
	Fri, 21 Aug 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316951; cv=none; b=lI2dYZgxZcV/QuDh+zeTpOPfighnsP+0nU3pt8mvz/jgskw4kmBIkrG0bWvjPCh1scZttFZxjPCKclYGqA34OAElGUXKSZqGJbf1f+sESEEuKpqPvNFCy/dOCje3NgNGeewJlshT3owZMZb06UC1xZwZHIHC4g379mmp1kl8lwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316951; c=relaxed/simple;
	bh=mJRRdq2R7x8TspZMcnGLPBXKInKiyG8vcNaA3qlPSNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+h68lmWdsmcdIcaoKNDH+SLUQcQXyJtOAszw3eUlpC58zbfQJ4Da4WDYaJrLWHCJr5dF0FtmMvt/cX8mO07UQzo/dhz3mhvbLfjKMZzRkERvPFhm6jyC+ijDCD1J+elBXZnyo2QIEN3JrVrhOI0sfdf0PfS8k3FN6+A90gVYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZG6H7MG1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZG6H7MG1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LC1ZR13766812;
	Fri, 21 Aug 2026 12:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pBqbwgkUhPFmQOTjhx2dofM6M6KhQk0qUUsxMRWdx
	/Q=; b=ZG6H7MG1NZTEt5NhUtOVvCbXjbrfcK5hoKbQ9MdpFDhilMX/6C78Y5o/+
	YQ/9NfY91WNIpTrsybvpZJ1xrM52SBe7LFeSZjOoJTC+j6cdqgCqlRq+aAD2QYck
	kEou0Vsg6JI1hnQjKZ92PNQVeiso/ljRiypMb9c9a8POya973BH+ZgqGxn1/jXwU
	Alt1o2PYpL/6EVrIn7un4RO+Ea2TPOH6yyFQI9i+h8k6k12I0gpDLd8xmjA6E8Ab
	7XC1FoCXQ/aXKN+6l0VXn7HR8EB+/9sGTTuM7quqcm56S/nU4A5YyDbnA0XoBQ+Y
	Zrh519ThOo0sWdNIz5M+Ss78jqBrA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0hhca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:55:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCkqgZ013611;
	Fri, 21 Aug 2026 12:55:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngvgfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:55:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LCte9551708384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 12:55:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BF0320043;
	Fri, 21 Aug 2026 12:55:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2861420040;
	Fri, 21 Aug 2026 12:55:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 12:55:40 +0000 (GMT)
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
Subject: [PATCH v2] perf evsel: Improve callchain warning for s390
Date: Fri, 21 Aug 2026 14:55:38 +0200
Message-ID: <20260821125538.3721169-1-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: gAgGQZNH0FFKqepVbXJWZtTJmMgPHkBZ
X-Proofpoint-GUID: dJmeqmiMzsRJBiAaJYzVbvp7uWzWYJKg
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a884ad3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=TOY_8snQAAAA:8 a=VnNF1IyMAAAA:8
 a=7t6sRi0A84GeM7WtoYcA:9 a=1-V9h6BHp-r8_tbamw7_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX9GOrZhqoN7AP
 W8xQCnsZ8LOcRgr7+ZpOs3rYMXNGJoXCS99uv6MiJUJtg+zxHkdO9LIfK6VVX5iEPOdkStS1kxF
 FpxmZZW6E1aCW+A+SmjJq5Q3YVdOo/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX1evyWjIrQOp9
 qLgc5Atu8i9+7b9p5jHf6Dz52bp4J2oyHKErGZh7fZDSKmAbRlmHVFOv7UmJoKaBYTkZMDNbqV3
 aJ7LoVuZxiEt+ZcPKV9Xna5YHNs3AN+kzHeFrTXueqbpv7jK56G61HSvpfZVNp1X89A6zFCUDNm
 B4buHJTJkZyYgPATFNWgodS45QFxcDTJtkPV3x3fH1N07pPlMmG0mGk4YyrSAJ/in3Z5y9KH/9X
 6+teDy7bwXPaFnSEAJKI7gXTvvtDaRsgXywLG+9HzCEkfucDwolwFLjUNK/W/XSM2HAwwF484wn
 vaxtgiA5ZcaWRspQLdD4GT0F3EEow0bYJD8YbQIKqP15JZlVrh4Ym+ZgKIexxj+rN+clgSdTiyc
 zZgMy57xxiA4yuQyK3dkClUY6kXPrluXIM7qtY0wCCfk5+N+bxzZT6t3ErqIoC2GM6ajmwV2Acd
 ABWml5h4cV64Vngkqnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

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
provided by the CPUMSF hardware PMU, because that combination is not
supported.

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
 tools/perf/Documentation/perf-record.txt | 7 ++++++-
 tools/perf/util/evsel.c                  | 5 ++---
 2 files changed, 8 insertions(+), 4 deletions(-)

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
index ea9fa04429f0..3b5c3654d9d7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1078,9 +1078,8 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
 	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
 
-	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
-		pr_warning_once(
-			"Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
+	if (EM_HOST == EM_S390 && evsel->pmu && !perf_pmu__is_software(evsel->pmu)) {
+		pr_warning_once("Cannot use hardware CPUMSF event with -g and --call-graph.\n");
 	}
 
 	evsel__set_sample_bit(evsel, CALLCHAIN);

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.53.0

