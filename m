Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9464476CCF;
	Wed, 12 Aug 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549066; cv=none; b=SqGiCFj8PNA91/Yc9rt6luKynS/lrgYCSWpmH31ODGXGju2glJm5BuN/2cYq611/oGJfowHrfADysmGQ5zwaFs3BNXwT42OyaUS28ALWXbsrsspOo8F/IWC7AVrwJ/Os1K63D+Y/qAs6nmAU3d5yUoO1ixPUJ4Up+W7C9ZqycwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549066; c=relaxed/simple;
	bh=mSXmF0y0HYPt1K5KC0eEtZRWapwfDYy82uHnw8V1pYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyTM3zkVT1Rs/xSQc/IhBqb+LkDJNyTtQVanvhyL9QrlF48S7O4Px0EPX9xsfaj6iR8g+0cpuYuOEfiwl1NNvUveVpStiPELrncFES/Igic+vq56klj3WXBxfgJiHAPqOTLdCQQiUXB4+Gkq8BasXWtjpBSo2ybkhV+x+WPSy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZNxL1sq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZNxL1sq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1oH12585927;
	Wed, 12 Aug 2026 15:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kFweWoD6BmrdWnt/M
	2WzA8rqD3JqQ3siBWorNyr03bw=; b=QZNxL1sqvE6z8N3oEEXFwTFUC+op3ctnH
	hfAaSHlS/yu5uSndibyTsDgPbV9iMaC9dtvNrl7xtmpmNCD5sNO/UE+FfN/fHNzt
	cWGLmtsYDYtnshRWWM7HyyqgZUdERi2F60huSUdQ1BAqgd7orYGbrbVlg9zD8N3Z
	7J+cqhF5AneibXAg3KEzDv+Fl/O49g7exuTOIxJp7LOG0eD1z5HrWyxqRQaifw2o
	efrqM2fDvYCSzvCSOTX9p9xFVxT3TJfxvRrx2se/iqiGwiViHCaU2mZj8gEl7IXS
	xaAlCBeSbtl0iK+M0zLBAcSFyvLm60VR1HuvOfrS/8CZnBICS4Sqw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23usga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQG6P021696;
	Wed, 12 Aug 2026 15:36:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6g40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFabsA37618094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9840B20049;
	Wed, 12 Aug 2026 15:36:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CB4C2004E;
	Wed, 12 Aug 2026 15:36:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:37 +0000 (GMT)
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
Subject: [PATCH v6 14/33] KVM: s390: Rename kvm-s390.{c,h} to s390.{c,h}
Date: Wed, 12 Aug 2026 17:36:10 +0200
Message-ID: <20260812153631.3376090-15-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c930a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GjolvbTUVQmQk0ik3y8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX3ufe0ge4z2t2
 MhCuaxxur0ioHeXr12UqsEb8pIjtT4uC9JTrSR8ycH4Ugb6isyb1LZxz4IjIjjmJQbHJ+F78FUn
 6+2H/r/vuPxkMi+Lh9RZ3eygDZbEVbfqpr4p1DiDLJSbqGa2b95KfHf97NfFOZZd1xCnft7f5wu
 +gbaoYuQxDBUm+ICokIiWYM7s5mL+PTgj61lLBrugQPHENiw2Mcy4m7VOpzHMKSL6bDmL4G7sV1
 Zf4bgzdKeRceTs0RtEF7QNiubAoMZrBLc6wucLHpWBVm3pcn/t4FB7aLbvfxdgId9E64/bbC3A7
 eQ4C/dmDeNIbUKbmtyyoYl9PEhHBe72bl+y3t5yMQ3XYm/VpYJOSRk3L/p6AjknVzAjFJYJsuHB
 peyiWxoYdcP28jsVz7l1W/VGAcz72YBatj1yTr5F6Y+mTAdH44h+RHRb5GmUIFfyX5Xw9eqfUeY
 eMCrDY7D4Q5TKLeXgog==
X-Proofpoint-ORIG-GUID: 5PT25hJ5ni7NkwffdMa1YsM44nXaC-rF
X-Proofpoint-GUID: B8ogpzjb7HWPUJyUlI9DRzoxCAUwN0Vx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX7vIML+b6UXuX
 30S9WYunDeSomLrP3KTKNVRc9STP487ZZReztXt9LwwxMal/QvPpSCHQYTPNN1npQAKMOrN5Adb
 icBIAC+Fv9XCZEOUC0RAW3D33Xl+qtk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Rename kvm-s390.c to s390.c and kvm-s390.h to s390.h for consistency
