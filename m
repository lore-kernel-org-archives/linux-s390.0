Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3F3CCFB8;
	Thu, 19 Mar 2026 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921916; cv=none; b=s6UsKFNmJLbnWP1KGyGryquzM7fTXHERVGcqYxGO3pgEGHZeGQ7cR2PKXxuwyTzoQbzS62LqKmDO1XK9WJMcLO/NE0wmX66nKYI3Uww2dDV1XlNC198WA6wUtiCROGCKzrtuX/XCVItQPYxltxGNkf/dXXi/42oC/idXuu98XWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921916; c=relaxed/simple;
	bh=6GJTxaWwR7SsXFuSvJ9EEx8IeTvptmfJsOIwIwetdhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGbVjD5V2XLCMOc8r1zZXq73Z045tUYK3vlkHNBEISjdlcy7sanx5E/QfmRu9mobgZgjp+TznabK5swfIrZS5y4A4p5IeEg11Qu+QlMwJYfjleTmc+EbDqC0GobOFvNsEsNdSAqtSaTUHzvD0aKd/eaF/+ufHYoYVhfysght7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ttlSSEWZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ttlSSEWZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IN5GPX437268;
	Thu, 19 Mar 2026 12:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xs2bj+fROmAG6N3/N
	6RjvdGdbnsG02BdiCjb16hzr3g=; b=ttlSSEWZUohDkZqKICaethVFIDV2iBU2K
	liINTm516w0XW3/vmicLli3YkOalC8InylCRMrfaBBrs1+LAEm3XwwRTZkBVGnwk
	eOdiFead3tvMe1vy8nGAYLML6+p6NOygWoTwZgZ1SX4iNGCzqKCca+phxF5zCOuK
	QzoBKBNN+JzKCaJgmE4X2aBwboB52SLPmpM5bvUHjh898lElc389aNj+Sk/eWJJn
	hsubd3i5g9P+So226XUEv8Djo9prUxBPH1iCDGFzh7tot+uQyIwjLn+C3XBLbK2l
	TgwPoGxlg3ikIzaruocBIuru4bOsLMPe61Utlwv765ngoCD6+1F8w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d60n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J8hlF5004559;
	Thu, 19 Mar 2026 12:05:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sjf83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JC53Uk51053020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:05:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9A3120040;
	Thu, 19 Mar 2026 12:05:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 865242004B;
	Thu, 19 Mar 2026 12:05:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 12:05:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 1/9] s390/percpu: Provide arch_raw_cpu_ptr()
Date: Thu, 19 Mar 2026 13:04:55 +0100
Message-ID: <20260319120503.4046659-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319120503.4046659-1-hca@linux.ibm.com>
References: <20260319120503.4046659-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bbe674 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=FJXwAgvRweZ6vCOBEk0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfX1uxA2EuyAFxg
 Nb6uMUnf7PMOAkEzDKHBcRxNbH9RMmnIsB6GBaPUQ/7ijuMTX3aqiHE6/gTc0gjpzTP+ixeKKoh
 FO9O3wxBVe404SoH++nIgbzS93JMzz5zbfH8dhIE2czoOAdrvbQMiL4zhooZVRlAvWyksk6BJpW
 MXenMInyUb0P9w49raygF5R9GaQ5n07Wgawn6eNZi1I9u6BJz9q/wtuREanhAXKkCN0ydtSBAR3
 tIWBqdeee6lEik5d2QrUarG/9r4Vd5wmJECE8/j0+bgMzmYD/SWx3xb+hRZbebRiDiQ6pd5JHJE
 Ezy4z2CNlboyEqLWXkmNyZ+mI141x9rjuXdfC5ijJaxvhWMPkkIrXNVZElYVVerhcfFpQYqTMbb
 /7aytZcT7e/g7XB6tGBRmXWVszvwGcrr3gcxB/TNUUDpkYGveJVgetUms5IYtE7qS+hSwZcmMWj
 HcIOtgp1VaE+eDPD76g==
X-Proofpoint-GUID: B5hlhpo5eTrEX_mBSH3Gt2iDk79EGFPc
X-Proofpoint-ORIG-GUID: B5hlhpo5eTrEX_mBSH3Gt2iDk79EGFPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190094

Provide an s390 specific arch_raw_cpu_ptr() implementation which avoids the
detour over get_lowcore() to get the lowcore pointer. The inline assembly
is implemented with an alternative so that relocated lowcore (percpu offset
is at a different address) is handled correctly.

This turns code like this

  102f78:       a7 39 00 00             lghi    %r3,0
  102f7c:       e3 20 33 b8 00 08       ag      %r2,952(%r3)

which adds the percpu offset to register r2 into a single instruction

  102f7c:       e3 20 33 b8 00 08       ag      %r2,952(%r0)

and also avoids the need of a base register, thus reducing register
pressure.

With defconfig bloat-o-meter -t provides this result:

add/remove: 12/26 grow/shrink: 183/3391 up/down: 14880/-41950 (-27070)

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 5899f57f17d1..b18a96f3a334 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -12,6 +12,24 @@
  */
 #define __my_cpu_offset get_lowcore()->percpu_offset
 
+#define arch_raw_cpu_ptr(_ptr)						\
+({									\
+	unsigned long lc_percpu, tcp_ptr__;				\
+									\
+	tcp_ptr__ = (__force unsigned long)(_ptr);			\
+	lc_percpu = offsetof(struct lowcore, percpu_offset);		\
+	asm_inline volatile(						\
+	ALTERNATIVE("ag		%[__ptr__],%[offzero](%%r0)\n",		\
+		    "ag		%[__ptr__],%[offalt](%%r0)\n",		\
+		    ALT_FEATURE(MFEATURE_LOWCORE))			\
+	: [__ptr__] "+d" (tcp_ptr__)					\
+	: [offzero] "i" (lc_percpu),					\
+	  [offalt] "i" (lc_percpu + LOWCORE_ALT_ADDRESS),		\
+	  "m" (((struct lowcore *)0)->percpu_offset)			\
+	: "cc");							\
+	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;		\
+})
+
 /*
  * We use a compare-and-swap loop since that uses less cpu cycles than
  * disabling and enabling interrupts like the generic variant would do.
-- 
2.51.0

