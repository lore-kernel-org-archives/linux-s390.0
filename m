Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA0149C69;
	Thu, 13 Jun 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293214; cv=none; b=jMa4TcLsRKii5eyDwZzfhGyo665BrIuatNNNi1RedKJfBgKnw7pV5qb8iNN7hXzAlNImmAcGM37ZAgSCKjoem7sCJf8lbJRCjqFo80TLvUc85Ph9pK9ZKXbRA3o7QiW6JRd2eXdQjwC/HtCPL6zX5QHQ5pw7nXv6JjR0ngISbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293214; c=relaxed/simple;
	bh=nL13IUFKFeXstid8TA1/JabYUB619clPMQ0nEcOTZSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv0prRHCaDannbMYMBtwtGA6pSWxxo/tg2v7Fsrp8VP8ww3ekGTYoTMOGfEOcQc990L/2FIpgZJqVWqSqreIIPuMjUupTb5USc8UOpXa2hOZ+cu2sFA/7vArw7aBZEFArQD2dQXko48Rr4OOjog39WrRhqUMtMRK2wxAftwCW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ILj8Ey+G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ILj8Ey+G"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DDoRSf002951;
	Thu, 13 Jun 2024 15:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=uLXUx7Jp3bWbE
	FcECk7slBB0jNtnowMXhhGygxJBd8E=; b=ILj8Ey+GeP8nN2owTF8zsbzwpRcQj
	qO8hJBDrYsWHvWkneuCadTPak54P+eMoO9lWl2FOhSUVpgP31wAQ8I0yLWn5X3L4
	PQJ7GHenGzZzD1U2GlwV8XNM6BidA9yS2+kFZ8hwPssap+yZlF+RSYCt69fqq7fK
	Cx7Y9gwdxrUj2hso+XG4MWf7caTzXpg7d1K6d2Qsw14nHavswhandJcqmQJWz/AF
	rfeF5T3StB+ibSzvbvfLbokeTBY7kLBKfXnUwGEkeKFCzcMQCuR5zIlIvKQwU5q5
	UFXYB1n4JNGut/DrvkVJrOLUgRY7lFy9XfSh7AvjA/YOG8z8RcPmnmTMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqy258xxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:49 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DFdnRh021098;
	Thu, 13 Jun 2024 15:39:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqy258xxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEAxeS023597;
	Thu, 13 Jun 2024 15:39:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn3un0qgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DFdgvl55640438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:39:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48EFF20063;
	Thu, 13 Jun 2024 15:39:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9CA52004E;
	Thu, 13 Jun 2024 15:39:41 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 15:39:41 +0000 (GMT)
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
Subject: [PATCH v4 17/35] mm: kfence: Disable KMSAN when checking the canary
Date: Thu, 13 Jun 2024 17:34:19 +0200
Message-ID: <20240613153924.961511-18-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: I4PaEB_PP3Cvo4oOH-ZDVke6KXq6_-uP
X-Proofpoint-GUID: X5BX2RWEHptsiw2F2Vy6DfHMQyyCihli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130112

KMSAN warns about check_canary() accessing the canary.

The reason is that, even though set_canary() is properly instrumented
and sets shadow, slub explicitly poisons the canary's address range
afterwards.

Unpoisoning the canary is not the right thing to do: only
check_canary() is supposed to ever touch it. Instead, disable KMSAN
checks around canary read accesses.

Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kfence/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 964b8482275b..cce330d5b797 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -305,8 +305,14 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
 	WRITE_ONCE(meta->state, next);
 }
 
+#ifdef CONFIG_KMSAN
+#define CHECK_CANARY_ATTRIBUTES noinline __no_kmsan_checks
+#else
+#define CHECK_CANARY_ATTRIBUTES inline
+#endif
+
 /* Check canary byte at @addr. */
-static inline bool check_canary_byte(u8 *addr)
+static CHECK_CANARY_ATTRIBUTES bool check_canary_byte(u8 *addr)
 {
 	struct kfence_metadata *meta;
 	unsigned long flags;
@@ -341,7 +347,8 @@ static inline void set_canary(const struct kfence_metadata *meta)
 		*((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
 }
 
-static inline void check_canary(const struct kfence_metadata *meta)
+static CHECK_CANARY_ATTRIBUTES void
+check_canary(const struct kfence_metadata *meta)
 {
 	const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
 	unsigned long addr = pageaddr;
-- 
2.45.1

