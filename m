Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080F35836E;
	Fri,  5 Jun 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673544; cv=none; b=j1bR6GaSBv6bWcK9KhfGEyM7oaoHYkphLnaDdk82lpym/J+tMZ7IVpIORjNCA5YK3kGMh+9m8RbdQBJJ5sqS7YSNgFoI5LpAhiVf4Rfu620hT+mIH2f7flpDQnu7XiUShbuUCqPSjPnyR3ECekh6AeJ7ji59fK9U85x0/jxxOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673544; c=relaxed/simple;
	bh=fuezBEKZKGxK2NA6ymxqFiDFES+o15ZE5X0gM105ymw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfPRCczASMSemFo58lcyhg10Od7OLqZkGwK5zC0pmnEELEncyH0fMuWs/zVWSHCqRsGwuvRMc8J7LBnoPq68XuO3hClHQXmxyHTep7yNcH1XAnjnS4lBb7kkiWtt2Y8YlR5RaUzB4ETq5BNpgOT0kTB7QN0+glQMT7or+d5XxeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gaJh3fBu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gaJh3fBu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6550EM1I2061758;
	Fri, 5 Jun 2026 15:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fwQ/NamontJB3pIjUjY7KJDYK/cTwJ3D+UyjLMPuj
	p8=; b=gaJh3fBuP8rhifnuY1krQieCW+/4/OKedz0oj6rJ5o+kg7jcFPlOyBfx/
	+VZ2V63DAIQ+1nqHgQuCZk/qHGh4ETA6LGrmuNJMIFK53v/UQgO8UVP3fg95p5g0
	uQiQJSXdcRYVwmcA4fsgdnQcq6uko0ySn9WsaMDjk4eGsV4ReF6pJGR4dQoWgxSF
	YISw0Ie8WLpGXo847ugnIRC6FrMgG3F6/VeTrjBFfWGKCQho81u3P/ZTeDE3pF23
	0bY12aALiGs9v2p3utB8neotPXWFQEoJNBJ+w3CJiQhuAZ3HD0nnKSzOv4XupMV2
	04L7qM/ccZX+mzUHuGimbZBiQSaxw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm5d1kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 15:32:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655FO9dN026386;
	Fri, 5 Jun 2026 15:32:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqht6tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 15:32:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655FW7QS40239424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 15:32:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 049722004B;
	Fri,  5 Jun 2026 15:32:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D952B20043;
	Fri,  5 Jun 2026 15:32:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 15:32:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: Remove GENERIC_LOCKBREAK Kconfig option
Date: Fri,  5 Jun 2026 17:32:06 +0200
Message-ID: <20260605153206.2397521-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ndBGU6FBmQ_qKPLWE3IIv_l4SrNpmTQ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE0OSBTYWx0ZWRfX/8mBBI5cu+hv
 Wx/BoZAG6pOXAzD6UXIe/2W4RJ+k5L3dVmLb3qkm9k1KgGUltm17ZlEs9Y7o4UQw5bjsCsh93we
 xUGmatXbTQlhD9WeRAhG24hnwSPaHMLIvPoysRDbVKnpOE15KjaFepXZV4IRMdE04rG+PBhF05D
 V9zT8FgTE1W60eaxRQq0gJs1Z9AD9+jAaOgoXH/ywQgrb3qEK43zrN030dRlHUf/LDpo5ZSDe95
 pfrxbKn+U+lG7STT6wrK6XZe1rLIsRITfkQ6/JtkU0UhMxZe86VxeduFvlKE6AuEXj1QQgzn4+1
 7ADYBZDlQUTW21ag3rF6akXv4tyD/XHhZfJw6nS7jxyhL4SP9pcx1aFBYVhaPfZsOM4SXlggT06
 c59dCP4YQeUWCIAEasYFmI16+ZkOqCld6CB3aR7fqgxzkmCdATHwZ34kAwAmfsg7oNYANJujZJZ
 9o7MxoTkMaFE2t/xgkw==
X-Proofpoint-ORIG-GUID: ndBGU6FBmQ_qKPLWE3IIv_l4SrNpmTQ5
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a22ebfb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8 a=VnNF1IyMAAAA:8
 a=ZBlrgJuq_Oy-vTlPGZwA:9 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050149

s390 selects GENERIC_LOCKBREAK if PREEMPT is enabled. Reason is a historic
18 years old commit [1] which fixed a compile error for PREEMPT enabled
kernels. Back than only PREEMPT_NONE and PREEMPT_VOLUNTARY kernels were
considered to be important for s390. PREEMPT should "just work".

However, since recently PREEMPT is always enabled [2], which also causes
GENERIC_LOCKBREAK to be always enabled. For some workloads this leads to
massive performance degradation; e.g. a simple kernel compile on machines
with many CPUs may take up to four times longer.

To fix this just remove the GENERIC_LOCKBREAK from s390's Kconfig, since
the compile error from 18 years ago does not exist anymore.

[1] commit b6b40c532a36 ("[S390] Define GENERIC_LOCKBREAK.")
[2] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

Cc: stable@vger.kernel.org
Reported-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..9921a3772bf7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -29,9 +29,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
-config GENERIC_LOCKBREAK
-	def_bool y if PREEMPTION
-
 config AUDIT_ARCH
 	def_bool y
 
-- 
2.53.0

