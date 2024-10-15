Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481E1D89F8;
	Tue, 15 Oct 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991748; cv=none; b=h9ECC6MXx7im2mPyrU3G0YlU3rCPYL6tc531w3LbAlj/D3XYXJ3kVN18n78unC/IFhCUIzW1FB2hWBzdO/kHJn9eci/i2dP1XVOpwAHL0pRLnHsTiDcdsHvtiMM5sepZyjkSg+geWP3HfEUiEovNhJWeeZgcOaEF5izUbvuCWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991748; c=relaxed/simple;
	bh=oKmb52NZW4Ss3mx9G4VcEGXja1Im+9PyseimUy38ot4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCGv0uvWo/k4hGUDU1ESHF7F61fFALKOtDwGn1BSyyX0CVmkDd6HyGv0n5b2IiSrovBA7yDRMJjfdCDzfd/Nl07ZUirTG9HLeXYKyJK0GporiRf67iOYDMjiJEz1cFREwMRDWsfEGzR4h64BokyybhMUf2WN2jiFDVf5cO4WpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nQMJ3k6u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nQMJ3k6u"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FApWV3013774;
	Tue, 15 Oct 2024 11:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WZDP5vSlSe04GTohU
	6vluHK/vacQa3M+mRi6Zp9cMQw=; b=nQMJ3k6uIIW3JykK5FOealaaIyMWXhuaR
	Ln7p1/lGiIkEOFR2gyEy9H8zBCSJ2Qo5ChAkglEgzQtLZIJAUbXZDdKtaTPoxP7t
	smQvHXwl31iA3v6DmnaJw/FrmYsgx078zhdQRBUy4do4DFFkr9dvrNGHxQDBiQO6
	Nk9P41rPz2qSrUKMIgfFEzmuCGcnAlk6NHEAou7cwPHGI44DjYEorX3xyAoyENcA
	M//mkWQGLTIfZq/tQi6UYDCZy1Q2ilVn+TSIHvZK/Mk+HjYyx4phQXEC9vAZlkjM
	MPFWoWIEcl72u/PHOAFop5FGwAC8FqG1r0ZRymTN76gj4WyT/kPRA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q0gg695-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:29:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8BF1T002452;
	Tue, 15 Oct 2024 11:29:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emkh2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:29:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBT0Ic48628016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:29:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2775E20040;
	Tue, 15 Oct 2024 11:29:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 006E22004B;
	Tue, 15 Oct 2024 11:29:00 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:28:59 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 1/6] s390/boot/uv.c: Use a constant for more-data rc
Date: Tue, 15 Oct 2024 13:28:54 +0200
Message-ID: <20241015112859.3069210-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015112859.3069210-1-seiden@linux.ibm.com>
References: <20241015112859.3069210-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PGIfTgPf1uksJG1jtxL7gpWE5nAK53hN
X-Proofpoint-GUID: PGIfTgPf1uksJG1jtxL7gpWE5nAK53hN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=789
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410150078

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

