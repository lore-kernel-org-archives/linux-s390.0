Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB84C10FD;
	Mon, 21 Sep 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006304; cv=none; b=pFiNl9NRnZBf9Z5kZo546GLcDiuOTsBgZuE46Ih7J70Ses/lvYp6R3nWN/AA9vUQ+1ba/YP6/uMpdn/7Qu7ykTHaleBHI4ditw2BLDO1Ic/PcNGJwY/LeU9ztYjFbrCitLa9nWxOJybgiWZcAMgRJ3UNzT+s1jrhIzRsArEoPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006304; c=relaxed/simple;
	bh=ETfxXUjrRH4J/di1U8Xgg8F4wjJw+tcsn5O1uG+VX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDSEf2t5utrScpC5qF1Hq0B6wO8QLVEmoSVRr5OCWd+oRYiQ1oTCiI2gqts7L1DISfZvZ0XvNxO4N3rJ+KzZxhkB1apyg1bnbyynHsKqnxnLipOFyAHJXaPYVsgzjnHV38ZADW0gnwluVOPGKI1oJf1JROp75OCGUt+Mp1urUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cmdmwUBX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cmdmwUBX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8EcW4193462;
	Mon, 21 Sep 2026 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hCQN16gxRDgP67dcL
	modHocT/4BhIAkQwOZ2klcPTOE=; b=cmdmwUBXHqySHchxh7UCyqIiwIW4be4u9
	pdBDa10d3uYV0IRSUsWKBiDLiGIhMrHZHmw7oeEf0WHLK38qeMWyovobxjvGPo5F
	xDQgb9NRzkI+GAWSWgvDiiRbCg/AwyVrA6K8q/JvfGuXzh4U4N7I454Kb9I5DCGW
	xcWboTUfQty1mfrzqpBekDi+LIhW9zzkLmsoQ+pGYX51GnKHJuRGh6jlhVWM40qN
	gTvJvOVEGzFyfxY5W/fF1VLR84ZkoEMAvzYK2QzVxqL5Y29oUikInca+IVR/2BUr
	+xmCO0NTPhuOoOFvAWIcE/NZi26Gas54O5MscZXJ7Aq51dQKm+C7A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1hfqw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHZAq1431700;
	Mon, 21 Sep 2026 15:58:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53ve314-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFw6I241287984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:58:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 927AA20043;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C1512004B;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 01/11] s390/percpu: Fix comment typo
Date: Mon, 21 Sep 2026 17:57:55 +0200
Message-ID: <20260921155806.2447506-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921155806.2447506-1-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YZyKaIa8638NSmBV-6PK7yFmrP9Jv8GT
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab15413 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=I_7Bz9khIIb0WmrdVP8A:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX3E5grHYAk3jw
 4mpMjkSuCcy4/KjiY2lWPz0QOY/HTMxQ6AX/vgo5FOy2tESj2xaO8jKPJ9FAYchz46IXWtRYgnX
 ++hfnZOrS4QT70O0DEY8uJ08hfHjr6k=
X-Proofpoint-GUID: YZyKaIa8638NSmBV-6PK7yFmrP9Jv8GT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX1Z7iRZL+ueEs
 4rmQXAJG2daDqevshk/U+5Iox0FfBHbWpAH3/ablG3ONEfHTIs77kl3w6cBO5T4csrwC04lVPp2
 11iijUQ21BM0tjydyXreoeDrdKpxIZGscMhzADcBn+FE08Z5ytQjWGVKVADOTmgLHqJrDix9BkV
 eIHrgB4KDRXZ/Il8PZGqdJoPkjd6hBH0S4hZSxedx221EeSTiLVxxVlt25PfjcloqtJjI69gy5u
 kQ778cQXA/sllMr00GysG3+X6fDgT9CslhVpd+MXCFCehWZW5As/hS3R7v9P20aP1hBYjnsNAIB
 M7Ve+5RLSaXgs4xISebkPMaTTHRtMhjGvyMJh9DggJCU8RmvAbK1aj96j2gpof2PRcSmSHVCAfi
 xjvcHYbMfdLRyRgJzceESqSSn7eiPUq2oDp/x6fdENeF54xEmW3VHFq1otXMEWrnyPLSwEm/jfh
 pwOqrPjHqZb/auOweAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210227

This is all preempt_disable() / preempt_enable() pairs and not
preempt_disable() / preempt_disable() pairs.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index feb58acf87d6..31012abe8292 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -63,7 +63,7 @@
 /*
  * Macros to be used for percpu code section based on atomic instructions.
  *
- * Avoid the need to use preempt_disable() / preempt_disable() pairs and the
+ * Avoid the need to use preempt_disable() / preempt_enable() pairs and the
  * conditional preempt_schedule_notrace() function calls which come with
  * this. The idea is that this_cpu operations based on atomic instructions are
  * guarded with mviy instructions:
-- 
2.53.0

