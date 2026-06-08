Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058830DEB5
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897081; cv=none; b=ZJW1d4E28ZbgvySaTR6HGfXrk7MdopxFDkPZH/c6xJHk7WCR+sbkH+e/kbs7OJg2CHClbMbfPqY9IuoThyUtrQzx7T7lrxGWL4WsKRQIHr5Q1yHCORTHXH7PbWKSjsmk0TV4dJxNV8z/wAwQWaOefjx5DbXgOZyMd/n70+F4078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897081; c=relaxed/simple;
	bh=euXBz9hMcHtLKbXJ6SkPM6eRGvjMeKngyg3SXw6FNW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/Hu+4RPzeV8/6DuN8x+3mG202wVBkVp//tLU5zrg1DQmCS4h6oMZmZWvIXxMBXA+3Yc6/opHSag2CGQbsxWM4DQQibpAnO6/5gEywUGYaAWy1BFNTHX1KM99lj5cFwpRDzB/Syv7n4C5DzAXZb2e5+BU8gi6xM8OEoNHX+W+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lladqVjA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lladqVjA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EjwI64051865
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tDluLaWzCDEVdI0Jg
	81C+rWjvldSV/kD6/JVUfw6cU0=; b=lladqVjALCMUT9tmp8pMFZgk40F2eBcgC
	R0PmbsbN2if2UWyCu0IV5HgQsSnED1esbdDKe3h3MC4Di6M7RikzcjJgw6I+juWi
	Z/90XDFr/Z+ohUMMvxxSPY18+oyqr+/5b/hxC6pYghAwq15ZPCaGGZAA/iKfjaht
	wTKCLmSNvar4n5E+9lq8+ClAvvNxWMI9qgjwYyJluoxZ25GbwJN0FTD9fDQR3EJ6
	K2KmDzN1y5i0TlYBBlXuO8JugXl8mhbSU64raflbNqfrqwwGI1A+9c9ZRCHGi3Aa
	/OxUjNfUC25jkYMIwkR/TH4BEa3eUszlVal6HFyiZsUpMxZmYorkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydwthe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585YmOV006137
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vv1ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585bsFC51970424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A6020040;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B964F20043;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 2/8] s390: Add .noinstr.text to boot and purgatory linker scripts
Date: Mon,  8 Jun 2026 07:37:48 +0200
Message-ID: <20260608053754.571282-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608053754.571282-1-hca@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfXxO48331MF562
 Gl+i+HSOHdio03HRWI0lqbVKUQnCtkTsz1TMSv7HCVfysIccThktaHCjH5CN7NefacPf/dK6eIE
 bFlx2Dron7bpaUT6S/CKcT1Dia8vMYbzj6pDesPKosp52mJJ7dlCmARgzxWI/L9jwEiLEzf4pFu
 wh5w/tXIU+uz1OrpJz/YV3qIv473V+bNWZnPMlpluIEM7xNvuLBAiqrDgMZI1y+ar4QBVygocTy
 sHiuOFj5lshRgCu6BylVsX+AFM5psq7omPB+scHnhXxPqvHO1enTu7Zr0XPBY5ZuvmYnr67HwQ/
 mopNzOkg2hlB9AELxNj0KLpFSGXC8F7MXKPh779OX9QjY+8/U3glia1lWkHuw6bEz3FOHlRBa3h
 Ne9O45cZOLv12yqlp0hCfqObAhSCgKZEYReP6bjZ2KxysicfO11YnaKJmD8HThBmTK6qoAg/ksJ
 0uuVHKUMtrg+CWd3qAg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a265537 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=9kNBAdQCpEflj3fUxFoA:9
X-Proofpoint-GUID: _N2FGhykRqy4S3E1hDPhZ7M3awT-cX0L
X-Proofpoint-ORIG-GUID: _N2FGhykRqy4S3E1hDPhZ7M3awT-cX0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049

Upcoming changes will result in a .noinstr.text section within the
boot and purgatory string.o binary. Explicitly add the new section to
avoid orphaned warnings from the linker.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/vmlinux.lds.S        | 1 +
 arch/s390/purgatory/purgatory.lds.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 070bc18babd0..d44964592541 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -31,6 +31,7 @@ SECTIONS
 		_text = .;	/* Text */
 		*(.text)
 		*(.text.*)
+		*(.noinstr.text)
 		INIT_TEXT
 		_etext = . ;
 	}
diff --git a/arch/s390/purgatory/purgatory.lds.S b/arch/s390/purgatory/purgatory.lds.S
index 482eb4fbcef1..387d0db4085f 100644
--- a/arch/s390/purgatory/purgatory.lds.S
+++ b/arch/s390/purgatory/purgatory.lds.S
@@ -19,6 +19,7 @@ SECTIONS
 		_text = .;	/* Text */
 		*(.text)
 		*(.text.*)
+		*(.noinstr.text)
 		_etext = . ;
 	}
 	.rodata : {
-- 
2.53.0

