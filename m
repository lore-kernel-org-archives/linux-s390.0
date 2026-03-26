Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF35393DE0;
	Thu, 26 Mar 2026 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489378; cv=none; b=Rc9gllkkMFuqsECL4/Z4eaNC2+N2wxYFvGIUWK1zpUrtOc3QYNG5LRMTagdOt3pPIKBbbdCkMtwl9NI98v4qhCFxc7uGuLpmHGKySmidCyci0mJ8Jc/cisVjWelKaigZCX/qF7AIe8uJqeGWtA+SvzW3HNFI1aUSdkIzICk9GcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489378; c=relaxed/simple;
	bh=oFVfyAybCLuvnSZnG5NwXekigpGQ84BVPfYVC5gp5og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exAZ/8foCy4aRNv8p/yWP1Tu247i1ozbGvLLo+DtZxaTDO+4Hws6xguEt89bseRUV4GxsOj17ticr2Tb6EaQhIrwdoZEO09uo9/QjWVF5DYHaOTZM7MvmZmkO7tQzUL/ulgTrrAnhzvFMeYorAM/M1xWWpT63mIpOOvHl5RcMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sFiwGO2v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sFiwGO2v"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBM9bW569186;
	Thu, 26 Mar 2026 01:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yJyn5h9bbxbLbCWiq
	tllROHdlzqkrnAAGZ7S7iCEd6k=; b=sFiwGO2vXsIN+WfPW68szNxYJ8zXTJ/Ue
	g2zYolx6GA5YJRhh0I0i5rF4LPT+4QhsPqBTVNTWP3SB3r0WRCKIlx5R30KWhqgG
	rRuh8pii5lZX7vUo8X3Vzd9rKVRwnj4MKomCWcYr4bB3baTWojMRiVk+b1A+Tl7f
	BgPOJ3kGANadH/DLQQrFe3Y4ejJLrnp5VbyN5njsPJZ2h9NHFw9/wcu9L8CQDhXU
	2JGUZKtWCAyPISO6yMo5c1Z/fAcpaTJRenQ019I4iWFfAaRVDKxZOD1pZC62zXG1
	UOE+NYAOJyRsLFojMeRsZBfoYRMVlE7tpptHCDHak425GARlOKTkA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv28mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:42:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q0ZFkd008749;
	Thu, 26 Mar 2026 01:42:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nns1e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:42:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62Q1gpnE26083956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 01:42:51 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75BD75805B;
	Thu, 26 Mar 2026 01:42:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4872358059;
	Thu, 26 Mar 2026 01:42:50 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 01:42:50 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v2 1/3] KVM: s390: Add map/unmap ioctl and clean mappings post-guest
Date: Thu, 26 Mar 2026 02:42:45 +0100
Message-ID: <20260326014247.2085-2-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326014247.2085-1-freimuth@linux.ibm.com>
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7Gb2wnxNpdtcrkuMkOE0wNxK1nZcSuQm
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c48f1d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=axuhncQ0aV2LBzSxV34A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAwOCBTYWx0ZWRfX1hxm6/IdanyJ
 7QReBRNbwxDqW9e9WJnkhWqWzyOm3PKk/CH5iqjY7z36YnhGkJnX2ChipO3pTrLdzsfg4iYTHYi
 N7dMHXnFhGhO7BZvJxRsMcO1lb2HfN2iRLbfFQIXX0x59+RtahWXvxwk3GXM2oMTpdIf3ND9y+o
 kHYDMWr8QWMOvSWw5W6cqivd2OY0QxrtD6urIBPhb+GzBB3d1u5Qco9YenPzPh2RQVE+WsI6zkR
 JYRP50xB2cn0QfPTw8s7BJQkgbooX4mIRNTJ3QmoXbCkOA30a1039BQP0oQLfZCtIh6PfQz+YU9
 oVLeiwtd5cqlpW4rBo0mrNa6rSoA/AJMabNJXTsRueEqc7wxk8D209ioXHLLuVGGDTgEcfPmce0
 XmGeg1Pko0hFJM0uqPYYAXOjRjIGJVKPTylyT0RdqW1+aW3AI2EUaC70/1YEIfJYUedyI0rDhp+
 yPqEbJzBsn1mMO/I/qA==
X-Proofpoint-GUID: 7Gb2wnxNpdtcrkuMkOE0wNxK1nZcSuQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_07,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260008

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
 arch/s390/include/asm/kvm_host.h |   5 ++
 arch/s390/kvm/interrupt.c        | 145 +++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.c         |  20 +++++
 3 files changed, 144 insertions(+), 26 deletions(-)

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
index 7cb8ce833b62..fce170693ff3 100644
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
@@ -2450,12 +2453,104 @@ int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
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
+	map = kzalloc_obj(*map, GFP_KERNEL);
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
+	if (adapter->nr_maps++ < MAX_S390_ADAPTER_MAPS) {
+		list_add_tail(&map->list, &adapter->maps);
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
+	int found = 0;
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
+			put_page(map->page);
+			kfree(map);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
@@ -2463,7 +2558,8 @@ static int modify_io_adapter(struct kvm_device *dev,
 {
 	struct kvm_s390_io_adapter_req req;
 	struct s390_io_adapter *adapter;
-	int ret;
+	__u64 host_addr;
+	int ret, idx;
 
 	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
 		return -EFAULT;
@@ -2477,14 +2573,29 @@ static int modify_io_adapter(struct kvm_device *dev,
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
+		mutex_unlock(&dev->kvm->lock);
+		idx = srcu_read_lock(&dev->kvm->srcu);
+		host_addr = gpa_to_hva(dev->kvm, req.addr);
+		if (kvm_is_error_hva(host_addr)) {
+			srcu_read_unlock(&dev->kvm->srcu, idx);
+			return -EFAULT;
+			}
+		srcu_read_unlock(&dev->kvm->srcu, idx);
+		if (req.type == KVM_S390_IO_ADAPTER_MAP) {
+			dev->kvm->stat.io_390_adapter_map++;
+			ret = kvm_s390_adapter_map(dev->kvm, req.id, host_addr);
+		} else {
+			dev->kvm->stat.io_390_adapter_unmap++;
+			ret = kvm_s390_adapter_unmap(dev->kvm, req.id, host_addr);
+		}
 		break;
 	default:
 		ret = -EINVAL;
@@ -2730,24 +2841,6 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
index b2c01fa7b852..4b1820bcead1 100644
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
@@ -2491,6 +2493,23 @@ static int kvm_s390_pv_dmp(struct kvm *kvm, struct kvm_pv_cmd *cmd,
 	return r;
 }
 
+static void kvm_s390_unmap_all_adapters_pv(struct kvm *kvm)
+{
+	int i;
+	struct s390_map_info *map, *tmp;
+
+	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
+		if (!kvm->arch.adapters[i])
+			continue;
+		list_for_each_entry_safe(map, tmp,
+					 &kvm->arch.adapters[i]->maps, list) {
+			list_del(&map->list);
+			put_page(map->page);
+			kfree(map);
+		}
+	}
+}
+
 static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 {
 	const bool need_lock = (cmd->cmd != KVM_PV_ASYNC_CLEANUP_PERFORM);
@@ -2503,6 +2522,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 
 	switch (cmd->cmd) {
 	case KVM_PV_ENABLE: {
+		kvm_s390_unmap_all_adapters_pv(kvm);
 		r = -EINVAL;
 		if (kvm_s390_pv_is_protected(kvm))
 			break;
-- 
2.52.0

