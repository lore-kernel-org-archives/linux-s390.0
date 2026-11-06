Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981329;
	b=llk5Jl3q36vTYLqtz8N/cYeeZygO/Kv6/b2uhywBC+TDFqS5zBIhuxVQk4VWZPKuPVYm
	 6FF2XArqEFEeQoDNFM1ZFJDIKbAJG8mpKaYqO/kqCATY+QXSfoIcDVPakc5YHXHBnYwlK
	 Zg4NXvKmu8/ujGoqXvmJqeT5ZOY+cS0rr4epwuKdRvZCZRpOH0HQE0gfLrpvA3N1cCacX
	 c4Ytlmr5xf/ArFSbQINvZlCwMUHI6oBMv9lwfr2NVVOyEu0mPvYqr7KhF4WYIjr8hXLEc
	 2bXuH2D0lM8zl8iwBzPrp5eWB8tERk69TGmynSm50Wfx4JZ/CHZqYHHwxzS0V2Z6tdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981329;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JjvkcLQHJeISncl1SwdWx53+wzqkib3zNmdGU0QzScw=;
	b=TfYujisVnAtxWIXhl3pBGMSrlrnxEFTapN8NX70/C606Rs4DMgZ2G0FY59XK2D90gpLa
	 Vu3DyqFAmn+U+Z5tDH6ec9leAi2+HW/F7/N0lcDQi22gr6Hh3YTanwrH6HHuu3FhN7PSq
	 TiTxjdu5+KULfURdGUyVkgOdDeNuOVYM5R6kk9skUv9A2A724KCSYyVOnRrSCtzwaN3ON
	 G4oKkJsIia9F1gU3JuADNhZusynYXvOWTZwY4LBcigsBPL+G1Sod0GnKXChzxhC3dntyG
	 YIID8/zLBQIwiSS4rNaKeF/y7/fCD4KzFay1i5PbzP0YSI1i79VoAfGbUAj6pkNzflg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KIW2wCEE;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079B606A32C;
	Fri,  6 Nov 2026 16:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3079B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KIW2wCEE
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEC732656391;
	Fri, 6 Nov 2026 16:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JjvkcL
	QHJeISncl1SwdWx53+wzqkib3zNmdGU0QzScw=; b=KIW2wCEE0RFIaWOO75wstw
	Hvy9fket5qvHtkWTE6s0wT+FmL1UDqdLn0A6FEygtxzARMSEBpDaqyvtGMPD9yhM
	ixqqTyfXswl6Y1lFnSTbDKzws/XeEJ3u7EEz4goNGtDlVjabYZPwkfG/KyKdJw5b
	4z4tT+uBiZJEApY4QSrCiw/WQrkt3f3kurCu4NjPZIKdNSStuMtJqEkg6s9wSIAi
	Vkb67R1MMRmWe+hIDvqOJi5/uuytH2faVWafwBsyL0/m5JYaLI1+KUWYvrPjthS9
	qgcvwXy2HK5mGGQ+mVvbhDeK7z+gVk+MTJjRI54MrDci97/SgTCfXtxUtmvk8jeA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc5et0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4t2g3476036;
	Fri, 6 Nov 2026 16:08:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmresryr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8FNb34668850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87EE52005A;
	Fri,  6 Nov 2026 16:08:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ACBC2004F;
	Fri,  6 Nov 2026 16:08:15 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:15 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:37 +0100
Subject: [PATCH v3 04/23] arm64: Prepare headers for sysreg sharing with
 s390
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sysreg-v3-4-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX1BJtW4YqeeEo
 RMFz19wAKRSzK2OnuFqBsUzPYOuNSJtlRhT3JmjqyR9vnvslaOX1Z0NUWxJGwo7YEiXGotCHj4c
 VwltSdiO8P1XALYjhV9twgt1k97Y8rc=
X-Proofpoint-GUID: QM8QKJo0QCsikKZmuZt8aqlu1Y9J4lR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXynqyh62lR7/N
 yGM2a0A7KleGvFGdEoBw1X+4eTzDJpJHkwPq4rCDB9f6J7CFE4FC0TUXP42DILkGUTLiXe6scNv
 zMNS0e+l0bJ9bgWyCi6YSh4VHRe+VQbdJ5c56i6Ut0SASFUVd9zdcB+Y3fdq4JPfTooYVOQomJF
 9DOAMIZ/P2W2/U4E5029f/qWTEWmDuTE0+fIn5pNaTos7saDkCto6JnS4DNAt4Q3eQLWuEShiWS
 wXFAnY9cnX5ml73dYIFH966FOOy3gilYnkgpZ7BDfBlGRT0vtWR/VAzhHpYMtjSlS27dGKAmLQM
 mxXO5zJ0j0jtwqSprb1z1IwQuUdBT+jO6WaQCq2Vz+my+KziDx9DURmtHcPL9dID5jW7lcS6soC
 Ml4o0u0QE10gtWiUOLDzsbZlL6bJDfyyeoEPCM7E2bS5BQMctqw50yxDAFTutjQhBMshHtqtY4o
 W/ueK0lciUrGYgGHU4w==
X-Proofpoint-ORIG-GUID: QM8QKJo0QCsikKZmuZt8aqlu1Y9J4lR2
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedfb74 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=FJHwoN1dvIUHDVMZdFEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Move the get-spectre-state functions to a convenient location. Guard
GICv5 headers away from s390 for arm_arch_timer.h.

No functional changes.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/spectre.h | 10 +++++-----
 include/kvm/arm_arch_timer.h     |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 296ae3420bfd..2ecc9eddbebb 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -26,6 +26,11 @@ enum mitigation_state {
 	SPECTRE_VULNERABLE,
 };
 
+enum mitigation_state arm64_get_spectre_v2_state(void);
+enum mitigation_state arm64_get_spectre_v4_state(void);
+enum mitigation_state arm64_get_meltdown_state(void);
+enum mitigation_state arm64_get_spectre_bhb_state(void);
+
 struct pt_regs;
 struct task_struct;
 
@@ -81,21 +86,16 @@ static __always_inline void arm64_apply_bp_hardening(void)
 		d->fn();
 }
 
-enum mitigation_state arm64_get_spectre_v2_state(void);
 bool has_spectre_v2(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v2_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 
 bool has_spectre_v3a(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v3a_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 
-enum mitigation_state arm64_get_spectre_v4_state(void);
 bool has_spectre_v4(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v4_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
 
-enum mitigation_state arm64_get_meltdown_state(void);
-
-enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
 extern bool __nospectre_bhb;
 u8 get_spectre_bhb_loop_value(void);
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 80f96ea59f1a..dcffad87b88f 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -10,7 +10,10 @@
 #include <linux/clocksource.h>
 #include <linux/hrtimer.h>
 
+/* no GICv5 for s390 */
+#ifndef __s390__
 #include <linux/irqchip/arm-gic-v5.h>
+#endif /* !__s390__ */
 
 enum kvm_arch_timers {
 	TIMER_PTIMER,

-- 
2.56.0

