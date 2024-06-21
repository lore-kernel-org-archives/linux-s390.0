Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430D4D5AB;
	Fri, 21 Jun 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929630; cv=none; b=oQp0VBZnjqeTBqMH2gwIQ6OJUMnDvRHMBqaS3ZavuoPxKDukIksqIiebYhaYqQzyc8w7PySiK4pVWCpRzLt10T/ucIDuV+bCHKAQA5DXWglR3K1/SLEbzFNOZUyJSPmA1h9/BCNZ6TstKD3PPEWq8/liJ+H0xeLh4aVBbCJ5JiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929630; c=relaxed/simple;
	bh=uv0nBdzB3wfoW8j1bC+LryIrpy/O8QzjRFRhtrOWxGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8NLytg+bTfdqPRXYFwRlS6nsTAnUwcvawz2hNCICnJElOb5pTXGmN9SEHF+RzZoiH9KQAdpWcDpKWsBbP/kHyywrnzDU+Gs/i9wk9/oO3qnhA2I+Fax+W4s74DoSZWTFZZUMMrXEjI9ZTl2THLQzOJyhtNz1XVg/y3TVNiGrfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RdWGIW+G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RdWGIW+G"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KNwn3G025841;
	Fri, 21 Jun 2024 00:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=0LPmEM6eL+o7B
	o27nUv4gfJxVa+Lf6wjrMNv3AzectY=; b=RdWGIW+G03uzxPZnb1uuO81tSsGmB
	KvlBs2vPj80+XLjY1hxMvNoNgXM7CELQjdFnGg7ewKlSmJ2AhT6KCTEMtl2vXWPY
	vXs2Rhf22iC+NmSvUc5mYtMQswnPAVqB3Ky93gua1VEv+SD1Ob7+7tyMljzOkt+B
	6lsI5L/OCFpHPaC2jwvprjz6+IfX8G6T7Yy2BjjL+J6gcAoa8DJhY1NmxR2gBq72
	aRaQjT8VMYp+faS7TOd8hZFE+I7gY7i8kflmTg0xWn90oVcPXd8sopqwASBC0nkD
	+/6R8XdeGNJn9qxSgaBTWAyJU/i5cXCuCKKt1eKK3w0jH5WcfSFWQeVQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvxjjr1j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0Qka0003184;
	Fri, 21 Jun 2024 00:26:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvxjjr1hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KLiBxH007687;
	Fri, 21 Jun 2024 00:26:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspampc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QdWT43385164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AC0520040;
	Fri, 21 Jun 2024 00:26:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B8CD2004B;
	Fri, 21 Jun 2024 00:26:38 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:38 +0000 (GMT)
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
Subject: [PATCH v6 16/39] kmsan: Expose KMSAN_WARN_ON()
Date: Fri, 21 Jun 2024 02:24:50 +0200
Message-ID: <20240621002616.40684-17-iii@linux.ibm.com>
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
X-Proofpoint-GUID: 3TpJaJWUrn5ONmFvCjHZ6jquugwLqa_O
X-Proofpoint-ORIG-GUID: ZSyRtuJikAyuhF47I2RpjGNIZUWKxRc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_09,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200174

KMSAN_WARN_ON() is required for implementing s390-specific KMSAN
functions, but right now it's available only to the KMSAN internal
functions. Expose it to subsystems through <linux/kmsan.h>.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/kmsan.h | 25 +++++++++++++++++++++++++
 mm/kmsan/kmsan.h      | 24 +-----------------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 7109644f4c19..2b1432cc16d5 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -268,6 +268,29 @@ static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
 	return __memset(s, c, n);
 }
 
+extern bool kmsan_enabled;
+extern int panic_on_kmsan;
+
+/*
+ * KMSAN performs a lot of consistency checks that are currently enabled by
+ * default. BUG_ON is normally discouraged in the kernel, unless used for
+ * debugging, but KMSAN itself is a debugging tool, so it makes little sense to
+ * recover if something goes wrong.
+ */
+#define KMSAN_WARN_ON(cond)                                           \
+	({                                                            \
+		const bool __cond = WARN_ON(cond);                    \
+		if (unlikely(__cond)) {                               \
+			WRITE_ONCE(kmsan_enabled, false);             \
+			if (panic_on_kmsan) {                         \
+				/* Can't call panic() here because */ \
+				/* of uaccess checks. */              \
+				BUG();                                \
+			}                                             \
+		}                                                     \
+		__cond;                                               \
+	})
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -380,6 +403,8 @@ static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
 	return memset(s, c, n);
 }
 
+#define KMSAN_WARN_ON WARN_ON
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
index 34b83c301d57..91a360a31e85 100644
--- a/mm/kmsan/kmsan.h
+++ b/mm/kmsan/kmsan.h
@@ -11,6 +11,7 @@
 #define __MM_KMSAN_KMSAN_H
 
 #include <linux/irqflags.h>
+#include <linux/kmsan.h>
 #include <linux/mm.h>
 #include <linux/nmi.h>
 #include <linux/pgtable.h>
@@ -34,29 +35,6 @@
 #define KMSAN_META_SHADOW (false)
 #define KMSAN_META_ORIGIN (true)
 
-extern bool kmsan_enabled;
-extern int panic_on_kmsan;
-
-/*
- * KMSAN performs a lot of consistency checks that are currently enabled by
- * default. BUG_ON is normally discouraged in the kernel, unless used for
- * debugging, but KMSAN itself is a debugging tool, so it makes little sense to
- * recover if something goes wrong.
- */
-#define KMSAN_WARN_ON(cond)                                           \
-	({                                                            \
-		const bool __cond = WARN_ON(cond);                    \
-		if (unlikely(__cond)) {                               \
-			WRITE_ONCE(kmsan_enabled, false);             \
-			if (panic_on_kmsan) {                         \
-				/* Can't call panic() here because */ \
-				/* of uaccess checks. */              \
-				BUG();                                \
-			}                                             \
-		}                                                     \
-		__cond;                                               \
-	})
-
 /*
  * A pair of metadata pointers to be returned by the instrumentation functions.
  */
-- 
2.45.1

