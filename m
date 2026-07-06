Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B747DFAE;
	Mon,  6 Jul 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328012; cv=none; b=eMxqi+SxyEIdDx25D1WU2gG7uKtZ1YytBDYSuPXAFZYLkTCNpsMLZF+7iiNEIjRirFqOasf/TvbrrWiZi1bx5ptXI1BzQpI0XAd495kiSaVo6TXqBuADEnzs3X9V/n71zSaQot7mzb/JmzQFucqK2FqfKAWTaJUesaUBR2oxZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328012; c=relaxed/simple;
	bh=YV9nrpi0p2+SP8CFE3k4V/jzDrAdE6OGidepyPvdq+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCK2hXy5vSfNMzgc9vAkYZ7UrMARBdoPEMQSG4xXqv58HoBFBIOUCPyQI6Zy1YO0+BsKPhH8+BzGQA+lFzDzKH4+VLX8e9/3W/YhDGBbN0caRvTMWjt+iNtTlYbkiSnNT6ewGuKLrppMJz8eyoB+nbVXcYfFb1e17uZEH78K/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dEFWaB3x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dEFWaB3x"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MISvD2304385;
	Mon, 6 Jul 2026 08:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OmJ0hDLaVvUY1ksjc
	uFBSGBnqfk3VPAGlx/m71U2knw=; b=dEFWaB3xx7cHhtUwK+Sa0POwRmBvQ5598
	O4+3yYSYVmIihSViK+0WuPZ38X8ZeaRsPm85ygiXM/EMP79Co39D/+y26EY47H5q
	DHmMl+q4wY3iDbtXiobUqBm5HcszM9ClkvJlqgDCFN4e+YHB1cqNQxAQdpcKb2qE
	ltAIaJpeRuaM9wrnu5NC9gHgUA9z9xPYnCtvz4YoNpkKuiR2/cmze/mPSa9xCcZJ
	B/mSwJj3WrVshP0MtalOBuP/R+uLPjtgf4EIF5nbfCP3mPmRSHKFkOUdv330N7DJ
	e2DYaiFFv7sgRAhcP9AyvTplhN5DL1K1wZQt2Ah8OHS/7N0cBm/4Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gk7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nmTp006242;
	Mon, 6 Jul 2026 08:52:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfvk9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qbuw34931026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FC7A20043;
	Mon,  6 Jul 2026 08:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C195D2004B;
	Mon,  6 Jul 2026 08:52:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:36 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v4 17/27] KVM: s390: Refactor prefix handling into a separate file
Date: Mon,  6 Jul 2026 10:52:17 +0200
Message-ID: <20260706085229.979525-18-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b6cde cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=4SwaMfgYKtkue4rGTFgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXwhIA+ZsRgaqz
 g5XjuRmzQbbDgcMwBeEXFV278TP9qe+t3dkSbqecHVEQfnUZlmKXvGnuroUuzyKXgyNIZcffCve
 QWs9BrLEzhHp92L25CvobwmDJiBZSPU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX3b5f9p245PM0
 iYx6z0PDv+QlF25cIdgLK3HZXrFZ5zC9+6PUjqGHLzJy7vge+VfAcaEP+2C9tEsLMul0anhPGh8
 MNd3ob0+xkEI1QJIRw0OcZU54GLV3dvgPmvmR/gfpL2y8OfpkNMLH7XkNm1CayC0IGn3s/kNSWK
 FDG8i05RYfbJTZmIwP2cDyZslHkut7vxkJwVkiOakgyt5Y+wFS66TqjdxhDyd1T1ar01fZoGjT2
 giM+/m5CZTIdQdy/UNfuBSOer2lsDCYRqR56lV+oVloDcOK6F/5J1qQ4P/fnfiYqyfr0vMUZwhp
 +2OdYa9xhSnakBKHKjvWhWvn6f0mU6jvAH2s2UW+nei6J0xcLsqWufbB+8Jpkm13mXFTd11IF/s
 qHgH7GvLuOSnydMePZL9qGio68p1NfXzaU4zW80pwg+2qJSMtRynzUArwHj9+ou+e09FGq0SfU8
 x9PdBlgQ8EpaIDJlMdg==
X-Proofpoint-ORIG-GUID: reMhww7am3AtjMpnP4olDrOh3tmugeN-
X-Proofpoint-GUID: reMhww7am3AtjMpnP4olDrOh3tmugeN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Split prefix page tracking into prefix.c/h with conditional compilation
via prefix-stubs.c for KVM for non-s390 guests. Enables gmap reuse by
other KVM implementations that don't use prefix pages. The prefix
tracking is conditional on the Makefile variable KVM_MANAGES_S390_GUEST.

No functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap/Makefile       |  4 +-
 arch/s390/kvm/gmap/dat.c          | 48 -------------------
 arch/s390/kvm/gmap/gmap.c         | 23 ---------
 arch/s390/kvm/gmap/gmap.h         | 11 +----
 arch/s390/kvm/gmap/prefix-stubs.c | 21 ++++++++
 arch/s390/kvm/gmap/prefix.c       | 80 +++++++++++++++++++++++++++++++
 arch/s390/kvm/gmap/prefix.h       | 68 ++++++++++++++++++++++++++
 7 files changed, 173 insertions(+), 82 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/prefix-stubs.c
 create mode 100644 arch/s390/kvm/gmap/prefix.c
 create mode 100644 arch/s390/kvm/gmap/prefix.h

