Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3EE2BDC0F;
	Wed,  8 Apr 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646449; cv=none; b=R0kvEq7+L+jhu9u5MZNknnC+dF/bxEGqNQx+G/JN1dfjYo2uam6cTiGNSY2SMYx6LaAwfC/cQ0wNDF3EeWseNBfCAJiyfNf9QPqxfKPqciMCNRN6m8kSRa1EZQCVWiPhL5ULl5y/2ZCeraQGiH2sFUDG1t/3olqxgLqiI0lpPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646449; c=relaxed/simple;
	bh=19vbLqPdTUlNx1WFl/wGwXpywhRBdNmV1VtBvbNkiIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKnOnRQ3cz4DTVCSmm0TWfp5QWTT0MqoKdppsog7cOshddZf02iz5L8/SStJDS10RpErQ7U+0pHaIxGmFOw8VYKFlpobDNirk0A5iTKGmPD5Nyhyp3ObikxIg38Ygz1t6CRcmfOWj7kSy0CV1WH6zY42Wk6z9SztqpMCQMKu7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sc7onZT3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sc7onZT3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63863Ome2297912;
	Wed, 8 Apr 2026 11:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wiRMxmsrb28fEqS/U4AJs5Mp8MAMN3ylj4MGtduei
	kY=; b=sc7onZT3ZG9pXq9yVQ4iyev4nZYeDgS9okB+kCJkXM25hTfj3xTepmfa4
	9E918MtOvn3h6NA+aKu5iKMTQGbafiYhGJVSWXnZzFGvEe0AkfsF2tVHyeP4+5SW
	t5ByZgAwPjHxfnQ4Xyp/krKRvlM4a83xohsu3Nt9JIecjjBC/XIeGEBkud0uHHwe
	WFqACdZ0TigWRL5njuMmeYV1BXl88rZEd5+07ZKESbbQy7IVPpHoBlNqAZ2L4j5g
	0fe4wnnOpuMemQGaIUFwSwyutGr/w3o1AV0E7cITGlIHRB7iXkeFMrsjNf2MPgK2
	Ld9NkCquhG+DkgFZ0b7dFyE71qc7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fy27q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 11:07:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63868far013827;
	Wed, 8 Apr 2026 11:07:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4744n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 11:07:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638B7J3129491522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 11:07:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 123712004B;
	Wed,  8 Apr 2026 11:07:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D46C020043;
	Wed,  8 Apr 2026 11:07:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 11:07:18 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, howardchu95@gmail.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Run test 126 exclusive
Date: Wed,  8 Apr 2026 13:07:07 +0200
Message-ID: <20260408110707.1455185-1-tmricht@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d636ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=gVPXMIi6xhloL7uG51kA:9
X-Proofpoint-ORIG-GUID: T3JrhOh6XAvTe3kTl71ILbLPjI3soKYg
X-Proofpoint-GUID: vnTbDliFq1GU3_W1YpUAFyquXY_qfVzA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA5OSBTYWx0ZWRfX/pdSI9ZX2JQd
 ek227LS2fJu6lHO0q+FaDAv4N51DrA42VFGcXP1hFtbz9vWl/pquRgwImCNAQFHcQyac3fiWn5r
 1UksS1/Bhlr7lLBrB018HwCouR/6uWGItCq4H5ml3ISzpZHAsXw9bqiGn3e7Q2W9dqFp8Mh/Zht
 zSr6PptAZi9Mjl3/oDDQ/ZoSesngplof4lEMnIRHba2IaIYkW/K0KvkcpRkibKaSnYeYYe0tPrZ
 fuRgmaZR70ZjRmvj0ekep19LIt9MtjqqrvL+utxX3fqtt4TQZPw+yeIxewDiqCNyAlp0bm5heV/
 tVpnr+hf79LbpfsBIQ1xFmNsH+Xs75cSTS/V4eGVzwMT0N4CToHzn8WZAbfwVTBKilR9L6mnLie
 CGdKtfatAK9j2ydXEpMaURiQtoYM64F2RUEVu6quAHw6iBq72tswy0Pfic0cOL4st7i0X6Ag7Cw
 LJdpdB5F7E2zGGdbUaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080099

Running both tests cases 126 128 together causes the first test case
126 to fail:
 # for i in $(seq 3); do perf test 126 128; done
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
Make test case 126 exclusive and it works.

Output after:
 # for i in $(seq 3); do perf test 126 128; done
 126: perf trace exit race                           : Ok
 128: mmap interface tests                           :
 128.1: Read samples using the mmap interface        : Ok
 128.2: User space counter reading of instructions   : Ok
 128.3: User space counter reading of cycles         : Ok
 128.4: User space counter disabling instructions    : Ok
 128.5: User space counter disabling cycles          : Ok
 126: perf trace exit race                           : Ok
 128: mmap interface tests                           :
 128.1: Read samples using the mmap interface        : Ok
 128.2: User space counter reading of instructions   : Ok
 128.3: User space counter reading of cycles         : Ok
 128.4: User space counter disabling instructions    : Ok
 128.5: User space counter disabling cycles          : Ok
 126: perf trace exit race                           : Ok
 128: mmap interface tests                           :
 128.1: Read samples using the mmap interface        : Ok
 128.2: User space counter reading of instructions   : Ok
 128.3: User space counter reading of cycles         : Ok
 128.4: User space counter disabling instructions    : Ok
 128.5: User space counter disabling cycles          : Ok
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

