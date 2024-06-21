Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389417C7CB;
	Fri, 21 Jun 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969873; cv=none; b=er9rz3eFcHX/07kTadlhmA9fJQODyRCxJTn1GmSPZG/5PGzGDXcp/+pHsETgXqiPWWgfWI/aCr4MU6t8t1OlLzTG3ZCNszaPn44/V+OcQiWMs/p7Zo9bYi0ZjI0gSHLt3oN8oazQvFL+1FEJ72XQpq7EhDu9LDSJYW/OsHh6XGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969873; c=relaxed/simple;
	bh=wR53sLEKK6Iq5nyyI35utKlPTSMVJzB0HRlsg8n1lgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgMuNSSXXgcCoTslCr/FT2GxNUusL5d2SfBvpAmKkLDVf2Z3mOn+XKJv2tb2e8tjHkOe90zreFEItL5YWFRIYjTTU2ev+wqVR94eT69WPM5OuN1c4jyLo6JcfS6CTvQIT1GoZLjqhKI1550cHdnLsdBZsv4gHYHUiolHyXrdu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gCmb/jd+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gCmb/jd+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBZFfl019981;
	Fri, 21 Jun 2024 11:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=DjuPcXR1BibZz
	5Ch991GiPtCxAY119xb/qfTqg6kigE=; b=gCmb/jd+tRaCgIblXL46fw3Ru9gvd
	3CF3TjMMxMyVSfK1w6i3qjTcd6lVoOatzRayVDautrWNG5BYAR0oAEvUDpOyl6eM
	1qytDXjek7pQv3nyZ2WYxSjrUmEndYwez31/qIt9IM0I/9yz73snsc1r37y++asY
	iTD8m3+dOt9kqx2xXJuIZ0IBZVnZRUbnkvwsS5/NE3Rp8KD4ozFspC0RczzV7XYl
	a/fUrV/AVQ5q9WbZjsGVRgMQprjN/eQd4TuKJ+/OhPpAy6oCpGFjybRPQgKjTRNg
	lCUWyKQl8DchFTWzVky4/8c0IMPHnEvynd0st6Y+3D2gN4iD5rkoS7Ilg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw49cgpwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LBbQpQ022007;
	Fri, 21 Jun 2024 11:37:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw49cgpw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L9H76V031933;
	Fri, 21 Jun 2024 11:37:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrsppv5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LBbKJI51839450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 11:37:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B0822004D;
	Fri, 21 Jun 2024 11:37:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9548A20063;
	Fri, 21 Jun 2024 11:37:19 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 11:37:19 +0000 (GMT)
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
Subject: [PATCH v7 18/38] mm: slub: Disable KMSAN when checking the padding bytes
Date: Fri, 21 Jun 2024 13:35:02 +0200
Message-ID: <20240621113706.315500-19-iii@linux.ibm.com>
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
X-Proofpoint-GUID: vituer1Uvt-m-Bx1xIgcKWanRH3GTkhf
X-Proofpoint-ORIG-GUID: v4Bwds8AEd2AHVddJ8G2HfSGwp0WqKu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210084

Even though the KMSAN warnings generated by memchr_inv() are suppressed
by metadata_access_enable(), its return value may still be poisoned.

The reason is that the last iteration of memchr_inv() returns
`*start != value ? start : NULL`, where *start is poisoned. Because of
this, somewhat counterintuitively, the shadow value computed by
visitSelectInst() is equal to `(uintptr_t)start`.

One possibility to fix this, since the intention behind guarding
memchr_inv() behind metadata_access_enable() is to touch poisoned
metadata without triggering KMSAN, is to unpoison its return value.
However, this approach is too fragile. So simply disable the KMSAN
checks in the respective functions.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/slub.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b050e528112c..fcd68fcea4ab 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1176,9 +1176,16 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 	memset(from, data, to - from);
 }
 
-static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
-			u8 *object, char *what,
-			u8 *start, unsigned int value, unsigned int bytes)
+#ifdef CONFIG_KMSAN
+#define pad_check_attributes noinline __no_kmsan_checks
+#else
+#define pad_check_attributes
+#endif
+
+static pad_check_attributes int
+check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
+		       u8 *object, char *what,
+		       u8 *start, unsigned int value, unsigned int bytes)
 {
 	u8 *fault;
 	u8 *end;
@@ -1270,7 +1277,8 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 }
 
 /* Check the pad bytes at the end of a slab page */
-static void slab_pad_check(struct kmem_cache *s, struct slab *slab)
+static pad_check_attributes void
+slab_pad_check(struct kmem_cache *s, struct slab *slab)
 {
 	u8 *start;
 	u8 *fault;
-- 
2.45.1

