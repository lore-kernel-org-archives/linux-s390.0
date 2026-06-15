Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2A3F4842;
	Mon, 15 Jun 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527382; cv=none; b=iKppCdt51ankz7yoj42XmZ7NxROSAqH75y13OvMF8GSbn6zuVjwO/OLHTRzA2nCs1updENg6Aidt/rC8+xeK1uTIZtv4wCFpBmhbNBuiqYOxTiIO+ijT7M2BkHrYcyvn7VKEly5VUXPbF8KBjMo5JCjyXCK42uSVkIj9gIFA1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527382; c=relaxed/simple;
	bh=5qPsMj0fJ03xicQmF2Yf34DZFMxZo+wlFnTqWRqKkxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t56anOrL9mG5WeADrX6kFuFR/6cCuERRrM2J43z6Z9FkeQNXKPOiaDMryUwpDhb8chYDW/Ik0WbbVuLMCIYPVCY9CvPESCrL/syiEIsOl+3VHlU2WUlbQFf5RE7PTcqUyr2oCYPz1JTrIjcCx1PjY796Imkl3aXTWHj0W8T4PbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EWv85jD9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EWv85jD9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAo0gU2255362;
	Mon, 15 Jun 2026 12:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XmP6H8cbvCNls4gTk
	MIxhL4GX175O1ANa0v+8NaP304=; b=EWv85jD9jONEXOZvogPc+RPwJqllhxntk
	MJrJYE1SXq0q3iWfVTYcHNVpXSzsek0LTOEhirbm4tbRwBaZ0aLvkaFv/KR6O/ll
	dHxv6n1hj0irwxdQhzYGyv5JetL790IrXXxZvmCaSDyUf3AoFrQ5VIwNWlIQpVLt
	LPGpt7b5PtukXcm9Qag4iwKIFyGnp4UnrDFLH/YPDdiCAaJj0M+KdRu2x5e6V5NE
	+QU4GQuyA4Jge7nFckYxvzWEPFzfm59NDubSuzX6vnmeZjc3OK3Et6N5wjmDbp+C
	nIWI4xrLRdbgbBz5jXA3oAlDbVFsMSURvm8V2W7Arb4ZlOE7DW2Sg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h80kud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYiBc028405;
	Mon, 15 Jun 2026 12:42:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpxqtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgq5b28115668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA4420043;
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B7520040;
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 15/17] KVM: s390: Add map/unmap ioctl and clean mappings post-guest
Date: Mon, 15 Jun 2026 14:42:41 +0200
Message-ID: <20260615124243.187614-16-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX0LiOdtcOGc4I
 gYx+IuAM43hWwdWTSMqRcjSfRcMG314KEq03UhgO9otWDC4j9swjEy+4SdctuG8ntePQkYP0OtV
 PNcZN+Kv7Ckq7ZRJOUB30OWErVh2a+o=
X-Proofpoint-ORIG-GUID: LKAQXDoK1V0iWmfAZQMQhHuO1UhTuMIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXzlwHaj3JRi9P
 S+ya1c5Ll5nmtjISeYDym/Sr0SBtQKV7pNo6M69UzHvTs6fADkf/e7PeaTVe/VZsJS+XuueFhIK
 idI4B3eSovt/Y5nNbjblvcUHkLv5I1gTQRz/K1r+tBK0c3CyyCluaCulReEwkw5XKuBBsn3FlOe
 MOlPQh9eIgXWlM6kNabXBgpQAfZbjLo4WwebDVypsbNYd7R9AnGtEsa43KvT3XwiyXjPOaJSx25
 ESDlsXCD6Ywur/hF5LNoGahYLWh5hY+AlqbXsrMGiIRR9VKprhhCUz3BNLuL7O3kirTyOu8gRvf
 +7KtSDSbTv3bjlcXi4x+MjAyiREohbdOwtpD2Lk6vi9hnoSRB+5TOicadIiHXE2DgWvlXJiCofM
 ODgirzMSAydwiO8Rp1ifwAKfPY8mD9NoiZG+sl6PVU1Jqhfr9x6vhpLlMm5hsfHZwBhidTdym8N
 AXKwSWckGn4L4QAYzjQ==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2ff352 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=mVC63NhR99eSWLqgKxIA:9
X-Proofpoint-GUID: LKAQXDoK1V0iWmfAZQMQhHuO1UhTuMIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

From: Douglas Freimuth <freimuth@linux.ibm.com>

s390 needs map/unmap ioctls, which map the adapter set
indicator pages, so the pages can be accessed when interrupts are
disabled. The mappings are cleaned up when the guest is removed.
pin_user_pages_remote is used for both the ioctl as well
as the pin-on-demand logic in adapter_indicators_set().

