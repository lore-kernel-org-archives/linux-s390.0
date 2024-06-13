Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0B12E1C2;
	Thu, 13 Jun 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293210; cv=none; b=lnQtcF27gEkFqWXBeKmb36UkEZVG+k7gDqljrP3537EJ0cpt5OMZcFawp/O7lgyKMUGKDuSnAJ/WUKykxzinXKC6A0yEm/Zlz2kIKrZ25gzTbY9H3yvNqqROZBfnAVQkuwM63rF8oy3ri9y4Uv3d3ViYoO4c4EbFcIYlOUPZsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293210; c=relaxed/simple;
	bh=KItl/9C6eG40jk7hUQLRQiZeJ0bPj6Y0X5vOYAo0Yj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+pKuRn6qaF0smnzRWORMEKFmVtV2spodoeYqRAyoQUcZK5wLQb4I2IaOmFn+xf/uWhCjKx4Ky11l+g0QYgGAEuVs+dh6lqs5pwBxxbeYIqNmN3menb5Q8y0AwLTDyfm/Ulfi6xT2xbTRHPz18RSMuI9vZbzDLtb3MAn/ke7rJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UBQFPbWH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UBQFPbWH"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DCR4OS031281;
	Thu, 13 Jun 2024 15:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=YaTjcojmIIYPS
	V3AqgAoZ8tGeMyuD+KvoajbKIBgv5I=; b=UBQFPbWH52wQgeblivmbAIG5/vj+n
	XOPZZsDy52b6UtIMUG4QvgiFPwNQIrlze3Kl01W8sCsZgP8XtongAQZ46/zlMEjL
	Tl/BERQRnRwvh/HbFxFr34Lh5HWfvX3XOZLYs0L5OP294po4HniG+vnBX1fgpwxq
	ThXwmB3Ha/5ygNikffkdZaC6mgj6OS9kxaycBeMxP7NC+Ppyi5rdEX5590uw1+O9
	sBfdRaeiMRMDzxLn1lGnmIHchaHQ3hrAfF//NbPhYMQL4kGqPl7Btizwl4Q1AUtB
	zosD4gxL0/UOExpvSrPdjC4SDQjxw0HLUoiKa0kx5FO5QRzyTEv24yv1A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4rt36v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:45 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DFdid5026772;
	Thu, 13 Jun 2024 15:39:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4rt36q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEqSGd027243;
	Thu, 13 Jun 2024 15:39:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn211979r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DFdbRo48890310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:39:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D82F2006A;
	Thu, 13 Jun 2024 15:39:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE30720063;
	Thu, 13 Jun 2024 15:39:36 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 15:39:36 +0000 (GMT)
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
Subject: [PATCH v4 08/35] kmsan: Remove an x86-specific #include from kmsan.h
Date: Thu, 13 Jun 2024 17:34:10 +0200
Message-ID: <20240613153924.961511-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240613153924.961511-1-iii@linux.ibm.com>
References: <20240613153924.961511-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I6lUMZaRn-eKqMWngW5wl1DQIlqcnkRS
X-Proofpoint-GUID: Punmgb6NwOmY9ZII4z-shjRaLe710KO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130109

Replace the x86-specific asm/pgtable_64_types.h #include with the
linux/pgtable.h one, which all architectures have.

While at it, sort the headers alphabetically for the sake of
consistency with other KMSAN code.

Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/kmsan.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
index a14744205435..adf443bcffe8 100644
--- a/mm/kmsan/kmsan.h
+++ b/mm/kmsan/kmsan.h
@@ -10,14 +10,14 @@
 #ifndef __MM_KMSAN_KMSAN_H
 #define __MM_KMSAN_KMSAN_H
 
-#include <asm/pgtable_64_types.h>
 #include <linux/irqflags.h>
+#include <linux/mm.h>
+#include <linux/nmi.h>
+#include <linux/pgtable.h>
+#include <linux/printk.h>
 #include <linux/sched.h>
 #include <linux/stackdepot.h>
 #include <linux/stacktrace.h>
-#include <linux/nmi.h>
-#include <linux/mm.h>
-#include <linux/printk.h>
 
 #define KMSAN_ALLOCA_MAGIC_ORIGIN 0xabcd0100
 #define KMSAN_CHAIN_MAGIC_ORIGIN 0xabcd0200
-- 
2.45.1

