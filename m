Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013250;
	b=SD5ChaufL1zKvQKXOZiCChtQjBiIM5624Z8HgIDRUatFqZof9v0F4ZqVMiN98GqwkO+5
	 rXsv8Ht2xyIc7WjESEupyOlUG6O3DEifWOpgYXhT1cFZTf0NM8ku1KiKRONDJWLYD7qXK
	 o6K7Ilshm2nwjuu2WBmtF5FwoOJUMDkjtkK+5SZ0ej8X83WoIusfTorZmsrmRK819miPS
	 /7v4g8BAFZyFbyAm9cbMrIIkzuSDHbgcR4yUl7+1xS95s63hxsVwZUFukFgAiS69covkY
	 3T14jyfLaK9UljcXr+zEyFKPfRmRpwb+1krY0dSkWodY5yXBMgyx+dwHJvWd1rZMC4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013250;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t5onPN3TrUNKENSnEWzImlab/yxdW0A7q5jzF8fCqJg=;
	b=ugK0rtFD7xAlgTaGbdtGr/tki6xI7QUZoGwC45LjCvwm4xBs98UqfXP0PB65DiSeEIGt
	 W554cMRVm+Dn4lJIXGK576RwxW3i09npndxCwY+xr9ir56kRiP1dfpGktQT35ftogmDdX
	 Al6A3YF+9dHrr/f7Mjsvsg/4B+sivGrLWPQn728tvGdC1MF3h6HvWtahG/LiJld99tXJ8
	 rNPAsywB2/THj+p+pUJ0cMgyW/YvT5jzRI5r1c6aaP2sADxWtixo4//UhpV9Set00qMTp
	 10XyVP3A4qjbqT32d18o/Oabt098Ye+XDdILa4oIeMszwZ5vHGOSxPbDlUFfeLH8Y2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rLOOlaCV;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC990606A331;
	Wed, 18 Nov 2026 14:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC990606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rLOOlaCV
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDR3dB012468;
	Wed, 18 Nov 2026 14:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t5onPN3TrUNKENSnE
	WzImlab/yxdW0A7q5jzF8fCqJg=; b=rLOOlaCVLQn5/GaIyIhvbmkHf+UXlBnEl
	XG1109xNVGlnK4u6Q6FEx2RK0TYiu4wIDnMiumMr+whOvJ20otfKpJRA7uGRsiJF
	CpqjJCtTnaXLWwt3RO546HyLOBa3q48BpMQS9Ww+co/XIf8hUi89UnSNhe/xwdH1
	GA8zMG65jVcjc5ZLZs5ZPEFESG6AlgKLUemUD93NBieKjt8BrVzArUEY8cG5Yg5m
	awVZ8cetOuljBfmqeGI/3U/5MDUBa2E71PX40BLpTRKGO8sxE+wqfEMSauyibjLH
	xA7L0gI/KdQ/r2/yjZFuUlQizXs9sDULyVVg6kH3TUCAKZr0t2ssg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vtuxg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDYtEF3470648;
	Wed, 18 Nov 2026 14:47:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt8swc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElAJ550659740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF07E20049;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B03982004B;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/8] s390/kexec: Let crash_protect_pages() warn in case of an error
Date: Wed, 18 Nov 2026 15:47:04 +0100
Message-ID: <20261118144709.202520-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118144709.202520-1-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
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
X-Proofpoint-GUID: VGYcd1GHk2X6PjwmKUj_tWaY4HtZnlpz
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afdba73 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=kMJ-d3RZYZQm1CzUGdYA:9
X-Proofpoint-ORIG-GUID: VGYcd1GHk2X6PjwmKUj_tWaY4HtZnlpz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX33xbrhqn573I
 7EajZrqz5VrwYL8/V/e869FRbOoti9YOd06zlLSmBwQV81eJe0uxZyaty/2TCS3E21BzIORjwud
 2JsPnf/avue/1xRtiHKRner/7fGY8/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfXxHUNW59blgIP
 HCUvXpndIq4/2HWhsUxPF1vbIxQUWOawsyACSjjl4gwR9UElc8vwlQcPZK47MSCuAZ46UBpSWoZ
 OPxXk/4zUGNE7JG2LalMD1s9Q7q/znD08ozWtdyHIqSPVY/81zNuO7vdtloWF/Xqr/zv+UXPkAu
 f+8hiUxJASo3l08MmXczp/wYaBQUz8Q08942YMuSUeVnotnzcNwCs2wtImJm0bjA0JhWGXGrLj/
 Jzb5y6uT66OCM7mxD+FFXSo2+zVnRg+oT9gLNXy2ujtJbXPKjQWEzCzZK4cBw0ux1+LKcyxgYbR
 qMnzLXtfKEEQUSY3Qqzhhi1AhFVSbkzpiTqKkRIygr+c3CUByEHiOcFsJX1aVnvPLVIJNNS4zKw
 yJqcmo1viabXGhv7sBsuN79RzgIm8vPX0T0rFT/muwa53njkfVsnStoULfSwdazKbuRRV5fVNob
 N7MHHgI6eix7eHzUPwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180057

Let crash_protect_pages() print an error message in case set_memory*()
fails.

This doesn't buy too much since a failing set_memory_rw() would result in
a crash of the caller as soon as a write to the memory area happens.
Fixing that requires larger changes - for now only print a message.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/machine_kexec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index baeb3dcfc1c8..bf65bea5fa01 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -152,14 +152,17 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
 static void crash_protect_pages(int protect)
 {
 	unsigned long size;
+	int rc;
 
 	if (!crashk_res.end)
 		return;
 	size = resource_size(&crashk_res);
 	if (protect)
-		set_memory_ro(crashk_res.start, size >> PAGE_SHIFT);
+		rc = set_memory_ro(crashk_res.start, size >> PAGE_SHIFT);
 	else
-		set_memory_rw(crashk_res.start, size >> PAGE_SHIFT);
+		rc = set_memory_rw(crashk_res.start, size >> PAGE_SHIFT);
+	if (rc)
+		pr_warn("Failed to %sprotect crashkernel memory: %d\n",	protect ? "" : "un", rc);
 }
 
 void arch_kexec_protect_crashkres(void)
-- 
2.56.1

