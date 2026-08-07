Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED84175A88;
	Fri,  7 Aug 2026 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099771; cv=none; b=bXIXVWgzlxBEOoTGi14zHK5M78Zf/5uHw2cPbArASsEoeujeYYwIEAlWUA1oE35K7sZlfqFTxjBm40znzVXTTHJaiWHiBxX6XHDXCpVOu2h3DmT50QwMRaNzbKKsrn5pnBls1wna7C2Gg3Fy7B/giZBPPycoK6UsJTBvqFFGmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099771; c=relaxed/simple;
	bh=DkhQ49c51uJuat9XGk774Ew6mSlPrX5diJfgohRqV4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQ6JhLSK1aY5zWuEC2KXv02AgG6k/pP8upY33Gtt+pSjzXnryBBihaIaFaSasBj8Tu500ik5JpIQzKOldDJo3Zw08YlxNMEvoPj0XQ12J63INWP5MUcLmfZ03XcpDjKnHVpbfMdnOuaUjYsjWPdDh/CaghRrvu3bFbuqL5+zj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y8sKyPh8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y8sKyPh8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HZk84161165;
	Fri, 7 Aug 2026 10:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KjSRorTFu8H1aYUuyCvUih1Wozekhim4uXd29URSB
	aM=; b=Y8sKyPh8nnL0Fj+7gyhZAuQfPglNf+cXQccil94ATOS8WgKERTeEd2Hur
	1dCrHx0UgLD4+MKfTjCI6MT3pSroc17QXbtwkAR7E+7jIplPpyWhvgkX7z5gYUdx
	Ixv2a4QP305v0zhgH9RHLQr9DlqqM6/tEBwUjmvrvm6xLavl0utwZYCU1jX44waa
	h5FWM8h+taBbXrNiTK0nLXr5x8TN0ngt1LveFKTi4PQaaHeft92S0UWJjAMJ1XJb
	6hOgs+k/2DPcqEZVR+BQZqSMTvxWO4jFZlxWbpypQBVfdiQ4Y2IDxZaePsB0nIYD
	BGkDYJx8fUpVM4mT40OQyEkpd7P7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyug1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:49:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AQZ9h008095;
	Fri, 7 Aug 2026 10:49:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhq945-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:49:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AnMMt44106114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:49:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E2432004F;
	Fri,  7 Aug 2026 10:49:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 067CA2004D;
	Fri,  7 Aug 2026 10:49:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 10:49:21 +0000 (GMT)
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
Subject: [PATCH] perf evsel: Improve frame pointer unwinding warning for s390
Date: Fri,  7 Aug 2026 12:49:13 +0200
Message-ID: <20260807104913.1784943-1-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75b838 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=TOY_8snQAAAA:8 a=VnNF1IyMAAAA:8
 a=ynzSfl5vX-4IzXC0hWUA:9 a=1-V9h6BHp-r8_tbamw7_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX7uW/A+1El8ZD
 5fhFPt7vt8C6jwh5qtj0JFXxiCgp3ZVkwRknNggZCUYdK5wgj95qvbhHacILQo7CUvz6HMUrQ51
 aYIWrjSmuaLPPkLxKxAv0NOxzjo+EPU=
X-Proofpoint-ORIG-GUID: rqsTOLS6WfhP8_IHAOvr9qPOy2YJl3hI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfXyKeO+zIp83Au
 pWhQnuGofzZkng1wcY9KRSMaxs45617RQrTjCzB70SXaiOd/EMRt6iJ3fMZMuIbL5PuxOlm3FRJ
 472yLK1M9n0plqvYvsQbt8djKBCX34nmTIYMLypys3eTI9jJ0ZmF6tjghKTwxAkowS5BLB8WF8N
 ix2Fs3SgrOsA6w2GCfmSO53Fa+QTzLHT2aouDTPmxZQ8LLlxoj7Yrr/OL0IPoRzHGixAW0q7yWK
 fHVRIc2P1hnbAilWp5p+CTPD1Xz8J5JpetT8ORQ6jXnbVItqHqP2IWw12SFPjDwX92gPX1au2wF
 E9nSdIhmK5bGTzj7159P09LrSKT3TPe4b2x6HfoKYQDqNlbuEO/JoKqnhI42OoHOpzanIWsAmqd
 erWrXBxV+aDyqEazrTfQRPs89jq/cTWG5D2ixfESw5G7GCUYqRUZY303X40G1crJVJ+WXVSCnNl
 hofVKtiUV17oVKHLDvw==
X-Proofpoint-GUID: N8iL4jKzc_iZSJ_lALxDlS1s_MeJyzfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070083

On s390 the kernel uses s390 back chain instead of frame pointers for
stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
USER_STACKTRACE support").  This is because frame pointers on s390
cannot be used for stack tracing. [1]

This requires user space to maintain a s390 back chain.  For instance
user space to be built with compiler option '-mbackchain' (instead of
'-fno-omit-frame-pointer' used on other architectures, which should
better not be used on s390 [1]).

Only few distributions and users built user space with '-mbackchain'.
Therefore '--call-graph fp' may not produce the expected results.

Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
added a warning for s390 that wrongly claimed that "Framepointer
unwinding lacks kernel support".  Change the warning to hint at using
'--call-graph dwarf' if user space does not maintain a s390 back chain.

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
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ea9fa04429f0..c4d67d1b35f3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1080,7 +1080,8 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
 
 	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
 		pr_warning_once(
-			"Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
+			"Use '--call-graph dwarf' if user space does not maintain a s390 back chain "
+			"(e.g. is not built with '-mbackchain').\n");
 	}
 
 	evsel__set_sample_bit(evsel, CALLCHAIN);

base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
-- 
2.53.0

