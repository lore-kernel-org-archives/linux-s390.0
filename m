Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2844AF67F;
	Fri, 18 Sep 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721342; cv=none; b=oaAhH3Y8gy3+bGN4VGUm/dhC5LYkqsLkVruJUC114TQj99NSrVAkjPzuoiMpTcV2LKOINxYfuWavd0jylCE1Y7FFq3aKp0QwjAQ/9JfQrlIcZJo3R0p7Qb7e8MXGijR3NIcOTR/QLFbdrJOOKqCmqSjQBAWD6yY7HLq65LgP4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721342; c=relaxed/simple;
	bh=QuLPXVAFgIJ9fPxmYJemmPvdwZIjvEMVor4YZEw3MJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbBC+QOFwux1Gv4dkCl03MfzKKYOXP6ihZ0OhU5cmHNK7+zXBLCQhZgxwprGoA0E5J3c8FMSg5CF1IR8UiAHHFxgW7luy5txS1S/HQmx4cTxU583+DNZnP+NyHtZu3I+I8zGPFq2tKIJ0+UcVEXK7mfgMqowHrYzTiMaWD2pDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D7Uvnfdr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D7Uvnfdr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61TaG2781130;
	Fri, 18 Sep 2026 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UbSM4J6q9wHJGxcag
	Fzwg95TRKRs0Sfalw4VwKXSGug=; b=D7Uvnfdrw6RI5v+n03bzinuVyW6kE8OzG
	GFfNkYJd03WUmZXuR7qxfA4a5KaJ+j32ixXCUV17GJbUS5NiF5YUOGlsPcYj+h9y
	+sDbXY6XDtFTj8K5jYquXt1gNs0NjP/0YNwmSZhgWc6vjYm/Em2fwTGBJ6ZZUdyy
	ZStjfLC4RulWpLFFwDxLl8O3NiVn04iYo0A8Tg5/FwBdJ21HB9GG2J+P3ePhc1hj
	6fzWI+kxKEOQF1hYEb4PcIHA/h6QMuokvYo5pAZ0hhnid77TEoY40G5P0Gnyrc6l
	QEg8KsO/O/vTr1lCIiE36B14iuciLUcdBOex14t0viUYyt7fifgzQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqq4ag-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I6554v208462;
	Fri, 18 Sep 2026 08:48:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa6ewb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8mhQp38011164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CDCD20040;
	Fri, 18 Sep 2026 08:48:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 290AB2004B;
	Fri, 18 Sep 2026 08:48:43 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:48:43 +0000 (GMT)
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
Subject: [PATCH v2 03/12] s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
Date: Fri, 18 Sep 2026 10:48:33 +0200
Message-ID: <20260918084842.2333237-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918084842.2333237-1-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX6OfrKvHJlrXs
 9XpeTat0tYyPOeOKUKkLZbY+DqW4ZeTp1U0EBKGTax78OFu37eVG5u7Wwl6annnVs4xoZfTWt2D
 bsU7VzoE8Stemp9AwFxrjcS58yLOtFNQvLrlv7vJUjfi18tYIQV1gylpBdADSl8F8Wo/uE+ZQL2
 u06wVsTA32GCD8NWVgjnQfLFdq7P7RletnkfIGCeMpkjzrhUl4PgkLLZbhHYbUeEPf5n+FcMv0T
 U6Hvv37aZBX+It092bt4wvO09sutEJROY3LhuMGT7+Nov+u8tG50CHkBnRp60Q80+uJa07F7Ijp
 9HOv8MFdoxZH9P9Fjso2qhettY9SMfmHcjqQ5m4N/Dru67n+1wlybIy+AMTETGqiAHwjdpBJWa5
 5kLacXy3mxBT0AVdgIYGeHmqnbWO/SPZBN/u/Js+21jyY8kDCD0CZq2EKcvzAUvjMPyV7CdDiSM
 /QzwU3Kqn6Dj1PyiApQ==
X-Proofpoint-GUID: 17oEIdE1Vec2b83favBFiHaZCbiPjWy2
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aacfaf0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=phCDqYjOjFlr_q_ZZjMA:9
X-Proofpoint-ORIG-GUID: 17oEIdE1Vec2b83favBFiHaZCbiPjWy2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXwXHEgZHrIofC
 U7prV4OYx8pk+hcGRiDhFrR30/7RYnkfWUaBZJubGJcYJKYSz/Hcfe3panQbbvOz0D7o+KIWXHF
 8sPGYygs3LsLBxQy/Z39Da/qkjGqYhI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180117

Remove the _AC() conversion from LOWCORE_ALT_ADDRESS. This changes the
type of LOWCORE_ALT_ADDRESS from unsigned long to int in C code, however
looking at the current users this should not cause any changes.

This allows to use __stringify(LOWCORE_ALT_ADDRESS) for inline
assemblies, which otherwise wouldn't work because of the UL suffix.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/lowcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 5cef215d30e7..f0364a9f8a19 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -21,7 +21,7 @@
 #define LC_ORDER 1
 #define LC_PAGES 2
 
-#define LOWCORE_ALT_ADDRESS	_AC(0x70000, UL)
+#define LOWCORE_ALT_ADDRESS	0x70000
 
 #ifndef __ASSEMBLER__
 
-- 
2.53.0

