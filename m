Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE704219E8;
	Mon, 11 May 2026 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516103; cv=none; b=GpVYYokD29IcAuGfmw4dua+8efUdhD7tTjKwrbytpsYC2ROQ/E95Z1Eruslq9InSFZZgvNijcVr8sF532PbsHh6Rpug8rsixdOuYrB3rA2u9pKjy19Rf0SRufHZVanXdJS3YP5NfXA2gYINsQVJenFYr93Ho7XNo8Sg0nnCl2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516103; c=relaxed/simple;
	bh=HMwAiZtYipVdQYLlWBs2AS8R6QzJJVI7kY9oJr2SxYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8QwTacsgIfnwyBbqdUYlB8ydRObFJl9E7xWcHYoQjsgMJIP92mZhqGp5CmPmJSdCHv/Sj+Wx+SuhWTwuhGQmH3Dyi08YGP3L1hienATyntCnUV70dGt68hwkKSpcw64J3vAIh+mgMCGptLDu52779IigM+hYKOPcIyFwmwTojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LOs3v66m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LOs3v66m"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BEMMxA3808092;
	Mon, 11 May 2026 16:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Pv3maWecD9u3COqH+
	6A89VgVxDBuoqFZT4+3PsNTADI=; b=LOs3v66mxV0gr8jniAnOdLMGopNt1wZV/
	5iJZjcpHzfmYquSH1egNHD0dzuXPdkl1KTWbppv14n82wHVW7QHmJknt0y1MakYg
	jX39sjFRcje+IAGPrfd4EacnC08yicr5Tj8w/a3Op0EsZMDrsK+tP1xBEEdOZHZ9
	7HlX+pqcEdyMNAa4gPUeDDjOau/wftVwDXTOmZhhQrLh+dOfVZg5DlJFyIx96w4a
	HShIH0yqeiJ/NvVH+58caGbQUhQAs1k7cBrlefcWho2WDnyE4RWI8oPiuXUUVX+v
	HhQRMhtf083Xtu23P+g3vmqMiD5/k7mhDStyKYu0yfm+DGarWO09w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4s56n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 16:14:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BFsXOH002457;
	Mon, 11 May 2026 16:14:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvx4bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 16:14:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BGEsA623134842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 16:14:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B11635805C;
	Mon, 11 May 2026 16:14:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C28A58054;
	Mon, 11 May 2026 16:14:53 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 16:14:53 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v6 1/4] KVM: s390: Add map/unmap ioctl and clean mappings post-guest
Date: Mon, 11 May 2026 18:14:48 +0200
Message-ID: <20260511161451.209464-2-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511161451.209464-1-freimuth@linux.ibm.com>
References: <20260511161451.209464-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a020081 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8ZgC-7A039QE7m0hxJcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NCBTYWx0ZWRfXx2l/2rfRmhhZ
 4a/Tn+qVK8GOYcPqgkLtxmA0nDcVySvySPhhvnVT0rSc+2G67rVWCN+bdOfGW7ZVNf4Gr97+S1A
 rDw1Ab7lyK4Ik6d7isupb0JhU3szoXcCF0ozXlEK4wz0YdJxSC9R82HBR9jiziZkRMRcgLzw5E/
 g5Rmv30Jot+Ej8QXci0MjpUt3Lbz+zEo3xBn700tuOe01WlPzu2zx1gm3lEfQmxqRsGACJk167y
 DYoeurl8BO4ipJATmXZN4NrcwEAz9sGgwui63gzJNs7GrDP/EqJaa0/D9Pa2LIzyrgxJiAnPePp
 O5qC/ZkggEIlV5yNDuV5L8kO9Hf8gnz9UcsnHJoCthiOBbrmy6nrAqwlh10lpj17pSLTXcUAHsE
 9vwIRMVTcVRoF8XAhoZpIuBchd0PfFDrZ7KCmA6S4bBMMMymiWI7Lk2IWwP5ZUOW2I4rUZvEP67
 uexGa83uZ09AdOCza8A==
X-Proofpoint-GUID: zFRY8zgJxQ7LlpUrK7U_Q4cUFfajKca0
X-Proofpoint-ORIG-GUID: zFRY8zgJxQ7LlpUrK7U_Q4cUFfajKca0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110174

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
 arch/s390/kvm/interrupt.c        | 192 ++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.c         |   8 ++
 arch/s390/kvm/kvm-s390.h         |   2 +
 4 files changed, 177 insertions(+), 30 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8a4f4a39f7a2..fbb2406b31d2 100644
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
+	raw_spinlock_t maps_lock;
+	struct list_head maps;
+	unsigned int nr_maps;
 };
 
 #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 07f59c3b9a7b..96ead830c35f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2429,6 +2429,9 @@ static int register_io_adapter(struct kvm_device *dev,
 	if (!adapter)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&adapter->maps);
+	raw_spin_lock_init(&adapter->maps_lock);
+	adapter->nr_maps = 0;
 	adapter->id = adapter_info.id;
 	adapter->isc = adapter_info.isc;
 	adapter->maskable = adapter_info.maskable;
@@ -2453,12 +2456,151 @@ int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
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
+	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
+	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
+		list_add_tail(&map->list, &adapter->maps);
+		adapter->nr_maps++;
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+	raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
+	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
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
+	raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
+		raw_spin_lock_irqsave(&adapter->maps_lock, flags);
+		list_splice_init(&adapter->maps, &local_list);
+		adapter->nr_maps = 0;
+		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
@@ -2480,14 +2622,22 @@ static int modify_io_adapter(struct kvm_device *dev,
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
@@ -2733,24 +2883,6 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
@@ -2760,12 +2892,12 @@ static int adapter_indicators_set(struct kvm *kvm,
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
 
@@ -2784,8 +2916,8 @@ static int adapter_indicators_set(struct kvm *kvm,
 	set_page_dirty_lock(summary_page);
 	srcu_read_unlock(&kvm->srcu, idx);
 
-	put_page(ind_page);
-	put_page(summary_page);
+	unpin_user_page(ind_page);
+	unpin_user_page(summary_page);
 	return summary_set ? 0 : 1;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e09960c2e6ed..74f453f039a3 100644
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
@@ -2497,6 +2499,11 @@ static int kvm_s390_pv_dmp(struct kvm *kvm, struct kvm_pv_cmd *cmd,
 	return r;
 }
 
+static void kvm_s390_unmap_all_adapters_pv(struct kvm *kvm)
+{
+	kvm_s390_unmap_all_adapters(kvm);
+}
+
 static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 {
 	const bool need_lock = (cmd->cmd != KVM_PV_ASYNC_CLEANUP_PERFORM);
@@ -2513,6 +2520,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		if (kvm_s390_pv_is_protected(kvm))
 			break;
 
+		kvm_s390_unmap_all_adapters_pv(kvm);
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
2.52.0