with the new directory structure. Update all include statements and
simplify Makefile ccflags from explicit paths to -I$(src).

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/Makefile               | 4 ++--
 arch/s390/kvm/diag.c                 | 2 +-
 arch/s390/kvm/gaccess.c              | 2 +-
 arch/s390/kvm/gaccess.h              | 2 +-
 arch/s390/kvm/gmap.c                 | 2 +-
 arch/s390/kvm/guestdbg.c             | 2 +-
 arch/s390/kvm/intercept.c            | 2 +-
 arch/s390/kvm/interrupt.c            | 2 +-
 arch/s390/kvm/pci.c                  | 2 +-
 arch/s390/kvm/priv.c                 | 2 +-
 arch/s390/kvm/pv.c                   | 2 +-
 arch/s390/kvm/{kvm-s390.c => s390.c} | 2 +-
 arch/s390/kvm/{kvm-s390.h => s390.h} | 2 +-
 arch/s390/kvm/sigp.c                 | 2 +-
 arch/s390/kvm/vsie.c                 | 2 +-
 15 files changed, 16 insertions(+), 16 deletions(-)
 rename arch/s390/kvm/{kvm-s390.c => s390.c} (99%)
 rename arch/s390/kvm/{kvm-s390.h => s390.h} (99%)

diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index dac9d53b23d8..961de97b8e80 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -5,9 +5,9 @@
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
-ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
+ccflags-y := -I$(src)
 
-kvm-y += kvm-s390.o intercept.o interrupt.o priv.o sigp.o
+kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
 kvm-y += dat.o gmap.o faultin.o
 
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 031ab6e5d6c4..09033c8ff1bb 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -12,7 +12,7 @@
 #include <linux/kvm_host.h>
 #include <asm/gmap_helpers.h>
 #include <asm/virtio-ccw.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 #include "trace-s390.h"
 #include "gaccess.h"
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 0d389a302a70..e5c064f263df 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -17,7 +17,7 @@
 #include <asm/access-regs.h>
 #include <asm/fault.h>
 #include <asm/dat-bits.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "dat.h"
 #include "gmap.h"
 #include "gaccess.h"
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index b5385cec60f4..ef922b3b4990 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -14,7 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
-#include "kvm-s390.h"
+#include "s390.h"
 
 /**
  * kvm_s390_real_to_abs - convert guest real address to guest absolute address
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3758e4009709..b5b920392378 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -21,7 +21,7 @@
 
 #include "dat.h"
 #include "gmap.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "faultin.h"
 
 static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 9a6149e310bb..1bf7e91b7e61 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -8,7 +8,7 @@
  */
 #include <linux/kvm_host.h>
 #include <linux/errno.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 
 /*
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 1980df61ef30..ca1205dfac8b 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -17,7 +17,7 @@
 #include <asm/sysinfo.h>
 #include <asm/uv.h>
 
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "trace.h"
 #include "trace-s390.h"
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 0d9fbe75dc66..9aa786952718 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -29,7 +29,7 @@
 #include <asm/nmi.h>
 #include <asm/airq.h>
 #include <asm/tpi.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
 #include "pci.h"
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 50f5ec79600e..82892e1e03d9 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -14,7 +14,7 @@
 #include <asm/pci_io.h>
 #include <asm/sclp.h>
 #include "pci.h"
-#include "kvm-s390.h"
+#include "s390.h"
 
 struct zpci_aift *aift;
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index b1ba24c346ef..b3cb2c2c3aa7 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -26,7 +26,7 @@
 #include <asm/ap.h>
 #include <asm/gmap_helpers.h>
 #include "gaccess.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 #include "gmap.h"
 
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index f549b161b972..7adfdc9b62be 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -18,7 +18,7 @@
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
 #include <asm/gmap_helpers.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "dat.h"
 #include "gaccess.h"
 #include "gmap.h"
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/s390.c
similarity index 99%
rename from arch/s390/kvm/kvm-s390.c
rename to arch/s390/kvm/s390.c
index 4faff6625da3..ff09ffc10f0d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/s390.c
@@ -50,7 +50,7 @@
 #include <asm/fpu.h>
 #include <asm/ap.h>
 #include <asm/uv.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "gmap.h"
 #include "faultin.h"
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/s390.h
similarity index 99%
rename from arch/s390/kvm/kvm-s390.h
rename to arch/s390/kvm/s390.h
index 6d2842fb71a3..e144ca2e6d5e 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/s390.h
@@ -452,7 +452,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm);
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 
-/* implemented in kvm-s390.c */
+/* implemented in s390.c */
 int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 55c34cb35428..131b3371ef4f 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <asm/sigp.h>
 #include "gaccess.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 
 static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index f546239d8ff8..cc94ede0621f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -23,7 +23,7 @@
 #include <asm/nmi.h>
 #include <asm/dis.h>
 #include <asm/facility.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "gmap.h"
 
-- 
2.53.0

