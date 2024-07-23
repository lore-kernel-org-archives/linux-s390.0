Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF614EC77
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738695; cv=none; b=uLm7NLb+RLP1mZsAK01YpsWA6waMNifUZEGf0Y/IP4bfDn587B074tgIxC7G9VzG4EM5FYrjlp6YIQiNFfp0Yvr/bz7Xf3Svx0ldcoK2svESHq0AhjsUtbhrnNTAAYjBKNa6AS90PJzb3XOX6ycnT3/TjyRHVZ5XpltkQ/SQP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738695; c=relaxed/simple;
	bh=um+lPMkN0ZTicV1LbDagqKM/Cg6zjvJkYVVY5HpBVTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXdp1cwJkhp0qLcC/D7mDruWlEL+haaZu3/IDl7/cJXuJq4K59+MOyKfVW06owS3AR5DhTu6KJ15MoSUtWDDFCbGi58wuzQbYjkCUes/tZi0XpGOVUMQS35KL6Zwx67neH3eVmqPQFfzRTf71xv6IJwl9YVxMzCzKaKxPHJbaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RqOWX4rB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RqOWX4rB"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NBvAdf009240
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=nqgjnJITuVTG6
	jX24lxm5m9NnF5Pts8Fet+FlojOha4=; b=RqOWX4rBp6oOlzqyv9/C78dva8inF
	5ikKWwOMdLaveHd1bSu0ZNDQ/Mq6kNpwZPIoNyoeE2kd3cYcQ2U/tB4w/RkGXswX
	fBoPok5cdX/GXaIP5qap2tcablGKjBaVmPE8sVMkVODKpX54fLEtjAJDYEvmGhci
	1xmB0e/xjagWKksV/7lqE5A/VA2QuWJXOHnHDHVpYhrD4wvo9WZsET1D80CK4STP
	0KPEjge/PZ4+z0kioWFQqFHKbVQFyyWuZuxB2Te6XLzwfMAfngppk43A/VJ3UrqR
	JPIUPc0bEhQNVbviQYQka5XzJJEnP//CWJwoMHMtsaO1Tz81uOK4QFZrg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rv165m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9OYHt006625
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn7acch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NCijj232637242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 12:44:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0249B2004B;
	Tue, 23 Jul 2024 12:44:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9B1620040;
	Tue, 23 Jul 2024 12:44:44 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.13.42])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 12:44:44 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] s390/ptdump: Add KMSAN page markers
Date: Tue, 23 Jul 2024 14:44:12 +0200
Message-ID: <20240723124441.120044-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723124441.120044-1-iii@linux.ibm.com>
References: <20240723124441.120044-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s6In8HdmHT2uuN9fok9BRcveRVFyDN5b
X-Proofpoint-GUID: s6In8HdmHT2uuN9fok9BRcveRVFyDN5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_01,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230089

Add KMSAN vmalloc metadata areas to
/sys/kernel/debug/kernel_page_tables. Example output:

    0x000003a95fff9000-0x000003a960000000        28K PTE I
    ---[ vmalloc Area End ]---
    ---[ Kmsan vmalloc Shadow Start ]---
    0x000003a960000000-0x000003a960010000        64K PTE RW NX
    [...]
    0x000003d3dfff9000-0x000003d3e0000000        28K PTE I
    ---[ Kmsan vmalloc Shadow End ]---
    ---[ Kmsan vmalloc Origins Start ]---
    0x000003d3e0000000-0x000003d3e0010000        64K PTE RW NX
    [...]
    0x000003fe5fff9000-0x000003fe60000000        28K PTE I
    ---[ Kmsan vmalloc Origins End ]---
    ---[ Kmsan Modules Shadow Start ]---
    0x000003fe60000000-0x000003fe60001000         4K PTE RW NX
    [...]
    0x000003fe60100000-0x000003fee0000000      2047M PMD I
    ---[ Kmsan Modules Shadow End ]---
    ---[ Kmsan Modules Origins Start ]---
    0x000003fee0000000-0x000003fee0001000         4K PTE RW NX
    [...]
    0x000003fee0100000-0x000003ff60000000      2047M PMD I
    ---[ Kmsan Modules Origins End ]---
    ---[ Modules Area Start ]---
    0x000003ff60000000-0x000003ff60001000         4K PTE RO X

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/mm/dump_pagetables.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 45db5f47b22d..98dab3e049de 100644
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
@@ -65,6 +75,16 @@ static struct addr_marker address_markers[] = {
 	[VMEMMAP_END_NR]	= {0, "vmemmap Area End"},
 	[VMALLOC_NR]		= {0, "vmalloc Area Start"},
 	[VMALLOC_END_NR]	= {0, "vmalloc Area End"},
+#ifdef CONFIG_KMSAN
+	[KMSAN_VMALLOC_SHADOW_START_NR]	= {0, "Kmsan vmalloc Shadow Start"},
+	[KMSAN_VMALLOC_SHADOW_END_NR]	= {0, "Kmsan vmalloc Shadow End"},
+	[KMSAN_VMALLOC_ORIGIN_START_NR]	= {0, "Kmsan vmalloc Origins Start"},
+	[KMSAN_VMALLOC_ORIGIN_END_NR]	= {0, "Kmsan vmalloc Origins End"},
+	[KMSAN_MODULES_SHADOW_START_NR]	= {0, "Kmsan Modules Shadow Start"},
+	[KMSAN_MODULES_SHADOW_END_NR]	= {0, "Kmsan Modules Shadow End"},
+	[KMSAN_MODULES_ORIGIN_START_NR]	= {0, "Kmsan Modules Origins Start"},
+	[KMSAN_MODULES_ORIGIN_END_NR]	= {0, "Kmsan Modules Origins End"},
+#endif
 	[MODULES_NR]		= {0, "Modules Area Start"},
 	[MODULES_END_NR]	= {0, "Modules Area End"},
 	[ABS_LOWCORE_NR]	= {0, "Lowcore Area Start"},
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
2.45.2

