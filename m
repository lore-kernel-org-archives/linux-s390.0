Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6011917DE;
	Mon, 30 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702361; cv=none; b=F1nnZM4AnnozQTYAFPQ5NXDQ7pQu9LlKLJKTMbz9X3HeBLrEjPBMPfDrlV+Tmo1A0qGzVNvLOFZ2BP7xzdceNKf1i1i8Q9tK4xCepqI89gxgtaS5uTKc6mMvM6kNFhWPkktKzCKPZIke0bOLMf3dEaOOu37ColVtRIqh/PEkTuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702361; c=relaxed/simple;
	bh=dD0IUBu5oKYX0iXgoknBuIU73T+29OAXhtQZsr2d1eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz/Ht08JWmu+n3AzQQnrpFTq2Yj7uhAWLKARybCM6yiGVRUV/vRpGu7UBZOz4XGqgbqhbVQ082H8WJKUxUZIu6Fxnt4QPpnA/bqbyfbkUM032OL/KIc5Un3i3VrhtnEcoEtqxAJmrm4Tw7dg/38TWPjP2Q7yz1cD/5qnEJN/PWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A8dG/Ca0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A8dG/Ca0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCwuvQ027466;
	Mon, 30 Sep 2024 13:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=J7BO1GV1GzoTb
	H5R2GkR0xLUxv8N99PpfNItGWKlry8=; b=A8dG/Ca0xSmdmcH4iOjOxp8XKBai2
	o/BMJqns7xZr3X4pFUkrAppla2u/9IoZ5tOc3Po0sybrPVRGMTZEqAXIu+oRcLE2
	OG2RQPCsEEHN0eKmoLa9jPgsROQdlnREvICBOeCg8LuVYqZ8mytibREJT5TgKEnE
	mZgpqQoOWRp/K1lBKLcvepzjPCnhuJ92YGgSgqYB99yHes47nntkHF8to13C3k8W
	mlppqOP3YVKoIFGeRzCJG5+DiKb4PJHWg5WzT2lByH+C92EhuQV42AwSPOCiS+f4
	wYM/dq/twI5vdq4ogDCMvCCt463VXnaPHiFFfsBBgV8LEsbg2o85YOklg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x77qsvvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC2Gwi013070;
	Mon, 30 Sep 2024 13:19:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj6epv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDJAZt29360884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:19:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E60C2004D;
	Mon, 30 Sep 2024 13:19:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 530A62004B;
	Mon, 30 Sep 2024 13:19:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:19:10 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/6] s390/boot/uv.c: Use a constant for more-data rc
Date: Mon, 30 Sep 2024 15:19:04 +0200
Message-ID: <20240930131909.2079965-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930131909.2079965-1-seiden@linux.ibm.com>
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9v1nC3WxksBubCOOvsCCDKH9_R1eYmVV
X-Proofpoint-ORIG-GUID: 9v1nC3WxksBubCOOvsCCDKH9_R1eYmVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=716 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

Add a define for the UVC rc 0x0100 that indicates that a UV-call was
successful but may serve more data if called with a larger buffer
again.

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

