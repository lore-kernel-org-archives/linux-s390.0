Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A1282F13;
	Mon, 27 Jul 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146268; cv=none; b=K3kttM7e9BoJcvXgXhdwGu4E+0E8Q6TpZ5a0zwJnpSMdOVcHvsG53HMrOEPs0BuVExXmWt/ZL5fByTel8AnMxNm1HdX5+fDZl4waz5mkdmvScbY40578PBVdjFt4Ux183tSkRmArozeNm0MeiogMUa8RWMgiGis5S22cItYGrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146268; c=relaxed/simple;
	bh=Afvv7uPuaQ87jL5LeANQFpB0okeZwhP5qIDt9ROl8mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAjDyResXDFGByss4vtQWbzCmCkKmkQKVb2dsCqrH7Yz7vKkCZfP1SBwPuttkq4N642ggVI8KKkfydp1rJ3ZxKpyQ/KaCXuGq8xIJFh5DsR3np2zxrLG4rkLpv4Ayp5R0dGiFP++a2SKII3VJw+5z5joXf0U1yOh5zxv2b9CxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FRkmwL5+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FRkmwL5+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9UcuH1821162;
	Mon, 27 Jul 2026 09:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CTKvmeLiUaZTQyWWc
	IQR2srXN2A8tVcnckWnu9EOyUs=; b=FRkmwL5+P9PPNNP7f0+hMXDO9g3/brcD+
	TMyJzJcHu2y5RJFWjAlKhmppx9bq4yGy1sJkli60NjEYqhs/bGhcncZ5C/+Rvrsv
	FE9lMnjvmzHd8FKvpvctFpYGZpbOy8GLx/mhTy2455db7bk32NJ9SXdBC+kDFIWk
	gLbm9+j2durTe30q7k52w0pmgx1BSS+GcVHR6JJQwtSaCiSyBzPNvMhCIwsVrcO4
	zBM0F1OnU0YJF3eTEnvP1NPJLcQH6Ll1HhM8nqmKB4LMcDGAXHsStrifSFEjq02+
	vohFcQTLE2ynVblpbr7vasDU0+8C5JSm3JxvxYWd54dFewQRcWJ2g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77c79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9uOws023294;
	Mon, 27 Jul 2026 09:57:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg4nf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9vfCJ3277714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:57:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB96F5805C;
	Mon, 27 Jul 2026 09:57:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6912F58051;
	Mon, 27 Jul 2026 09:57:39 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:57:39 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [GIT PULL 7/7] KVM: s390: Fall back to short-term pinning in MAP ioctl
Date: Mon, 27 Jul 2026 11:57:20 +0200
Message-ID: <20260727095720.9150-8-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727095720.9150-1-borntraeger@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e4Bq_qggQczEkFxIkE0WWIpZaxGuC3BU
X-Proofpoint-ORIG-GUID: e4Bq_qggQczEkFxIkE0WWIpZaxGuC3BU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX/XNA7xPxB0fu
 9MoeyBSmk4yjFlKLc9yPzHp2FuNv7gDOuYQEP4xZ/LC8ZMcnG48XxFSCRCxWnbyfU/Vuezw7XCE
 zxiSg6wnDkIh7WAiwa9l3STdAojBvCVZdpXSHa7eJE6MffVkiOTaCdPB699jMS7BOmKeJf5RcPg
 urkMAcdBdPGgQSFg65vSxOEOyr9HVXNb3pyCHnnTIWE2RUfH7GjHwtUQSWK0/yRjpwvh/EfXVeP
 caE3x/ZlLkqJcV5lIGdJoYRePSnZlWlY1e18H/20vDdUi6XFGVZWu91OQ7jt7qIeViyPO491YB0
 frCHxSrclvVGeWuaUjRG2GQUsmbk9iAblW+wXnEr6oha7UVAK8wExS/EKWnNKi2yhXqT2Tsl1E/
 PX0X95BnxziW46yvPPxnmxKgBi1K4uPp74El3sYBZ9sckS/rxGRVZo3Vb+7f3HjgDEaFyV018wV
 +QlWopChAMzm1CIBFBQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a672b98 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=rQUY9zMWWlwLR9XeW8oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfXzJyezW4pFPg0
 8YRg/NxNdACDN7igqZmXYmU5PCtDzi7oKlBbphcSlwB8at3Fw2tfSTQaBxhMiGqNdQq2T7Urc77
 QwjJrj40cs1eKwib/6R7E/KPEjeLBkQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270096

