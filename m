Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094813777F;
	Fri, 21 Jun 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969861; cv=none; b=OeNBtV6EQyF8BiNoYw5zhu3xoY2TxDih2eQo7b7F0kvuFpiJ+lrCSVyLvJt9HcGVVpTTzL177Bdnqu4wYTNP/vHLgHk9BwULkW5QaT9VmYtZqBHj8ZT5rX+ygZg+58Jigvxm61gp6xRn+BFN0m6j0BuxRdvLQdbWs7lcFZqj3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969861; c=relaxed/simple;
	bh=yEkUFwHzqM2QxOJ6rCJjLwbF170i74UCFAzqXMXYm3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFC5IOoQa0xz9etiF80ElV8tcsQEPN5zCnKElI/DSGG7SN5p+CofyGy2hmB4lODcdqVpdG3prqh1oXWGA+mdxvQb1VRQjTtBJnFiurdlI9fHfdZTiCpH6aK1N16K//rI26jXgfoBm66Xe5+9C9tpCZAiJyMSkYoPQPt091rn20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OuMN9lLw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OuMN9lLw"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBTkcI029866;
	Fri, 21 Jun 2024 11:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=1qF7H4bGHDZ6i
	OOMBP071rdyF1q1YAWA6gRStiWbHSM=; b=OuMN9lLwF/oqbO2ymxq2Xijx0Y0/W
	KeJBrZ//0PA/P5dWhWO/w9grmiPDirB4wwk6BOdSH4iezZUxUz2UWIpzpI3px5Fr
	6OApwtfgoA29V2WebA9kKu0mJidZU4Le9dUfuyIWutaQyUZ25kWWETc1IPkykurh
	p5ASHHM4vkdIdLfjYB2PIMk1lF0x/JakVPJTEyd/njUbTkNGAg9+lUGUE4wcfxFn
	+Glkm23mCT5lX+Uwr+fIHrWwcyrRyEzMHmJ57jIwrK6f8wY+Dcd4vj+Lbic7QsZp
	hMbHyq5X4RhDKdSHBdl5RsYU+rFIvWNKBOJZajMwHRFbnxhzeKygCGmuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw8p080mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:20 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LBbJEh008790;
	Fri, 21 Jun 2024 11:37:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw8p080md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L9OhiP007658;
	Fri, 21 Jun 2024 11:37:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspeupj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:37:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LBbCHq51380564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 11:37:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE3F92004D;
	Fri, 21 Jun 2024 11:37:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34A122004E;
	Fri, 21 Jun 2024 11:37:12 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 11:37:12 +0000 (GMT)
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
Subject: [PATCH v7 06/38] kmsan: Fix kmsan_copy_to_user() on arches with overlapping address spaces
Date: Fri, 21 Jun 2024 13:34:50 +0200
Message-ID: <20240621113706.315500-7-iii@linux.ibm.com>
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
X-Proofpoint-GUID: ZhQY6_lca67g0ijpbVVKolBQCQddUqc3
X-Proofpoint-ORIG-GUID: _dvfEb5eIB4856vofN3h5INjSUP5phgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 mlxlogscore=799 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210084

Comparing pointers with TASK_SIZE does not make sense when kernel and
userspace overlap. Assume that we are handling user memory access in
this case.

Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 22e8657800ef..b408714f9ba3 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -267,7 +267,8 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 		return;
 
 	ua_flags = user_access_save();
-	if ((u64)to < TASK_SIZE) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) ||
+	    (u64)to < TASK_SIZE) {
 		/* This is a user memory access, check it. */
 		kmsan_internal_check_memory((void *)from, to_copy - left, to,
 					    REASON_COPY_TO_USER);
-- 
2.45.1

