Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACA1D0DF3;
	Wed,  2 Oct 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885141; cv=none; b=D6AEzBKUxQvKVK4ikx8AZxe0K9+GV97bX7M7A+MnDRmq78baVrpOMZ9mpEbQ71lmWRcxv27Fv7fQzqTnzUO5X+m39dYLYZXfcXuYfxp4/skkJojwGKvEQ5/2qaV/dO9Zh85AMo6VsaqttIbcXOZiU5mQeSOsUBJm6ThQsIedC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885141; c=relaxed/simple;
	bh=oKmb52NZW4Ss3mx9G4VcEGXja1Im+9PyseimUy38ot4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su2pkYp+FUKlx94Ia4VKS4PzmSw4iLKp+b7NQXSOA9cosC7/ht7m+nCD3JQ5tY4RBFHGWFwXMX6TnplEKerSYY9pfDbbRj6TaupeT4p8rgZD7TSNOdJnW/qq8Bw+ThshpAjQJrAOGKrersS8jWfsH1DKwc/Rg/3u+dj7AIpFRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e76GkRPt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e76GkRPt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Ft1mQ011482;
	Wed, 2 Oct 2024 16:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=WZDP5vSlSe04G
	TohU6vluHK/vacQa3M+mRi6Zp9cMQw=; b=e76GkRPt145iwHXtgtTzXeddIwu9e
	12ucVPMZz5wnH7Hh78+UCJjNPv8u+mgeqj0+YoAE3zQEMpXkSkvGdj0HHNjukN0N
	TS1WlTmMyvtfJJcrg2b7tFFu5aP+nazwkcsR/P9uV+tgZ5l2voKHC3L6csJlwkCG
	hjDZ1tQjoSaYak3JxYZ9Qkc+1L1JCaxnDse/a9UeXXWEc/mXCnqgCMv0TZ1JdtlN
	fl2fwUTf3FXb0LjA8WdL9RABIHTsKc3CNplS2GutWBRXO8eNVelxyiSy+AYWML6j
	2EWM26hWeYQTQxoxKerZo5cxrYsTgquDD/TsT/EIHYVKn+/tHSmWA9p9Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42197tg1u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492E376n014616;
	Wed, 2 Oct 2024 16:05:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmkb3yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492G5X8i55837076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:05:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5B9220040;
	Wed,  2 Oct 2024 16:05:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 866FA2004B;
	Wed,  2 Oct 2024 16:05:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:05:33 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 1/6] s390/boot/uv.c: Use a constant for more-data rc
Date: Wed,  2 Oct 2024 18:05:27 +0200
Message-ID: <20241002160532.2425734-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002160532.2425734-1-seiden@linux.ibm.com>
References: <20241002160532.2425734-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7_2JEgZDcAAljvKvmNHTDGiqEwwyxey0
X-Proofpoint-ORIG-GUID: 7_2JEgZDcAAljvKvmNHTDGiqEwwyxey0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=783 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020114

Add a define for the UVC rc 0x0100 that indicates that a UV-call was
successful but may serve more data if called with a larger buffer
again.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/boot/uv.c        | 4 ++--
 arch/s390/include/asm/uv.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index 318e6ba95bfd..2a71e759dc42 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -22,8 +22,8 @@ void uv_query_info(void)
 	if (!test_facility(158))
 		return;
 
-	/* rc==0x100 means that there is additional data we do not process */
-	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != 0x100)
+	/* Ignore that there might be more data we do not process */
+	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != UVC_RC_MORE_DATA)
 		return;
 
 	if (IS_ENABLED(CONFIG_KVM)) {
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 153d93468b77..94ff58336e8e 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -28,6 +28,7 @@
 #define UVC_RC_INV_STATE	0x0003
 #define UVC_RC_INV_LEN		0x0005
 #define UVC_RC_NO_RESUME	0x0007
+#define UVC_RC_MORE_DATA	0x0100
 #define UVC_RC_NEED_DESTROY	0x8000
 
 #define UVC_CMD_QUI			0x0001
-- 
2.43.0