Map/Unmap ioctls are fenced in order to avoid the longterm pinning
in Secure Execution environments. In Secure Execution
environments the path of execution available before this patch is followed.

Statistical counters to count map/unmap functions for adapter indicator
pages are added. The counters can be used to analyze
map/unmap functions in non-Secure Execution environments and similarly
can be used to analyze Secure Execution environments where the counters
will not be incremented as the adapter indicator pages are not mapped.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260604192755.203143-2-freimuth@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   5 +
 arch/s390/kvm/interrupt.c        | 227 +++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.c         |   3 +
 arch/s390/kvm/kvm-s390.h         |   2 +
 4 files changed, 194 insertions(+), 43 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index aa4c4685f95c..4ff1ede90873 100644
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
index 07f59c3b9a7b..d11dea4cb0d3 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2411,34 +2411,46 @@ static int register_io_adapter(struct kvm_device *dev,
 {
 	struct s390_io_adapter *adapter;
 	struct kvm_s390_io_adapter adapter_info;
+	int rc = 0;
 
+	mutex_lock(&dev->kvm->lock);
 	if (copy_from_user(&adapter_info,
-			   (void __user *)attr->addr, sizeof(adapter_info)))
-		return -EFAULT;
-
-	if (adapter_info.id >= MAX_S390_IO_ADAPTERS)
-		return -EINVAL;
-
+			   (void __user *)attr->addr, sizeof(adapter_info))) {
+		rc = -EFAULT;
+		goto out;
+	}
+	if (adapter_info.id >= MAX_S390_IO_ADAPTERS) {
+		rc = -EINVAL;
+		goto out;
+	}
 	adapter_info.id = array_index_nospec(adapter_info.id,
 					     MAX_S390_IO_ADAPTERS);
 
-	if (dev->kvm->arch.adapters[adapter_info.id] != NULL)
-		return -EINVAL;
-
+	if (dev->kvm->arch.adapters[adapter_info.id] != NULL) {
+		rc = -EINVAL;
+		goto out;
+	}
 	adapter = kzalloc_obj(*adapter, GFP_KERNEL_ACCOUNT);
-	if (!adapter)
-		return -ENOMEM;
+	if (!adapter) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
+	INIT_LIST_HEAD(&adapter->maps);
+	spin_lock_init(&adapter->maps_lock);
+	adapter->nr_maps = 0;
 	adapter->id = adapter_info.id;
 	adapter->isc = adapter_info.isc;
 	adapter->maskable = adapter_info.maskable;
 	adapter->masked = false;
 	adapter->swap = adapter_info.swap;
-	adapter->suppressible = (adapter_info.flags) &
+	adapter->suppressible = adapter_info.flags &
 				KVM_S390_ADAPTER_SUPPRESSIBLE;
 	dev->kvm->arch.adapters[adapter->id] = adapter;
 
-	return 0;
+out:
+	mutex_unlock(&dev->kvm->lock);
+	return rc;
 }
 
 int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
@@ -2453,12 +2465,151 @@ int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
 	return ret;
 }
 
