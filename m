Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575615A86E;
	Wed, 19 Jun 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811975; cv=none; b=CJWZK/UXSHeeFjB8mSW056Ktj2ZG7bW63YjPupSbL+QXu64MR4UoX76Faoi4IXYoXKAi5fh3T/nUhs/rWsOmUN08gqVNUGGBSI8t7iJbo0/Clpes7wV87uBNvd7DEEd3sRQ5AMIUiXLcuARI/l87Ixatu8yLJY1qUvzmze/E76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811975; c=relaxed/simple;
	bh=2Wgvcf0smiyR2hvDG57dZeFCL0G9Nu6TmtHSS3SpZww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lu9KABCSHDUF4lPjTvDosUsSWVvvPOiclg6UuI7Yu58/iF7fq4xQPSRjtMgfAf8fSSjb/kO6NLkKZ+rsF9NvyT/Zmdo6pihMNcTx/nrKX4MeBSHwqL/hyy4qqGvnLb9FewNClJGU0Cmo3JD9tBnMOhtAUNTem8thAEiC+w5CyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=giV3GCSu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="giV3GCSu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JFQlR4018028;
	Wed, 19 Jun 2024 15:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=1loLMhtSJ//mV
	R2W6iv7p+SprUeUNXIsjh3OlBetJcI=; b=giV3GCSuSRIby5ry/DXskg0sjwva3
	yiZF0NIBT1G9/u3p/Bi/StG2hvOMT8dskezLNFjmjhQ8eZPoyTStwq3Gig1C3v96
	4cLKPTtk8ulvP6SSdOutkJu9CVz9AZP51GLXwvlkkA6s2ktB9dZ9bOqMakw3f2EG
	WDFSjAiTHmnSG4OFpX3xz5J3hyft2PES/TAPlCa/Iv1XSLxGjxlgStM9XJJYPd3e
	NeXa2KpcNj2pkYER7I0BlkAfbnRdbRwZx43ybmRofB6Xxo2ifM23Lkb1AYX2jW0i
	cmrzxKVX40FxFqxvtvj9eHz/RBVEAwN4vPAO8FYah+8xgxlxf5d2mqp6Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv1jg8546-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45JFjol9016365;
	Wed, 19 Jun 2024 15:45:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv1jg8543-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JExeaH006285;
	Wed, 19 Jun 2024 15:45:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9ux8n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JFji9C20382130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 15:45:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C5A2004E;
	Wed, 19 Jun 2024 15:45:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF5F52006A;
	Wed, 19 Jun 2024 15:45:43 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 15:45:43 +0000 (GMT)
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
Subject: [PATCH v5 30/37] s390/mm: Define KMSAN metadata for vmalloc and modules
Date: Wed, 19 Jun 2024 17:44:05 +0200
Message-ID: <20240619154530.163232-31-iii@linux.ibm.com>
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
X-Proofpoint-GUID: AecUav4zPu2pbA3kMbY9tgEYraj6MXQ1
X-Proofpoint-ORIG-GUID: aq7PB1sVMkX90gQQlshy4s4Ee0lgg62B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=702 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190115

The pages for the KMSAN metadata associated with most kernel mappings
are taken from memblock by the common code. However, vmalloc and module
metadata needs to be defined by the architectures.

Be a little bit more careful than x86: allocate exactly MODULES_LEN
for the module shadow and origins, and then take 2/3 of vmalloc for
the vmalloc shadow and origins. This ensures that users passing small
vmalloc= values on the command line do not cause module metadata
collisions.

Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/boot/startup.c        | 7 +++++++
 arch/s390/include/asm/pgtable.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 48ef5fe5c08a..d6b0d114939a 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -301,11 +301,18 @@ static unsigned long setup_kernel_memory_layout(unsigned long kernel_size)
 	MODULES_END = round_down(kernel_start, _SEGMENT_SIZE);
 	MODULES_VADDR = MODULES_END - MODULES_LEN;
 	VMALLOC_END = MODULES_VADDR;
+	if (IS_ENABLED(CONFIG_KMSAN))
+		VMALLOC_END -= MODULES_LEN * 2;
 
 	/* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
 	vsize = (VMALLOC_END - FIXMAP_SIZE) / 2;
 	vsize = round_down(vsize, _SEGMENT_SIZE);
 	vmalloc_size = min(vmalloc_size, vsize);
+	if (IS_ENABLED(CONFIG_KMSAN)) {
+		/* take 2/3 of vmalloc area for KMSAN shadow and origins */
+		vmalloc_size = round_down(vmalloc_size / 3, _SEGMENT_SIZE);
+		VMALLOC_END -= vmalloc_size * 2;
+	}
 	VMALLOC_START = VMALLOC_END - vmalloc_size;
 
 	__memcpy_real_area = round_down(VMALLOC_START - MEMCPY_REAL_SIZE, PAGE_SIZE);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 70b6ee557eb2..2f44c23efec0 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -107,6 +107,14 @@ static inline int is_module_addr(void *addr)
 	return 1;
 }
 
+#ifdef CONFIG_KMSAN
+#define KMSAN_VMALLOC_SIZE (VMALLOC_END - VMALLOC_START)
+#define KMSAN_VMALLOC_SHADOW_START VMALLOC_END
+#define KMSAN_VMALLOC_ORIGIN_START (KMSAN_VMALLOC_SHADOW_START + KMSAN_VMALLOC_SIZE)
+#define KMSAN_MODULES_SHADOW_START (KMSAN_VMALLOC_ORIGIN_START + KMSAN_VMALLOC_SIZE)
+#define KMSAN_MODULES_ORIGIN_START (KMSAN_MODULES_SHADOW_START + MODULES_LEN)
+#endif
+
 #ifdef CONFIG_RANDOMIZE_BASE
 #define KASLR_LEN	(1UL << 31)
 #else
-- 
2.45.1

