Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84A377A94;
	Fri, 17 Jul 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295108; cv=none; b=XfagWD0dorw88tdCINJSmFgs4xU+wP3CBXy3tbuWoOS1G5LXl1ptWOhEOl8RFw9BLllYpuV8gN7/GE9SpX6w8TkreqoreuZEnzdLMVkTwryVZdbV2k1myRhL9736vFFzQqqT6yNF05tgyB4fxzsas6Q4FiEg85T3RjMPR/T1sEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295108; c=relaxed/simple;
	bh=hk51UZRwDpzpKxx9P4zvwhGwspRE5OxvnqU6o9gzdmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fU3rFnYA3RckMivkn3PhyW799htM5ohSCTqVztVc5fiEt1tDMCeuQSx2cnPUOLQSOBQDI6boZuCudR8fsk+WCwDRhvEk+1xH3llPAXXteVrGxcCtgOYqNWISVAa4E8AEdOvxi4kutuPZrNiFcPloqnicAUQELUBLFd0rQLnxx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N6lYy2nd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N6lYy2nd"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCfeBe1958516;
	Fri, 17 Jul 2026 13:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+MQ4b7YGVoFB5jVdfOX1Gg+Xf/Lj1K/kI7fKFwRXb
	mU=; b=N6lYy2ndAsNy0H7kv2egcbF0mirRfVNlDZNi4K0rCOUc2JXKhZVuf9rp2
	jVwrPlzQgc3RQ5m9PBpcZNXc9oi6+8nnCJJpKvijRwu+Y5ydiHE3nH7x+e4Lsm0D
	Rvxe28pU2fu4hnAt66La0eTru0L7OVchw9VJhBXlSfotntKb2LtwA/LDkiZulZaj
	GfKkyptLxBmPWcDMdb/qhFwSm4iY3SOYTgLzaE+//mH+pB8qGq+knaF7nhyG95Ew
	9xFZzUiEF8H88RNi3XNqK/4B2uzOFQT/lcY2cEncrA7czjuvZjbFZJHiRhRhxaP0
	xY3l3HB/DDYRq+dunThi53JvGdhzg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx5kky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:31:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HDJalL016644;
	Fri, 17 Jul 2026 13:31:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qj1xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:31:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HDVfPE23069212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 13:31:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D5D15805F;
	Fri, 17 Jul 2026 13:31:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF3B5805D;
	Fri, 17 Jul 2026 13:31:39 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 13:31:38 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2] KVM: s390: pv: ignore ultravisor donated storage for kmemleak
Date: Fri, 17 Jul 2026 15:31:36 +0200
Message-ID: <20260717133136.5188-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vMDo-FkDkQctxov75FUBk-7CmdV_p2Qq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfXxG244d2E2Yc4
 1FeNaPZk+Sop53svZLZWWAEug1iAL5vhVLSr5bhICj6Dlw5agjXrPyB9KlR7wAbMQFRloo65VfA
 xHCeDEPjqR/lLplx7OdfxeN8XB2sXosfrDYbWvABPoyElCjeSyOTIEF+iR2Qzfzx89q1aGkcyOA
 UQ6r0PoZ3IENRGOgJAnyzpK3fK1QwhmOimcfz4N+e/E+k27IRzD4TXFKt11z8I4n9y4jBmRdL1x
 ls0H65b8n+5Jd00wjIm6lxLz/ffADQ44x9T8AcrIzsg1nyjcj+DX21mFSKJkOlsM+1lQgsiJ+/V
 SxP5KxFUW5AR0CY+rM/J5OP8RByUYrxJLTHgdcq+kOO6/1Yq3S5DmX0oG1zCjY9xxbehuvH8U5f
 /b1DvBZXRTJ5p/IsGn8l/QpioSy9LqnJ97jvlotnguWLfDa+oSovosY3zrhucclSpbiJBbSHSTI
 H8TxSbhzJYS5wzLsP6Q==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a5a2ebe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=3_QFYANXyXRq7ZT6DTcA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: vMDo-FkDkQctxov75FUBk-7CmdV_p2Qq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfX7Eoc7spr8rne
 0TejjAmB+UmXnKlHCfH0OlHeK6ed6JUs+mgCvlu2o3Zde1li0KAWBuYTkEJhac2EXvuh0RYx/Y1
 OqbZ9cquXysLdDMvas0AlaWMfOfZjr0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170134

ignore ultravisor base storage memory that was donated early on for
kmemleak to avoid kernel crashes when accessing such memory.

Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
v1->v2: rebase on linux/master
 arch/s390/kernel/uv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index a284f98d9716..7dde37c365a9 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -16,6 +16,7 @@
 #include <linux/swap.h>
 #include <linux/pagewalk.h>
 #include <linux/backing-dev.h>
+#include <linux/kmemleak.h>
 #include <asm/facility.h>
 #include <asm/sections.h>
 #include <asm/uv.h>
@@ -70,6 +71,7 @@ void __init setup_uv(void)
 			uv_info.uv_base_stor_len);
 		goto fail;
 	}
+	kmemleak_ignore_phys(__pa(uv_stor_base));
 
 	if (uv_init(__pa(uv_stor_base), uv_info.uv_base_stor_len)) {
 		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
-- 
2.53.0

