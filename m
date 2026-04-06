Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517F37649C;
	Mon,  6 Apr 2026 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775457877; cv=none; b=EjY+A6BGdBekHc9P+d0prV5UeqhGDfEXD5/Xg+iY0RiP/AbPffft6jvhR1XzuTGxMiRfivCuqw4rojAyOdTecryyav186ejMyc9vR+yCSHnM/IfFeYGxzpeDNWjAwK96nTAGCmsWjvWYR9eIzYpwCM8PMRrfKtMJkMeA4+Ls3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775457877; c=relaxed/simple;
	bh=c/zGYdb7SNr4xSTl7tzKhmEzxuPy3qwt/E0XSORa1T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rivtoqSDH0IsxIWOJYXonbA/w0JSeTA6G92KuMQAG5WITh+vbKsc8J3WUu8q5pOLYEYdgZ+RJ2AA3Rki9sC2oyZggFEd37YLPGIxDrdnqws3NNr8IPd3aZhLYOdYv31huYWToYD8jbb3UfSGRJFhwHJW6KItAsTE/+KnXFoCriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RtWyTUWF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RtWyTUWF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635GlcG93095729;
	Mon, 6 Apr 2026 06:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KxHFQpQTEAsHtUZ1N
	o1H682IzSQ+rJmhhqSdd0gwwRc=; b=RtWyTUWFZZNi4oysoDlO41/TWAhWDg/Y1
	LiBFAcIxf7eBCHWTHUME+E6zQuAZ5S5o9W0qjhWpP24ypMYzsM5zYUF437Ekz0K/
	3JK6MUwox93ognnFlWmfHWX3GB68SgPYDiW5QWmvGYM/Ir/bBNilNduE8iFr7F9u
	96rbf/HkrIIVex/2xAjcgQmmrAohCaM1Z7VkKli8ymOQlMz6sr9UmH5sq60NrDH4
	9NOzcTpFtntkKQXnscOKCr1aRM48zilMqzxiejHtwLItByOfkuMdkIYvJpSPtp3n
	1xsCkG3Es0cN5ZPqZSx6oZ1qj61f0zffX4vs106Kbv88xlMSO+bKg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2nf47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 06:44:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6364sTZx021109;
	Mon, 6 Apr 2026 06:44:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdbybrrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 06:44:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6366iOVj20578934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 06:44:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EABCC58061;
	Mon,  6 Apr 2026 06:44:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39C5E58057;
	Mon,  6 Apr 2026 06:44:23 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 06:44:23 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v3 1/3] KVM: s390: Add map/unmap ioctl and clean mappings post-guest
Date: Mon,  6 Apr 2026 08:44:17 +0200
Message-ID: <20260406064419.14384-2-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406064419.14384-1-freimuth@linux.ibm.com>
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA1OCBTYWx0ZWRfX2JB5bDP8hxva
 SW01x5F8e+byOP9khIIObP9PqZiVjgRys6AB/KWMtIcODLDAxj2Ergue+ByyiM45Gz4OhrxtC1A
 Gl4X60AYRG9vVftUckK+W/WXKxZz11h6CL/UWmOd96zebwougs2DEFRUS4OFXBegY803U9r87rM
 jQANlTgABC+14qekzm9HEhIRc7yyncDi8uJw0YcB7Kn/wosCocTDbE2YJmRDIXSAtJXfOPpp+jh
 MplNV5nieBY/oj2pi5bf9i5wYdyXdimdko4uL0y1cqDJYYphyJRQOhnV2QgwoHuOH/EafUzdYE0
 46EPYq7NqMcBelmvRCXD8y4VbOWNVUyrWlthux5rT4lEC0I9+kYeShcIlA6vk6ClEDucl426DrB
 a773Cip3ohowOT4fA+xuaOwhbIgN/60VSoS26W4NM8VzDiIR4drqHnT8D90oSOZRH49YbjoEMTg
 /juffqNgFQQJrVx2q1w==
X-Proofpoint-GUID: gvL-BebWAO0seKySbuM2g6Gq1Hxq0QK4
X-Proofpoint-ORIG-GUID: gvL-BebWAO0seKySbuM2g6Gq1Hxq0QK4
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d3564a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gs1mDF41wL2eXU8JTBIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060058

S390 needs map/unmap ioctls, which map the adapter set
indicator pages, so the pages can be accessed when interrupts are
disabled. The mappings are cleaned up when the guest is removed.

Map/Unmap ioctls are fenced in order to avoid the longterm pinning
in Secure Execution environments. In Secure Execution
environments the path of execution available before this patch is followed.

