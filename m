Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3F38D40E;
	Wed,  3 Jun 2026 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501690; cv=none; b=LxZOVSwLjg8F1DpYMt4eObkgh72c4qasnHkdtuFdj5I1MsAV7jLcbAI9VMpNPiTvfoT62o8IPXE/O598q4Zwecd2G0PGqUzXIO694KmcFOcWiNbpGGcedApj3ctdZx7I2XlZxqPNHkw36Jvf4esta5ddHgXAaprhTCdzk4G+QoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501690; c=relaxed/simple;
	bh=fqOCT+DG5o6RVACRrvaT+QBalDXQ9AIiWhv2rkoT6QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKIys7C9zwv+IVhWo75M76BNRyT9bG1TKoUCqHEl6FsItrasq/JJBtLcy3tKr5HHVIvzgqkFTGNvyNdk6inbrV7q/sC5fd+wdaRINkb65pQInzSHIR9qAxRItefOU3dsG4YFaBCC5VEmwS7b0b+b+zEiAVZNyl8Pa3U1hR2P6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P4XWO0jK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P4XWO0jK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65376o4H867987;
	Wed, 3 Jun 2026 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yjQ4e8C3ItJ/vYqgz
	f1FvaLmG8ThtgO0vq3HmYf45+E=; b=P4XWO0jK3uzf1scFslhffF0bWCDp5nm78
	yezXlNvi7o2Kudwp9abqVwUAzZMTNpryCZ4ypCXw+RTNTXkiinS1ReZlmv8qZQ/C
	Mg3hnHPVlQreYX7XAj3m+J4OlTldjjUTnX/G25nlu+QD985go+Xu0igHn46sJzrZ
	AoT3DkX6ThdicCS7hj5lGbGnOGg+RGeXMKqft7ZrL6Fn77iZgr2mrfzGAZkikDAz
	b+cFlL2l5w5G+pHzb547whQh/OCMLjixj3rk5bgVi/ejiZ+JEySv48VythYaM5GQ
	SazMPMRtYMCeNgvTDWlBM1ShtnxUMTr6JTC+FJRDdyS/3Bj0KEpWg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqbqn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 15:48:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653FdNOp002437;
	Wed, 3 Jun 2026 15:48:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw10w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 15:48:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653FlxHk51183902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 15:47:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 517E02004D;
	Wed,  3 Jun 2026 15:47:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D49820043;
	Wed,  3 Jun 2026 15:47:59 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 15:47:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 2/3] KVM: s390: Add capability to support 2G hugepages
Date: Wed,  3 Jun 2026 17:47:57 +0200
Message-ID: <20260603154758.234768-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603154758.234768-1-imbrenda@linux.ibm.com>
References: <20260603154758.234768-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FMMddMLZjsUiLcWPMNph9miDVTah7hq9
X-Proofpoint-GUID: FMMddMLZjsUiLcWPMNph9miDVTah7hq9
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a204cb6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=QhT8cEMGEDdk696zIO8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE1MSBTYWx0ZWRfX4Ec35UfVe685
 ENpTZIn26PqUwQOGb8Whg1AbS6q0K6o9Q8uZgyIUEit3WBG9i8L27vpuZ6PicaZ6SNg8IHGJG1z
 rl+1eH8kYn4SN/jdCp9AWXNsdwM67/JcW0SOEoHNzeDRK4PE9Ko83tC6ujRKbftUdqb43MHKQy0
 Kbhlj3ZyebZpk8cszm10d6t33vpmA71I4Iy9uDIMzd+Utx1JSpzbOE9rTiprW6ZnKzbUpqkOsFB
 8i+rBr9pn8R1P05rXh+XDrxCTspz22S7M853De5PaOCd6+vX1kospyzJcGE0MS4sf8lpDRneflS
 w2SnaExZ056lntRMOPbdM5F1Bs2b6JVIn59rckb9QfREWZP1Y/NcMAuv0gt1MsfT0jfbrU+Ic7K
 Qm7l21ggJ73PHfuvUU3IrJvBw8+Thm2/VnA4hM6SfLu9XWnfKMY/QGgOmt7gyJnj+yHUUpzv38K
 6UqdykfuNu9uvQEGVmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030151

Add KVM_CAP_S390_HPAGE_2G to signal to userspace that 2G hugepages may
be used to back the guest; restrictions apply similar to 1M hugepages.

Enable the (for now still ignored) GMAP_FLAG_ALLOW_HPAGE_2G flag for
the guest gmap, and propagate / disable it as necessary.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c     |  5 +++++
 arch/s390/kvm/kvm-s390.c | 26 ++++++++++++++++++++++++++
 arch/s390/kvm/pv.c       |  1 +
 include/uapi/linux/kvm.h |  1 +
 4 files changed, 33 insertions(+)

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
index 4b865e75351c..0f818149e644 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -741,6 +741,7 @@ int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
 	uvcb.flags.ap_instr_intr = kvm->arch.model.uv_feat_guest.ap_intr;
 
 	clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &kvm->arch.gmap->flags);
+	clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &kvm->arch.gmap->flags);
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

