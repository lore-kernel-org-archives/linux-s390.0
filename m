Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3A15D5CD;
	Wed, 19 Jun 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811979; cv=none; b=WQpn1y23PUy53t9E34ffn0giiK3ql+Eh3JR5/MH4VeQ2ltqB+2HaSymoMv/OTsqmrkWSeVZmEFxo2g3rNr2371ct5eQU6SyqbKaDLLzxZQbZD3TMpowMKOQDoQfVGCNqymMgL0aohEpAMfO4nlk/FyWoPj1GUYc1GGgCBvpejgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811979; c=relaxed/simple;
	bh=we+8YEIjIruLSlIl4JJyOmsbiXxMUAovQv4VftLclJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEa0U0DmN5CSyRkq9Mufq0tHr74S4jCYObp3dPnC0DsAaFYc3CbQO1P6tEOiz5gADzpMgXyDznKvwKP+TkS9uWzAsAvKSauf0aweq1Qb0gNVWTgJ10yQ/GRs3Pa2ug7bVUu0QXCM3ftpuGWBkSzu3VtqLHdaaLBBV1vRTi5sWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxzKVds7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxzKVds7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JEtwGJ013034;
	Wed, 19 Jun 2024 15:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Scz6uta8wJUcm
	kDwOaiOL8UogdsQpVaK9UJlhoWG7HU=; b=rxzKVds74UqHTpAHTV6TTJ3971W+d
	6XbtI3rMQi0dBwotTZ9HREuUr+hhXQw8tfApEhojn+M7EAM1UXe1EVsRwZLgwjKM
	SCJEfg/pqptc8FT5qvoAfBLg1shijLWAiGceHfz5Rx0a5XkTi4dGaccqM7NeIQp+
	C3WuRkNiy2GCXJXtiEPn8rm3xHeoEUjH0n612+lFc6L6tNagr0/a+s4WHxOSBaex
	s2nWazmpnXX0rwpK71ACM0qXPxs9g8/bW2gaz5gl/1XV44zSqk5ClvunpexbrbIf
	FV9lgmTQwviWQCSG1QGvTvMBzYViWlto99FoJtE+GqjDUwaWY5jP7aCfg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yux3fgupe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45JFhBe4032622;
	Wed, 19 Jun 2024 15:45:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yux3fgupa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JFhSXM023897;
	Wed, 19 Jun 2024 15:45:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9qdypk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JFjZku47907278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 15:45:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41BAA20063;
	Wed, 19 Jun 2024 15:45:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4D912005A;
	Wed, 19 Jun 2024 15:45:34 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 15:45:34 +0000 (GMT)
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
Subject: [PATCH v5 04/37] kmsan: Increase the maximum store size to 4096
Date: Wed, 19 Jun 2024 17:43:39 +0200
Message-ID: <20240619154530.163232-5-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: yqBnn__VPUChFXLmx57TWXMbRlB3RKnh
X-Proofpoint-GUID: wAGMmQY3YfNo3xdFT986fs_57LHV7tLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=742 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190115

The inline assembly block in s390's chsc() stores that much.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/instrumentation.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
index cc3907a9c33a..470b0b4afcc4 100644
--- a/mm/kmsan/instrumentation.c
+++ b/mm/kmsan/instrumentation.c
@@ -110,11 +110,10 @@ void __msan_instrument_asm_store(void *addr, uintptr_t size)
 
 	ua_flags = user_access_save();
 	/*
-	 * Most of the accesses are below 32 bytes. The two exceptions so far
-	 * are clwb() (64 bytes) and FPU state (512 bytes).
-	 * It's unlikely that the assembly will touch more than 512 bytes.
+	 * Most of the accesses are below 32 bytes. The exceptions so far are
+	 * clwb() (64 bytes), FPU state (512 bytes) and chsc() (4096 bytes).
 	 */
-	if (size > 512) {
+	if (size > 4096) {
 		WARN_ONCE(1, "assembly store size too big: %ld\n", size);
 		size = 8;
 	}
-- 
2.45.1