Statistical counters to count map/unmap functions for adapter indicator
pages are added. The counters can be used to analyze
map/unmap functions in non-Secure Execution environments and similarly
can be used to analyze Secure Execution environments where the counters
will not be incremented as the adapter indicator pages are not mapped.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   5 +
 arch/s390/kvm/interrupt.c        | 151 +++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.c         |  27 ++++++
 3 files changed, 157 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3039c88daa63..a078420751a1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -448,6 +448,8 @@ struct kvm_vcpu_arch {
 struct kvm_vm_stat {
 	struct kvm_vm_stat_generic generic;
 	u64 inject_io;
+	u64 io_390_adapter_map;
+	u64 io_390_adapter_unmap;
 	u64 inject_float_mchk;
 	u64 inject_pfault_done;
 	u64 inject_service_signal;
@@ -479,6 +481,9 @@ struct s390_io_adapter {
 	bool masked;
 	bool swap;
 	bool suppressible;
+	spinlock_t maps_lock;
+	struct list_head maps;
+	unsigned int nr_maps;
 };
 
 #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7cb8ce833b62..47bd6361c849 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2426,6 +2426,9 @@ static int register_io_adapter(struct kvm_device *dev,
 	if (!adapter)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&adapter->maps);
+	spin_lock_init(&adapter->maps_lock);
+	adapter->nr_maps = 0;
 	adapter->id = adapter_info.id;
 	adapter->isc = adapter_info.isc;
 	adapter->maskable = adapter_info.maskable;
@@ -2450,12 +2453,109 @@ int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
 	return ret;
 }
 
+static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
+{
+	struct mm_struct *mm = kvm->mm;
+	struct page *page = NULL;
+	int locked = 1;
+
+	if (mmget_not_zero(mm)) {
+		mmap_read_lock(mm);
+		get_user_pages_remote(mm, uaddr, 1, FOLL_WRITE,
+				      &page, &locked);
+		if (locked)
+			mmap_read_unlock(mm);
+		mmput(mm);
+	}
+
+	return page;
+}
+
+static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
+{
+	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
+	struct s390_map_info *map;
+	unsigned long flags;
+	int ret;
+
+	if (!adapter || !addr)
+		return -EINVAL;
+
+	map = kzalloc_obj(*map, GFP_KERNEL_ACCOUNT);
+	if (!map)
+		return -ENOMEM;
+
+	map->page = get_map_page(kvm, addr);
+	if (!map->page) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&map->list);
+	map->guest_addr = addr;
+	map->addr = addr;
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
+		list_add_tail(&map->list, &adapter->maps);
+		adapter->nr_maps++;
+		ret = 0;
+	} else {
+		put_page(map->page);
+		ret = -EINVAL;
+	}
+	spin_unlock_irqrestore(&adapter->maps_lock, flags);
+out:
+	if (ret)
+		kfree(map);
+	return ret;
+}
+
+static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
+{
+	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
+	struct s390_map_info *map, *tmp;
+	unsigned long flags;
+	int found = 0, idx;
+
+	if (!adapter || !addr)
+		return -EINVAL;
+
+	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
+		if (map->guest_addr == addr) {
+			spin_lock_irqsave(&adapter->maps_lock, flags);
+			found = 1;
+			adapter->nr_maps--;
+			list_del(&map->list);
+			spin_unlock_irqrestore(&adapter->maps_lock, flags);
+			idx = srcu_read_lock(&kvm->srcu);
+			mark_page_dirty(kvm, map->addr >> PAGE_SHIFT);
+			set_page_dirty_lock(map->page);
+			srcu_read_unlock(&kvm->srcu, idx);
+			put_page(map->page);
+			kfree(map);
+			break;
+		}
+	}
+
+	return found ? 0 : -ENOENT;
+}
+
 void kvm_s390_destroy_adapters(struct kvm *kvm)
 {
 	int i;
+	struct s390_map_info *map, *tmp;
 
-	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++)
+	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
+		if (!kvm->arch.adapters[i])
+			continue;
+		list_for_each_entry_safe(map, tmp,
+					 &kvm->arch.adapters[i]->maps, list) {
+			list_del(&map->list);
+			put_page(map->page);
+			kfree(map);
+		}
 		kfree(kvm->arch.adapters[i]);
