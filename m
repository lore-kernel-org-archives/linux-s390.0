Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923740626C;
	Mon,  3 Aug 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760856; cv=none; b=oP27NxSMU5/rPeBd2TN8AZ7uqwbRl+qL7wxTfaKm6OsG3DsJg3Y6I7n8Inp2jtLJHE7m16uKfQTyT1UKcOZ7owEmZYRKMMCP25y124Zc6TKR8tq06naMmBsrKPhU+lx7c7V4gM+I9IeHdw4W5ocyG7hlfcwrYe/LDKtvB6nUY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760856; c=relaxed/simple;
	bh=3caGIdp+p3kPdcgMgYkHp0OEp1q1F9YNv8vDbyO0O04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqLDjoL+bbfgC5Tj8OKountl/prHkgbnBj9tbZJslc8l9wQGHxZQ84G1Cos2EY3OrBzzisiJhxuoB2u2HfzDTekqWWXRiMtyUE6W3hacYwxaUGCzZx37EXoWk8aUsKPjz0l4f0DI1WpDkIFPnS9Os9YbO/ZqjT0qiMwpwA1vpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IZL4q7gY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IZL4q7gY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CI7wc2000345;
	Mon, 3 Aug 2026 12:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UneEizWds06um/osM
	D5l8RbzWNvgmHxpG3rtAjIygyM=; b=IZL4q7gYuk8XUCJHp2myoEjFp5UWirq5C
	XOXcMKN+KapdOlVotazHHKUYTAQQ1/i89p0YMZMZnVY2pHqOca1Qymqbn1y/kAeN
	JEtdmbZfTc5DqZh+pDjBqt8kVqkHpSJUVezdHAg1d9pcq2p4FDunEObUYZrVfh6Q
	XRdjziOHjyE1Y8DqUzOq4MXke0g1SRCnxNjJIYVLsdTlI6zIabrLsfsKal5GC/qU
	UhUjFqa9Bc/kwOnpIvh+ccE3cF5SJ3rHAkthRUgltS4WEOJoU+ZCfbP0hut32zlC
	S1bL7nxTLdYePzqEEyYs48X++FxxQHFKFbcHbBuw90LV8yWGlYm7w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3rryn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CBgxQ016851;
	Mon, 3 Aug 2026 12:40:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwe5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Cei3I30146968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A384920040;
	Mon,  3 Aug 2026 12:40:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40B142004B;
	Mon,  3 Aug 2026 12:40:44 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 07/13] KVM: s390: Fix race in __do_essa()
Date: Mon,  3 Aug 2026 14:40:34 +0200
Message-ID: <20260803124040.126471-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a708c54 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=vVGDtJNaOgRaVfleRDgA:9
X-Proofpoint-ORIG-GUID: hzjx_BLxbmKuSm4XF4htu4VU6bcLDhdE
X-Proofpoint-GUID: hzjx_BLxbmKuSm4XF4htu4VU6bcLDhdE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX/7Hx7Bs7/XZp
 5QD47S8J0XRCi9KSCk+EjAYKhdKwSKVbG2sxpU4n97f8L3+R/1eFEe+afmu3V3uATu7Wj+ThqXW
 +CCeoMzIeOpc2Wu+abjHTZBOJ+Kgh5M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX5sjBWizi8OrG
 d0LFRg4YKnGCGF0CrCrkWBZz/j3gGApP2kbDK+8uaMkYdJ++adU05FMRYYjJomcY6eFrtTMgm+g
 6bp66X9Af3npoJRMinA26nIbf0vtdQw+Jdn+kCH4y0OMKHIu6FchEYfk+o5KEAoYusOCfDrJgIZ
 OAw//yOLfqh4gf6elTZgWXWStoag5aSlEY/8/B6ZNeg65OX/at7DjD2Q1p1xZZHyapUklQ4KWON
 LxgWjKOwK9g6aO3QsCRPSYDX6r3sZHRtxtL/DYIRGtUDqhUMIfAYwvz6IZudvGF6cFKsrAkQKu2
 UPO5w2FKCKTv82eihTFzNci5T68JSzvb3g8yE5w9UbW2VHJqtL0EY8wqu+LmUgz9wbLfkwvX5v2
 73XphQsnZpsxjGFyQ7prFf+Pizr7ewonCF51VBdT/2JZNY3b1ojhO9ZnYwiqyxFg5Hz8o6ycCDl
 Eo4mrJCceSTOKavwwGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030110

An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.

Fix by locking kvm->slots_arch_lock. Since this is not a hot path, the
overhead of an additional mutex is negligible.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 20 ++++++++++----------
 arch/s390/kvm/priv.c     |  5 +++--
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e162efaa35b8..e5c5e9f61cb2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1219,8 +1219,8 @@ static void kvm_s390_sync_request_broadcast(struct kvm *kvm, int req)
 
 /*
  * Must be called with kvm->srcu held to avoid races on memslots, and with
- * kvm->slots_lock to avoid races with ourselves, kvm_s390_vm_stop_migration(),
- * and kvm_s390_get_cmma_bits().
+ * kvm->slots_arch_lock to avoid races with ourselves,
+ * kvm_s390_vm_stop_migration(), and kvm_s390_get_cmma_bits().
  */
 static int kvm_s390_vm_start_migration(struct kvm *kvm)
 {
@@ -1265,7 +1265,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 }
 
 /*
- * Must be called with kvm->slots_lock to avoid races with ourselves,
+ * Must be called with kvm->slots_arch_lock to avoid races with ourselves,
  * kvm_s390_vm_start_migration() and kvm_s390_get_cmma_bits().
  */
 static int kvm_s390_vm_stop_migration(struct kvm *kvm)
@@ -1300,7 +1300,9 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 {
 	int res = -ENXIO;
 
-	mutex_lock(&kvm->slots_lock);
+	guard(srcu)(&kvm->srcu);
+	guard(mutex)(&kvm->slots_arch_lock);
+
 	switch (attr->attr) {
 	case KVM_S390_VM_MIGRATION_START:
 		res = kvm_s390_vm_start_migration(kvm);
@@ -1311,7 +1313,6 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 	default:
 		break;
 	}
-	mutex_unlock(&kvm->slots_lock);
 
 	return res;
 }
@@ -3001,9 +3002,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
-		mutex_lock(&kvm->slots_lock);
-		r = kvm_s390_get_cmma_bits(kvm, &args);
-		mutex_unlock(&kvm->slots_lock);
+		scoped_guard(mutex, &kvm->slots_arch_lock)
+			r = kvm_s390_get_cmma_bits(kvm, &args);
 		if (!r) {
 			r = copy_to_user(argp, &args, sizeof(args));
 			if (r)
@@ -3017,9 +3017,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
-		mutex_lock(&kvm->slots_lock);
+		mutex_lock(&kvm->slots_arch_lock);
 		r = kvm_s390_set_cmma_bits(kvm, &args);
-		mutex_unlock(&kvm->slots_lock);
+		mutex_unlock(&kvm->slots_arch_lock);
 		break;
 	}
 	case KVM_S390_PV_COMMAND: {
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ea5a99537346..b1ba24c346ef 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1261,8 +1261,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		/* Retry the ESSA instruction */
 		kvm_s390_retry_instr(vcpu);
 	} else {
-		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-			i = __do_essa(vcpu, orc);
+		scoped_guard(mutex, &vcpu->kvm->slots_arch_lock)
+			scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
+				i = __do_essa(vcpu, orc);
 		if (i < 0)
 			return i;
 		/* Account for the possible extra cbrl entry */
-- 
2.55.0

