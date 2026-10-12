Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B60449988;
	Mon, 12 Oct 2026 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794196; cv=none; b=NXuQ3s9l02ARuNTk7ikgTeA2gZCJpQKaW1b3WRSmbGepkKCQg9Sh0DTuvves4m9OzqnGw6aQIEX09aghpTSvHERxDO+Y9YPfuqafFnbm9hRkTX0z83QzaGr0xcXm92JTzuKGCpKsNnon1Iq7aBL3o9mo9nCoM6OctERNfnImb8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794196; c=relaxed/simple;
	bh=XKW5C6tKQ1LhnP23BZ/fyJrVZac1unGeH8mWdiekZao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYNpNLLgSaBXG5SLaI7aPymzcxiYYa5o6YgDrOCNl5S1zlb4P+BHN9tGnwqfIv8IrTiKnVUeE1fg55H24fPL7d/rrrnMLoyFXOpGvQHxgskILn6gZvtnYl+svnhFG183RUW0nP9vADJzBAt3lmw+ZZ654lF9OGbq++DQV0I4d38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UANW3iZA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UANW3iZA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5F7pU1695480;
	Mon, 12 Oct 2026 08:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SQeEC5GJZ0NNSIHNW
	N3V5m8hl2aEwn9v3OjSedwnHHg=; b=UANW3iZAvkNmJ26g9Ri7GaFZW3EYpcbu4
	kKl0iKnp+UVps1gGdr57XZHpGbqJzBjifVOoAZlgGkBFLvcaclYpb2yKavyEzYa4
	9co6fd6vZwrfLm4NI/d0Eav+YjRyYdXWguWqxuEqrKLifb3Xt+dVtlBNYBrmnMlH
	HG0udLIAxHfDKO5Ukfpt/uAuCGVqOEpD2lS+JeZ4dzylgJ1Q23EW8XHYOF/KBkXY
	EyPkTx9btjDCFRYlMddgGCN82Qd/QYzwC28O6UnJcaLR2N0PpBWpqf1ynYGDCjSa
	ZqoXdMZMa02gajtxmMj6SP2C1Ck/B2KAPlEpeLATqYVnC7jJNfoow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh7xpg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:36:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K4s91013637;
	Mon, 12 Oct 2026 08:36:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyc3jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:36:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8aU5a34472432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:36:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B472004B;
	Mon, 12 Oct 2026 08:36:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBAD22004E;
	Mon, 12 Oct 2026 08:36:29 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:36:29 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/3] s390/probes: Fix wrong opcode for cgrb fixup
Date: Mon, 12 Oct 2026 10:36:27 +0200
Message-ID: <20261012083629.2109206-2-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfXypGXQvZoL12s
 Flqx+OX+VTMnwDbLpBGK88G0lERkiBH1iVogUws1F28oIOeTWksWLIG48s42pl5EOA/NHWbp82v
 DdAkL02Ed/6OfH24T2xCXKlnnR+O20w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX/W5JPHgoXr9Z
 BQqxffQ9cSbc/X99cOK60ILYx8REkl0w6gTD9ySvWZB2tCIYT7EUkEj40pt+GsM2TTtTOPc3co1
 ySWtubUgsIP3Rf4QCqGVq814TKU1F9+GfrmrLXSLCqt3ydVZ6OzL3lCv2OaditSvcMkaEN/wN2K
 Gb0dTWe++6F4PiEeU+c1EJ3D88D7K2W+2dT1rHHn1GrTS/aVp3XoqBrpOKtZSxh0SBcdMENkcE5
 QhubcBtKLtaVrIhEOkh04iHSxwhM+TLEzouGzfGZPd+UjBNUqHxFFHAEgwFpAHSm4L1vogfwsXT
 B/t3+JMfi9T2AUUUgqbPqUoRpAA498JlxETVYu3JUEyCpSvx3lG1ff+QGjO/9GHn+cFRNh0LTLE
 QRei7+3chzBmcWPTHwUIDoVHkOAvp5aX0eQ3gi8jKz20tCfdoyUbkH1ECiD4+pZLacMYA78GBMn
 v9PFCTuutEYV6eKWtkw==
X-Proofpoint-GUID: 8vJAEkqz2MyZAi913n10Axv7vL5nUxou
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acc9c12 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5hdLX1jSI6mmvzFWJ2MA:9
X-Proofpoint-ORIG-GUID: 8vJAEkqz2MyZAi913n10Axv7vL5nUxou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120032

The last byte of the cgrb instruction is 0xe4, however the probes code
compares against 0xe6. Fix it.

Fixes: 6b169ac9b434 ("s390/kprobes: add support for compare and branch instructions")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/probes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/lib/probes.c b/arch/s390/lib/probes.c
index 1e184a03442d..049300b68ddd 100644
--- a/arch/s390/lib/probes.c
+++ b/arch/s390/lib/probes.c
@@ -99,8 +99,8 @@ int probe_get_fixup_type(u16 *insn)
 		break;
 	case 0xec:
 		switch (insn[2] & 0xff) {
+		case 0xe4: /* cgrb  */
 		case 0xe5: /* clgrb */
-		case 0xe6: /* cgrb  */
 		case 0xf6: /* crb   */
 		case 0xf7: /* clrb  */
 		case 0xfc: /* cgib  */
-- 
2.53.0

