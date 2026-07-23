Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C81D9A5F;
	Thu, 23 Jul 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830226; cv=none; b=FLwgntbMxrTbeEpAanSAZ5ByG/njwETE+c4GCIBMT6aU9eftUdjw+3tWDzNYMwTf96KXALXOXJD3LW2VZUOPYP2DhZg1NVps47evRJ2H07uBHxR2R159ObHqhLsJenXx641efoe5GVgcFPjqF5sDRYAdy3IOMma371cdzoY/jxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830226; c=relaxed/simple;
	bh=AoSF8bkRkbISbkyfOU6ABYuMh+8+87AqaY1ZJNQ1yys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTqKkbX4WG8KSdciZvef2f2FRSMOYHkFd+HUwQbszACvs4qyPXugF6++WWbWJHpODBhcvFgrawjRbjEA1boUl8Qf/o0S5ua/jPcyPRjh6OyxPXO6T+SM1302+KXCkuElrYAlY3jHj9sQ7UXga9vTJNi7V4c2LtJEcOwRSHET9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VIDjNNxr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VIDjNNxr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHgVwm3689491;
	Thu, 23 Jul 2026 18:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XoE9d9rvQwvZtpfw0AGnP6ps6vKTllkX3tlIKwRy9
	ZM=; b=VIDjNNxr2t2C/XMUgZ9sE1dVy28U6bjkoDXQxsdbCtFugMdxbwbSJFq+r
	GlbhbyHUHy2L01iTfnkejmfHvzItMK0jUbYWF7GgEpynKSwyvwKZz8Afu1YOAaVx
	kCGHv80GfLT3C0FfP+KJvZWKCas/OnhWjdaPa6vMFbvH2e6TfnXpZHLi5ZEw8z17
	CfJT2Fo3WModByEpkx6U02NTvz0laROKOANLWfU6HINqkkPa7w+S98EdX7lGHuBX
	q+/w/Tuh9/9XTMSPTD31ztUezgGjlMgxqPPTjXST/evdGGxOLjtUGoEpVBk3G0Ky
	2I1qOqptZ8lawtszs9MrtLuMNm/gg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahgc0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:10:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NI4brD032698;
	Thu, 23 Jul 2026 18:10:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqdkvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:10:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NI9hBV3932924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:09:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98EFE5805A;
	Thu, 23 Jul 2026 18:10:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5573558051;
	Thu, 23 Jul 2026 18:10:19 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.247.15])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 18:10:19 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        freimuth@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v2] KVM: s390: Fall back to short-term pinning in MAP ioctl
Date: Thu, 23 Jul 2026 13:10:16 -0500
Message-ID: <20260723181017.1220552-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ox7zgz8KvIhzN_p4fL0KLBBwFoL47TRD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX80MbzLCsJjzg
 RGIl9fVajrGSpXiy2xy2yRQHauijx4fOj+2WQcE/e3QpBLSsRC+/HFchQtSsQfCLAlynU/HpfKe
 Z/ylnUsJL50q7Rx4+a4fMUQD2m1BSGto6oeFusmWhZfKwub5i1HsEOolB8/Rtb6cW8sAx4zlnNs
 38p1KzFV1siluvFNmdljfsVMbNyt6yD7KVY6dp1lNGHksNWcluH2Y7AX4SiqZDA343aWykMIIvp
 cx/8Mfjcd0Do/OodPqPfuHABBaR7H4UvrLxtvk3SKzye39aC6qjq9ZU1j/TXIFgnaM+zA8FelaL
 FDTmdveTpVivsDTb8mNU4sKeMKqnaftBqyF5cI+wzcMZFwrBYcvUVUTJU2Y6XZRCEl6tBvAe6nw
 AVpGSXm/rsM5EF1ZnCeuoIfbPe194Js0p87nIaHW60lMSkR38PupMofAM5fwshblBkBe/YzhR4z
 U/70A/y17iKbbZDfPmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX+bfxv72bKERl
 hM2qqkB7yWcTN5/ciV2Cei2ROVMDPY5ZyM+9nbbBOpU7ixOdkKP9q0qxgrpv3n730gJIPMI7Tqd
 AEfV0ILcQpCxbVzCu4GhZsx+XNemMoo=
X-Proofpoint-GUID: Ox7zgz8KvIhzN_p4fL0KLBBwFoL47TRD
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a62590e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=H3qqm0ZU6jIU6DdWDYQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230173

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

Fixes: adcd5b3e758b ("KVM: s390: Add map/unmap ioctl and clean mappings post-guest")
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 Documentation/virt/kvm/devices/s390_flic.rst | 11 +++-
 arch/s390/include/asm/kvm_host.h             |  5 ++
 arch/s390/kvm/interrupt.c                    | 59 +++++++++++++++-----
 3 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/Documentation/virt/kvm/devices/s390_flic.rst b/Documentation/virt/kvm/devices/s390_flic.rst
index b784f8016748..ec9aaae04e22 100644
--- a/Documentation/virt/kvm/devices/s390_flic.rst
+++ b/Documentation/virt/kvm/devices/s390_flic.rst
@@ -112,9 +112,16 @@ Groups:
       mask or unmask the adapter, as specified in mask
 
     KVM_S390_IO_ADAPTER_MAP
-      This is now a no-op. The mapping is purely done by the irq route.
+      Map an adapter indicator or summary page for long-term pinning so that
+      interrupt injection can be performed in atomic context. If long-term
+      pinning is not possible (e.g. file-backed memory), the page is verified
+      via a short-term pin and the ioctl returns success; interrupt injection
+      will use the non-atomic irqfd path with short-term pinning on each
+      interrupt. In Secure Execution mode this is a no-op.
     KVM_S390_IO_ADAPTER_UNMAP
-      This is now a no-op. The mapping is purely done by the irq route.
+      Unmap a previously mapped adapter indicator or summary page and release
+      the long-term pin. If the page was not long-term pinned (e.g. file-backed
+      memory or Secure Execution mode), this is a no-op and returns success.
 
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
index 9e3e6b0d72ad..75eacd1578ef 100644
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
@@ -2929,8 +2954,12 @@ static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
 		return NULL;
 
 	list_for_each_entry(map, &adapter->maps, list) {
-		if (map->addr == addr)
-			return map;
+		if (map->addr == addr) {
+			if (map->pinned)
+				return map;
+			else
+				return NULL;
+		}
 	}
 	return NULL;
 }
-- 
2.54.0

