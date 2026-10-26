Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016217;
	b=grs29+DETs4ydAb/TbNfl8DtpJTAeCne7iHwAc5Mbx4f4LXffpGX+fvhV+w6fQ17PqN9
	 Ycfxzm1pQAH8uRM1ffORHK+UQP7Lr1kgWX8SMts5EWJiqEhtVWaCK2sp2LLuJXHdle5MM
	 thmVDvgzh73tRvJB4wu10xCPPevtz5vX6fu35sWo24t0sMDuyRbgVc//hn9Tp7evi/3Op
	 sDFWheejq0w5UOQQM1rqMPuhJIVG2xe8M8UDCHF0GROyIVXB+6b/HhK4rJr3/++10aD9Z
	 wf1SNYsQb/WZ378tK+OMub/RRP+BeYiYBOtqm8yQzGTlg1VvOhYXP4ZZZEyutw9RZ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016217;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pJvkKezVsaptzcKzZ1UJNWhruCUdQlQPxasi1dFLfpA=;
	b=xMsXaOgPUnDNDWJoQoraJEP/8O9aWMtvEmHYZuiErVWjdMDGTUAYAqiHtMTGMCMTdcVE
	 1RZ+/sm0K1sWbXAHWFDA6sogorabAKuKkqXEuMdDMY7RpZdYSk8tyrhGnxCDZ53IlniGE
	 Vsr5R8T+0/fb+G2AgvVnKotpR6RKzKLJgpURT+q5rtkz2pTPHyCvI/M0lUwdth64ajt7b
	 lTbY5xby/tyB7TFMhTcORQWXaoy48cy4suZbAgHlO5yRiShlnKed9XGLNjARAABdAvVvZ
	 6KP+IDdwGoLfcJcd0pb/TpZtVs96dcvUKH2/wgWzzs7FqAKuUoWzKqZv+0xBvOwI/FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZMXNCE2G;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD2606A330;
	Mon, 26 Oct 2026 12:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5FD2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZMXNCE2G
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBECjB1707101;
	Mon, 26 Oct 2026 12:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pJvkKezVsaptzcKzZ
	1UJNWhruCUdQlQPxasi1dFLfpA=; b=ZMXNCE2GZJwaeoUKxY/su22iUL9k+nTy7
	DMDjvzfrh/JauYlq4C3YkHtmRrEdu5H9LkuRZDy7Kl4pCglragG0Rwr0zpjaXo8l
	pY31iHRxxObGsfIqJw4A3uyK3QPhtvHwXTiHqHFM6t3+gLeCC4F2LIlNy5naGAlP
	xbzys+ME2X8rNFL1OH09YSKsxClG8w4s996OsaahPzeBlVKRtsukih03skpvn2Mp
	Y1eFJ6nd5AH6qgFQYvrboo4Q82XAtnFpw5BmOEPWmhgdMzuojP1d6dzRAVT0cbk5
	pjx/eAeSCRZh5/EXLkaA/+b1haK9XZNboWq/mRtzJVBuEHgG5KmCw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsspt2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB51Ha2500630;
	Mon, 26 Oct 2026 12:03:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8ggwmmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QC3UPU44564760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 12:03:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD0962004E;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B78CF20040;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/4] s390/maccess: Remove spinlock from __s390_kernel_write()
Date: Mon, 26 Oct 2026 13:03:29 +0100
Message-ID: <20261026120329.1792436-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026120329.1792436-1-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfX7nKj+NMLzief
 fMGjhtt3qA7tqcjPpXxjVFmN+Cda+RubbJDAwbGLPmAazdtpz8MzaT60o/r5FlMytBrw/UrjMt9
 6mNruNSQQC6jA12JmIC9FdgX/GNdtrV1tKGy6vYQxFX4GWt/EnZOsMTjs7yfN9pfEQayM4zq6OY
 izkMT6FFoYloa6p8+9G2vP8NPLWzFVw2m540gDFoPfwhbjWH67M/bazEDAm6z74lmwDbicNplAU
 8HGV8CGkHI8DyjsgufX6VJRjT5PCQ9QxKYohct/9q5sOudZFPg45ssPSMOywS1jUAZGzOFD41VO
 6srvJiq/jahwS5DKf7SqtdFqOjnfAtQ2s5Q0h4wJ4C+wWC0V8C504aTUd9M5SYsZBASZ1cTCqtW
 cszBkB2tFAFukj/rDyMNIzM1mAguLIc3c73APqlTwwY8yvleZ7gb2kYus5BTur/Sqnd1s3FAcpU
 6m9AaaidjSTPW0UXE2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfX0JFogmDOXIji
 hwSBhfgwaMSu6G8gQGcPPTdHUYnaL9MGnbHzh36qMibcTBBuHIEXpcCngI8REI7zyvDPTbbf1UM
 jeVYuYYaBkvegRX+yhy27K4tAEc5v5U=
X-Proofpoint-ORIG-GUID: l0wCHTx9IBHlxqMPxV8OoY67RZSjHl9t
X-Proofpoint-GUID: l0wCHTx9IBHlxqMPxV8OoY67RZSjHl9t
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6adf4198 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=FgSWGUQ1hMViQLcLPCwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260046

The spinlock in __s390_kernel_write() was introduced to serialize the
read-modify-write sequence against concurrent callers. Now that all
relevant runtime callers of s390_kernel_write() hold the text_mutex, the
spinlock is not required anymore.

Replace it with preempt_disable() / preempt_enable() and sync_core().
Previously, CPU serialization was implicitly done by other
instructions. Make this explicit with sync_core() instead of
relying on that.

Preemption is disabled so that sync_core() issues the CPU serialization
instruction on the same CPU that executed the stores. This completes all
previous stores and makes them visible to other CPUs.

Other CPUs need to perform CPU serialization, e.g. with text_poke_sync(),
to discard already prefetched instructions.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/maccess.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index f39968dd8063..cda3f81dfbc2 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/text-patching.h>
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -60,22 +61,20 @@ static notrace long s390_kernel_write_odd(void *dst, const void *src, size_t siz
  * bytes from destination at an eight byte boundary, modifies the bytes
  * requested and writes the result back in a loop.
  */
-static DEFINE_SPINLOCK(s390_kernel_write_lock);
-
 notrace void *__s390_kernel_write(void *dst, const void *src, size_t size)
 {
 	void *tmp = dst;
-	unsigned long flags;
 	long copied;
 
-	spin_lock_irqsave(&s390_kernel_write_lock, flags);
+	preempt_disable();
 	while (size) {
 		copied = s390_kernel_write_odd(tmp, src, size);
 		tmp += copied;
 		src += copied;
 		size -= copied;
 	}
-	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
+	sync_core();
+	preempt_enable();
 
 	return dst;
 }
-- 
2.53.0

