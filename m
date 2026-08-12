Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B1379EC8;
	Wed, 12 Aug 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549061; cv=none; b=WGW9QVBIVW/iLMnRdEDWF/5mKpYyP8NS68L2e5u5ORYtUUR8fAdQ4ThUESLZ/yzpddQhC0ZO67hvRShS5mY4y4X+C/UkNwBM+sO4y1lgYd1zSDKfQ0h3WlvWbkJivZ2ng/LCf+fl8hm09bk9bgdQjRS8XGSZ3Usk7IRQ0vxeSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549061; c=relaxed/simple;
	bh=dSvMIDvJm6IzwXNQ65iwxXqa90FGz9LEvL0jLe1mkqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtSLIJ0AEF3k8mAzKTkBw+LHHH2QCKUzQ24X61zCchMTzdULlatxnhYRRIfY1N+h7ZKe8fNvm0bTEM37YlDjc6zy4Mbr3KoOo8C/W+cdKkPUGuCMuP6bxV4op2+Raj12luNrWd0OGgmF8B22fwEwSdPDU4a0RKF/fjx0kso2KTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MnJD6QwV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MnJD6QwV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1bCC3640263;
	Wed, 12 Aug 2026 15:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cPdtovAYXF22FUXJg
	W37R+HUCWsKp0CDniDtlu11EGg=; b=MnJD6QwV8QED0nGLoC16FBJVUiAJ5SEsz
	6zL5joYFfa17uLTNgWoJm2q2BcZtN/ZuauvR5i2N5bfvzNuzRg6sOrLGizOGOVzf
	iGn1IV10TbJJyM5fplbUvsSP/LBag+XhCX120uowQeq03GWq9+Il4QgqPhb1309N
	DKm+wqaF4dI7B8YKutp1WDe1qEU0FIaGgi0T3dUTKrGOSQFK2OANp2ZgHBVX6Itb
	LU7b7yKz46jC2ip+JTzROea+n2vgP2lrj7gR2mR/H//yA6x0icSm+ffg1/11qgok
	rdna94pw2tBlPqT5cDBNvjBiLR6DMiDy/sWrGIOt2GxZurKyMPBfg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9k7bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQNvt012331;
	Wed, 12 Aug 2026 15:36:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6uta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaa1I38797602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D003920040;
	Wed, 12 Aug 2026 15:36:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ECE22004F;
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
Subject: [PATCH v6 12/33] KVM: s390: Extract gmap tracing to a separate header
Date: Wed, 12 Aug 2026 17:36:08 +0200
Message-ID: <20260812153631.3376090-13-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: 4RLhiJBG_ECstebReXH6oyQMvCaJMXi-
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c930a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=hUpfy6h2KLrKm0K-hOsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXyOQhuOvmWgCu
 7789l1u8jBSO0roN5429dQzs9DBD1PnpcXnSmGjar6P1hemnGXx1lNL2BU2+zugIzYBbZTdkRm6
 f0CS0BIepVRH6Y3QeaAd+ic27J1GywGejUqmDi+tGSJFPkuItMEK5R1j61uWzK1fuMFf2BccNTQ
 0AQ0btIGj6wiBg5YLyAy0NzhIsverd9Gm0E9o2Ywo5fJQA8l/+SqtxK0/pBFGEJ47edx3NTHb0f
 gnwZeIfasaDmb1O5nValexZL+uVarOJe8KSs8hFSsENgc+pjAza/1kC3lh8ppy4TZT9aoSmok0D
 wRHP8Q00M67kNuruz5GPpG0pi+kCZmCFsqGkFFGUXHXL5ZG2L/h8rT6QVN8VTYbKUvH13BDbo9G
 m3+BjeS7VRoMHJ2windd7n9GDkLQOtl6QPOgOM3OPdjtOBHWpSXG5jhHg3rAchenWsC0ZcZwGie
 ThEbiDgv8E8iUokl4Ow==
