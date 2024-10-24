Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8A17B4F6;
	Thu, 24 Oct 2024 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751207; cv=none; b=XM0XwnWI48uRYue+O/bWl/sICEqPGTG3vkQiGKnESC7MrnUpsh9hSo8d5jSZkwBDiIF7cNvTmDIbnzN4FMUmH7XA2UMsE1WHJJEMukq7WB3xyGE+kWz7oQHgQHoBAvGSSVxwrmh6yYZ9eQOju98FN0t8mX9XXB4lEn3n8dp7TeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751207; c=relaxed/simple;
	bh=wgCrqlRXi3O+Ks3dP6PikYK5HnEOZ8qwzAQBgQqI7dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQrUe51pxofvfJWlbHmgwFh7bbrqUDsPdw4SlXAW51IHXFXvsWZxL/kD0+BuBG6g+BnGyA3NgNFO9ho3RlzAlUWCQ5VLHp6BBMD9AZx9ScC1rbv6B5UJc9Ucqpp9WN0uzm4eKHV2R8wxHt+juOG7ifL98PwXQ5YtfDcgiCdshtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L3XMMOUS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L3XMMOUS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O3oWYC016802;
	Thu, 24 Oct 2024 06:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gEjBgVIEcXC0tXkQs
	qUuxD/tNu7I2RdQzakrVk9yCmE=; b=L3XMMOUSm5w6R5sQ6WvXoG+INvdqyoZZN
	ZakmdFERKeQjXK1HyczwSmf22cvWkduM4xIDDhhWbMY/xv4LPie2IbufOBTMU9mo
	QnPAsPLtDhZTcnvcomtCksdudg2kNtGwrgFmr5Wz1+CEhQY0e9abZj0Nk7WS07i4
	P1LC8WeECOOTHSmh2ChgZQiC9daaz+sekPUoTObLxc/HlMAzfvZetzqu67ybeKfF
	OXX4aeHAhTUtQaa+IyCR9iTUSZHMuYcSNLQ9gh+19fwNXt3sVfwMJRWYA2tyvJM3
	PIokS0AbLzGRxHTUPJgO4VlC9AD5IzzJGbGEtetaa+KwBkarZZ5dQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajptbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:26:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2jVnD014771;
	Thu, 24 Oct 2024 06:26:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfpxeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:26:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49O6Qdkc33686132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 06:26:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 184A120040;
	Thu, 24 Oct 2024 06:26:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDFDC2004E;
	Thu, 24 Oct 2024 06:26:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 06:26:38 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v5 1/6] s390/uv: Use a constant for more-data rc
Date: Thu, 24 Oct 2024 08:26:33 +0200
Message-ID: <20241024062638.1465970-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024062638.1465970-1-seiden@linux.ibm.com>
References: <20241024062638.1465970-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NS9lZUbLDUxpEbKN2I_p-CR1KzJZ5qx4
X-Proofpoint-GUID: NS9lZUbLDUxpEbKN2I_p-CR1KzJZ5qx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=746 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240042

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

