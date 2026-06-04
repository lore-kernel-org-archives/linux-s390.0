Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17238B7CD;
	Thu,  4 Jun 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601293; cv=none; b=LYMMzwY7xfa5ZLVZeU/AvVKcF0cctlTGyAW0tKi1oRTZBZvEUmHdYrnOLAASfQfy0xZQ3Z9wuML9mj1KIE6N09Wi2g4gSUGMNbeH+D5sf2g50E8oP7LBUmyKIJdXtCLwES632Er9RKgW7ZuQmduepCCIlv/EEU7wHAyLoied+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601293; c=relaxed/simple;
	bh=sa5ibd24fZPt3WFRwxb5nxihdWdMlrmCpz9SLht+jKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoEgpC5aG3XKNgW0OlUlj2YIofP4kxAbU5CVQ10yJZzsoxyP6rZN8cOPdgni6RNOj7DwTR0RLx4kuLSx3oecfLMFynhh3wSthuzJA/0Tw6syGjYGTDFrnx/rB44q5KhJ1p9nyA6s4WfGiN1helLHtVDxcWjGtcnbfau2OQt1Dnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oihoXFGZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oihoXFGZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Cn1wx3158529;
	Thu, 4 Jun 2026 19:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EsAEfmszMFVuKU9CU
	KNjhgTC73spMxJ5utdwbmweU0Q=; b=oihoXFGZeXe3DDOOXVGuMkusTJMkpFHNu
	6TNIanlHWYbKqaahSV4FzguCzwHJdT9MIFccJiK4oC0qxAN47ur7O3VKPY305tXJ
	j217LkyMpbANBIavnE5GkueiEi2AraI4SyaN9u2SOItPecQUNPjMEsyLmyGNqJuN
	3qD4HrimQIQzHqN9nhGkZr3d8u0KJ13INt121H1JUNRozrkp2piNV6IC26zrHK+7
	SK6XdWTMnZ04cFtHk7aEld4yDza0C/KMrT4a6LWVCX8Vuwh2FtZdsgPF3Cmk8vIe
	AQZewnS09aB8YQryDM/waboi8rwJoNUDTfWat6DznLYUUDYYd7fYw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaegu6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 19:28:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654JO9b6009553;
	Thu, 4 Jun 2026 19:28:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qprju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 19:28:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654JS2eL19792550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 19:28:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8101758055;
	Thu,  4 Jun 2026 19:28:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D116358043;
	Thu,  4 Jun 2026 19:28:01 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 19:28:01 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v10 1/3] KVM: s390: Add map/unmap ioctl and clean mappings post-guest
Date: Thu,  4 Jun 2026 21:27:53 +0200
Message-ID: <20260604192755.203143-2-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604192755.203143-1-freimuth@linux.ibm.com>
References: <20260604192755.203143-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a21d1c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=mVC63NhR99eSWLqgKxIA:9
X-Proofpoint-GUID: w4coxYeuG4_aqhkxxAyH-5ZkPNmBCTzO
X-Proofpoint-ORIG-GUID: w4coxYeuG4_aqhkxxAyH-5ZkPNmBCTzO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE4NyBTYWx0ZWRfX3V8KDcXPXMFW
 lY44+JD9RBjWumKI65eNldrl6wVU3qDbjtwSPwt5H5tSufwH6jYrjHjbskl3GimD+LngZN+AK37
 qcCymSKBp+Zd6b9J798tXx4st8bjdVcfQNHiuwKvR/CS/8FsKH1c88tsOZ3XiUBZLKBq+6+Jk23
 cTYCTYjoOQfnUyXQuXnpwxqJmbWHuMZdjiEbW5ZOY3k7HokGsPeUJ4hfykUb9modmbaDBi6EBJN
 UiaJ3nU2XbpNe+cAtI62bgaZpsDFKT8yH3YkSw9Y19ZhaYTP6DVVsaex5Zp0hg0gVmj/IMAk/9C
 S1J27rwEJnxnIx/bxTCNVuG7VYwVadhGlG7szYBLDTzajsLV/WrBrgJEsNtI48X+OinuOiYwaGb
 xF+tqrGL6qF7vOS4waJ0SjvBkNyPu5nO/chLKdSgWE8ZtCZir95p73yVXp57ezSpfo9qJylP+SB
 lVxgQYlVKB+GDzT6hAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040187

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
---
 arch/s390/include/asm/kvm_host.h |   5 +
 arch/s390/kvm/interrupt.c        | 227 +++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.c         |   3 +
 arch/s390/kvm/kvm-s390.h         |   2 +
 4 files changed, 194 insertions(+), 43 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8a4f4a39f7a2..0056cc9414a0 100644
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
index 3bcdbbbb6891..d066a282271e 100644
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
index e09960c2e6ed..0d39c1375de2 100644
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
@@ -2513,6 +2515,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
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

