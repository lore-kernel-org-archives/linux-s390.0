Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D229174EC2;
	Fri, 21 Jun 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969875; cv=none; b=iQkNiaoLlLb6BpIpo9MrM4/6mg35riVv/qMCI7lSufeKGR7QtPRh9eS+qkPNzAUUHHYiGct6RSsABhlQB6Fik0vGEjE38i13aHwiYmdvTPwzAftvHLzGxrcwnk84Iu1k5YSfdVsUcAx+pKR4i0KitqX66TF/BR7diRAvsHo/8AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969875; c=relaxed/simple;
	bh=wZbdgyfm9mhUX5hJUbxjFVz/i1tPc5SbXvdd1uF8Pj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlMEi8KzrgjRuqQWrtci3G1QgFbjiK1M1ZVLvWY7vXkMb8vvluaJgEx+JnaZ/blRGkoqMjlCtm7R1ptV9rYvOHmeN0OWR0x78dIDKd6CEsl2BX6oYnryjpKOMpOL1F/78CzDnst2Lvsl8jjmh2LtV4Mb0I4a8b1uvDIuAu4TW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EVMWG01B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EVMWG01B"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L9wphq019602;
	Fri, 21 Jun 2024 11:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=o5OLh1G5igJ7w
	fCkEas83RRSlonR9xfZGMUuvDY/DE0=; b=EVMWG01B2oC74lZBbL2kSPnMQZ5Ey
	GhloJsCiv+elwBctf7BhxcRrVcSkiv0g2G2V9yGfWYfTQfIaRc2bJdcrcGlvrJW3
	OWxRPnp1WSA9rr55k6HJbN6/DoWp9IND7o4KAW7MoUK/O2qgZHk/fhTTnx+rCdyh
	3H1BjfUk2clfA6ZZpiua3Fsjx+c9IS1AyXnw2+TXz1Jbi6G9VvrXnx7uefnK9+tM
	QL4sB0UUXmCVQ/8CPXpJ5DKAvAYkgmNOLl7pdqQlkSdxDg10GOL18ycxjPAS3Us6
	89uo2XPPczKg1q1E04eP6VRSF8UKl+5IPEFuQvqd/KkHVkGaAfxQyUxkg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw7by86pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:28 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LBbS0q005032;
	Fri, 21 Jun 2024 11:37:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw7by86p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L9KGho030990;
	Fri, 21 Jun 2024 11:37:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrssxvbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LBbK5U55378330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 11:37:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF09520043;
	Fri, 21 Jun 2024 11:37:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 351DF2005A;
	Fri, 21 Jun 2024 11:37:20 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 11:37:20 +0000 (GMT)
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
Subject: [PATCH v7 19/38] mm: kfence: Disable KMSAN when checking the canary
Date: Fri, 21 Jun 2024 13:35:03 +0200
Message-ID: <20240621113706.315500-20-iii@linux.ibm.com>
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
X-Proofpoint-GUID: qNNzZXoNK5Jx7e0m-RV4t8XuUyzuBdnJ
X-Proofpoint-ORIG-GUID: 9nqHha1GsHQHCk2fCPLnLz5EA_SBzbVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406210084

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
index 964b8482275b..83f8e78827c0 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -305,8 +305,14 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
 	WRITE_ONCE(meta->state, next);
 }
 
+#ifdef CONFIG_KMSAN
+#define check_canary_attributes noinline __no_kmsan_checks
+#else
+#define check_canary_attributes inline
+#endif
+
 /* Check canary byte at @addr. */
-static inline bool check_canary_byte(u8 *addr)
+static check_canary_attributes bool check_canary_byte(u8 *addr)
 {
 	struct kfence_metadata *meta;
 	unsigned long flags;
@@ -341,7 +347,8 @@ static inline void set_canary(const struct kfence_metadata *meta)
 		*((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
 }
 
-static inline void check_canary(const struct kfence_metadata *meta)
+static check_canary_attributes void
+check_canary(const struct kfence_metadata *meta)
 {
 	const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
 	unsigned long addr = pageaddr;
-- 
2.45.1