From: Jaehoon Kim <jhkim@linux.ibm.com>

FOLL_LONGTERM pinning fails for some memory types, such as file-backed
guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
irqfd adapter registration fails even though interrupt delivery could
still work via the existing non-atomic path.

When FOLL_LONGTERM pinning fails, verify that the page is accessible
using a short-term pin instead. If the short-term pin succeeds, unpin
the page and add a map entry with pinned=false to preserve MAP/UNMAP
symmetry. The non-atomic irqfd path already performs short-term pinning
for interrupt delivery, so this restores the previous behavior for
memory that cannot be pinned long-term.

get_map_info() is updated to return NULL for unpinned entries so that
the atomic irqfd fast path falls back to the non-atomic path.
kvm_s390_adapter_unmap() and kvm_s390_unmap_all_adapters() skip dirty
marking and unpin for unpinned entries.

Update Documentation/virt/kvm/devices/s390_flic.rst to reflect the
new MAP/UNMAP behavior.

Fixes: c9a568838086 ("KVM: s390: Add map/unmap ioctl and clean mappings post-guest")
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 Documentation/virt/kvm/devices/s390_flic.rst | 15 +++++-
 arch/s390/include/asm/kvm_host.h             |  5 ++
 arch/s390/kvm/interrupt.c                    | 56 +++++++++++++++-----
 3 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/Documentation/virt/kvm/devices/s390_flic.rst b/Documentation/virt/kvm/devices/s390_flic.rst
index b784f8016748..983c858b444a 100644
--- a/Documentation/virt/kvm/devices/s390_flic.rst
+++ b/Documentation/virt/kvm/devices/s390_flic.rst
@@ -112,9 +112,20 @@ Groups:
       mask or unmask the adapter, as specified in mask
 
     KVM_S390_IO_ADAPTER_MAP
-      This is now a no-op. The mapping is purely done by the irq route.
+      Map an adapter indicator or summary page for long-term pinning so that
+      interrupt injection can be performed in atomic context. If long-term
+      pinning is not possible (e.g. file-backed memory), the page is verified
+      via a short-term pin and the ioctl returns success; interrupt injection
+      will use the non-atomic irqfd path with short-term pinning on each
+      interrupt. In Secure Execution mode this is a no-op and the ioctl
+      returns success.
+
     KVM_S390_IO_ADAPTER_UNMAP
-      This is now a no-op. The mapping is purely done by the irq route.
+      Unmap a previously mapped adapter indicator or summary page and release
+      the long-term pin. If the page was not long-term pinned (e.g. file-backed
+      memory), the map entry is removed and success is returned; if no prior
+      map entry exists, -ENOENT is returned. In Secure Execution mode this is
+      a no-op and the ioctl returns success.
 
   KVM_DEV_FLIC_AISM
     modify the adapter-interruption-suppression mode for a given isc if the
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index eaa34c5bd3c1..c172f9b212d1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -476,6 +476,11 @@ struct s390_map_info {
 	__u64 guest_addr;
 	__u64 addr;
 	struct page *page;
+	/*
+	 * True if the page is long-term pinned. False if long-term pinning
+	 * failed and this entry exists only to preserve MAP/UNMAP symmetry.
+	 */
+	bool pinned;
 };
 
 struct s390_io_adapter {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9e3e6b0d72ad..7514d9e2403c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2520,8 +2520,22 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
 	map->addr = host_addr;
 	map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
 	if (!map->page) {
-		ret = -EINVAL;
-		goto out;
+		/*
+		 * Long-term pinning may fail for memory types such as file-backed
+		 * memory. Verify that short-term pinning succeeds so that the
+		 * non-atomic irqfd path can handle interrupt injection.
+		 */
+		map->page = pin_map_page(kvm, host_addr, 0);
+		if (!map->page) {
+			ret = -EINVAL;
+			goto out;
+		}
+		unpin_user_page(map->page);
+		map->page = NULL;
+		map->pinned = false;
+		/* Add an entry to preserve MAP/UNMAP symmetry. */
+	} else {
+		map->pinned = true;
 	}
 	spin_lock_irqsave(&adapter->maps_lock, flags);
 	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
@@ -2532,7 +2546,7 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
 		ret = -EINVAL;
 	}
 	spin_unlock_irqrestore(&adapter->maps_lock, flags);
