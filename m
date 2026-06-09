Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33847D937;
	Tue,  9 Jun 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017786; cv=none; b=Yvw2FcDRElims52IWoZd/BNmYdoFWs+/4DowggnMWbUTFF8UZtIMzDvE6YgDI0jNgwIrA8ye6Xieapb246eEuyigvIVme3g/HYE9xn9gb3HxsUSdHcbGUrQFxW/58n57axgaQznuGA9ghLu3cUYY1a1LcZOuVMczBPR9Shiqpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017786; c=relaxed/simple;
	bh=uoQDxkkYl9TebcURjK0NWuDg/McTbqXu4jmsDYqQVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf5FZJAPLTWStxHdKjn/ba+DfE4PSZ8jx31BP0UIUdwSkR+omqIyS70eGhq1CCOzbUzfsvba173uZiRQOkO4kb5OSUMvci7QSMk3lm+mnjZrj+GA2nZH78WquO7R5MDlLa6ry2/2UPS9O9LL1lRw4Yymj8CBYhJ0UnFzKoU5OIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhEWNcvk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhEWNcvk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659E0eLt2451177;
	Tue, 9 Jun 2026 15:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hrTw0tLgGzmQBoP4j
	Itca1C1kqRc/jArKVD68ZEa/Go=; b=bhEWNcvk6eA9NbKChdx9kUh94y7cvrI20
	pSVk0z7rjur6ultIcL/G+VfSG8h5xItMckOAdxVjU/NOwUwthkaXh09SbFoSKS2d
	JOeOA0pARZfjty7s79O82yDSj6kvX6n6twtyFeT0ptIb8SYF0N3RXjqmr0CZP05v
	sAFgKhh8iliNek1GAshuBbHeYfV0eNH305G0MIyCOnHUWEfidN0k2lF09iSZdFg0
	PyobSBQrefd93ocHbS04N8XMzltqrdIVoeF8Y6Gy488F3cLnPyQYIkTvK91yEIXW
	8cPY5BKwsaW2p1cP0cMBrhBK9Lxz2WOK8VRSpVaFHinag9DoTka+A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qmsn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659F4dJO017042;
	Tue, 9 Jun 2026 15:09:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych2f0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659F9Z5g61473168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 15:09:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F8942004D;
	Tue,  9 Jun 2026 15:09:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4082520040;
	Tue,  9 Jun 2026 15:09:34 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 15:09:34 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 2/4] KVM: s390: Add capability to support 2G hugepages
Date: Tue,  9 Jun 2026 17:09:28 +0200
Message-ID: <20260609150930.665370-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609150930.665370-1-imbrenda@linux.ibm.com>
References: <20260609150930.665370-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a282cb6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=QhT8cEMGEDdk696zIO8A:9
X-Proofpoint-GUID: i8b4eY45QXe_iLfcjRjZE4VOYpxkK1i8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NCBTYWx0ZWRfXxEhccUw31e7x
 LE8HHDuro8Vy2QvbHPO4MjZPk7hIs0KUpeEo9gwUXoQFS8JGowHuHDnCnoI1uLEyQASsrm6M8W8
 MSQOpADaZqpwPtctiZ89tGyuMcHZm/+nJgB/+am/O0yDdSndfPhK6vg7F4XeB7b6s2+v79bqrJF
 V52G2JwqnSn7kRVZvwrjl1s0uZ+7cWAgUWVsh4Nbba+18cHUbjzQMZbtqiNL1HWWUhZvOEu6QKo
 44Kl73ETK4VLuBFrFXdPSB4rCV+lq8FxYWaHRyJOhIWQerJ0GHPCH3ZI0AEhqFWT1a4p1+lxkZZ
 qVTlY+2DGducjbbw9a2jPJsyisHrKMxgIG3LHocofgD8Xw58yf+xBYaZEcHFgdTHiGLkRwS81QG
 zVx+6JZ08ds/4kc2vobhTjS66G6tf8z834bXLxGhtKF2ZKNm007y3FGLaiWo5B43qsqgWWbWdB5
 yj4xUh/nUk/9ZArH96w==
X-Proofpoint-ORIG-GUID: i8b4eY45QXe_iLfcjRjZE4VOYpxkK1i8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090144

Add KVM_CAP_S390_HPAGE_2G to signal to userspace that 2G hugepages may
be used to back the guest; restrictions apply similar to 1M hugepages.

Enable the (for now still ignored) GMAP_FLAG_ALLOW_HPAGE_2G flag for
the guest gmap, and propagate / disable it as necessary.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c     |  5 +++++
 arch/s390/kvm/kvm-s390.c | 26 ++++++++++++++++++++++++++
 arch/s390/kvm/pv.c       |  5 ++++-
 include/uapi/linux/kvm.h |  1 +
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 52d55ddea8d4..c9e348149ba1 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -105,6 +105,11 @@ static void gmap_add_child(struct gmap *parent, struct gmap *child)
 	else
 		clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
 
+	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags))
+		set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
+	else
+		clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
+
 	if (kvm_is_ucontrol(parent->kvm))
 		clear_bit(GMAP_FLAG_OWNS_PAGETABLES, &child->flags);
 	list_add(&child->list, &parent->children);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 801a622691b6..616d1db7c0d9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -645,6 +645,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		if (hpage && !(kvm && kvm_is_ucontrol(kvm)))
 			r = 1;
 		break;
+	case KVM_CAP_S390_HPAGE_2G:
+		r = 0;
+		if (hpage_2g && !(kvm && kvm_is_ucontrol(kvm)))
+			r = 1;
+		break;
 	case KVM_CAP_S390_MEM_OP:
 		r = MEM_OP_MAX_SIZE;
 		break;
@@ -901,6 +906,27 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_HPAGE %s",
 			 r ? "(not available)" : "(success)");
 		break;
+	case KVM_CAP_S390_HPAGE_2G:
+		mutex_lock(&kvm->lock);
+		if (kvm->created_vcpus) {
+			r = -EBUSY;
+		} else if (!hpage_2g || kvm->arch.use_cmma || kvm_is_ucontrol(kvm)) {
+			r = -EINVAL;
+		} else {
+			r = 0;
+			set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &kvm->arch.gmap->flags);
+			/*
+			 * We might have to create fake 4k page
+			 * tables. To avoid that the hardware works on
+			 * stale PGSTEs, we emulate these instructions.
+			 */
+			kvm->arch.use_skf = 0;
+			kvm->arch.use_pfmfi = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_HPAGE_2G %s",
+			 r ? "(not available)" : "(success)");
+		break;
 	case KVM_CAP_S390_USER_STSI:
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_STSI");
 		kvm->arch.user_stsi = 1;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 4b865e75351c..1beacc841ca8 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -740,7 +740,10 @@ int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
 	uvcb.flags.ap_allow_instr = kvm->arch.model.uv_feat_guest.ap;
 	uvcb.flags.ap_instr_intr = kvm->arch.model.uv_feat_guest.ap_intr;
 
-	clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &kvm->arch.gmap->flags);
+	scoped_guard(write_lock, &kvm->mmu_lock) {
+		clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &kvm->arch.gmap->flags);
+		clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &kvm->arch.gmap->flags);
+	}
 	gmap_split_huge_pages(kvm->arch.gmap);
 
 	cc = uv_call_sched(0, (u64)&uvcb);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf..419011097fa8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -996,6 +996,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_S390_HPAGE_2G 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.54.0

