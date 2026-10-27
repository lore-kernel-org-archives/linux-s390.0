Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111440;
	b=JyAFpn/lDDAsYOOwtagj4Ath7KH58Vo5xFrjqxdNLK0gWMM51rBYRNFAUkytf0SJw16T
	 L+S0PLND+WmgHbwIWcx6uexc1n+ErvkY3Y3qp93DFKkKW+kpA4uAbaKTDeYw9UJjC58f1
	 6Bchh6YlMc3BmkDwk9ztgrAxR+9bX1AL3XRIDbheGucBkOLpspJ+XzAuR8atbF6W7mURo
	 kRsFNKTSvf1zoJlsE89rn2B5itwQm6m0vwdH6Hh4nq/uTvm3MZD/oLLaqsXz1o3wpXLjx
	 7RuL6iDSdWrv5eJVIEBUA41MST3ybTmRoQeOcXA9VdwSU6A9jK9F2rvV3r3XsG/0tCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111440;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=969Cd/qqDS7OBhkeihGQAnRlR/UG7I8Zr1MfRD7Om1U=;
	b=c/cOx246fCukVvsGWY6Ykx8LUA/tQAlO/e+OGyUfkDevtDYyffCNnRjiFJtK7PFwsKDp
	 E96wTlAEya4/nEybyc8AEP7uAd9cQai9CQXaMmJs1VtDcvD0MNPxcnVlcIzTE8mPHnycR
	 ezpNddUjg1bPOjOvenwbUNDwSHW0GyVg7QlipHUV4h5xbzy87iOLg4KSVcB7RismIHfoT
	 HfazzcXmlkGYQAKfr5WVruFWDbusZGmosVsBhST//YTKHkAaVmO3fKy+4Vucjfu6vwERK
	 FWyzpCUsg87/0yCXEjC9XJ/vOdbBitlhYnJddiJrTAZiNSPsKihdXiAl45vZZW86sVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oxZTpBMn;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F060A263E;
	Tue, 27 Oct 2026 14:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 094F060A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oxZTpBMn
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REEM6Y2897946;
	Tue, 27 Oct 2026 14:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=969Cd/qqDS7OBhkei
	hGQAnRlR/UG7I8Zr1MfRD7Om1U=; b=oxZTpBMnaROrkaUSkIDWkFxT0kcED9Lh1
	7s+r6Uv7cS32g88NM0WjEspNq69WkgblhzBLcHOiQEdapdc6GMbHAeco83QNuHGV
	C7noE5VL7muK3zb29X0M1ub+d8mgjeoF/PfMqo7c/+zkTTQcNKczmyggAS+vDM/2
	7IKF/8XysWCaFLBknvmaHYcnl8Yc2Nts9r/4fU/qOp6KrclRnzC1CbAW8FcAKnUa
	N72Mrlg9STu0dLBuUpRGEbA1/O8aHUxGVHYAsMhUKbSO6eYuzaijJxHypvglEuHN
	ajU8hsnN1Im9C7G90nZDOO3SsTttVOrHcAHFTxvzEFsBVlwsyCzpA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm640032-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoM9u098140;
	Tue, 27 Oct 2026 14:30:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1rcxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUWPj43712842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F8AE20043;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34E032005A;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 07/10] s390/nospec-branch: Serialize text patching with text_mutex
Date: Tue, 27 Oct 2026 15:30:27 +0100
Message-ID: <20261027143030.3154657-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX7r4kjAlBm1Jc
 zxxgRWtSF0dG/+5TRvpc6aVVX9Wb32PsfjAmff5+BQT8I0mieDyVbjUdUBQQErvEk0RNCC6lwZl
 XZkoy+fz+cd7EYKvow00hdqWm8/DVMo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX40dbjl/rsd+9
 JeDmdb2l6HMG8mBR/eb/fhUnwDT3hk806ChbH9Wvldc49L9FCs+RDERzGDHvaf2nKhZw7chROsu
 7Mxfqo9KFmu/UnsE6adefoumf4Iy2xZECSaXMZfBEOkFATgWivHkalnqJRoUX067QPgh/ORpxSM
 JMOqgOX8dZ/4HxGZhTKhXzq3+KY7I6QSH6rfEK3mEELANGDLGdL+tlRFDc7GjCCwW2PoSbl2R33
 xozszeXXiNdv3oc9k1+jHw7/b8Qjk91S7m05Q26TL5cEoM85A8nG7yHkwFHTwWIV1QUv2y3gWEN
 XANTiaqIpoWmAIkUG6C4KlQLYYO0dzQf8+6OLdMX6g4bopuAS2tMnKxc9bvQzmxX0IfH+ndwFWJ
 hkpYA/GlsSnukG8ak38TZtO7KV/a/Z5wBeh47drPsDxot73hsi3dsCUe/J1rgIsIPOXOl3+7T74
 8mPfHtGhQhiZ798Kv7w==
X-Proofpoint-ORIG-GUID: aNrq8SaD4EAmg3aleOyTL1bVIhZdt-D6
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae0b58f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=fwsI9ysbrLTR6U1S1t8A:9
X-Proofpoint-GUID: aNrq8SaD4EAmg3aleOyTL1bVIhZdt-D6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270056

Acquire text_mutex inside __nospec_revert() around the patching loop.

Serialization is not required for __nospec_revert(), however this is
part of larger series where at the end s390_kernel_write() requires
that callers hold text_mutex.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/nospec-branch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index e11ec15960a1..26cd5b278e8a 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
@@ -108,6 +109,7 @@ static void __init_or_module __nospec_revert(s32 *start, s32 *end)
 
 	/* Second part of the instruction replace is always a nop */
 	memcpy(insnbuf + 2, branch, sizeof(branch));
+	guard(mutex)(&text_mutex);
 	for (epo = start; epo < end; epo++) {
 		instr = (u8 *) epo + *epo;
 		if (instr[0] == 0xc0 && (instr[1] & 0x0f) == 0x04)
-- 
2.53.0

