Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206E3EFD34;
	Mon, 15 Jun 2026 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527377; cv=none; b=f33dmQgZu8AFGfBQcPx9NJMoG6kn7kJrOzd7kyASFs74WQPx9/sZBOH4iP0EcKkZwIXlDxqqGhvAf1GwEOQA6dqtt2NAkmdYMrRFY986Jkf6EVAbSnHCeEMBKu/iXhwG+MsQho0cOP9/b2swcujkiEm5X0xZkF9hawgPDflbY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527377; c=relaxed/simple;
	bh=NaBSU24ggkBdrkx3PXcj54SqVq8JgsPAljVmzqmt83w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQXlQBE8LYXt4CwLsqLaCxToxD4jja8AC2ExmHZ64y/+etSkSuJpaoy/5k50hHwZQmp2QYEwn/HjFUV+uJjate7hZU0wyfIM5Ct6tNTz6Nvz5yU+2imcd9Z6CXxgoTJaRjgBwob5r3dZGqpeP5j3/ZUfj8YNtZtz5xP1OIeiWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bAjdERQo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bAjdERQo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAnvFY2208581;
	Mon, 15 Jun 2026 12:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+R99zoO8MdBk7WobO
	g4kOnOBkP0gXwjXF1w5jMqmnWY=; b=bAjdERQoWKOzt84+aFB2F2jidKe9N6gcx
	JGgg3EE3siMzXs883qzf8kHhOfIGr5GhLzwogYAuzoLex/1LLFOuMG4V5HaGxXme
	+hQKT1tdIswcK80gVWnLJ8gntwHtj5S3ryv31dBzSQ7GuKkWtfMK1QI1SwRLW9Dy
	espXmYRIYtUYwoGFMQbiD8D4vrR1nVO3tSfep4MU9dQMpZacb68cvKpExbzMjlWY
	KCnUQzX2URK9n30LExhgWjUM8PlWa/mUj4KPR7yHAdUe8SGg8E83hmhJd0rBQQGY
	WSkeDPqqeMkA/xYUCkk2Cx/Va2CZ4tS9/uRjzxnkNW7yzc+vwttzg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm0g7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYfKK017148;
	Mon, 15 Jun 2026 12:42:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg6cq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgllZ12780010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A799020043;
	Mon, 15 Jun 2026 12:42:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F3212004B;
	Mon, 15 Jun 2026 12:42:47 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 07/17] KVM: s390: Add capability to support 2G hugepages
Date: Mon, 15 Jun 2026 14:42:33 +0200
Message-ID: <20260615124243.187614-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX0+Gq9wHxD5+C
 jM/KLj20w3ZrlpeOfWuGQ4erkwXuc+YhMf2w5tVMJvFumq1aFNAcRNC/PHX/Oz3VtiaH8Kt7Qc1
 C38SKKtTt9ZFxtXu73jdMYgrOKQIT3Y=
X-Proofpoint-GUID: e1eJECxwEC8EhDixdzGfmkrwMo3RVT5A
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ff34e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=QhT8cEMGEDdk696zIO8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX8e+BiX9I0o/y
 yz9DVDcVv3p03JVjrFux1z5BJhJBpEsC+VnCD1OU331hu0pd8kM2NVjQpdriBD8/jEfEDER92U5
 pRVF7AbONL3HYNUA70wMNBeVbHWv9JjwGEeCrsbcLE6DfRkJZXF/sH4Rh1RsolAtMTsi+R+X4GR
 tP2/fuo+78pSdW4wal4iOyeDaxcrsJBLzRbmJdY6eMDgA02Q6mKtyijtliGHoHUsEyPE2663vfG
 FYaINmcQOTDg9M3/FEwNkmAOQ9E00CLJVJ+atYztNfMeswVHwo9lH5M0Kc7V1XTWgeH/FhFbLsB
 vNKQ88OcyJSheA2zBVYCAmLdNF/WOB/mHVAZxHLC7huEF+h0aJGtSikmG2A010kvUR1ha7ZNJ2W
 Af5coSbtgAkdmOE8AgZUeq1KCaR9yXjB5y6ubOzP/MIceksq+223fLchL7RAXUGTIUHWrAz+qyz
 g2gxteKCl8dEC1iHpTw==
X-Proofpoint-ORIG-GUID: e1eJECxwEC8EhDixdzGfmkrwMo3RVT5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

Add KVM_CAP_S390_HPAGE_2G to signal to userspace that 2G hugepages may
be used to back the guest; restrictions apply similar to 1M hugepages.

Enable the (for now still ignored) GMAP_FLAG_ALLOW_HPAGE_2G flag for
the guest gmap, and propagate / disable it as necessary.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260609150930.665370-3-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c     |  5 +++++
 arch/s390/kvm/kvm-s390.c | 26 ++++++++++++++++++++++++++
 arch/s390/kvm/pv.c       |  5 ++++-
 include/uapi/linux/kvm.h |  1 +
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index fe138d17caaf..f8bd6c135e3c 100644
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
index abc7941d7bb4..6de36421548c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -646,6 +646,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
@@ -902,6 +907,27 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
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
index c2dafd812a3b..b9a23df96f7d 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -721,7 +721,10 @@ int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
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

