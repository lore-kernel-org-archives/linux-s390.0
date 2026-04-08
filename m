Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180D2F3C18;
	Wed,  8 Apr 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647917; cv=none; b=TjRtZe6KQWEdPOmQkI2MukzmUyXoxozHkK5RadxYut6QmXWmIF9+ghzs35C7mFBILSkofeFC3hF3joMHSsLD8JxuZsrg0lz2bg+JUvvmdx1vDEihSkfm+m20d5xiwN6YD/sc5ALKs52pIFo6crTb2cSWyTE67BVyEpfF7dHstHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647917; c=relaxed/simple;
	bh=rKzk6mgKCPtLM4wQ+RvDbzYcb9KpxmVDIVwySQias80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOL8BI0En3BOJIUx5IjZU9br8UqmN/3NMMUtMcg2ffkcNstI8tLcDZBiEw6v2x04vCFrf8SeZ+xPiL4hipcAdKm+q0F+yJ8er3Lh86qRZxVb0wJgioVrk/sudV+b00QyQ0at4ZtE9WS8WRn/3njt8CCwqgcrS7e6r9Fq7ErAexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eAgJlIUr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eAgJlIUr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638441eE2297727;
	Wed, 8 Apr 2026 11:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=R31XZymasesZeWcOOhzDqz7xh3zahljlpFSsIbGxR
	gk=; b=eAgJlIUreF8mE1z1xnbyykM10s6fS9OwZgKpQIVcZuT2vfbv5Njc9kyL3
	0+MhTxQyogpmoEccuydDAeymz+kyVe4n0fL5dqFR2LBJPbjgi/SQ/amRe0TLR6HV
	7vcUv6mVDYe1V2xBnHjOiTc7JYlQyTYVa6dEvT1dodA+GlEDovIR1aUy6bno5UMr
	/ZqxbSQiNKtddXcZce5mtw26bqxCQ3MvK9XlKkmF6HT7IYdOxElE5TE/C+LPeYWS
	26UvfyQzhAvaGwWuxhazL0gnyybUMRiPWsNa6qOPS7nbuKIdXSgt3cmrbqo6/CCV
	3bbYQ/fc5kQSobmcx7+Ec7kgzs1sQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fy4ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 11:31:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638BASBK013878;
	Wed, 8 Apr 2026 11:31:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf476ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 11:31:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638BVl7e55968252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 11:31:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78CF12004D;
	Wed,  8 Apr 2026 11:31:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FFA42004B;
	Wed,  8 Apr 2026 11:31:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 11:31:47 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, howardchu95@gmail.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Run test 126 exclusive
Date: Wed,  8 Apr 2026 13:31:43 +0200
Message-ID: <20260408113143.1645091-1-tmricht@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d63ca8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=bNJXeJHnkcElx3EIz2QA:9
X-Proofpoint-ORIG-GUID: TQCBUXivFhyzNaBdPcqMCAVRK4qFKhGC
X-Proofpoint-GUID: tLGpT-52PWVfne8RAXaAzS5sLS0hrQbv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDEwNCBTYWx0ZWRfXy0CKdNMEUPRC
 LRNOVEGNXF8Da+xHvdGOLjMZCkQ8uEdGjk9yzpi62K2eea1CXkH6fujntBPm61ahUBR+PEDHRO/
 UbCauAMzvULIVWOJhNPV9LZYqa0972urJ3kZEw4CF28DBX50pVHlumwb0HYg0zOUnynl6jhuhEf
 PM7Z/Yj6jzTFiEvaQrxmT6Fwoc3FtTa8aWIMgbLvK8VxUQMOF2622iCSX8BSIcjKcNTR1A2axC3
 2B7bBDl3gTSBkBbbJGr04o4tzz7pl2KrBxXj2VOQavxXtBsLoUXT7z/Gn9v9nMYLTecLoM6AYBj
 MjzquXhdII7FY2zmesGAOq/nKT2ERXWISokcHHwOVWFaJkvKRgg6pq3+a2gkegJAXLIbZP4U/lZ
 DMq6xJsI9lCo3+t6hn2P3ntsczV87x9t0E4GSFYU0vU1ub/t/pezaotqYXhpD2YVqBBMaytV+iP
 DVnDoPUTeKepId9N7QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080104

V1 --> V2 Fixed commit message

Running both tests cases 126 128 together causes the first test case
126 to fail:
 # for i in $(seq 3); do ./perf test 126 128; done
 126: perf trace BTF general tests    : FAILED!
 128: perf trace record and replay    : Ok
 126: perf trace BTF general tests    : FAILED!
 128: perf trace record and replay    : Ok
 126: perf trace BTF general tests    : FAILED!
 128: perf trace record and replay    : Ok
 #

Test case 126 fails because test case 128 runs concurrently as can
be observed using a ps -ef | grep perf output list on a different
window. Both do a perf trace command concurrently.
Make test case 'perf trace BTF general tests' exclusive.

Output after:
 # for i in $(seq 3); do ./perf test 'perf trace BTF general tests' \
	'perf trace record and replay'; done
 127: perf trace BTF general tests                   : Ok
 155: perf trace record and replay                   : Ok
 127: perf trace BTF general tests                   : Ok
 155: perf trace record and replay                   : Ok
 127: perf trace BTF general tests                   : Ok
 155: perf trace record and replay                   : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index ef2da806be6b..7a94a5743924 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf trace BTF general tests
+# perf trace BTF general tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
-- 
2.53.0

