Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55399144D12;
	Thu, 13 Jun 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293213; cv=none; b=qqsN9WiesnPFRF35NJ2J9js3HdMhA8cA5x1f4c4WlTkO0/WmU/T7mEsnrgBKCfk0IVWG3oHPJmfbxAmByaGKTis9vjt1KcoMTNI8x5E1bZud4bOmoQmh1q3G37X+3wHe4k7mg3dKKUsm9KBkcFfxrJpAXtsMCerNzZGYotw1R0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293213; c=relaxed/simple;
	bh=hhRvfIXhwi4b4Gk2nOamzluWsNvydgc8y/UEMUlk7jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1PaFUFWpzeRb3q+sKNqK+iIrRdyyuQxAnPoTF7xKGzCyJp9QPbQ/6vbsKjXEdKqHa/Y+SVWV8Ymj5d03Az7h1o2eEn28cfEhvPtn7xVaxduGDfE+Mvvw1CP+F4w4gQl/8awClmUn04oyInSnWUyS6Ujzmp3c+6LIFhPEgzbX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VORhykUz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VORhykUz"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEMmKu009466;
	Thu, 13 Jun 2024 15:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=/gY59diCnvafE
	B+4mQiN4AxCmJVF2c9HWCLDsUZw+Ho=; b=VORhykUzQX07l22DxUNjzV7kQCcYh
	7XxHs+Bps15m/3JBqePHkv3myq1XbKPZDKvC0FURk9yD/cR6iwe+1KOLSJj7EDqg
	quf/XqRbNm9Th+zGbk+uuhGQUaDZWSE2LYJAton/eF/dkq62fn0xjoQ/H7xG5rzx
	V0xS+gqlQXA/rJncbBaJ0ShISo1TnAfKhNrlvp9lSRSTEXgWomF18OJqzRXoDng2
	NHEdQFOurXW/cZ6DMBn7PJzt5ky/1UT290NrJ2Zd9MIHLwGbK/0rFkYHu5HcZvBh
	PpRd788nlZdHsBOWYK9VPBgFfH0SQ97SovcNENgJ2JmvNSWelGZBuardw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr28g8buw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:46 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DFdkhn032507;
	Thu, 13 Jun 2024 15:39:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr28g8but-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DF54o7020086;
	Thu, 13 Jun 2024 15:39:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34nh0bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DFdduK48365846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:39:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5972004E;
	Thu, 13 Jun 2024 15:39:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09E292006E;
	Thu, 13 Jun 2024 15:39:39 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 15:39:38 +0000 (GMT)
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
Subject: [PATCH v4 12/35] kmsan: Support SLAB_POISON
Date: Thu, 13 Jun 2024 17:34:14 +0200
Message-ID: <20240613153924.961511-13-iii@linux.ibm.com>
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
X-Proofpoint-GUID: d5DLJuwF3n7IYysGR2MUKcLztsyMiSDS
X-Proofpoint-ORIG-GUID: gIfaDqrA226oT8V3lIkGJ1p31k8efaLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130112

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
 mm/slub.c        | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

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
index 1373ac365a46..4dd55cabe701 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1139,7 +1139,12 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 	unsigned int poison_size = s->object_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
-		memset(p - s->red_left_pad, val, s->red_left_pad);
+		/*
+		 * Use __memset() here and below in order to avoid overwriting
+		 * the KMSAN shadow. Keeping the shadow makes it possible to
+		 * distinguish uninit-value from use-after-free.
+		 */
+		__memset(p - s->red_left_pad, val, s->red_left_pad);
 
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
 			/*
@@ -1152,12 +1157,12 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 	}
 
 	if (s->flags & __OBJECT_POISON) {
-		memset(p, POISON_FREE, poison_size - 1);
-		p[poison_size - 1] = POISON_END;
+		__memset(p, POISON_FREE, poison_size - 1);
+		__memset(p + poison_size - 1, POISON_END, 1);
 	}
 
 	if (s->flags & SLAB_RED_ZONE)
-		memset(p + poison_size, val, s->inuse - poison_size);
+		__memset(p + poison_size, val, s->inuse - poison_size);
 }
 
 static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
-- 
2.45.1