diff --git a/arch/s390/kvm/gmap/Makefile b/arch/s390/kvm/gmap/Makefile
index a49c7e36b71c..4ca7635d1d0e 100644
--- a/arch/s390/kvm/gmap/Makefile
+++ b/arch/s390/kvm/gmap/Makefile
@@ -4,7 +4,9 @@ GMAP ?= ../gmap
 
 # Enable s390-specific guest management features (storage keys and CMMA)
 KVM_MANAGES_S390_GUEST ?= y
+USE_PREFIX_STUB := $(if $(filter y,$(KVM_MANAGES_S390_GUEST)),n,y)
 
 kvm-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o $(GMAP)/mmu.o
 
-kvm-$(KVM_MANAGES_S390_GUEST) += $(GMAP)/sk.o $(GMAP)/cmma.o
+kvm-$(KVM_MANAGES_S390_GUEST) += $(GMAP)/sk.o $(GMAP)/cmma.o $(GMAP)/prefix.o
+kvm-$(USE_PREFIX_STUB) += $(GMAP)/prefix-stubs.o
diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index 6114ff442837..4a9847139534 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -777,51 +777,3 @@ bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end)
 {
 	return _dat_walk_gfn_range(start, end, asce, &test_age_ops, 0, NULL) > 0;
 }
-
-static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	union crste newcrste, oldcrste;
-	int *n = walk->priv;
-
-	do {
-		oldcrste = READ_ONCE(*crstep);
-		if (!oldcrste.h.fc || oldcrste.h.i || oldcrste.h.p)
-			return 0;
-		if (oldcrste.s.fc1.prefix_notif)
-			break;
-		newcrste = oldcrste;
-		newcrste.s.fc1.prefix_notif = 1;
-	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, walk->asce));
-	*n = 2;
-	return 0;
-}
-
-static long dat_set_pn_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	int *n = walk->priv;
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	if (!ptep->h.i && !ptep->h.p) {
-		pgste.prefix_notif = 1;
-		*n += 1;
-	}
-	pgste_set_unlock(ptep, pgste);
-	return 0;
-}
-
-int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
-{
-	static const struct dat_walk_ops ops = {
-		.pte_entry = dat_set_pn_pte,
-		.pmd_entry = dat_set_pn_crste,
-		.pud_entry = dat_set_pn_crste,
-	};
-
-	int n = 0;
-
-	_dat_walk_gfn_range(gfn, gfn + 2, asce, &ops, DAT_WALK_IGN_HOLES, &n);
-	if (n != 2)
-		return -EAGAIN;
-	return 0;
-}
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 4ade7794e990..3dcd1d4c6a29 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -254,29 +254,6 @@ int s390_replace_asce(struct gmap *gmap)
 	return 0;
 }
 
-bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint)
-{
-	struct kvm *kvm = gmap->kvm;
-	struct kvm_vcpu *vcpu;
-	gfn_t prefix_gfn;
-	unsigned long i;
-
-	if (is_shadow(gmap))
-		return false;
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		/* Match against both prefix pages */
-		prefix_gfn = gpa_to_gfn(kvm_s390_get_prefix(vcpu));
-		if (prefix_gfn < end && gfn <= prefix_gfn + 1) {
-			if (hint && kvm_s390_is_in_sie(vcpu))
-				return false;
-			VCPU_EVENT(vcpu, 2, "gmap notifier for %llx-%llx",
-				   gfn_to_gpa(gfn), gfn_to_gpa(end));
-			kvm_s390_sync_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
-		}
-	}
-	return true;
-}
-
 struct clear_young_pte_priv {
 	struct gmap *gmap;
 	bool young;
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index aa65fe724fdb..0500c8c6c9ca 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -13,6 +13,7 @@
 #include <linux/kvm_host.h>
 
 #include "dat.h"
+#include "prefix.h"
 
 /**
  * enum gmap_flags - Flags of a gmap.
@@ -158,16 +159,6 @@ static inline void gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gf
 		_gmap_handle_vsie_unshadow_event(parent, gfn);
 }
 
-static inline bool gmap_mkold_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
-{
-	return _gmap_unmap_prefix(gmap, gfn, end, true);
-}
-
-static inline bool gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
-{
-	return _gmap_unmap_prefix(gmap, gfn, end, false);
-}
-
 /**
  * pte_needs_unshadow() -- Check if the pte operations triggers unshadowing.
  * @oldpte: the previous value for the guest pte.
diff --git a/arch/s390/kvm/gmap/prefix-stubs.c b/arch/s390/kvm/gmap/prefix-stubs.c
new file mode 100644
index 000000000000..d1d6286f454a
--- /dev/null
+++ b/arch/s390/kvm/gmap/prefix-stubs.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * These stubs are used when building gmap for non-s390 guests
+ * that don't need prefix page tracking.
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/kvm_types.h>
+
+#include "dat.h"
+#include "prefix.h"
+
+bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint)
+{
+	return true;
+}
+
+int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
+{
+	return 0;
+}
diff --git a/arch/s390/kvm/gmap/prefix.c b/arch/s390/kvm/gmap/prefix.c
new file mode 100644
index 000000000000..44caffed2da1
--- /dev/null
+++ b/arch/s390/kvm/gmap/prefix.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+#include <linux/kvm_types.h>
+
+#include "gmap.h"
+#include "dat.h"
+#include "prefix.h"
+#include "../s390/s390.h"
+
+bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint)
+{
+	struct kvm *kvm = gmap->kvm;
+	struct kvm_vcpu *vcpu;
+	gfn_t prefix_gfn;
+	unsigned long i;
+
+	if (is_shadow(gmap))
+		return false;
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		/* Match against both prefix pages */
+		prefix_gfn = gpa_to_gfn(kvm_s390_get_prefix(vcpu));
+		if (prefix_gfn < end && gfn <= prefix_gfn + 1) {
+			if (hint && kvm_s390_is_in_sie(vcpu))
+				return false;
+			VCPU_EVENT(vcpu, 2, "gmap notifier for %llx-%llx",
+				   gfn_to_gpa(gfn), gfn_to_gpa(end));
+			kvm_s390_sync_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
+		}
+	}
+	return true;
+}
+
+static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	union crste newcrste, oldcrste;
+	int *n = walk->priv;
+
+	do {
+		oldcrste = READ_ONCE(*crstep);
+		if (!oldcrste.h.fc || oldcrste.h.i || oldcrste.h.p)
+			return 0;
+		if (oldcrste.s.fc1.prefix_notif)
+			break;
+		newcrste = oldcrste;
+		newcrste.s.fc1.prefix_notif = 1;
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, walk->asce));
+	*n = 2;
+	return 0;
+}
+
+static long dat_set_pn_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	int *n = walk->priv;
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	if (!ptep->h.i && !ptep->h.p) {
+		pgste.prefix_notif = 1;
+		*n += 1;
+	}
+	pgste_set_unlock(ptep, pgste);
+	return 0;
+}
+
+int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
+{
+	static const struct dat_walk_ops ops = {
+		.pte_entry = dat_set_pn_pte,
+		.pmd_entry = dat_set_pn_crste,
+		.pud_entry = dat_set_pn_crste,
+	};
+
+	int n = 0;
+
+	_dat_walk_gfn_range(gfn, gfn + 2, asce, &ops, DAT_WALK_IGN_HOLES, &n);
+	if (n != 2)
+		return -EAGAIN;
+	return 0;
+}
diff --git a/arch/s390/kvm/gmap/prefix.h b/arch/s390/kvm/gmap/prefix.h
new file mode 100644
index 000000000000..f1f3ace24f03
--- /dev/null
+++ b/arch/s390/kvm/gmap/prefix.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_KVM_GMAP_PREFIX_H
+#define ARCH_KVM_GMAP_PREFIX_H
+
+#include <linux/types.h>
+#include <linux/kvm_types.h>
+
+struct gmap;
+union asce;
+
+/**
+ * _gmap_unmap_prefix() - Notify vCPUs if prefix pages are affected
+ * @gmap: The gmap
+ * @gfn: Start of the range
+ * @end: End of the range (exclusive)
+ * @hint: If true, skip notification if vCPU is in SIE
+ *
+ * Check if any vCPU's prefix pages fall within the given range and
+ * request prefix refresh if needed.
+ *
+ * Return: false if notification was skipped due to hint, true otherwise
+ */
+bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint);
+
+/**
+ * dat_set_prefix_notif_bit() - Set prefix notification bits
+ * @asce: The address space control element
+ * @gfn: Guest frame number of the prefix area
+ *
+ * Set the prefix notification bit in the page table entries for the
+ * two prefix pages starting at @gfn.
+ *
+ * Return: 0 on success, -EAGAIN if not all bits could be set
+ */
+int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
+
+/**
+ * gmap_mkold_prefix() - Mark prefix pages as old
+ * @gmap: The gmap
+ * @gfn: Start of the range
+ * @end: End of the range (exclusive)
+ *
+ * Inline wrapper that calls _gmap_unmap_prefix with hint=true.
+ *
+ * Return: Result from _gmap_unmap_prefix
+ */
+static inline bool gmap_mkold_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
+{
+	return _gmap_unmap_prefix(gmap, gfn, end, true);
+}
+
+/**
+ * gmap_unmap_prefix() - Unconditionally notify about prefix pages
+ * @gmap: The gmap
+ * @gfn: Start of the range
+ * @end: End of the range (exclusive)
+ *
+ * Inline wrapper that calls _gmap_unmap_prefix with hint=false.
+ *
+ * Return: Result from _gmap_unmap_prefix
+ */
+static inline bool gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
+{
+	return _gmap_unmap_prefix(gmap, gfn, end, false);
+}
+
+#endif /* ARCH_KVM_GMAP_PREFIX_H */
-- 
2.53.0

