Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4AA951;
	Fri, 21 Jun 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929645; cv=none; b=FuXYS7wX7FofX0+vmBUqmhUt6oRnVjF+zE6C3JoWjVGbFbjkW7QF1nA/9KMfdSPmL7sJIJJywzpUIA52HUQZBbNCDJAKsHYfz7DV8hxYo3MuArNGNmaYcyDAnY4vgex138Dwdp1U6eHwD2iUTRrog6gmd5U4MZXPPHt7WBcuIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929645; c=relaxed/simple;
	bh=x/bqTW8aLaeugolp1vyK3H0LbuMPCMTzluKQNFmesYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0LQC5X/JNp1KTTgXQd15zP6R9UBVej4CUTIhLCiEZwwVbs+cYqRGWHgZotgS5299UdsZdiiGVFTBjwO3FaLF0bKioe0Eom1VqYx408jtPRjG5nR2OXHaeJ1evbAMdwiMD5eYCaLg3SJWPBh/DGvUIjvm9aHPOqUHAeYK40hlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CpVjcAR0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CpVjcAR0"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0QZfW022585;
	Fri, 21 Jun 2024 00:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=hop8BCpVSniaF
	M1MpaXvqCFGVqZnzKhq9StiRXmewRE=; b=CpVjcAR0OosZ+FQKvo8Jt1i1ShciW
	NC5NUYX6ovbPR0EhliBF9Qb655atP4PZX5N4DlLuKNKwQDQ8wNwBP7xnzeEtKHJZ
	eDBa9JXexUaC70+QolO/rHSeHJFDr8zvCdnFDX2ZY7VytXmVGKuBL7TwVGyfprAx
	6EwH2gcc6rnckKj1HnyOHBe12aMzjxtKW6RK9T4tGHaopCFZo3ycBmNwAgY4+3MF
	79lmxIJPWcuP10J4wCpKrWpN0FvyscQq9DDNu+WdDM5zj+anGyOBGm8rU0R51TEe
	UAQaHxcjva3oSw3RNbkhAiwvhZzpKw6gXjYKhe5La3fPrG3GE74isni9w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvs6g7t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:06 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0R5ij023521;
	Fri, 21 Jun 2024 00:27:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvs6g7sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KLcZY4030993;
	Fri, 21 Jun 2024 00:27:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrsstn3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QxY857213382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:27:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AC832004B;
	Fri, 21 Jun 2024 00:26:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AA3520043;
	Fri, 21 Jun 2024 00:26:58 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:57 +0000 (GMT)
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
Subject: [PATCH v6 32/39] s390/ptdump: Add KMSAN page markers
Date: Fri, 21 Jun 2024 02:25:06 +0200
Message-ID: <20240621002616.40684-33-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: D7iiuOSKyPIFLwMOccTbCBPFEbLUtDDO
X-Proofpoint-GUID: opa2CPcd6-_OVWf6pOKSPr_YpfqQEXBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

Add KMSAN vmalloc metadata areas to kernel_page_tables.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/mm/dump_pagetables.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index ffd07ed7b4af..f51e5d0862a3 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -36,6 +36,16 @@ enum address_markers_idx {
 	VMEMMAP_END_NR,
 	VMALLOC_NR,
 	VMALLOC_END_NR,
+#ifdef CONFIG_KMSAN
+	KMSAN_VMALLOC_SHADOW_START_NR,
+	KMSAN_VMALLOC_SHADOW_END_NR,
+	KMSAN_VMALLOC_ORIGIN_START_NR,
+	KMSAN_VMALLOC_ORIGIN_END_NR,
+	KMSAN_MODULES_SHADOW_START_NR,
+	KMSAN_MODULES_SHADOW_END_NR,
+	KMSAN_MODULES_ORIGIN_START_NR,
+	KMSAN_MODULES_ORIGIN_END_NR,
+#endif
 	MODULES_NR,
 	MODULES_END_NR,
 	ABS_LOWCORE_NR,
@@ -74,6 +84,16 @@ static struct addr_marker address_markers[] = {
 #ifdef CONFIG_KASAN
 	[KASAN_SHADOW_START_NR]	= {KASAN_SHADOW_START, "Kasan Shadow Start"},
 	[KASAN_SHADOW_END_NR]	= {KASAN_SHADOW_END, "Kasan Shadow End"},
+#endif
+#ifdef CONFIG_KMSAN
+	[KMSAN_VMALLOC_SHADOW_START_NR]	= {0, "Kmsan vmalloc Shadow Start"},
+	[KMSAN_VMALLOC_SHADOW_END_NR]	= {0, "Kmsan vmalloc Shadow End"},
+	[KMSAN_VMALLOC_ORIGIN_START_NR]	= {0, "Kmsan vmalloc Origins Start"},
+	[KMSAN_VMALLOC_ORIGIN_END_NR]	= {0, "Kmsan vmalloc Origins End"},
+	[KMSAN_MODULES_SHADOW_START_NR]	= {0, "Kmsan Modules Shadow Start"},
+	[KMSAN_MODULES_SHADOW_END_NR]	= {0, "Kmsan Modules Shadow End"},
+	[KMSAN_MODULES_ORIGIN_START_NR]	= {0, "Kmsan Modules Origins Start"},
+	[KMSAN_MODULES_ORIGIN_END_NR]	= {0, "Kmsan Modules Origins End"},
 #endif
 	{ -1, NULL }
 };
@@ -306,6 +326,16 @@ static int pt_dump_init(void)
 #ifdef CONFIG_KFENCE
 	address_markers[KFENCE_START_NR].start_address = kfence_start;
 	address_markers[KFENCE_END_NR].start_address = kfence_start + KFENCE_POOL_SIZE;
+#endif
+#ifdef CONFIG_KMSAN
+	address_markers[KMSAN_VMALLOC_SHADOW_START_NR].start_address = KMSAN_VMALLOC_SHADOW_START;
+	address_markers[KMSAN_VMALLOC_SHADOW_END_NR].start_address = KMSAN_VMALLOC_SHADOW_END;
+	address_markers[KMSAN_VMALLOC_ORIGIN_START_NR].start_address = KMSAN_VMALLOC_ORIGIN_START;
+	address_markers[KMSAN_VMALLOC_ORIGIN_END_NR].start_address = KMSAN_VMALLOC_ORIGIN_END;
+	address_markers[KMSAN_MODULES_SHADOW_START_NR].start_address = KMSAN_MODULES_SHADOW_START;
+	address_markers[KMSAN_MODULES_SHADOW_END_NR].start_address = KMSAN_MODULES_SHADOW_END;
+	address_markers[KMSAN_MODULES_ORIGIN_START_NR].start_address = KMSAN_MODULES_ORIGIN_START;
+	address_markers[KMSAN_MODULES_ORIGIN_END_NR].start_address = KMSAN_MODULES_ORIGIN_END;
 #endif
 	sort_address_markers();
 #ifdef CONFIG_PTDUMP_DEBUGFS
-- 
2.45.1

