Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B93A6B70;
	Mon, 31 Aug 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188196; cv=none; b=HvWZOSBEEBpHs+AqH2xZkNa+IvNEqFS8f99pwA/2RHcRbRcmFsVIZOAe9zJzLO1HqKfJvTBOR2rdkwYFXT054Lm6wBNQcVQnLg04Air5SUc1Fy1T2GN8fFmgarfw6unE87eA6wiaqUhKgov+SuvR30Je/GNZBFqnwJv6k0bXCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188196; c=relaxed/simple;
	bh=rtS2g3FsHd4aCkUpJJpHNSqqL7iHcIrp9zNuHBftrvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drSOs/hg3ngttZWHCiLBWHAfUoZG6NUIq2usNKZpsoPBM27MFc489NKoAhOoLRH/BXMOwNldUsAxSMRqC7tH+ShcPtR9ooVzBoX23ltG17npT2rj5ynfjzkS/Z42sjFYDoDr2BQpgUaVqT6hYmiCYk7jBNoeN4zljjXVhXKTXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D0Xjhtge; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D0Xjhtge"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZEhk1398351;
	Mon, 31 Aug 2026 14:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sgUt9egqXj2PIY7+U
	GE/sQbTOJ8RStytx8OS4+CsSUA=; b=D0XjhtgejI1ADUHQLZ4HsRbTPSVNT4Xq3
	yOlIySOGALAlKxlWSH9hD1h/9iya0a2g8/oHEM9EGyrYuTK90oE0nZow5ujaWmA9
	WzsF/h3ecoAkWypz9ILIqKbh4HNRI04MKOebFUUU2VDw37bKqS/QapURIAr7DB5d
	/MkX1TLhANimbOiBB04xdTe36leuolnxAT18JX6P9d5GbQx+vg1cnfxIoxJH4cUK
	lFezSy3KI61I2Wqt84Zzzn6nM/V1R/yCgk+c/4bcAqY06wlsbRMSKWIWaS6sDGIU
	21GlYQEFon+EwCta7yUTKBv0QowTWNz7As86R1zkJHc9jYsXZ3Kww==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudj17w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfkbc015618;
	Mon, 31 Aug 2026 14:55:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6nbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtdf144106076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E652320040;
	Mon, 31 Aug 2026 14:55:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 759F22004B;
	Mon, 31 Aug 2026 14:55:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:38 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 03/20] arm64: sysreg: Define OSLSR_EL1_OSLK_MASK
Date: Mon, 31 Aug 2026 16:55:18 +0200
Message-ID: <20260831145536.913567-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LwT3gEzUS3LZHZNeGZn19FB3ABTi211y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX3xo55otUbl01
 pTxRMR+VkOhNquEl3G04TlCB1C6jQrHpvqFurKOIlkII/qVyf1RhItOl0uAW0Bra3Bncss51bPf
 kBVWDmj52iA2z2RNF6IlLcRXlz3FUNFoQSnBZpk3vtGAi5xT8DhkkQtFRC6nFoa42COwCWN8GqR
 M9FryzmOmcWEJ906+73ASFMr6+WV4adLjVzUM0AGLz5GmDdLKCdg0VAY377DAARgHbfw4eOV6FR
 hTuaUt/iU1OSRcasHrIYVTK2IR26oeFhhwOl4DTD/3xXKuUMNqvqUdh7nzHDJ08NFI0WEan3d4a
 7Cl6sSwh+KND6HU482icC7wz3/lsKnfFqKXRT6SX0BslXByrSMXG6to4xYGTzDELQ+0Zao2D8Rg
 fi49wtArMyyPNHe0fa8EIq1ylOAbdbRyivZ1wmts+SyCogREeJrQwEMbpOR/J7dx3WA2+ff1Rnz
 VvdFk4sNOyNL3wei9AQ==
X-Proofpoint-ORIG-GUID: uW9RCDqnBJtADL7vzOK1tTxc66Jnaof5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXwWK0mxSbN5Hj
 vRQjMq1Xcx+ldkQvBTsCLmZImQLQUjq1JLBpzAX9tQe//cgvOvyx0RcHB0ic8ReHhgBHaG16C+G
 ViidyR23jJlDocFVt4lCEaWFzjesSJI=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9595f3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=gbZSv5tjjXpotTrhOsYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Define the missing mask for the OLSK field of OSLSR_EL1 which is
required to safely write a value to that field.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1c5c4df260be..5a439853b721 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -200,6 +200,7 @@
 #define OSLSR_EL1_OSLM_NI		0
 #define OSLSR_EL1_OSLM_IMPLEMENTED	BIT(3)
 #define OSLSR_EL1_OSLK			BIT(1)
+#define OSLSR_EL1_OSLK_MASK		BIT(1)
 
 #define SYS_OSDLR_EL1			sys_reg(2, 0, 1, 3, 4)
 #define SYS_DBGPRCR_EL1			sys_reg(2, 0, 1, 4, 4)
-- 
2.53.0

