Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789451;
	b=0rZk0COTp+rLC9+ucwh8MPbUn4zK1HfjTGq3qOMFvE3YgASu6YLLC/cqf1GNiF94Ikot
	 62Om7mQXGD9YkT4+/3jBca3/eFHbxJietuL0pcM3qHeo2NKQW61+dPO//dScuVeKDrB4O
	 D0KCakjrMYRtfzd3Zh87hWaBiXBwlRZcWtpbeJKvZKyBZM3p/ezewdLmr6eDhx5iuXUFQ
	 Ru6EGtgNZbbChkoBlXpAAJcyRlz/Po5WPzJ9ZZMreW4GaMEWdnxghdfLsSLEcycGEOtBC
	 POQXbsvZb+Bh0SWus/KIJF+Wi0JtalEUdfP8noNr9tKM5/bEEv3UcIZTwswe4wDGd2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789451;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QTVzZ+ZLC6ZJ3kqDyWFnAYQukVSRG7CDeMaoAqGaVqo=;
	b=01j4NwFiyAPFq5Mlj+4F/6QHEfh67k4pl6RDCNwUmvxvlEQWjNlgyORltZqmYN939Ma6
	 Y8J9D7yjzoUIH7Wposl0wlxEA9bk6ciBTUONq8vPaaakR7oleDaoqescWkw5HaUmjYwiq
	 RoG+hcqXvHlpi63gbr/Kd7sJgT0KJRQ2a9mQysxEvucJRjgkWcqN6s6TXUmpcGqBc9pIn
	 skWT4IKRNS3+SXxw3Hl0PgyFoml+X/T2tmhvBdQQcCvjiP1ibDffzk+CceJmFYZ30nTOj
	 qafvcofYEduzn8Qn4MN60cqOhblUGRP+r70xckR9KnE6xpmrzbtQsYrz2qu7xu+enKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aqTjVVn8;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353AA60A3813;
	Fri, 27 Nov 2026 14:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 353AA60A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aqTjVVn8
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE51Jw2012238;
	Fri, 27 Nov 2026 14:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QTVzZ+
	ZLC6ZJ3kqDyWFnAYQukVSRG7CDeMaoAqGaVqo=; b=aqTjVVn8BLhVXN5Q7k3W2T
	T0dQ1QvdZLUhfPIIH3WzSka1LeNtS9Oac3k4i2R5qsSu8DrgB9x7URMc26VR9fDL
	4QB43bhqqLnapy2QvxrLFXnNdsA7J3J2fXpgwXDhg3P7TBgC3c3mvTt0EVb5vDPF
	PYDcpoF+6WqjI6FShAJgPFo4Fif8RBOEP3YISS8D5SLzgbSJIuWC1LKFjPIe9kz+
	Ivqk9e5CMixBVD/lxPOwlA4pcT2Yi6O0slzk2ZuePzmihL+Y8E4aNNW7ODdFUB9z
	BaQukmAYM5g+zzZNWuu10DtfkzWLWHLGgmOVjJhu7rnYr1saWioCtEPUcxisDnkQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4w8fn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4Idq3893132;
	Fri, 27 Nov 2026 14:23:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6ucctx2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENGxH38863294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C02D2004F;
	Fri, 27 Nov 2026 14:23:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 149032005A;
	Fri, 27 Nov 2026 14:23:16 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:16 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:09 +0100
Subject: [PATCH v4 06/25] arm64: Prepare headers for sysreg sharing with
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
Message-Id: <20261127-sysreg-v4-6-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX0n8V0sDiMWvt
 ew4ocZRmX9Sqr/YhUKpxEQnuJ5+9cKepgs1+lrc/tBvzKskXWe4XU/IXS2pm48+2ooxtUpm7zVf
 /eqOjVGBY4FIBQRoMiMyhLgJatC6548=
X-Proofpoint-GUID: GV8I9oH5Ml3dqm7n_R4MwRIFz_ifL1fx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX6vToogMyOBMm
 ZOTPHZWDAutVvukyhoLif5PIYTVQY6rKN+bR86m78AIs/fgOn25SPxdFE0+4I2FVX+z49GEIxtK
 nc40m+H9FYsBvzEOi5Y8cOd8ghvbUOIHUDLUQAXrtdJLiilkjGBQ8zmIog7WmHkLkL45RnNw7BX
 ZHlhoDZa8tdLbBMwhUQD7cREp2IrE7eVCljDWpdjJbFlTLie+tHqXhABDgEkwp4qB+5CEaBhVQP
 E65jhZ7FmQTyomOoXmg2IVNe1bH3nOtjTP8tGIKtQ3p/ZvQVUySGmy6gEtidkOpkkFhRVFfSgMn
 FgwG1tj8wgAFVg9u0dlYvoiSQvuseXzyJukeDu6f/rTyryUa1hOuV+rFL7N2YaAjvaxI0kT42Qc
 jYcdoioc6ti4XLFKOEWJQoMgVwmVKdWyERXtGeycwlPe8VQ66X4GVY3yxT735tK/Sj6Nyf8PZwK
 m907WFMN537Q80rYFcw==
X-Proofpoint-ORIG-GUID: GV8I9oH5Ml3dqm7n_R4MwRIFz_ifL1fx
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b09925a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=FJHwoN1dvIUHDVMZdFEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Move the get-spectre-state functions to a convenient location. Guard
GICv5 headers away from s390 for arm_arch_timer.h.

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
2.56.1