+	}
 }
 
 static int modify_io_adapter(struct kvm_device *dev,
@@ -2463,7 +2563,8 @@ static int modify_io_adapter(struct kvm_device *dev,
 {
 	struct kvm_s390_io_adapter_req req;
 	struct s390_io_adapter *adapter;
-	int ret;
+	__u64 host_addr;
+	int ret, idx;
 
 	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
 		return -EFAULT;
@@ -2477,14 +2578,30 @@ static int modify_io_adapter(struct kvm_device *dev,
 		if (ret > 0)
 			ret = 0;
 		break;
-	/*
-	 * The following operations are no longer needed and therefore no-ops.
-	 * The gpa to hva translation is done when an IRQ route is set up. The
-	 * set_irq code uses get_user_pages_remote() to do the actual write.
-	 */
 	case KVM_S390_IO_ADAPTER_MAP:
 	case KVM_S390_IO_ADAPTER_UNMAP:
-		ret = 0;
+		/* If in Secure Execution mode do not long term pin. */
+		mutex_lock(&dev->kvm->lock);
+		if (kvm_s390_pv_is_protected(dev->kvm)) {
+			mutex_unlock(&dev->kvm->lock);
+			return 0;
+		}
+		idx = srcu_read_lock(&dev->kvm->srcu);
+		host_addr = gpa_to_hva(dev->kvm, req.addr);
+		if (kvm_is_error_hva(host_addr)) {
+			srcu_read_unlock(&dev->kvm->srcu, idx);
+			return -EFAULT;
+		}
+		srcu_read_unlock(&dev->kvm->srcu, idx);
+		if (req.type == KVM_S390_IO_ADAPTER_MAP) {
+			dev->kvm->stat.io_390_adapter_map++;
+			ret = kvm_s390_adapter_map(dev->kvm, req.id, host_addr);
+			mutex_unlock(&dev->kvm->lock);
+		} else {
+			dev->kvm->stat.io_390_adapter_unmap++;
+			ret = kvm_s390_adapter_unmap(dev->kvm, req.id, host_addr);
+			mutex_unlock(&dev->kvm->lock);
+		}
 		break;
 	default:
 		ret = -EINVAL;
@@ -2730,24 +2847,6 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
 	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
 }
 
-static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
-{
-	struct mm_struct *mm = kvm->mm;
-	struct page *page = NULL;
-	int locked = 1;
-
-	if (mmget_not_zero(mm)) {
-		mmap_read_lock(mm);
-		get_user_pages_remote(mm, uaddr, 1, FOLL_WRITE,
-				      &page, &locked);
-		if (locked)
-			mmap_read_unlock(mm);
-		mmput(mm);
-	}
-
-	return page;
-}
-
 static int adapter_indicators_set(struct kvm *kvm,
 				  struct s390_io_adapter *adapter,
 				  struct kvm_s390_adapter_int *adapter_int)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d7838334a338..4eada48c6e27 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -68,6 +68,8 @@
 const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_COUNTER(VM, inject_io),
+	STATS_DESC_COUNTER(VM, io_390_adapter_map),
+	STATS_DESC_COUNTER(VM, io_390_adapter_unmap),
 	STATS_DESC_COUNTER(VM, inject_float_mchk),
 	STATS_DESC_COUNTER(VM, inject_pfault_done),
 	STATS_DESC_COUNTER(VM, inject_service_signal),
@@ -2491,6 +2493,30 @@ static int kvm_s390_pv_dmp(struct kvm *kvm, struct kvm_pv_cmd *cmd,
 	return r;
 }
 
+static void kvm_s390_unmap_all_adapters_pv(struct kvm *kvm)
+{
+	unsigned long flags;
+	struct s390_map_info *map, *tmp;
+	int i, idx;
+
+	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
+		if (!kvm->arch.adapters[i])
+			continue;
+		list_for_each_entry_safe(map, tmp,
+					 &kvm->arch.adapters[i]->maps, list) {
+			spin_lock_irqsave(&kvm->arch.adapters[i]->maps_lock, flags);
+			list_del(&map->list);
+			spin_unlock_irqrestore(&kvm->arch.adapters[i]->maps_lock, flags);
+			idx = srcu_read_lock(&kvm->srcu);
+			mark_page_dirty(kvm, map->addr >> PAGE_SHIFT);
+			set_page_dirty_lock(map->page);
+			srcu_read_unlock(&kvm->srcu, idx);
+			put_page(map->page);
+			kfree(map);
+		}
+	}
+}
+
 static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 {
 	const bool need_lock = (cmd->cmd != KVM_PV_ASYNC_CLEANUP_PERFORM);
@@ -2507,6 +2533,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		if (kvm_s390_pv_is_protected(kvm))
 			break;
 
+		kvm_s390_unmap_all_adapters_pv(kvm);
 		mmap_write_lock(kvm->mm);
 		/*
 		 * Disable creation of new THPs. Existing THPs can stay, they
-- 
2.52.0

