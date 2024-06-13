Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B912FB2A;
	Thu, 13 Jun 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293212; cv=none; b=jVcGlxXPOowueoL9CjHLlFvfrIJME0+QBja5dN8mwcsbDSdBla7FRf9UIi7cOoReFmGSfsQ+qKgfUaTHQMU/p/uuZ1nSJMVmlqhBK0BbDyAk8Y9bKIDsBuEUpVIZx+7gcLGipMbJ7mAsqEqNv8vQ5wJL1jGMKJqfkJ/+uxr9uZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293212; c=relaxed/simple;
	bh=bItt4UUwxu+2tmJmCAt+K4yoUeHpiYoK4z+iFNVh6OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmvuKT4aseDxf62lFynrsi+9ytZdBlbttazOV1zANh3oS77ZgZZW7fILQgpK2gMi1RGETpefjmwF8a1pzofycNG3JC/Cs7E0ssdjhLmNIoEOSLWZ14aXhBlgnP6s/UORrS2r8zTgZCzHVgseKzM/h2FNbjKu6DMIhrR2UoZjVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C9B3gD6x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C9B3gD6x"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DES86s002416;
	Thu, 13 Jun 2024 15:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=CQQ3u2h7dcFLB
	X9YiN0MD8i5Yqiqh3Ez2ST5U0/0yhw=; b=C9B3gD6xMn4t/5RiT1yZlP3WUmW3e
	Yl20IZRYZ6uPlrUEn40Vy8xS4A56YLMR5ka3YhBysgGTcUiZRISitgugV2NOV7dg
	IeoM4si4EuWQhRCYV660qE3pRICKUk1IVs9BzWg1bszAzNw0fNYbwO56zBM50qFj
	cC55Eoz7M8/HWHU1jIzGkrnsyTHIZT8FCRV9HlratyKhdh6Qkh+vY8UdUP23Prhy
	8+bm6BdfZ8XcKk2v55SMwnON92K90uza4SPc1dEuEZwWZKZM8Dd2RWLMJEyBosFk
	9DHajnq0HfKhMQvVW+ljxck4zkpzfE+vFNc/ne4sTwZihr8P8/2+J4ImA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr1rbgdef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:48 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DFdlFo014327;
	Thu, 13 Jun 2024 15:39:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr1rbgdeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DELP7P008731;
	Thu, 13 Jun 2024 15:39:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b3rk0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DFdfJD49217960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:39:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30DB420065;
	Thu, 13 Jun 2024 15:39:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B299920043;
	Thu, 13 Jun 2024 15:39:40 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 15:39:40 +0000 (GMT)
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
Subject: [PATCH v4 15/35] mm: slub: Let KMSAN access metadata
Date: Thu, 13 Jun 2024 17:34:17 +0200
Message-ID: <20240613153924.961511-16-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: i6q6hWHhRl-wcxMBB5jGTOrB5o4Wtw90
X-Proofpoint-GUID: Hdll2VtH1-GxrpJV3pG_l093JfGpbX5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130112

Building the kernel with CONFIG_SLUB_DEBUG and CONFIG_KMSAN causes
KMSAN to complain about touching redzones in kfree().

Fix by extending the existing KASAN-related metadata_access_enable()
and metadata_access_disable() functions to KMSAN.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 4dd55cabe701..a290f6c63e7b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -829,10 +829,12 @@ static int disable_higher_order_debug;
 static inline void metadata_access_enable(void)
 {
 	kasan_disable_current();
+	kmsan_disable_current();
 }
 
 static inline void metadata_access_disable(void)
 {
+	kmsan_enable_current();
 	kasan_enable_current();
 }
 
-- 
2.45.1

