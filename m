Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F23D1AA4;
	Fri, 24 Jul 2026 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900392; cv=none; b=i/IpT/nTEG8+LS10jrbm6ohnv9hBNPeld2Gxs9/AtzMFgsCOwdzKFKaDzkYz9SEPPsC4H3kPeaMLV+lDeQ607/VLLgMi2MjYSqxNDw8CMD2K73/+6k+doqghSrR8el7aJ0xklKPp5YxAHbYUw8SSZ9hpZPMay1oCpw+3PA9O5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900392; c=relaxed/simple;
	bh=U9+YfDYt0nzqdRokeIRV8LjYXY7TVKM3Ey1h0acFLwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkUQihrXL7102Zoe5CMt9xqNh18qNm2UBkZ1HMalOM2Hjbz6eJZk34LMLPD5q4DyYmJlA9k8qPciap5IaWE04LvMo4vMfLVjX7Sz1XM4t5TmwJZz+dI2/6xGAumW/r5y/nU82MdUIBva8rIwYdp1O2CrFF7+5PT5it1s6BBj/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rMlruLZA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rMlruLZA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODBqx61929119;
	Fri, 24 Jul 2026 13:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=k448QoSz3mdiYLT/uW04VQ/SJZapN9KjCDgXXT9nA
	qU=; b=rMlruLZAwbROTQMnG/NzF9KpBtDHuogJQl+wGAtD4Zw/LiciCc594uPZ2
	gdoo4jL/mVcPHeOkln0VptD1++R4siYJe9QCbCcDccSwph2pSm5I4pWjE8ifMchE
	FXzo7efWX4BpoxFpHfAeWF7+3ulNSELI9YngS1vqKUxCz5GumILZ4p+frS5fSyGT
	tf//rQFOdk5wfAVlAXMz37GwljH/Y4xKj6h6Qwm9ZPpvH5pTP/K8rnQYBuPeZOE9
	QQ9wADyIBFs8z3JpAY1Z6uFVSPCT4Fyj4Gf/vYKwlg9sxQREWq7yg3+eob+CYMbt
	55g+Uo4lJNxDb+orIY3d7vXozPn3w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h005jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 13:39:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODYb8N025208;
	Fri, 24 Jul 2026 13:39:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1grwh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 13:39:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ODdkIL19071558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 13:39:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FBD758054;
	Fri, 24 Jul 2026 13:39:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9819E5805D;
	Fri, 24 Jul 2026 13:39:45 +0000 (GMT)
Received: from IBM-GLTZVH3.atx-us.ibm.com (unknown [9.16.36.179])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 13:39:45 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        freimuth@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v3] KVM: s390: Fall back to short-term pinning in MAP ioctl
Date: Fri, 24 Jul 2026 08:39:43 -0500
Message-ID: <20260724133943.1664961-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a636b24 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=H3qqm0ZU6jIU6DdWDYQA:9
X-Proofpoint-ORIG-GUID: qjQt28Dx9mt9QeRxTAus-FlGHVTjEA19
X-Proofpoint-GUID: qjQt28Dx9mt9QeRxTAus-FlGHVTjEA19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExOSBTYWx0ZWRfXw1kIMoOVBWY9
 e/YdWgHmaxzxwO90Tt1/D85y9g9XN43TYdRjdZECRLBrqUR9NaCYo6YOG3oYBU0M+uiUuR3Q8q0
 cZqMAq/84I7x9ohOPtNYUBrdIDb7DbMK5xi+xehdiZmODwwdGD1kM0Vz1FCX4AoGtPHFfyjBDX+
 pJK8+1HmcmIt6AiPWPY/FvOkcOywnTC7OCqrTEUE5maxh9dmPNQsQIvOoBCH21/6XEwRg0orlor
 N8ju0rcHn0+bfimyvNzbftIQ65joyKeAkzOL8g/KRlDXkS3MVPgzKXTuUwzzVE9iNjdW51lOc3H
 4yNXkeQA8C9gXfLayLS9FqJt87iTaRLqLytvEwDxa6MD60D7GH4hnfWpeTA/q5uwIL2O2CALmQ5
 24X3D4s3LotdM66mf0y0x2oRyCEsqkWWJ8TFBIEfH4rTImnLz92eF55gi3d03cY0P2lGqUOw3xy
 97BF+73lNiE7axrUGAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExOSBTYWx0ZWRfXxxcxyFuLeihM
 plez2xIwfeLa7KyShbYREaJjnzpGiV+W5fab7KF1f9huPmyRIAGv+Cyl0zgm6bmSTSeHU5BoRpO
 efISxRKyLV4sh1QIX3lP86YUL9sgGIM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240119

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
2.43.0

