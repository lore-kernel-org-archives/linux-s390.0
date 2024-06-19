Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5F14A615;
	Wed, 19 Jun 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811971; cv=none; b=BWYIotxs4t603gcjJWug2YoHrV99DQGgrNE9Q25ZzK4RwCE+VE/YHNmGevPjabOfzuWi6jc1DOkvMzmo2zOBJX0iJPUhy2hHLpppLHZ5MwMNbM8qg9eTq/6WwlgszVfOAQgf1LKlZeYtAlDC2FtfN+97ix96fyIM01I+UUjy1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811971; c=relaxed/simple;
	bh=9/+TaRm98PaID0ykM7GYspHb7uowxjnEpYEFBqC+YSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLKLPBRYLW+fiKFkl2AuGGUA5Y/kaex2L8SXT6GvArr7i2I3YpBnfLVw1Tde2ojbEODBlur07GQ6Isbnd6UBY/2hjOUnLdRUwGhUVFdyKYxzIahqzvFrm2wRk4FoFwo1CDCRnzvoniP3apIQS8AlcvzkLa9fpq7wV5vJN3tPXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LuP4TB7R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LuP4TB7R"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JEQaiH000931;
	Wed, 19 Jun 2024 15:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=s29Q5OzIygT4U
	HJ5zziThxrqJQB5H7WVOZbTWfWq5Kk=; b=LuP4TB7RByllRldmIwTChvSAyv399
	pNfVOnxnn5zOiszCWNA6nGDLJOcMHG067Xy9WR8tTMdo/Xdf/nv24dw+PQV1RPnw
	7R0UoF1kMl+3jMksMc/OYZHjuQi46iMLmkYNDC/nxSt/0moSY6fKMnwUYU4ZZFX9
	erw0kNQIUyJVf8vMQoc78J05Ty3j5ZZfQJok4w2qDThKKIAkU52ATNoRgpxZf/MS
	rvAbN2OIEb9T19M42u+a8jsSzb3tFogLQhCw7gtHKQjYuZHtnqQGovEwgYV7SpnY
	0vboQ9UvMDWBJzJznD9ZEd7/LX/XS7WXsNLrckZ4SEKgVbxZzdKGQrGeA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yux3fgupp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45JFjjgr005244;
	Wed, 19 Jun 2024 15:45:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yux3fgupk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JEmdqG013385;
	Wed, 19 Jun 2024 15:45:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr03wkqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JFjcVd50659768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 15:45:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C1E20049;
	Wed, 19 Jun 2024 15:45:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A7E220063;
	Wed, 19 Jun 2024 15:45:38 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 15:45:38 +0000 (GMT)
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
Subject: [PATCH v5 13/37] kmsan: Support SLAB_POISON
Date: Wed, 19 Jun 2024 17:43:48 +0200
Message-ID: <20240619154530.163232-14-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619154530.163232-1-iii@linux.ibm.com>
References: <20240619154530.163232-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KYH5t4Sb11YAqzz4oXvn4ytz6Vv06L_-
X-Proofpoint-GUID: guJGVNqH8e1n_84FGAC7fsHfL-QDgcCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190115

Avoid false KMSAN negatives with SLUB_DEBUG by allowing
kmsan_slab_free() to poison the freed memory, and by preventing
init_object() from unpoisoning new allocations by using __memset().

There are two alternatives to this approach. First, init_object()
can be marked with __no_sanitize_memory. This annotation should be used
with great care, because it drops all instrumentation from the
function, and any shadow writes will be lost. Even though this is not a
concern with the current init_object() implementation, this may change
in the future.

Second, kmsan_poison_memory() calls may be added after memset() calls.
The downside is that init_object() is called from
free_debug_processing(), in which case poisoning will erase the
distinction between simply uninitialized memory and UAF.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/hooks.c |  2 +-
 mm/slub.c        | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 267d0afa2e8b..26d86dfdc819 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -74,7 +74,7 @@ void kmsan_slab_free(struct kmem_cache *s, void *object)
 		return;
 
 	/* RCU slabs could be legally used after free within the RCU period */
-	if (unlikely(s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)))
+	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
 		return;
 	/*
 	 * If there's a constructor, freed memory must remain in the same state
diff --git a/mm/slub.c b/mm/slub.c
index 1373ac365a46..1134091abac5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1139,7 +1139,13 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 	unsigned int poison_size = s->object_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
-		memset(p - s->red_left_pad, val, s->red_left_pad);
+		/*
+		 * Here and below, avoid overwriting the KMSAN shadow. Keeping
+		 * the shadow makes it possible to distinguish uninit-value
+		 * from use-after-free.
+		 */
+		memset_no_sanitize_memory(p - s->red_left_pad, val,
+					  s->red_left_pad);
 
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
 			/*
@@ -1152,12 +1158,13 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 	}
 
 	if (s->flags & __OBJECT_POISON) {
-		memset(p, POISON_FREE, poison_size - 1);
-		p[poison_size - 1] = POISON_END;
+		memset_no_sanitize_memory(p, POISON_FREE, poison_size - 1);
+		memset_no_sanitize_memory(p + poison_size - 1, POISON_END, 1);
 	}
 
 	if (s->flags & SLAB_RED_ZONE)
-		memset(p + poison_size, val, s->inuse - poison_size);
+		memset_no_sanitize_memory(p + poison_size, val,
+					  s->inuse - poison_size);
 }
 
 static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
-- 
2.45.1

