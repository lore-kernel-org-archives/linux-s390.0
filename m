Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74871E6DEE;
	Fri, 18 Oct 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242924; cv=none; b=mFYbxW6SF0g7rRGGfubMqKrUNgQ9WGjFkd9ni1t5pL1vBZGyG3yq5aYErggCQReMpuLk3Xnjq4HhQfZUdgt9TMAUQ+5G7reKkUtnCvfF5hVb2Xd2gyCImP6ejbMS/u5JHwIi80FaXK6YgZ/eSOWRYI+hecaL9ThkERGAcijvjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242924; c=relaxed/simple;
	bh=wgCrqlRXi3O+Ks3dP6PikYK5HnEOZ8qwzAQBgQqI7dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQQ7RfiwB4px+Paq8HYz5ItDe8GAGYlIKZLw3SB36H9FSc3xOXKRORuP/+eElSH3ukMnQV2VyK0ak1MJWcrPiC25Twj6Uwc0RG+nj5HZUTTySlS8J0nrAd2VWHVE4NIdbFbHL06+DkkIAf6kyyH1Q6kJCtK65aqzNHe5JJCIPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ynskq6xk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ynskq6xk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJSBBK008056;
	Fri, 18 Oct 2024 09:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gEjBgVIEcXC0tXkQs
	qUuxD/tNu7I2RdQzakrVk9yCmE=; b=Ynskq6xkASCzqB34m/gXOAQq9eubcZE0f
	y32lJA6C/tTvPEAxOKseJqDZgMlAJYHqThnIM9gIkYSgleLary/mZTn1Vkm6PQTL
	Pvgwq7pPHfRU13moSP4Sn7+qbrZXUyM2Zpe8GKS7qr/DprJFCYjV8hItDdpztBz+
	ohv6/EhCDjdH9L3iFbbJXm399u5kGXtV3C/L6/HW1jPihz9U9dnhqIvXW69a1n14
	I0dbMEm/AsNTFxbehdfWmYm2lEi1wf7r+9W12knBQ/4dtijC3MZsznSkd9a/uGEa
	fO6auoqHT901adYKfypxE4KK9JRf2HT/LI2Osh5SRK8fQM7+mItAw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42as8a7f7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I61TLI006338;
	Fri, 18 Oct 2024 09:15:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428651b6cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49I9FHlT42729940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:15:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED88D2004D;
	Fri, 18 Oct 2024 09:15:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE9542004F;
	Fri, 18 Oct 2024 09:15:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 09:15:16 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v4 1/6] s390/boot/uv.c: Use a constant for more-data rc
Date: Fri, 18 Oct 2024 11:15:11 +0200
Message-ID: <20241018091516.2167885-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018091516.2167885-1-seiden@linux.ibm.com>
References: <20241018091516.2167885-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q8UT5UVrFnjYgBmw4plyajuwe9BU4hWE
X-Proofpoint-ORIG-GUID: q8UT5UVrFnjYgBmw4plyajuwe9BU4hWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=789 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180056

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
2.45.2

