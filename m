Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D852473C6F
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818846; cv=none; b=YZ1pOwft38A3WuBEs9KN/xL62FwT49oFpcQZ1gtIYgMk6ZodNPa+Ga7oQHr20i2lK7qnlgP5dMywx6Wc4tZiPjCQAFj3vFQdflvnGDVc2yYvLGdhLv0Gp9u2/7fZuE4b2qXwgOhXKuX6Xf48W3Efi1fG4gBjRZb17F3fdEKnokM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818846; c=relaxed/simple;
	bh=zFG0v2yRM1HKN4o/8O4jyo8xZ6nFaj+MyAWbJjQ8Q4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBlFCVQSjTAfwpQMZkcA32dGChQY5SB7BPHHBu6Cu14bTsSGxr+hCcNeuskm4BgVPc8JTc1yLJYIG6LiCyBF2QVObGUuJ7+Uv+J4xcLbGEDGvNIpj2hEtGvywn799vnMuInj44pR28JLU9JbBFnPdIJi8iRVMxgoKQYJ07RzHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nrLYEua6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nrLYEua6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBvqo3095185
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p0VcDIIlIO14EWrJP
	jMSviw7M9Gr9mqklcB7sMYlmcQ=; b=nrLYEua6AOx1atxXsjE2L3kfzrqev9JxA
	SfZdlYdvnBgLAQtZsUVelD5fVeo1CLEXjz/4ETv8Jfjc5XI4yXpTsfZ+V5IguW9x
	UB91lPvfAj23OophW8fggkWCf/PZNqJc3X/ia7ZiNAE493ONA434wicoPNvFaTS1
	kBWinHm5o46k1dfkBDSKv5uJxzOA+06xmbKJBPAd8kTEK6uEkrTYfRBPLUt9fA1C
	JVMP/i9YsgQzakTpQJK96dFE9VjFyhVFd+NbMUDCQWyb3S5NjGshrrUJczEljNmf
	1Pmk4leVI5T65ARfn4Xm+LOa5XIMvOHmOncg1xjw4DB0doM5H0mtA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahfjh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NEndIm002705
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gmh5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NF0dal33751482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 15:00:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 607DD2006A;
	Thu, 23 Jul 2026 15:00:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35B3A2006E;
	Thu, 23 Jul 2026 15:00:39 +0000 (GMT)
Received: from ibm.com (unknown [9.224.64.167])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 15:00:39 +0000 (GMT)
From: Finn Callies <fcallies@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, fcallies@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v1 1/1] s390/ap: Fix queue depth field length
Date: Thu, 23 Jul 2026 17:00:38 +0200
Message-ID: <20260723150038.93617-2-fcallies@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723150038.93617-1-fcallies@linux.ibm.com>
References: <20260723150038.93617-1-fcallies@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7t-zw210grKxqfhTipLBKhnvAoRzQySv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NSBTYWx0ZWRfX4IaLgEKQ2S05
 B6sorMJTQrIz3TjgR/Gsqd4VJp4aGoyMggVgOdjU2ztASfVpLteNkDeMAJzf3q3jhim/E50Gcis
 JnRNaXa6FsGUMZS7YU41/9gUSfuHSXpr8HQ1KQtATKSvRx1Xn56NKj8YvwXAWJQh0yjF+EnvFb8
 /uhwM9e3v0VPiHk+pGEhWE5gNpMQkpKPXLuKJbH+CiMNEZ7LDIf4Hrm40NyIGy8AqsQxA40tfKe
 iqHfcNGNSqj/qXOxpt1ULpC8yVJv3QjqZFlY/8QpDlorNtNUrm5oQfz2U327ky4a0U9AcWujRpc
 b+RS2cESPq49/n6/aRrIb+K69SMiKStPU7AeYBH3l7HxOVwbFDi15UQf31gN6N2T52U/7xVtii4
 eGu6/jIAdDUha/gaeR3T01VdNjO24wOPa0yPRUZaomimIoRqwFRB2MAjunsjSNhvofbB2skPM75
 RsxA4p6exxbWOMv9WZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NSBTYWx0ZWRfX/VpahuPsbNC0
 7Sadi59z1EG6Vvk9J/l/rOTQvDLGeex9HJd7v/m3D17Z9g4mnEJx7VIL27dea2+pZP3RawppLRU
 9rHV35maAN7XXfOcktljrqYNLr2W5ls=
X-Proofpoint-GUID: 7t-zw210grKxqfhTipLBKhnvAoRzQySv
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a622c9b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4sT3S5sFd033F05KN8sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230145

The queue depth field is defined as a 5 bit field in the Z architecture
instead of a 4 bit field.

The queue depth (qd) can be in range 0-31 and is reported in bits 59-63
of the TAPQ response. Currently this has no effect as all CEX generations
report a queue depth of 7, which fits into 4 bits. However, future CEX
generations reporting a value >15 would not be properly reflected by the
ap bus and therefore all user space applications relying on it.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Finn Callies <fcallies@linux.ibm.com>
---
 arch/s390/include/asm/ap.h   | 4 ++--
 drivers/s390/crypto/ap_bus.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index 3b95c6531a67..c91b6ace199d 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -125,8 +125,8 @@ struct ap_tapq_hwinfo {
 			unsigned int nd	   :  8; /* nr of domains */
 			unsigned int	   :  4;
 			unsigned int ml	   :  4; /* apxl ml */
-			unsigned int	   :  4;
-			unsigned int qd	   :  4; /* queue depth */
+			unsigned int	   :  3;
+			unsigned int qd	   :  5; /* queue depth */
 		};
 	};
 };
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index b2e57e5d6c3f..fb4d678336e4 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -181,7 +181,7 @@ struct ap_card {
 	bool chkstop;			/* checkstop state */
 };
 
-#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFF0F0FUL
+#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFF0F1FUL
 #define ASSOC_IDX_INVALID 0x10000
 
 #define to_ap_card(x) container_of((x), struct ap_card, ap_dev.device)
-- 
Finn Callies <fcallies@linux.ibm.com>
Linux on Z - crypto

