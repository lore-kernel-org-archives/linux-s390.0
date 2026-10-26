Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016216;
	b=caP4Zi3BfY2CzrMZVLz3SWDJG+ESz1PtvvNq7NM+sI4KPZje7GjKiwsCiNer83eJQze+
	 EsxVRiUgykIZrV655m8AwRUlHRxHKk6iYiDm2mhlmvSYi/VtVBRvBWOiQTz0tZWi3mElp
	 G8RtAV9qRX9umAiuLOnCzAksbGXjrKfCzG+lBs9Y+BmMjVIPe8JAF3KFxygJR/Dcpd2zC
	 rkIWBTKanoapzWKezPL4qDK/gIL8RDhzeK6Yi8VYVJbwave6IyLA+pYgV0gg1i6g8Ra3o
	 kppaNdRHcNCTXwPvZ/mAe6FtdCuBeEUNaXSS5e1Dpi/yaI9FEYrxlvJzSayZ+JudimA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016216;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MnIePYRDUxTzNLe90TBTOBH+8H3yqJvdjytvDQGfuBE=;
	b=eYO3ykNcEGIRD+xBJfQGb3LXZpkEyUPG7Z91sb2wv20AqlhNLHXdy02e8JIKVVnjVKF3
	 r6B/fVXHx/DsRqFWoyNxYxiqw6G/UT6Qoop/QhNqgWe0lr3U4LN8fa35WYAccxNN7Cfhy
	 G4jhPSxcUy6e/J38aMWvJEV0di+wcVQuu8lvO6drt7wzd2eSV9ewvDRgb11OCGaFQEEz6
	 cXeRPvfO8ok3lGFrWsHl9tpvNleKmirp2xeD78j/y2qA+QgxsqruX+ynm6VOjdRmSGsJ1
	 wuEOJuNEClTd/eo5ZXpdjtZfqp/TQGFV9JGJisNSEDQ+Ha3Q010clW++ey8yjUZmGFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bcQ6a1eu;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB5606A31B;
	Mon, 26 Oct 2026 12:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDAB5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bcQ6a1eu
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBE9vY3452428;
	Mon, 26 Oct 2026 12:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MnIePYRDUxTzNLe90
	TBTOBH+8H3yqJvdjytvDQGfuBE=; b=bcQ6a1euo1smvhVmDEY8eu26CzoFVDn1Z
	hKK2nfGkbYuJa3p8bBJlzC2xmxrtAyFfHgS42hz6W4LjeU8uNBqbG4Iotp2ZVAPx
	8avz3wdhk+Xm8t6LIUo6pZzzyzLTKeO+mT48XTkrf1qL4V2hg3QTFhb45Tf1Rr5D
	BtkYoJkoaro434YuOuKzvkZnDFz8a3l831lf+WCOgqOxw64ZfVbC8hpOmAbu3fUR
	GFGH3eROl/Gpa9PXhdL27B27sQ8peDJ3Zv2a69IFaZolyZLJFCJbcn1gU4VASUH6
	hRmY644Ri4zmem65Jp0IWnDyFT/Kpf/8j8baI1chhgzqje0guXKcA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm63sr3p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBJwoh2442758;
	Mon, 26 Oct 2026 12:03:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvdth2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QC3UFh46268856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 12:03:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E70020040;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D22C2004D;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/4] s390/jump_label: Serialize text patching with text_mutex
Date: Mon, 26 Oct 2026 13:03:26 +0100
Message-ID: <20261026120329.1792436-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026120329.1792436-1-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfX8vXI1n/2007y
 WVexTP0Hj+fIg/vj3LZlLHI7g+Db1CJ/0p9RWaVr6jrndL9IkGAZUXhk/8b3gEnbcNTrfEg5ChY
 ZAbey86AN3SrDwx1Do6LLEW9w5TmoGs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfXwLB1zcEch5zL
 DkTPvfw404/mwwUf8BTuCT6xdZB8CN1to9TTrOSIGJkh2ZVN0MHvaKuBOEGt78oGib/zOFrsrAq
 KF+4BV+xPHfFa4a0DZRyvn3mznHVqCzyAzcgXneOV/XpWvYnhnXEdGrNV0whaKbkYC9nj1Ydf3c
 poLB9u7Jl2r8sQb7NQNzvt54cgnWtam4Kr/B2AqkAIA40b3v/1N+p9YR6CIIwqs/PKasP+D/bFR
 kv5fR6cD+bLOptkD+rP/MeF3xeV4H1oOY1rO3LW86stfV9c5LjFL2DWnrVeilp4nGbbPq5UoFa5
 FP+CDc9tTCUC1uwf5POKZsgMoQmxq01s8j7Be4FWyPTNQyyM7AXTivs3BkTUeJbApuqpLVZfO1n
 aU0IhV3ZxiakdWUYXwcnRHlryC/PfOYJ4J9uUNdQq1+pvWvmYRK2Qh+6kAP+gB/RtKVXVTjJCOY
 HaUX6M7Dp4UXIgvfcxA==
X-Proofpoint-ORIG-GUID: PV_DNF0FDcSiaNC5W6deopK-GwcE09VD
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6adf4197 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Qv2Z5fm34N4ByW7sTngA:9
X-Proofpoint-GUID: PV_DNF0FDcSiaNC5W6deopK-GwcE09VD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260046

Acquire text_mutex around the verify-then-patch sequence in
jump_label_transform(). This way s390 uses text_mutex like other
architectures and does not need to rely on other implicit semantics
(e.g. no kprobe can be set on a jump label).

This is a prereq for removing the spinlock in __s390_kernel_write().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/jump_label.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index e808bb8bc0da..682069673f48 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -5,6 +5,7 @@
  * Copyright IBM Corp. 2011
  * Author(s): Jan Glauber <jang@linux.vnet.ibm.com>
  */
+#include <linux/memory.h>
 #include <linux/uaccess.h>
 #include <linux/jump_label.h>
 #include <linux/module.h>
@@ -57,9 +58,11 @@ static void jump_label_transform(struct jump_entry *entry,
 		jump_label_make_branch(entry, &old);
 		jump_label_make_nop(entry, &new);
 	}
+	mutex_lock(&text_mutex);
 	if (memcmp(code, &old, sizeof(old)))
 		jump_label_bug(entry, &old, &new);
 	s390_kernel_write(code, &new, sizeof(new));
+	mutex_unlock(&text_mutex);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
-- 
2.53.0

