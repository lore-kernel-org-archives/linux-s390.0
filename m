Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7916416D1A;
	Fri, 31 Jul 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503376; cv=none; b=GJdUQa7oYlrhJpH83z3tLcCoUdUgQ5u2iRM/cmWHfwntoaC1fYhN/txH34uv5e1ueSElJldi0voCRL6HSxqBqutwSva/5gangfItHOd8yT8BUs+lRos80sTF25LpMdwVW2R6xB1SRzJQUZcfXDBaaSjikTA/b4wmsD59hk7NEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503376; c=relaxed/simple;
	bh=EAa5FTBEPwE/31jwb1z+GrO7K5vevLQgbYFzgo43IBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQpSyfY/e65F1X3ITwQWRKKA4L3TbaIcn5XiwUpZ5YXaRShEU3NBVHkgMHeoUDLOi5bhAxxk/QtjrYLXmx2rwq/CSfoESDyXONNSOqH1wx85A+nM0Xrngcs3/oIE6sG4PLkGKHShPYT7cChOxZyaSgMNt/SJH4JFw7+eEq27qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjLfiIlX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjLfiIlX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlkS91765505;
	Fri, 31 Jul 2026 13:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3UhK5YmUdmMvcOTRb
	YWKMVw6tSYQ82hiNVjgPLai9/8=; b=IjLfiIlXncP0YHSEOcgh0IudpkBlqANCi
	LRQKiwdh+XrqEMLjemZ9RZHjO6/DmhMIrdhLmkwvYC/6w3joR7LxapBEhjZKcYit
	oW4MXTB3jDGmc2OhHoYzhuva2a8/wJTmfH7Um91ecvkwwGmGBNq6uLJkFAGXXDz6
	F/CXeT7IUAFtZNWPOG06t8Vf8l66O51CHT7HFsZNl+Hy2lc0r3OTVu+FY+w/E3Vz
	SqsuY8HMNJhFhcMgSPCfDA/NOvjr7kub9bZQyezE4dQbV3oJqHSn/A4VFSR2Ip0c
	HAuqpmwsYsDnBUCEtLxRv4d0v6u7VGEZf6Goh9yYmd4MhD8y43/Sw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y5658-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuQ1x021776;
	Fri, 31 Jul 2026 13:09:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwg43d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD95pR31130088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F8B520043;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1108F2004F;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
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
Subject: [PATCH v5 05/31] arm64: ptrace: Use constants for compat register numbers
Date: Fri, 31 Jul 2026 15:08:33 +0200
Message-ID: <20260731130902.654679-6-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vIV77J6sCKVUS31HtHRbg5PWhRh2cT7L
X-Proofpoint-ORIG-GUID: rRP1Gnw3Vu8yqoAKu3qG3hn5ahB1Z4z0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX/Bnipok4nDZ9
 dknm3KkCWueF0CWTnUB/8pAJwC0T95GhhqyjMzlbSmUhumGgYkpwBcNdLMiT87cQ6T9sOyPDReQ
 BFxm/pulmcA0LH4SbtMgp3kcecm2lX8=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6c9e7a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8sKaXpLx0aSSeG29UzUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX9VROhnMdKu62
 /EtrgHI7kTjpuzF1N2XiHYMXgEG8jp7bUssiuYKtCG5xGhGg5GtaPsMNy2qcx1EtwlHbGT0288f
 iuFJLUWjMKDQIBt1k8cpwFXRGV06HkjvIeWifdRdrFUw8Sq0h+gz+LYThhjSC1dN4oVFoiw2cV6
 1HQ+2U3gIVf7BzmW5ZMtaVTz9V6v22v45AoPwL+TTzcQpPSa5NeKNVB3qgrYOv9hoivf/PhPeMw
 B0nPWj/XG7D13yjgqKoMvzTAIat/p0oiZxe7pXjnrpJ2iNdGLjWmkQQMAObYNnhx9xFTuT/pz9v
 mYQwmVuiGVpKBZ31WtUcLE2k5LDT9PFjTpjUDAtNOIIA0y0npEkxr75yfHzYVegBAA9qW9yUz/c
 b5oU9zeqkNttWComBz09bO9ADwNF1WKfpjUdxMfKiz8TAkuXmpYC3onOsUdD+R5BJFJtfHo2D9u
 8GA+vyeBaWN3DGKwJVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Define an enum to determine the register number for the mapping from
