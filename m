Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD042AD20;
	Fri, 21 Jun 2024 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929626; cv=none; b=WasEbdKeeyDk2zH9ebRQTUUn2k6DSbsbkLsjQ/zLciCNqv4NKO9fgOu8dVVyUM28xbqMweGfz2M8jCOKeABRizyy7vr6iDvK4L9oYMIPo9EFE0kMd3mf8wyMlH3o/Nz5VgHzEZu0wyDmJAHUD6MERhoOGt3MtP4Mndenwx3RKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929626; c=relaxed/simple;
	bh=wR53sLEKK6Iq5nyyI35utKlPTSMVJzB0HRlsg8n1lgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwZprC0wQ1zt9JnSWsO3sESYnc00JakAyZZr6FG3RvNL6Y5m5gG3C0gNt0oS2tnkK8cf1e7Ljj3XXqzHFxmy1OMIzLABwlaY9bH3zAB8xXmNOqes3u8Wuwgl/gR2cZKNwXOYDGJR7OKMMkBunrTYxWsk76bQwFiM/HaBBiG3YJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tcPUg5+W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tcPUg5+W"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0QnuZ007904;
	Fri, 21 Jun 2024 00:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=DjuPcXR1BibZz
	5Ch991GiPtCxAY119xb/qfTqg6kigE=; b=tcPUg5+W+hgpGH+krm31HOBPTrWO9
	+DwN/OijUc4YdG2S9x4PQuP91KRNyj0u6dHD6OGZqYSFY7CXNhMh4b2UmKG/ExnI
	4LlB6a38g3SSDC3UyX5+LPThGXjReiAt8V/Jha0DgTll3n5JRlwWreEo8vAjWsux
	1qhZPBSZo0CUVOdmR/tudy14cnxn7Fqdrj2ry/X561UbJ3RmikfQ5Vuq/z8KugvA
	DTFsAvh5a5zOK7s0dbwIiQZQK+y7T9TZUBhDhwvIRGMOy08fX+cAFY6Rv8cQwkkE
	ygUbC1JuBVE84SxG5n4UikZq9py7H0fDu/EO5mgnYRNlVvOgPZMTtKUQw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c875u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:49 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0QmWJ007892;
	Fri, 21 Jun 2024 00:26:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c875q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0PD2h031890;
	Fri, 21 Jun 2024 00:26:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspjmyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QgCm18481484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 052CB20040;
	Fri, 21 Jun 2024 00:26:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5F6420043;
	Fri, 21 Jun 2024 00:26:40 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:40 +0000 (GMT)
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
Subject: [PATCH v6 18/39] mm: slub: Disable KMSAN when checking the padding bytes
Date: Fri, 21 Jun 2024 02:24:52 +0200
Message-ID: <20240621002616.40684-19-iii@linux.ibm.com>
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
X-Proofpoint-GUID: s7hafDy5aFTcRtvqVQpLOtSJKs9sYlpb
X-Proofpoint-ORIG-GUID: 2sowwXNvMO2B8DX6tP-_7374bKZOifoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

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

