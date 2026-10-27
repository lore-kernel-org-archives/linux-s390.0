Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111439;
	b=sibhwodcY/HoWn9LpYaPvbfbGWH3DABoOHlMMC9ZJsrMM5yimgy95KCoYoe+tmYZkiMU
	 LNEtM24vDICE/tiSCCr4g/YjUJ2COtCjMwuaeCMuS7FP/gZjRcsTtJbkfz0waoQO+LcS9
	 yT2cKRJJWACli+9nioqjOpsZiBxZVuxHwtUdHi+2VI5Jv4o2GigAwGMs0DL9bj4pKHnLw
	 HP2TnFXfTh1ShiNFVKvw2WdOieIK19eBrGEorifQhvU9Wf5azFwxczqtAo+T+/lGiL1d2
	 hbqhkhyjBT99eMVcPbS34eW1MVsoweI7gtWZ7novLWTORyMw73q1AY72kU0WIh9bEpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111439;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uSmC4/nt8Z2FZBo/AzVQtr84u0BN6mGkw5ctpkF+Lu0=;
	b=m9oz2vQbQjlkwNdCEp+b82tZy+4+ANppsN9n8xL5pQu/CBPccMRxPLzlWd9ViezxDz0U
	 cQ3rci5bD1OPpnqav8fti+LxeW7CD/lur6Ja1tz7ds3pHhnIK6rggR1I6yuKQMlxydjz/
	 bi+iZ8GokSMGkl6dmQdDXagooqHlv6TilePYRcEeKnEALlXfeAljJQ86KiqgTVxbZYxG8
	 dfwh2pAOOc6PCzkjMZAIrp2RhIeXYqb9NBnlSRqpW89Buav/flN9K9sv9eCNc6u+tqzQD
	 g2iPdUyp3jD0zv91IaxGJC8M8PEsiOxlrZd1T+U/w9p07M/54tJ1DsRzKZBmitIsC0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nw5078ua;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17D606A339;
	Tue, 27 Oct 2026 14:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A17D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nw5078ua
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REEaI22697679;
	Tue, 27 Oct 2026 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uSmC4/nt8Z2FZBo/A
	zVQtr84u0BN6mGkw5ctpkF+Lu0=; b=Nw5078uavoy5+xvC0DzZUmbdYk6OwFF+r
	XO+jOC4FnDwoSRQR7nab8tSJTUE33oDIYDfjxpT1uCE6QBy1XkIXMjDltv+K9jLO
	ZNrC/fcECmk0wuyF1IcVNIu094jFwfk/ApUusDHR6K6fvGaD1urqu0h5uaYgZKZq
	+vM4epnOYaV96C9cCFsO88jFepqZJnHY/3L1nswUokLPcC1rjPquxGh194wG846p
	QOBdOiLEpjakOx1J2uUlpo7ter7RToBFJBdwQkEOltXUidNFj44xYdvca6QygrYa
	IvQHk/VW/PpQLzPuxbWYNXkMbbUWe0/XRtkvBEbnqiRF7EpQKnsOg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavfgad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoqRE054387;
	Tue, 27 Oct 2026 14:30:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7ryrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUVFQ34537812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C852004E;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99BAA20040;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 04/10] s390/runtime-const: Serialize text patching with text_mutex
Date: Tue, 27 Oct 2026 15:30:24 +0100
Message-ID: <20261027143030.3154657-5-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae0b58d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=00iQXdrkLu6meO8cnrkA:9
X-Proofpoint-GUID: 03o7sryTX-0FWRE3SjeNQIbnTzIKD6ZG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXzFjEwVk5C1bX
 q++rM8dpsmpF+j+i0dXDAbxuIq7RLIc4nJtpKH3fucO+yvZjwqcH5u+HkQclFsAg+3MRYX/95kC
 9fo9PJKC69qO0rm/HC6hXt35xolpkUI=
X-Proofpoint-ORIG-GUID: 03o7sryTX-0FWRE3SjeNQIbnTzIKD6ZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX/RFTvyVR4F7w
 2r1mpfTtzP3OCBLopLlxEksOvmnLRh1QYsNRVQ1N0fBWSbmFpHVI3jqRidx4EdWi3gTcVfqwbbI
 mlCO1g/FGW9OBMUJXKegMjwcOuWjznFBfE2iTkUpYIAGxXwDVAyslMG+x/1VpcdUbL6JjubtZPT
 Usgk2hbLeT31+1AUsr3MGuQcm/tleN2COvyOGlmZ2MPCJyCOeCutrT21RbRLthtRY4LapTh4cL0
 8Gm5XP6DJ/QhjEEgIFwdosXAxF1UeVI5490X0kltLmMXifAxI0mvsoIZJF8AVm4Y3l9wEjonacz
 G0heVCU5BovUwPvFjXlLp/prAoWD5yGLyA4RwJD13tvv45+bFy8wAcb5sG2P5GsFTa2ocut99VV
 zwVsGhwGwRORwEOs1tbGeGDcE+qHGwsL2cG6qx6isJ6Obxo4i8tvt6Uo3UYEHEZ6P/Yq3MPg+XN
 MG8Hgkqu1z9rx4bC0mA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056

Acquire text_mutex inside runtime_const_fixup() around the patching
loop.

Serialization is not required for runtime_const_fixup(), however this is
part of larger series where at the end s390_kernel_write() requires that
callers hold text_mutex.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/runtime-const.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index 7b71156031ec..0e2402717e8b 100644
--- a/arch/s390/include/asm/runtime-const.h
+++ b/arch/s390/include/asm/runtime-const.h
@@ -3,6 +3,7 @@
 #define _ASM_S390_RUNTIME_CONST_H
 
 #include <linux/uaccess.h>
+#include <linux/memory.h>
 
 #define runtime_const_ptr(sym)					\
 ({								\
@@ -88,6 +89,7 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 				       unsigned long val, s32 *start, s32 *end)
 {
+	guard(mutex)(&text_mutex);
 	while (start < end) {
 		fn(*start + (void *)start, val);
 		start++;
-- 
2.53.0