AArch32 and AArch64 registers. This allows for a more flexible use of
the register mappings.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/ptrace.h | 60 ++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 39582511ad72..6f5b79ee1f3f 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -104,26 +104,48 @@
 #define COMPAT_USER_SZ	296
 
 /* Architecturally defined mapping between AArch32 and AArch64 registers */
+enum {
+	__compat_fp	= 11,
+	__compat_sp	= 13,
+	__compat_lr	= 14,
+	__compat_sp_hyp	= 15,
+	__compat_lr_irq	= 16,
+	__compat_sp_irq	= 17,
+	__compat_lr_svc	= 18,
+	__compat_sp_svc	= 19,
+	__compat_lr_abt	= 20,
+	__compat_sp_abt	= 21,
+	__compat_lr_und	= 22,
+	__compat_sp_und	= 23,
+	__compat_r8_fiq	= 24,
+	__compat_r9_fiq	= 25,
+	__compat_r10_fi	= 26,
+	__compat_r11_fi	= 27,
+	__compat_r12_fi	= 28,
+	__compat_sp_fiq	= 29,
+	__compat_lr_fiq	= 30,
+};
+
 #define compat_usr(x)	regs[(x)]
-#define compat_fp	regs[11]
-#define compat_sp	regs[13]
-#define compat_lr	regs[14]
-#define compat_sp_hyp	regs[15]
-#define compat_lr_irq	regs[16]
-#define compat_sp_irq	regs[17]
-#define compat_lr_svc	regs[18]
-#define compat_sp_svc	regs[19]
-#define compat_lr_abt	regs[20]
-#define compat_sp_abt	regs[21]
-#define compat_lr_und	regs[22]
-#define compat_sp_und	regs[23]
-#define compat_r8_fiq	regs[24]
-#define compat_r9_fiq	regs[25]
-#define compat_r10_fiq	regs[26]
-#define compat_r11_fiq	regs[27]
-#define compat_r12_fiq	regs[28]
-#define compat_sp_fiq	regs[29]
-#define compat_lr_fiq	regs[30]
+#define compat_fp	regs[__compat_fp]
+#define compat_sp	regs[__compat_sp]
+#define compat_lr	regs[__compat_lr]
+#define compat_sp_hyp	regs[__compat_sp_hyp]
+#define compat_lr_irq	regs[__compat_lr_irq]
+#define compat_sp_irq	regs[__compat_sp_irq]
+#define compat_lr_svc	regs[__compat_lr_svc]
+#define compat_sp_svc	regs[__compat_sp_svc]
+#define compat_lr_abt	regs[__compat_lr_ab]
+#define compat_sp_abt	regs[__compat_sp_abt]
+#define compat_lr_und	regs[__compat_lr_und]
+#define compat_sp_und	regs[__compat_sp_und]
+#define compat_r8_fiq	regs[__compat_r8_fiq]
+#define compat_r9_fiq	regs[__compat_r9_fiq]
+#define compat_r10_fiq	regs[__compat_r10_fi]
+#define compat_r11_fiq	regs[__compat_r11_fi]
+#define compat_r12_fiq	regs[__compat_r12_fi]
+#define compat_sp_fiq	regs[__compat_sp_fiq]
+#define compat_lr_fiq	regs[__compat_lr_fiq]
 
 static inline unsigned long compat_psr_to_pstate(const unsigned long psr)
 {
-- 
2.53.0

