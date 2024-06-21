Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF13AD5F;
	Fri, 21 Jun 2024 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929622; cv=none; b=kgJTeKFHwllmkc6ehvb2wW70FL4dex/tabSOKYaIXM5aHzSacghwoaQ31RbzcyZnqfvrWsLLKSIm3MTunkiFoaQ/W6r7+L1r96GvYzDTpFyGyI+3lCo6fRWHGDdXqa5R0KxPJqTO3VUJbDi8aNayH/zQ4a1jvb2EiO0py1JCkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929622; c=relaxed/simple;
	bh=COqCNEmfwNwT/aHRfv25m13vUI7mI0L5rYUQfj5BVF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpYzrYuq4iJTs1swTvGrnPlBeYprIW5zQOhNpbo3XJDL+c/6mY/jKnv1USNqc1gkYjFyuOwnBvcHsL5jbx1hR+Z87kFBPq3JeJ6IjWISUrHUP/5ly49HhBYIxNrmnTKL20djD5gdw1ttPETmUwewR7c47Xk3Ke1ucdHzWJ1TMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TyYZLocx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TyYZLocx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KNSIao032554;
	Fri, 21 Jun 2024 00:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=wYZcdN8GaCldu
	rJMmgBO/xn6iWaosLK3Wj+Mr2vvPT0=; b=TyYZLocxPDZI6g1LUnLnTM6RDN3bb
	M7v8iYyXepna0Yr+j7Hk5FEq7FoB2fFjURkk5+DxhadWyAdzDpOU7JjHFnnP1Id7
	+q2ZzwdPHAfACj6Fq251rnzGpfoq06AKR8ergc/fm7tKTPfAHc+3ANsjdPV/3Spm
	UXnRKjK8/PCs8Kf1NymeznspqQ/ZkrqSzmGlc0pSWIrtqfPET2uyqxvvaxZP/2sf
	CHNIpssaZWn6vu4fcVb00iEWBPhdzTMdhj0h6pzjDHlVaBy2dxQWT3mbbf+jxvfo
	585oNd2nePmOktSPHHnN6QYWTHN5g/dPs/pDZJuPCSSlyxVnghKF1WtWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c070g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:42 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0QSYH022603;
	Fri, 21 Jun 2024 00:26:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c070a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0EnR4019910;
	Fri, 21 Jun 2024 00:26:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrqujnwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QY4p49611188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9F7720040;
	Fri, 21 Jun 2024 00:26:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86EEE2004E;
	Fri, 21 Jun 2024 00:26:33 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:33 +0000 (GMT)
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
Subject: [PATCH v6 12/39] kmsan: Introduce memset_no_sanitize_memory()
Date: Fri, 21 Jun 2024 02:24:46 +0200
Message-ID: <20240621002616.40684-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621002616.40684-1-iii@linux.ibm.com>
References: <20240621002616.40684-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HVD5r9y6qc451bgRBsPVDEcQFobrK51H
X-Proofpoint-GUID: juOALtlB8s58b-RD-irHl1aByTJkzhA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=867
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

Add a wrapper for memset() that prevents unpoisoning. This is useful
for filling memory allocator redzones.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/kmsan.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 14b5ea6d3a43..7109644f4c19 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -255,6 +255,19 @@ void kmsan_enable_current(void);
  */
 void kmsan_disable_current(void);
 
+/**
+ * memset_no_sanitize_memory(): Fill memory without KMSAN instrumentation.
+ * @s: address of kernel memory to fill.
+ * @c: constant byte to fill the memory with.
+ * @n: number of bytes to fill.
+ *
+ * This is like memset(), but without KMSAN instrumentation.
+ */
+static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
+{
+	return __memset(s, c, n);
+}
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -362,6 +375,11 @@ static inline void kmsan_disable_current(void)
 {
 }
 
+static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
+{
+	return memset(s, c, n);
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
-- 
2.45.1

