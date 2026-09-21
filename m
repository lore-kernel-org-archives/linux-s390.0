Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257CE4C226D;
	Mon, 21 Sep 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006304; cv=none; b=Fjow/Edflf//erbpNfw+SASeqB1avkmu6UUAlxINnlpwlHUwsfq2CnEd+Pe0la0N+vfWDAayRouGZw1SkfwVxsYSzBjB2HtrnzYi1SBc+C+iZOOi3YEaqScEeOEFnhhCesJKjtMY8xCYTTf5l6WMp/8GoDoUFtBjJZGZv2fimF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006304; c=relaxed/simple;
	bh=BmJWJ7W+k9H+fQskDn+IIdJ98XUmWR1/SWYsvLXi+q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=If187KzQmcr/hp0kY2GoRMGKzyeXEKwJMiatgXtA4Iz91P+NxHFWnILtwR7qpedX6sy+E0n3zFT9ntZFDV1oRA5sXIsNUk6AEBe6lBV71GH1FaW/zy+809oudu4sOvj5oiSKjPIvsK64BrJKgCmH0Lg0BgqRYZqVlr9VEqTLIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HMPdvT2K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HMPdvT2K"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8Ywa703554;
	Mon, 21 Sep 2026 15:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wmRVBXxhNWwSdCLks
	rWnt9f7rQDOreYtdYAPiaccpwo=; b=HMPdvT2KbUqhHQuSXu354tHPSttvkWZCf
	XpcqHXYWy86mAADoshHIW0VM6wZhFSLsJd9AGz9nffnuW5B5Jo0dldPDKPHHetH8
	joEVW48ES8RvC0B7F8VhWZoSrqO60t8j82FhfUuhk/9iJYj6oEh76pCPQpizgivD
	FlAYSKa3ucLsPluAP6vdpzaNmaF/kiG9XLW27KFI1R4c9RVmFOmiiX7RgJKbuU4d
	9IR7kqiDHJqCxpu7fS8lR0XDx/3Q9/PR/53Xm1wgCGma9gwi0ybo2pLMboTajQX+
	wvoo4uqzK0aPRn0dW4Tc+D2kwpLfISVZVTeGsDKMpnU/e39ZW289w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq98wn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHZAr1431700;
	Mon, 21 Sep 2026 15:58:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53ve316-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFw8ck28377500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:58:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B70020043;
	Mon, 21 Sep 2026 15:58:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ECAD2004B;
	Mon, 21 Sep 2026 15:58:08 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 15:58:08 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 09/11] s390/percpu: Use percpu code section for this_cpu_xchg()
Date: Mon, 21 Sep 2026 17:58:03 +0200
Message-ID: <20260921155806.2447506-10-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921155806.2447506-1-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab15414 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1_S2mAAb8jf74u_WUuMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX4GMGqzhJuVpC
 Kv1z1bEIrp2q9j6pbpZY5fpmu64mr2BrbEhHsb0s37f01xfTY73AzY5jTOcTLpranDilRCXMCc2
 Naj6+Ov09/ZxXhvxpUbhuerWOgj6JggLbhtJQH2HH9BPM3vrvVhSMC+RRp/DSHVm2K2QCBhG5X4
 oVVmwN+4vMHpEE7dqrRDbLowrl9dr0up+nUAKRLsfb2vjHz47stNLIkl48STwJaYm26xGWlxb4N
 j+r5+rcX2HR7aKSnVtS9WYKW96tA28NujaLTLUzvqSzf8nZ4W+aAdsHDxzQR73fftzEITlxVegV
 FwAAwkh/PoZdf0De6vpmUO7e302XNdBCL09GRpvdyrIUO7KtNbYsZXyqYlfw/ezd9wJryi+dBRA
 bLrgUKNnfGnritKGp0hzKMVjzEdRDMGdqVhBgcK3q5MD0XzhE0DWbPp/xTRFxScw+jWwWViYk7t
 6szBavmph+W3N4p3hgA==
X-Proofpoint-ORIG-GUID: 7J7HkvJd4SHClLa2YXFZmwP5I-1vI-_c
X-Proofpoint-GUID: 7J7HkvJd4SHClLa2YXFZmwP5I-1vI-_c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXzsbLW6+cNs8N
 wfDmCBmsWCK6KY4/IBZn3z3D+WP2voltz6l+9osAZoIs0EW+HtT3RPDcnmMShGLzUfaM543LBif
 jgGFFIp1MAQsZCOgaxZVGFTz63Rit/I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210227

Convert this_cpu_xchg() to make use of percpu code section
functionality in order to get rid of preempt_disable() and
preempt_enable() calls.

Consider only four and eight byte usages, since there are no compare and
swap instructions for one and two bytes available. For one and two byte
use the previous simple implementation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 0eae65937c0d..237bf8c80843 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -331,7 +331,7 @@ do {									\
 	old__;								\
 })
 
-#define arch_this_cpu_xchg(pcp, nval)					\
+#define arch_this_cpu_xchg_simple(pcp, nval)				\
 ({									\
 	typeof(pcp) *ptr__;						\
 	typeof(pcp) ret__;						\
@@ -342,10 +342,34 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval)
+#define arch_this_cpu_xchg(pcp, nval, ldop, csop)			\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ old__, new__ = (nval);				\
+	pcp_op_T__ *ptr__;						\
+									\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
+		"	" ldop "	%[old__],0(%[ptr__])\n"		\
+		"0:	" csop "	%[old__],%[new__],0(%[ptr__])\n"\
+		"	jnz	0b\n"					\
+		__PCPU_END("%[lcreg]")					\
+		: [old__] "=&d" (old__),				\
+		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [new__] "d" (new__),					\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "memory", "cc");					\
+	old__;								\
+})
+
+#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval, "l",  "cs")
+#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval, "lg", "csg")
 
 #include <asm-generic/percpu.h>
 
-- 
2.53.0

