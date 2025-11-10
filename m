Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B353346B9;
	Mon, 10 Nov 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800891; cv=none; b=Z08ugxdOp0r3NSbjp1vP7EsVbUVxYlfErq1NIkfZX20Hh+7ravZHwOQVtxxKD5IqL/AlAdhY5LM6JhtSTFA1LlRLXcfp2a/YEDE20FYwFfZAEiFQU1ySYsGCydWGQJNMvnwBYG8FWXqmaNEkglFXoi3AMRfv84p2GiyxFuJwRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800891; c=relaxed/simple;
	bh=aNb8py/b4jZsppjSKK8XdMx1rBPhco6QTflKaURlSlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFXErQUL0H2JZa9WlnKpe8J/Q1D4wFDH/on/L9klGSgU3keLw66rshZ/tzvQlrd4rWJ0k1b+QX5jB6/JooAYymmuOxmU9On7rtuRuegBrHe8Bagfp8wmDUOiW5jUVXgyIYQLx/9qwbU/AmbQbvm67ZCuxElw/w+D017fW4QT+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qCDRiBrc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qCDRiBrc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AADT4ii017447;
	Mon, 10 Nov 2025 18:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J1+Dy/7Bp2maC86Pb
	Cxhmf3BMcyqDto95F0tNjlhhDY=; b=qCDRiBrcVWGUWC1A0WN6eZACcAw0wTlD8
	w/XWBoDWFtsCJ7GeMwcur2SvNHSjC+N4PklAMqU7hWoGbp8hXr9rtHoxKDoUrTWP
	2IGPy0PULpUw7JlazH2s8NB5c/HOOym9j5Jzu0Cj45TEJnwmicK/qb0pw2vmUVTi
	WSdIhna6VbTye66lLfoNG7TweHgW+PwpV6z4t6ay6Aq4VNMq+xmf/zBdHKC0Q34h
	l5mA6gnIbqNcFtx1KzWLkSn0rfgkeUAGOBE2wrM8th5/beRQ238AEyfrJLlKdNF2
	b08P1/PkqS+b4+ohiObafbxhNFo4r8C5J5OF2jEwHmCqdsfGightw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc71tt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGWmDx004755;
	Mon, 10 Nov 2025 18:54:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxq89t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAIsfhf11600346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:54:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3499820040;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0631A2004E;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 18:54:40 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 2/8] s390/kvm: Use psw32_t instead of psw_compat_t
Date: Mon, 10 Nov 2025 19:54:34 +0100
Message-ID: <20251110185440.2667511-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251110185440.2667511-1-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfXzFi6K/HSS2tp
 134pPiQDkFTLWKFziOKxDiigGtLHtuG7kiez1S+aMPeiF8+21kwsluM8J51U17CuwJlF3pb1QQh
 3rTmfj7QmCdJAk6KHxCsEdu0qLMhvvjOPR91f+9caECB/XIo2abWnZe7J89ruKzf+7A2CidL1wd
 1fAPXWhHeZMrdaORIIAwNaJiJ8hVIq249ZZ/fKrcB6uUXK91sX3s2goOvhpvB/nK3+SLXCsM6U0
 qVGw2S1R24nPDuLtUpNBVLEluovhOJvb/B9y4a/82Al1ByDOaZGjmJFBqsVWixyc2bZABR1J+gf
 fffjefH74MoEsb1oi6GSkdHybL0A4X6zxWfU83kfpgzbJRwUskG4ISvVCi912643pDg+b7tPYWx
 e3fvSemUn6AnkBr1xltFrn1bbQVxnw==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=691234f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=3qFtz8xY5qhfeabdUIUA:9
X-Proofpoint-GUID: 0n3oG5FfdPMu-ZR2Crpgv-LkGMqtUBob
X-Proofpoint-ORIG-GUID: 0n3oG5FfdPMu-ZR2Crpgv-LkGMqtUBob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

kvm_s390_handle_lpsw() make use of the psw_compat_t type even though
the code has nothing to do with CONFIG_COMPAT, for which the type is
supposed to be used. Use psw32_t instead.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9a71b6e00948..0b14d894f38a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -754,7 +754,7 @@ int is_valid_psw(psw_t *psw)
 int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 {
 	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
-	psw_compat_t new_psw;
+	psw32_t new_psw;
 	u64 addr;
 	int rc;
 	u8 ar;
-- 
2.48.1

