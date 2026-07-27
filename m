Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084613890FB;
	Mon, 27 Jul 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148602; cv=none; b=ccVp2bdD9b6L/O+TCUL6fHkdcGZ7SPYPKiTxQYqe9HfthRx68ZkYEYBreW8F2ysto7FrDT827l5+zrAZEsn/dsxvpHzvbJ6732ZgTiVsC6bVPVNEIC1Duxb+8tewDZ3P1wZNgrevuhrk3hl7xTY+fI24O+u/g8kk9jMy9ToFjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148602; c=relaxed/simple;
	bh=Nr9pqwCaBaqgBE4vf7n0/MiVoxGGnyKbS7S3Zqf20tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TrZh0V4EzH3fENytZ8gOLP+eVSpu5xHmvZQDzR1Nen7yY9soNn/ebKIzPk6BSs976pU7TDCGp03yfla4d847mAW/aTFH0h05bVEt4jUTDgNNsFo3TylenTrnO4MgFYdgt2uVQQSgScypa00qX2OiFmt21VmeyPsz1YNG/1FlChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eExTZ6ze; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eExTZ6ze"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIS3t1921918;
	Mon, 27 Jul 2026 10:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p/UBmX
	PsshYILClnY/0b+PS55rq+L2jxS0XsUIEbf08=; b=eExTZ6zeH+r7vNppWYdR83
	dDBFgatwX9DP+n9H42mgtzT+Ali5AzjCph5BM1x9o7r/GNjF8L4AP4uQRmXiIxeU
	ASqj9vX8ItTfZZlz3wTjvqC/dk45TdE4NujdKupgjT3oAQvqd+OzcVHBzxS4hD5P
	R3bVzQLc5MG8UScQRiUQKEELhXqCiz5FavJZEe2HN9gmnk/jlVvbMb0NWF9nZNaO
	eRatlrlQ6b698qLFlDqErxAQlHItf59M0Ef6sNxyFfgGRQradWdoKwfWF5T8np/b
	BggHI+jcEFk8WtW8tBnuPqgNH2WfLK9bIYARnL8XC0EzmM7FMFPNFeYdQdoGtILA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77h2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:36:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RAQdt6004639;
	Mon, 27 Jul 2026 10:36:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjvyx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:36:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RAaPfl39518596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 10:36:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64BFA2005A;
	Mon, 27 Jul 2026 10:36:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 055742004D;
	Mon, 27 Jul 2026 10:36:25 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.31.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 10:36:24 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Mon, 27 Jul 2026 12:36:20 +0200
Subject: [PATCH v2 1/3] panic: Introduce arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-arch_do_panic-v2-1-4e25ceb05075@linux.ibm.com>
References: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
In-Reply-To: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hYuBBZ5t5TESj7GHziVPwXTj8SFtpLys
X-Proofpoint-ORIG-GUID: hYuBBZ5t5TESj7GHziVPwXTj8SFtpLys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX9Riwf9rjDBie
 OQfKdzAiM+mRrbP8XTNZpXG5c8CN0G2cK1jGK8E7UnZnJIm5yom0+jWAKHTW7PhN3fF26330LYT
 fwcZJPWSmHc2db+Gthqs2b43fxTAzJnx7tFpcJxF1d2HI86L9n8HkFghKTISjLZAOGLDyoZ7L2Q
 WzbBIY0aXOjaFeo8yUIf4LF+LuL6VHKLva1cr8JQvlVHTm5uxQe9JBWn02QBISYhM4ah1IU4PO1
 /klueZKZSvG0oI76l1qOU3Z0HcF4lawA1Hj4P3RIY/W235nqXHuDdOwHYnBq9oImDKGwTq/eq4k
 X7w1CyWq5XzKhmcV8PuebSqXpiW2ecUEN9AbYXyp3VAYk7zfdE6tJ+nNjMl+FNysLOjvzD8tRKS
 wS9zBAxIQ+sE+1iDCyUZsEca94JREHxJEDfV77aJ0wcDo+A8TUtlvUsIReMrPgllxdrdDZJ9r7m
 w9xYvQraQjQutwr11yw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6734ae cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=vDqFKWyYXM9dIk6-_9sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfXzdn7aZhn2dXR
 QcTs/Zxy6aFdNNIqFUEaTh1xiu+PXVu3pfJ+ndNZxsQ/7h4qNIJbUePAVWhJhVExD9d+OL1keza
 eB3Lk/4fYOb4QQTfaNMiwPxKWDJHdgk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270100

Introduce a hook for architectures to put their specific panic handlers.
s390 and sparc already has ifdef preprocessor checks to execute
architecture specific code. Pave the way for vpanic() cleanup.

Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 kernel/panic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..1eb0cdc159d9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -567,6 +567,11 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+#ifndef arch_do_panic
+#define arch_do_panic arch_do_panic
+static inline void arch_do_panic(void) {}
+#endif
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -756,6 +761,7 @@ void vpanic(const char *fmt, va_list args)
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
+	arch_do_panic();
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 

-- 
2.55.0

