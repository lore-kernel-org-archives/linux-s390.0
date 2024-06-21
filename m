Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8B171E41;
	Fri, 21 Jun 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969860; cv=none; b=H/SEpZM14bPfdIRQFB7jtS/i405ntNNZ3OWB/Dv1NZ4x7t4EXyvghWwt13m9/0FgGsb0BT3KmDtv5b3M1uTJjM5vAr3y5kAZLK6sYjVh9tbNcpk9+Fh4dHI35+H7chJEBes4bllCTDmVxUFtqHvjrgOSt0cRX80cva5Nq1WpP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969860; c=relaxed/simple;
	bh=bnT2QIsysA2SxzDjj+x+XXiVNRwGqhae3E4dloFaMys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cx+gtleNRHZs8FLXDCrR6n9air1/NMUNgNHUQps2fme6XPXMPDxBdhlgeBxCOI75q8ciR3oFqoOfFp/vGploS+FTKlXNf48KfzykIBdmwONgWMjfvCyzuIdNrC/dprXRTZcKnR3KK2/mdXW604J6FGEvEEUw0RAs0/rImrzFU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IS4ZtVj1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IS4ZtVj1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBT2fX021960;
	Fri, 21 Jun 2024 11:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=B2wiMcD3tdJRz
	Ji1KnXmn1aGmTaVwcFVLNTdCb0XDUM=; b=IS4ZtVj1AfvkUG7483Tgmr0DrzGsg
	H/yVfozsu61QHrsNj1KI+Q7OnIGCKzl3S6xWaImCS6mSKVlcmuoWjeMu4+RE83Da
	gBpGfdd6AzxJJTvkZr5hVOweY8PnLmFbKgKiAo1tMc95v1E3fV5TLExrgKUV6jnM
	7aeYd0j75CQHwBZoNQIYtoz7xgCso1KJOBf6oQyYtv4nifZkGCeNWsn0D8z6S8GK
	uCRFaSSFxgsU+Hfa1VcTUETZTPSgZUQ8sI+8uxERh91AtMTFyPNWSQRXPM97JS4G
	KBHi/LlomHjU0AfPNcathcAfIijMU8k4D/qokj8DInEpcs/pc1QoccGpg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw6ws09bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LBaJmL000419;
	Fri, 21 Jun 2024 11:37:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw6ws09b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L9EjD0019980;
	Fri, 21 Jun 2024 11:37:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrqupvym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LBbC4S45613482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 11:37:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A8B62004B;
	Fri, 21 Jun 2024 11:37:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92E262005A;
	Fri, 21 Jun 2024 11:37:11 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 11:37:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v7 05/38] kmsan: Fix is_bad_asm_addr() on arches with overlapping address spaces
Date: Fri, 21 Jun 2024 13:34:49 +0200
Message-ID: <20240621113706.315500-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621113706.315500-1-iii@linux.ibm.com>
References: <20240621113706.315500-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _QxgKIXm-H474SZgRMjPUkGWFJ3XjBZb
X-Proofpoint-GUID: yGqjU0FWgkV47EzU5yDvoLI2eE9WBVok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=952 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210084

Comparing pointers with TASK_SIZE does not make sense when kernel and
userspace overlap. Skip the comparison when this is the case.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/instrumentation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
index 470b0b4afcc4..8a1bbbc723ab 100644
--- a/mm/kmsan/instrumentation.c
+++ b/mm/kmsan/instrumentation.c
@@ -20,7 +20,8 @@
 
 static inline bool is_bad_asm_addr(void *addr, uintptr_t size, bool is_store)
 {
-	if ((u64)addr < TASK_SIZE)
+	if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
+	    (u64)addr < TASK_SIZE)
 		return true;
 	if (!kmsan_get_metadata(addr, KMSAN_META_SHADOW))
 		return true;
-- 
2.45.1

