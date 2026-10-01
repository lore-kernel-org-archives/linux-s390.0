Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39444EA368;
	Thu,  1 Oct 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850800; cv=none; b=LnpDdHUHtXxdpmQ6wJKRGgLBeahcoy4XgkmPrd3E90jEBqUHCV8Sj9IgMdIJPfp2O/YVElqEcl/iI9H5xlgOipzKxhmpTE0dcDL/LGpSx3dAC8QZvcOOJormDEmC8Dhcs8ynk0JmZhYrTOqdlGL+IALXsiWniHzwlAg/CE0ecd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850800; c=relaxed/simple;
	bh=ZURKAAerR8c57sQMUhVsE6/fAAttema5uSsEE66OPu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcLhKWJbEY49rOrFIuRYnhDT+Nps+fwtpGwg6i0dydNQkAKbTWQ8phnnLgX1OC4YqsZOQxBYl43o6BQOyFh0yNK0wZMQ7mekUGzZf1X0wu5eZXxXgg4aN7gSJDZV+55KGlUODCn+jHhuUonFHKBt+lncPk6av3jyFznkU8aJ+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FzrPNk9r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FzrPNk9r"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175UfU4040699;
	Thu, 1 Oct 2026 10:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Nzgplunf1xAzj3+M4
	mLwVzHMUIVt0lyrH5V/Zs/k+ms=; b=FzrPNk9r5GBLlOM+jAt2LKvSnu+LKEexP
	wTk/ybt9F5NPqzHEi8jVGH0TgFbrhzjyrUgFET9bQdXDJCukB4mLrDDdePxBfgSh
	LluJ2LCIgR5rKonb5b7tmlkBijR6Cq+wqnWbAkCCYNXEV/EM/OjsEvyih696kCYG
	wSHVMu1QgMeNAmQ9ZUTghtghgeJCJVURdPbwO2a1sb/EvLjZVERHjUg1AEN80dEU
	74iOphA5zbaRaSiiS6E3yPMdfsoFs+rKdS8NoTyT8MPMTFv2ielQ75Mw/J8RNq8v
	UcZyrsVI/TXiL5ne+WH66OVmtruzOvZqazqUHsMqBpsaDQncZhjvg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehfnd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172bfA589720;
	Thu, 1 Oct 2026 10:32:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWsGC51183886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2326220040;
	Thu,  1 Oct 2026 10:32:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1A0E20043;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 21/32] s390/fpu: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:36 +0200
Message-ID: <20261001103247.1989111-22-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe36da cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=xkwLvO81_lu8KS_w7AYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX+TUDiYrP6rgl
 5yU9NgJCszVRpS1U9lRz7bciLBSW6pd9EwzwMKZEyr2bWa5ik8g5DiaFNJC4Qfv17BtAmGYnSOh
 HypbUXS2mggmPWIzdBFyoCDXZU3XGro=
X-Proofpoint-ORIG-GUID: QmF1GZbOQW9RShx8_resS4q5UISLxfdi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX6JOtpWPyKrxG
 iHq4KvPHWNOT+mX273u3eGbrHM4DlD4C26a/XjzQeP9IhJpnpfsq4ei3KE0tOrgukml1hpefBzF
 t8NT6HX0wOMZhd6hY8yOF4rwN4I0r5u2ZLxoMlSWau7gBwExUhzeA1zgYfDna/9nCruJ5FmyIv/
 VvIyGH343VV4wyLTvqxcfqRBsiEsCS5qcpkMJsM4q6qzTiXtRbyAXwlFXVSEKdUWKB8ESTYR+dW
 caxMkZMlPBvcsQSbQ9Mco1Z4bFMhuX8ckID4+ntSUX0HN7SbN6XLTkVUvfil0oUhHcb79sW6ClD
 dheifh58km7jk4KMlZu9kQ/ly8TsiNRs891LKH8yPGnB+wLx/ZMSh0uffQCsuZmtEUznDLmks0l
 MqA80t3xaCsnBGAyAwCZ9WhYrU6P2obeCHkSEb4Wk2sHVHEOkkT2jB7m9F5Z2YkafgAm2cZq2xN
 BR95y/aUOkbRd48MKdg==
X-Proofpoint-GUID: QmF1GZbOQW9RShx8_resS4q5UISLxfdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert the fpu_lfpc_safe exception table entry to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so nopr padding is no longer needed and removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/fpu-insn.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index ae8b7033cfd2..eeb0a233d5c7 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -104,9 +104,9 @@ static inline void fpu_lfpc_safe(unsigned int *fpc)
 {
 	instrument_read(fpc, sizeof(*fpc));
 	asm_inline volatile(
-		"	lfpc	%[fpc]\n"
-		"0:	nopr	%%r7\n"
-		EX_TABLE_FPC(0b, 0b)
+		"0:	lfpc	%[fpc]\n"
+		"1:\n"
+		EX_TABLE_INSN_FPC(0b, 1b)
 		:
 		: [fpc] "Q" (*fpc)
 		: "memory");
-- 
2.53.0

