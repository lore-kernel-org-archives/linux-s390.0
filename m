Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67D409280;
	Thu, 30 Jul 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403442; cv=none; b=KMox1AYV2HnBpOyOOMSlOU5w1oVq5pVW/YE76mPyGDkvRHHguonqF6sCGnPYYXg6QI0L/4WzUzHNp880CqPXmy/8hSXykp5krmyq/g/A7ZD+XR5dNxBYRsbw3jIbAb8VUGqMRs40MPjsGgoKr9sBR5XoLj0nyb0cn2yWRVzaeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403442; c=relaxed/simple;
	bh=cjpiMiEDqfJPrj33295z1Ghm8pSRGPlm6YG4fBlCtYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFo9aRJdKz7/A5q6+ZBKR6ZVmnwLsQZt1QkxvW/X5pEIgPM0p4lzb8tG5fnp3mprNwsG9+MazqqMsDOTev3sF85rGe0KxiM9WZ/cxTme77q4reHkDt10murgzb5AoKXtyJq9d7Wlqwz5vBwoPRhBQp4MSrsjvAQnvPrcYrPTNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FmCaJahC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FmCaJahC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6llB52193257;
	Thu, 30 Jul 2026 09:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ujuq7i
	DI5C20NDnGWJ3+4fbScaM82S8IkAhTt/MLpak=; b=FmCaJahCqSXvoRO0cy/F0C
	1sflnGCP4dIg47rHq68pn8vSE1GZVtPUfVO5umdG31e2cTGXqFrixkq3HCJKaGlo
	tIR5qH86Sa3QdL/nD2YvtfGul7aKC8iwtFaUJZOGQeu5tG32LwvsJOBJx+5opVK4
	ebYLjNC0xP59lj9wOSNYgIWcwfH0nB743YYUEOOuRcckjP4cZRU8LSRSbrQgp8L+
	lkOZn7ZKaWCvoqjBabUqtC1i2pzsRtmhZ5KEctwZS9SZlENFxGbL3J7xuPZt95DS
	1vkVpxT3KGRokLEkgW9i4lhHmVkHZXKU60oqI5Ia+Sj9SZQNGvj/ycnaVs91F4jw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyje4bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:23:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U9BYbc011341;
	Thu, 30 Jul 2026 09:23:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhjjfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:23:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U9Nbt329426054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 09:23:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0BFF20040;
	Thu, 30 Jul 2026 09:23:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F5522004B;
	Thu, 30 Jul 2026 09:23:37 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 09:23:37 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 30 Jul 2026 11:23:27 +0200
Subject: [PATCH v3 1/3] panic: Introduce arch_do_panic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-arch_do_panic-v3-1-d5401e683cdb@linux.ibm.com>
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
In-Reply-To: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfX/ca38MtHx5sO
 banMTURY8j5WYb2sSQE4ZmzhoaI5hzu6vyKf0tgVxX4ljj19lsFZC/kBu/IXLPUlmJWq4jEZKOT
 UcdSvVCuagPFgoGoSsTPihrHrLmyffQ=
X-Proofpoint-GUID: aPWvPhBUfX_9bL95DEGj25wMmqVkRLpP
X-Proofpoint-ORIG-GUID: aPWvPhBUfX_9bL95DEGj25wMmqVkRLpP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2OCBTYWx0ZWRfX1l9LXFaq7L9R
 JW+Q3fOkwnumLU8TjEMd3LBJ/RxYn+hDZ8/A01+VLRJm4xnwibVs+4OYYh9EyWN24TmVK2MMQbr
 7TfGrvPXlhIbHcjNXq0Ffa0I42iw23GCuD4gQxAkylRR3/RQjVJCYisfP0tDGgFNamqlhECnqtl
 JN71VoDwAAnYXRIeIUkPZu/XoP5++NRoVSOZHsYosTq5CiBXExiorwEMU5sX4wTDHw5nGLaAVxQ
 se3frkyeDeVbislAZqzQhutzdlMTUbzJTTXKB8d9nhrNIzGlZ626ySTBaE774QIfwMGuMeCtPLu
 J+I7L8NcH8GuBTNFdXkxQm3AiWmXQ7bj3NpckVef9sLWlzIec2f312mspw+Tqv/wPsS5hvwdpeu
 Eyo+7/cvDWfpHcQ5vS3Sdd+qQf4HZOZmOv0ycGmpVygTKz69cDaGf8OjOLuqPcx0nQU+pN4lQY1
 TmhTTaVdONrWLSBlyVQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b181e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=vDqFKWyYXM9dIk6-_9sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300068

Introduce a hook for architectures to put their specific panic handlers.
s390 and sparc already has ifdef preprocessor checks to execute
architecture specific code. Pave the way for vpanic() cleanup.

Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 include/linux/panic.h | 2 ++
 kernel/panic.c        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f1dd417e54b2..98dd7dfd27de 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -110,4 +110,6 @@ extern void add_taint(unsigned flag, enum lockdep_ok);
 extern int test_taint(unsigned flag);
 extern unsigned long get_taint(void);
 
+void arch_do_panic(void);
+
 #endif	/* _LINUX_PANIC_H */
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..726a97842232 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -567,6 +567,8 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+void __weak arch_do_panic(void) {}
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -756,6 +758,7 @@ void vpanic(const char *fmt, va_list args)
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
+	arch_do_panic();
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 

-- 
2.53.0

