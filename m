Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DC844F552;
	Mon, 12 Oct 2026 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794196; cv=none; b=ne/kIFoBBG6PriLirmHganJfqWKkRj4ppUzeRLFP29HW/2oDHbcfISdLb4yAaKrWikKxgj7AGBuMa16iCbF/RlDTG9fnCSx+Ln2c2D4A7RLcACMoubT1I2tZZyKW7VgoEvHzmGVUsQx87QRtf1bzB+H82jQ5eAfGx/AiBRZwgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794196; c=relaxed/simple;
	bh=q9J0q+qe8+SekxpbHj9+5YhGyoX5RYawmlWTnKJlJaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnCHHm4/Qni0CVHE07lId9qL5ZfiCFMQP2Tqo+cXUKTnwAwcNQY64wLvqJKkiPXn/K+Np/JhWdnfIlyvTLUOKJ+bvxTzHGgQoje3FsMFu59ULR3HCRGsqWQsGbWQZe7RpCyrf7C4btqT9MtO+KQUraLFwLAowJ7JveqSI9qCxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qooXQ+ZO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qooXQ+ZO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EkFO3565679;
	Mon, 12 Oct 2026 08:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aJy+o+vZ3bkp2oSHJ
	XRKajc9Ch1IANkYDaX2YeNhfcc=; b=qooXQ+ZOkAXYWsLGFA0QNoSNL4KWyUhv4
	PnT1pPI9EtUKwVm1ciPuUAgvCMZ/jL2qNNejzlvgicacWUWlGk+kmvWUAx9rt7R7
	Pg3ICH7p42ClEn1WvQtDkjn8mX4PPZIsY5Zl6wYFS2uDTBVsgHTBO5byKAMlh/pu
	n9ZY844KGUcCdXf8r4vpqOkRgj3dihmTQXW3ErAx7XxXJS9E7BdOtLjtAowOeRYV
	REueQkU1Rvbw3Z6Xsh0ZZ0QY6myGPFInS8eTtUGExlohrXXqy3Y/5e2FI8z5/rdm
	F1GM9sogSGdsEFnJfqj5HwiixKwAwiMJkPidx5asmGU0yYH5xwWjA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug7y4h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:36:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K39K964625;
	Mon, 12 Oct 2026 08:36:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppmgwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:36:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8aU8D34472434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:36:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14E7D2004F;
	Mon, 12 Oct 2026 08:36:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA4F32004D;
	Mon, 12 Oct 2026 08:36:29 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:36:29 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/3] s390/probes: Add missing fixup for bctgr and bic
Date: Mon, 12 Oct 2026 10:36:28 +0200
Message-ID: <20261012083629.2109206-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012083629.2109206-1-hca@linux.ibm.com>
References: <20261012083629.2109206-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acc9c12 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=lYt58h03u8l9IyEFmewA:9
X-Proofpoint-GUID: Y372HnJQH2mL7TkqFMRGtUjzbc_SwdIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX5wVhhpx54Kdd
 sHsuFqtXRemMoji+kgh500D0R0IUXImjqhjdLwAF5impF7oJOsRHSJXNCfolvBuKl98RLg44H6M
 Ff9LjxEvFH2fAPOqhgSN9rg/1LtCS01V0cHZvuXfW+9ku8kDD+cTR0/JmlYPXGUjqYtVxJIUrd2
 2afalMB/ygk9HHivNwClUmbYTTIjCr0Ckd914fUqd5JC3ndr7YgBhuM6YLd7bvXJAb2hgfndNLW
 Z6zCFl3xluqN+hJtXHHLVJZy2NAu1GJOvRwJ4VeGq4hbgfQb6TiO4nLwP4lQGLjoS6WV7KlE+c8
 4yTKMWwHiSzLCZzijJaILi3KEcz2sSo1GswHQywBLWKs+/uH4N9XxUtJa7U+bl0UMOJAqrcx+yO
 qRTACefWGWUMFcpP/mWt9QEqAiOWUI9F16MZ7SUmx4qZSyQmCpXYVuJxy6nHf4XaUHhxJV7YnHW
 LWXn+LR54ZxroX8PETg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX+6X63Nk2z4l5
 4QhUlk4HYRkQC6ZHi+wKCVrG8vJTLIb8SQYIvnEgxQgofKshPFn1FiJgKGd6Njxi7w0C3afHoEk
 LmcE+fkWkVtlo7AvPfrgC1zUhU5XnP4=
X-Proofpoint-ORIG-GUID: Y372HnJQH2mL7TkqFMRGtUjzbc_SwdIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032

For the bctgr and bic instructions the probes fixup is missing.
For both instructions the instruction address must only be fixed up
if the branch is not taken. If the branch is taken the instruction
address is already correct.

Return FIXUP_BRANCH_NOT_TAKEN instead of the default FIXUP_PSW_NORMAL
to reflect that.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/probes.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/s390/lib/probes.c b/arch/s390/lib/probes.c
index 049300b68ddd..3e7654223b05 100644
--- a/arch/s390/lib/probes.c
+++ b/arch/s390/lib/probes.c
@@ -77,6 +77,10 @@ int probe_get_fixup_type(u16 *insn)
 		if ((insn[0] & 0xff) == 0xb2)
 			fixup = FIXUP_NOT_REQUIRED;
 		break;
+	case 0xb9:	/* bctgr */
+		if ((insn[0] & 0xff) == 0x46)
+			fixup = FIXUP_BRANCH_NOT_TAKEN;
+		break;
 	case 0xa7:	/* bras	*/
 		if ((insn[0] & 0x0f) == 0x05)
 			fixup |= FIXUP_RETURN_REGISTER;
@@ -85,6 +89,14 @@ int probe_get_fixup_type(u16 *insn)
 		if ((insn[0] & 0x0f) == 0x05)	/* brasl */
 			fixup |= FIXUP_RETURN_REGISTER;
 		break;
+	case 0xe3:
+		switch (insn[2] & 0xff) {
+		case 0x46: /* bctg */
+		case 0x47: /* bic  */
+			fixup = FIXUP_BRANCH_NOT_TAKEN;
+			break;
+		}
+		break;
 	case 0xeb:
 		switch (insn[2] & 0xff) {
 		case 0x44: /* bxhg  */
@@ -93,10 +105,6 @@ int probe_get_fixup_type(u16 *insn)
 			break;
 		}
 		break;
-	case 0xe3:	/* bctg	*/
-		if ((insn[2] & 0xff) == 0x46)
-			fixup = FIXUP_BRANCH_NOT_TAKEN;
-		break;
 	case 0xec:
 		switch (insn[2] & 0xff) {
 		case 0xe4: /* cgrb  */
-- 
2.53.0