X-Proofpoint-ORIG-GUID: 4IKwY207ohIYZNIWOT49smatfU6whGSv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX9tOJ76A74RdO
 Mr75z1r2CBqdEhbpFR/hsBnEEAoYyVxE5N122ZihtoztnVx21xd87qjKnd5grinZ5q7w7S8G164
 ObvHns3xuS9b8dOBv3k3grWnVsuqIZw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

Move the kvm_s390_major_guest_pfault trace event from trace.h to a new
trace_gmap.h header. This separates gmap-specific tracing from general
KVM/s390 tracing, preparing for code sharing between multiple KVM
implementations.

The trace event definition is updated to use local defines for
parameters so that they can be replaced later with ease for when another
KVM implementation uses these traces.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/faultin.c    |  3 ++-
 arch/s390/kvm/trace.h      | 14 ------------
 arch/s390/kvm/trace_gmap.h | 47 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 15 deletions(-)
 create mode 100644 arch/s390/kvm/trace_gmap.h

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index 3cc45f7f5b2d..1dc79807012c 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -9,10 +9,11 @@
 #include <linux/kvm_host.h>
 
 #include "gmap.h"
-#include "trace.h"
 #include "faultin.h"
 
 bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
+#define CREATE_TRACE_POINTS
+#include "trace_gmap.h"
 
 /*
  * kvm_s390_faultin_gfn() - handle a dat fault.
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index dd2685c7df5b..3d2fffb1555a 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -45,20 +45,6 @@ TRACE_EVENT(kvm_s390_skey_related_inst,
 	    VCPU_TP_PRINTK("%s", "storage key related instruction")
 	);
 
-TRACE_EVENT(kvm_s390_major_guest_pfault,
-	    TP_PROTO(VCPU_PROTO_COMMON),
-	    TP_ARGS(VCPU_ARGS_COMMON),
-
-	    TP_STRUCT__entry(
-		    VCPU_FIELD_COMMON
-		    ),
-
-	    TP_fast_assign(
-		    VCPU_ASSIGN_COMMON
-		    ),
-	    VCPU_TP_PRINTK("%s", "major fault, maybe applicable for pfault")
-	);
-
 TRACE_EVENT(kvm_s390_pfault_init,
 	    TP_PROTO(VCPU_PROTO_COMMON, long pfault_token),
 	    TP_ARGS(VCPU_ARGS_COMMON, pfault_token),
diff --git a/arch/s390/kvm/trace_gmap.h b/arch/s390/kvm/trace_gmap.h
new file mode 100644
index 000000000000..a3cad705021b
--- /dev/null
+++ b/arch/s390/kvm/trace_gmap.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(GMAP_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define GMAP_TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace_gmap
+
+#define __KVM_FIELDS \
+	__field(unsigned long, pswmask) \
+	__field(unsigned long, pswaddr)
+#define __KVM_ASSIGN ({\
+	__entry->pswmask = vcpu->arch.sie_block->gpsw.mask; \
+	__entry->pswaddr = vcpu->arch.sie_block->gpsw.addr; \
+	})
+#define __KVM_PRINT \
+	__entry->pswmask,\
+	__entry->pswaddr
+
+TRACE_EVENT(kvm_s390_major_guest_pfault,
+	    TP_PROTO(struct kvm_vcpu *vcpu),
+	    TP_ARGS(vcpu),
+
+	    TP_STRUCT__entry(
+		__field(int, id)
+		__KVM_FIELDS
+		),
+
+	    TP_fast_assign(
+		__entry->id = vcpu->vcpu_id;
+		__KVM_ASSIGN
+		),
+	    TP_printk("%02d[%016lx-%016lx]: major fault, maybe applicable for pfault",
+		__entry->id,
+		__KVM_PRINT
+		)
+	    );
+
+#endif /* GMAP_TRACE_KVM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.53.0

