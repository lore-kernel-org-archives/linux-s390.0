Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247764746C8;
	Wed, 12 Aug 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549051; cv=none; b=oZa8Yquo4coCzEUWIEia1qLocaOObxNLotJ5Rfg5cfTCiTFiZuVozAv43NdwAkbQrb8O7XYYdmi8P9M1nAay3N1sbfPkTMoGs+K8JjNllwF6gldwZaVix3oEe2pfpd8Q9Lrp0v+YEHe4RVHMT53WTZtJm6rm7j6pXPQlzessNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549051; c=relaxed/simple;
	bh=MNr34QA4exGDujDQ2v/MKuHtAdWp6LYgl1KHdt/wpbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbgpOt/eOLY9tZ8US6fnd81ypSIlwTGvGcsmh51S+OiR5Z5CjF1kEGIjY23NYCOkBx4EHZshR2ujQ6OQu7dc0XgdnBJI+rSU+Y/ncOZe6YUB4FWA6NzSls3GStSkxcB4VK63PUcwY9qegHCNJGlT7v11Ji13qy4yJQ7YVhhYz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LyfMAkyA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LyfMAkyA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1meH3687174;
	Wed, 12 Aug 2026 15:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vX0JhDDXNBnfGCA1V
	Hi3fAjLiUTD3W0wwM5OuZSdrF0=; b=LyfMAkyAZNkM9A/IOutveFkJo0c8PRhab
	wteD00bsZ0+h9ik0oyrHSnoVgid1nd/91IBcHE1PeXHeD1C1c9SNuHQaanN4l25q
	MOw/EHdY85jxcTkaYuWIULvLyrR+V9+FLswg9y2aeqE7Ov0H30Ip9JH+9xzzgLB+
	CEDJGNm3WpwxX4+5lqcGGGBhEbCoHNdspWFpuLeWW76TBtzzk3mwFQ7NEfXGUQaZ
	lzjicfOhxKl2tdrEOpbsBMLYWCcercW2V9siHm7UizfZ2BZGIhLLsyaADmKdq77W
	7Zga4h3Kw2By9cXcOuQAwhXYL71dXAoWJrItyrzXb8L/Z6Umv8FKg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9u9u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQOOc013784;
	Wed, 12 Aug 2026 15:36:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h6mk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFabDo37618088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3748820049;
	Wed, 12 Aug 2026 15:36:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D540C2004D;
	Wed, 12 Aug 2026 15:36:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:36 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 13/33] KVM: s390: Prepare include guards for a new location
Date: Wed, 12 Aug 2026 17:36:09 +0200
Message-ID: <20260812153631.3376090-14-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXwkTyVP7pbZ8t
 9dnTQsMba2GOfibuR6ehI1P0QaT45jqz3Y1S9kM9h/PzmCIW9/xs2Qma/xXQFrGK526knJEVXm/
 vmrEu3HN/l5n+96UIfd51exg7dtLT6SNFYk+K9ZuvIc96ayI2FoonKfHRt0I9JdoodS+YhpD4A/
 0ZsWXE9PZ+SUTD5zMI92FS2dYJGNlT89QysLXspKlBEt23FWVzaAXP0dIGoswVqYBrmHKqUUQgX
 d32luaawgrTAUhBRUp024728SBVPSY7rIyzri+bXC5getvwX9896H6MRHaDA2HNcJcl4ST8P7tL
 THhKAmf+sZYN8Gs3lKjVuAld5CqaGedYclaHIv8PwGxcPHLvp46dMQYuSnwDokUoFVuckH06ubw
 7kEwHh+1PPNhFUERSPyODXDCy4Dkz5JojOB/smiCNjom+AA8/FjiuI73treGWFNmQWpggVj1uRU
 rvB5SzdI1ZvG2wBEZnA==
X-Proofpoint-ORIG-GUID: Qc9OFY2T-XcjZQj8nkFY2REe8_BxbBFR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX8Ar6d0KCJwig
 AZbos1cn/AEVmkLzgIaXsK7Zphmfkz33CSIVY599/rDvq5t0yg5kaHaUK2nlwZXA5b8kLj2WRzQ
 S7j+3E5BBra0oU76PQkeQU33WEkh8yI=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c930b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=0n0nkFggx1xHrEoCumAA:9
X-Proofpoint-GUID: nPtXakkkjq2FEaatpXQhgPu4_iaHtAeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Update include guard names in dat.h, faultin.h, and gmap.h to
ARCH_KVM_GMAP_* to reflect their upcoming relocation to a shared gmap
directory.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/dat.h     | 6 +++---
 arch/s390/kvm/faultin.h | 6 +++---
 arch/s390/kvm/gmap.h    | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 141ee7b9f019..87108f51228e 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -6,8 +6,8 @@
  *    Author(s): Claudio Imbrenda <imbrenda@linux.ibm.com>
  */
 
-#ifndef __KVM_S390_DAT_H
-#define __KVM_S390_DAT_H
+#ifndef ARCH_KVM_GMAP_DAT_H
+#define ARCH_KVM_GMAP_DAT_H
 
 #include <linux/radix-tree.h>
 #include <linux/refcount.h>
@@ -975,4 +975,4 @@ static inline bool crste_is_ucas(union crste crste)
 	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
 }
 
-#endif /* __KVM_S390_DAT_H */
+#endif /* ARCH_KVM_GMAP_DAT_H */
diff --git a/arch/s390/kvm/faultin.h b/arch/s390/kvm/faultin.h
index f86176d2769c..f343b6fb6f16 100644
--- a/arch/s390/kvm/faultin.h
+++ b/arch/s390/kvm/faultin.h
@@ -6,8 +6,8 @@
  *    Author(s): Claudio Imbrenda <imbrenda@linux.ibm.com>
  */
 
-#ifndef __KVM_S390_FAULTIN_H
-#define __KVM_S390_FAULTIN_H
+#ifndef ARCH_KVM_GMAP_FAULTIN_H
+#define ARCH_KVM_GMAP_FAULTIN_H
 
 #include <linux/kvm_host.h>
 
@@ -89,4 +89,4 @@ static inline int kvm_s390_get_guest_pages(struct kvm *kvm, struct guest_fault *
 #define kvm_s390_array_needs_retry_safe(kvm, seq, array) \
 	kvm_s390_multiple_faults_need_retry(kvm, seq, array, ARRAY_SIZE(array), false)
 
-#endif /* __KVM_S390_FAULTIN_H */
+#endif /* ARCH_KVM_GMAP_FAULTIN_H */
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 39938d363ec9..c54c35e47d6d 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -7,8 +7,8 @@
  *               Claudio Imbrenda <imbrenda@linux.ibm.com>
  */
 
-#ifndef ARCH_KVM_S390_GMAP_H
-#define ARCH_KVM_S390_GMAP_H
+#ifndef ARCH_KVM_GMAP_GMAP_H
+#define ARCH_KVM_GMAP_GMAP_H
 
 #include "dat.h"
 
@@ -330,4 +330,4 @@ static inline bool gmap_is_shadow_valid(struct gmap *sg, union asce asce, int ed
 	return sg->guest_asce.val == asce.val && sg->edat_level == edat_level;
 }
 
-#endif /* ARCH_KVM_S390_GMAP_H */
+#endif /* ARCH_KVM_GMAP_GMAP_H */
-- 
2.53.0