-	if (ret)
+	if (ret && map->page)
 		unpin_user_page(map->page);
 out:
 	if (ret)
@@ -2546,6 +2560,7 @@ static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
 	struct s390_map_info *map, *tmp, *map_to_free;
 	struct page *map_page_to_put = NULL;
 	u64 map_addr_to_mark = 0;
+	bool map_pinned = false;
 	unsigned long flags;
 	int found = 0, idx;
 
@@ -2560,6 +2575,7 @@ static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
 			list_del(&map->list);
 			map_page_to_put = map->page;
 			map_addr_to_mark = map->guest_addr;
+			map_pinned = map->pinned;
 			map_to_free = map;
 			break;
 		}
@@ -2568,11 +2584,18 @@ static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
 
 	if (found) {
 		kfree(map_to_free);
-		idx = srcu_read_lock(&kvm->srcu);
-		mark_page_dirty(kvm, map_addr_to_mark >> PAGE_SHIFT);
-		set_page_dirty_lock(map_page_to_put);
-		srcu_read_unlock(&kvm->srcu, idx);
-		unpin_user_page(map_page_to_put);
+		if (map_pinned) {
+			/*
+			 * Only long-term pinned pages need to be marked dirty
+			 * and released. Fallback entries exist only for
+			 * MAP/UNMAP symmetry.
+			 */
+			idx = srcu_read_lock(&kvm->srcu);
+			mark_page_dirty(kvm, map_addr_to_mark >> PAGE_SHIFT);
+			set_page_dirty_lock(map_page_to_put);
+			srcu_read_unlock(&kvm->srcu, idx);
+			unpin_user_page(map_page_to_put);
+		}
 	}
 
 	return found ? 0 : -ENOENT;
@@ -2598,11 +2621,13 @@ void kvm_s390_unmap_all_adapters(struct kvm *kvm)
 
 		list_for_each_entry_safe(map, tmp, &local_list, list) {
 			list_del(&map->list);
-			idx = srcu_read_lock(&kvm->srcu);
-			mark_page_dirty(kvm, map->guest_addr >> PAGE_SHIFT);
-			set_page_dirty_lock(map->page);
-			srcu_read_unlock(&kvm->srcu, idx);
-			unpin_user_page(map->page);
+			if (map->pinned) {
+				idx = srcu_read_lock(&kvm->srcu);
+				mark_page_dirty(kvm, map->guest_addr >> PAGE_SHIFT);
+				set_page_dirty_lock(map->page);
+				srcu_read_unlock(&kvm->srcu, idx);
+				unpin_user_page(map->page);
+			}
 			kfree(map);
 		}
 	}
@@ -2929,8 +2954,11 @@ static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
 		return NULL;
 
 	list_for_each_entry(map, &adapter->maps, list) {
-		if (map->addr == addr)
+		if (map->addr == addr) {
+			if (!map->pinned)
+				return NULL;
 			return map;
+		}
 	}
 	return NULL;
 }
-- 
2.53.0