+static struct page *pin_map_page(struct kvm *kvm, u64 uaddr,
+				 unsigned int gup_flags)
+{
+	struct mm_struct *mm = kvm->mm;
+	struct page *page = NULL;
+	int locked = 1;
+
+	if (mmget_not_zero(mm)) {
+		mmap_read_lock(mm);
+		pin_user_pages_remote(mm, uaddr, 1, FOLL_WRITE | gup_flags,
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
+	__u64 host_addr;
+	int ret, idx;
+
+	if (!adapter || !addr)
+		return -EINVAL;
+
+	map = kzalloc_obj(*map, GFP_KERNEL_ACCOUNT);
+	if (!map)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&map->list);
+	idx = srcu_read_lock(&kvm->srcu);
+	host_addr = gpa_to_hva(kvm, addr);
+	if (kvm_is_error_hva(host_addr)) {
+		srcu_read_unlock(&kvm->srcu, idx);
+		ret = -EFAULT;
+		goto out;
+	}
+	srcu_read_unlock(&kvm->srcu, idx);
+	map->guest_addr = addr;
+	map->addr = host_addr;
+	map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
+	if (!map->page) {
+		ret = -EINVAL;
+		goto out;
+	}
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
+		list_add_tail(&map->list, &adapter->maps);
+		adapter->nr_maps++;
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+	spin_unlock_irqrestore(&adapter->maps_lock, flags);
+	if (ret)
+		unpin_user_page(map->page);
+out:
+	if (ret)
+		kfree(map);
+	return ret;
+}
+
+static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
+{
+	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
+	struct s390_map_info *map, *tmp, *map_to_free;
+	struct page *map_page_to_put = NULL;
+	u64 map_addr_to_mark = 0;
+	unsigned long flags;
+	int found = 0, idx;
+
+	if (!adapter || !addr)
+		return -EINVAL;
+
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
+		if (map->guest_addr == addr) {
+			found = 1;
+			adapter->nr_maps--;
+			list_del(&map->list);
+			map_page_to_put = map->page;
+			map_addr_to_mark = map->guest_addr;
+			map_to_free = map;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&adapter->maps_lock, flags);
+
+	if (found) {
+		kfree(map_to_free);
+		idx = srcu_read_lock(&kvm->srcu);
+		mark_page_dirty(kvm, map_addr_to_mark >> PAGE_SHIFT);
+		set_page_dirty_lock(map_page_to_put);
+		srcu_read_unlock(&kvm->srcu, idx);
+		unpin_user_page(map_page_to_put);
+	}
+
+	return found ? 0 : -ENOENT;
+}
+
+void kvm_s390_unmap_all_adapters(struct kvm *kvm)
+{
+	struct s390_map_info *map, *tmp;
+	unsigned long flags;
+	int i, idx;
+
+	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
+		struct s390_io_adapter *adapter = kvm->arch.adapters[i];
+		LIST_HEAD(local_list);
+
+		if (!adapter)
+			continue;
+
+		spin_lock_irqsave(&adapter->maps_lock, flags);
+		list_splice_init(&adapter->maps, &local_list);
+		adapter->nr_maps = 0;
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+
+		list_for_each_entry_safe(map, tmp, &local_list, list) {
+			list_del(&map->list);
+			idx = srcu_read_lock(&kvm->srcu);
+			mark_page_dirty(kvm, map->guest_addr >> PAGE_SHIFT);
+			set_page_dirty_lock(map->page);
+			srcu_read_unlock(&kvm->srcu, idx);
+			unpin_user_page(map->page);
+			kfree(map);
+		}
+	}
+}
+
 void kvm_s390_destroy_adapters(struct kvm *kvm)
 {
 	int i;
 
-	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++)
+	kvm_s390_unmap_all_adapters(kvm);
+
+	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
 		kfree(kvm->arch.adapters[i]);
+		kvm->arch.adapters[i] = NULL;
+	}
 }
 
 static int modify_io_adapter(struct kvm_device *dev,
@@ -2480,14 +2631,22 @@ static int modify_io_adapter(struct kvm_device *dev,
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
+		if (req.type == KVM_S390_IO_ADAPTER_MAP) {
+			dev->kvm->stat.io_390_adapter_map++;
+			ret = kvm_s390_adapter_map(dev->kvm, req.id, req.addr);
+		} else {
+			dev->kvm->stat.io_390_adapter_unmap++;
+			ret = kvm_s390_adapter_unmap(dev->kvm, req.id, req.addr);
+		}
+		mutex_unlock(&dev->kvm->lock);
 		break;
 	default:
 		ret = -EINVAL;
@@ -2733,24 +2892,6 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
@@ -2760,12 +2901,12 @@ static int adapter_indicators_set(struct kvm *kvm,
 	struct page *ind_page, *summary_page;
 	void *map;
 
-	ind_page = get_map_page(kvm, adapter_int->ind_addr);
+	ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
 	if (!ind_page)
 		return -1;
-	summary_page = get_map_page(kvm, adapter_int->summary_addr);
+	summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
 	if (!summary_page) {
-		put_page(ind_page);
+		unpin_user_page(ind_page);
 		return -1;
 	}
 
@@ -2784,8 +2925,8 @@ static int adapter_indicators_set(struct kvm *kvm,
 	set_page_dirty_lock(summary_page);
 	srcu_read_unlock(&kvm->srcu, idx);
 
-	put_page(ind_page);
-	put_page(summary_page);
+	unpin_user_page(ind_page);
+	unpin_user_page(summary_page);
 	return summary_set ? 0 : 1;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index de28ee1f7882..9de6edeb5ae0 100644
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
@@ -2539,6 +2541,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		if (kvm_s390_pv_is_protected(kvm))
 			break;
 
+		kvm_s390_unmap_all_adapters(kvm);
 		mmap_write_lock(kvm->mm);
 		/*
 		 * Disable creation of new THPs. Existing THPs can stay, they
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index dc0573b7aa4b..7ba885cb6bd1 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -560,6 +560,8 @@ void kvm_s390_gisa_disable(struct kvm *kvm);
 void kvm_s390_gisa_enable(struct kvm *kvm);
 int __init kvm_s390_gib_init(u8 nisc);
 void kvm_s390_gib_destroy(void);
+void kvm_s390_unmap_all_adapters(struct kvm *kvm);
+
 
 /* implemented in guestdbg.c */
 void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
-- 
2.54.0

