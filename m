Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2826FB2;
	Fri, 21 Jun 2024 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929641; cv=none; b=Xm68G511aoKs003HU4nb0QQ7bMJCr1njt08a1g6gInSYfclJFGdjumDntrKVDhUmYqgFyZZFLXZwTmN0daMgfK7lbjzgyUuLWh8Gw86ecbACUKP/anQ9jZP5HmAavmdUGSl0yLyzS3gRT8vbnqNPvbMmKstd0huvd0ZZrpLQacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929641; c=relaxed/simple;
	bh=d2/rW4z5JA+hWF6GGLxIeeVunzjSAZfwoQbx7SnQ6OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDr5jgy35H4no3yC4Jzjni9EpwgXc6kkcInZhADMAwbM6rRV2Od+bbVqZODaUcf3+aDCifJXV6XF59y639h0U6iSVYk97/1smMgX+9L5wh6MkD69XqFf0xivV5MVfL93h96sVmBM21Rc6bZeWdRQZXSndMNcNV4/+RPAoy+ONvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sUnHME64; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sUnHME64"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0R3tp023355;
	Fri, 21 Jun 2024 00:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=lwqEGphQg9/N4
	AE+qTFRbf/COwqV90p8RxwOJfRaDvM=; b=sUnHME64zAR07GeAsCP+tfFazMxF3
	AvF9W5UCwUx7LoW3WzAZfnxwWYON8fjMhK7kfN4JALZ+xlEgs5BsX/6eTrPpv3fe
	9RRDK1FAnCTwPEjVN6GimR9wgNkYooDDWBPrtls4oszTTtcjE+CMn+Yz26QHa2Sv
	az7WoSlOb+sdcqh4z9iNwgdbzzDosvUCxXj55ZBlTFWgEFm0qIQAKtu/RYe/NbBL
	AVSFc8h+aLsCsBo267JOfd34MeDoj8t1pcjwCrxsRY39Xo/gW9rp0pm6YBLfFloI
	BqVKccJOkx3zRqBMooif8i+FsH4jOO98EtqS6RunC6DVPHHW+mncS9Tug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvs6g7ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:02 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0R29o023301;
	Fri, 21 Jun 2024 00:27:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvs6g7sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0DBDN019999;
	Fri, 21 Jun 2024 00:27:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrqujnyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:27:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0Qt5m44761488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DF2120040;
	Fri, 21 Jun 2024 00:26:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BB6820043;
	Fri, 21 Jun 2024 00:26:54 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:54 +0000 (GMT)
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
Subject: [PATCH v6 29/39] s390/ftrace: Unpoison ftrace_regs in kprobe_ftrace_handler()
Date: Fri, 21 Jun 2024 02:25:03 +0200
Message-ID: <20240621002616.40684-30-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: N3pQcZOmYYu02d0GkX16fhENd3yleyOu
X-Proofpoint-GUID: f6nbbUMMpzabyYE5l2CvSVqR2_ItvZYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

s390 uses assembly code to initialize ftrace_regs and call
kprobe_ftrace_handler(). Therefore, from the KMSAN's point of view,
ftrace_regs is poisoned on kprobe_ftrace_handler() entry. This causes
KMSAN warnings when running the ftrace testsuite.

Fix by trusting the assembly code and always unpoisoning ftrace_regs in
kprobe_ftrace_handler().

Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/kernel/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index ddf2ee47cb87..0bd6adc40a34 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -12,6 +12,7 @@
 #include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/kmsan-checks.h>
 #include <linux/kprobes.h>
 #include <linux/execmem.h>
 #include <trace/syscall.h>
@@ -303,6 +304,7 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
+	kmsan_unpoison_memory(fregs, sizeof(*fregs));
 	regs = ftrace_get_regs(fregs);
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (!regs || unlikely(!p) || kprobe_disabled(p))
-- 
2.45.1

