Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF93F4DD2;
	Mon, 15 Jun 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527383; cv=none; b=pN8Su8jd3r6tw7z/9fM2MIAmfBV/pziZAgdvCAwU8n9ADQZBRDOk6pBzcQIxDIpzgYrR9v1jzsklNTl4zqVFc2w/JmgjCdPTRIwo6pkoR6l8N6EZa/YLTkxbOvPbsDBaDnRjl2Y4dv2skcn3+K593cbrS9r46Yj1c1FkovLU9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527383; c=relaxed/simple;
	bh=11xb11mP20VbD7PQwclLkTUqlTiTu2b56hFd3JYTv98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBLxCwTr8+1KQqtq8Y0u34FdAAZtLrGS6ucOKod2egdaxCr3BIavRmXBYRRbxIGImgUM5pvKOnqfi1QADbR11sYdVIJQHRcsdxWEpBYEZa8axjwtvTl6FzUP82U8YCz8mR/5VpyhDv3L9bU+tmz39w+eZG6x/cvxb3NSaCp4C4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VlgPi/Ib; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VlgPi/Ib"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAo12X2198582;
	Mon, 15 Jun 2026 12:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YU75Bak3ShDt7hhea
	Yw0ybR4fSkOtb141jkoYylLKcI=; b=VlgPi/Ib1VW7IHbaXQ3AEcXw9aUVfZf2Z
	oMcVlyrW1PE1b7YJvrDR3qjtsVunl31Z4qhqJUjLwheBmNkdzhf160Ljzb5PwTSl
	c01pOE60FOhdgpE8iCXnUDv7+6DIp/2I6mMJ4XATkRvOEC9wortI/0qc5tqcxypc
	QIz1CNn/Q+a0SNtsOdlleBxt395bGzC8uqi0PTJvGmpU2egJCFy++eQaYJb8vC73
	CTsxIVW12QfL7mCCV+g2n8oNXoZouEbJ+9ZJdvXOfAXiviD5VLge6dPtYnrRdOQI
	NQ1rLXp1+yFSu43GMsjkxYaLUJwMQfkyzvNLAM/F69wtUBVVnRduw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23ngfjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYc7J004876;
	Mon, 15 Jun 2026 12:42:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvxnt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgqQk12058894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5E12004B;
	Mon, 15 Jun 2026 12:42:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15CCE20040;
	Mon, 15 Jun 2026 12:42:52 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 16/17] KVM: s390: Enable adapter_indicators_set to use mapped pages
Date: Mon, 15 Jun 2026 14:42:42 +0200
Message-ID: <20260615124243.187614-17-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2ff353 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=YjS9HVbYqgu1dYzwBkUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX/uUekl7ZVwUK
 p08araLfoeQzx9bLt1bA49wSG/v3OAla2QCuYwIyeTMFgJJIjkBkTJq32UCMxIEpZ32dSsOohER
 lW5BQP0zxYesBPyU6BCoL40tkfIuNdV3kQAa/tiOMQQeFTnS/uVOHUaF1RSiaU4mDUzdZdhUqXE
 U7gSBGahunStO9QWGbrBjcahzihJknoEiNncHqEmwQdXMoH7qh6hLDYNBMOwa1WbmTrx9KNbFs9
 VDxclIBhvdMtloHBQWcqU4bMJKoqEq9a7pnLfX7aAD6mxfeeWG3g84o63a55I7iEONp7m7SMqAU
 2yCx234G2M0lJ4T8CWr/TXFxz4qqmx3ah+plLm7EshlY9Uewnuw6JoTHMop60ELZGKRRgjChKo2
 EaG+QQMcjDcO95WhOLsKlcJgH2FJNjEHn5eJApP5bEqcBq1wdY9ay/hcoQs+WPw1A31Ceoj8ZIV
 m2sut/eQLWjdyczJs9w==
X-Proofpoint-GUID: 3Vb2tyi3TKv1CfUv1OMlUxM-3zgjZc3e
X-Proofpoint-ORIG-GUID: 3Vb2tyi3TKv1CfUv1OMlUxM-3zgjZc3e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXzFqBKh9Vfpz+
 6XNAq2r21S6rrglVHwrjD+YGqdZvppwSLS2KsFE3a4AyCBsqvEB0wH3zjD7VMQgQL+dj58xMxhe
 Y9kutEDj7IWJrOB3L3YekPKm+bWBbmk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130

From: Douglas Freimuth <freimuth@linux.ibm.com>

The s390 adapter_indicators_set function can now be optimized to use
long-term mapped pages when available so that work can be
processed on a fast path when interrupts are disabled.
If adapter indicator pages are not mapped then local mapping is
done on a slow path as it is prior to this patch. For example, Secure
Execution environments will take the local mapping path as it does prior to
this patch.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260604192755.203143-3-freimuth@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 87 ++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d11dea4cb0d3..f276f76f814f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2892,41 +2892,80 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
 	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
 }
 
+static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
+					  u64 addr)
+{
+	struct s390_map_info *map;
+
+	if (!adapter)
+		return NULL;
+
+	list_for_each_entry(map, &adapter->maps, list) {
+		if (map->addr == addr)
+			return map;
+	}
+	return NULL;
+}
+
 static int adapter_indicators_set(struct kvm *kvm,
 				  struct s390_io_adapter *adapter,
 				  struct kvm_s390_adapter_int *adapter_int)
 {
 	unsigned long bit;
 	int summary_set, idx;
-	struct page *ind_page, *summary_page;
+	struct s390_map_info *ind_info, *summary_info;
 	void *map;
+	struct page *ind_page, *summary_page;
+	unsigned long flags;
 
-	ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
-	if (!ind_page)
-		return -1;
-	summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
-	if (!summary_page) {
+	ind_page = NULL;
+
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
+		if (!ind_page)
+			return -1;
+		idx = srcu_read_lock(&kvm->srcu);
+		map = page_address(ind_page);
+		bit = get_ind_bit(adapter_int->ind_addr,
+				  adapter_int->ind_offset, adapter->swap);
+		set_bit(bit, map);
+		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
+		set_page_dirty_lock(ind_page);
+		srcu_read_unlock(&kvm->srcu, idx);
 		unpin_user_page(ind_page);
-		return -1;
+	} else {
+		map = page_address(ind_info->page);
+		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
+		set_bit(bit, map);
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+	}
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
+		if (WARN_ON_ONCE(!summary_page))
+			return -1;
+		idx = srcu_read_lock(&kvm->srcu);
+		map = page_address(summary_page);
+		bit = get_ind_bit(adapter_int->summary_addr,
+				  adapter_int->summary_offset, adapter->swap);
+		summary_set = test_and_set_bit(bit, map);
+		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
+		set_page_dirty_lock(summary_page);
+		srcu_read_unlock(&kvm->srcu, idx);
+		unpin_user_page(summary_page);
+	} else {
+		map = page_address(summary_info->page);
+		bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
+				  adapter->swap);
+		summary_set = test_and_set_bit(bit, map);
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
 
-	idx = srcu_read_lock(&kvm->srcu);
-	map = page_address(ind_page);
-	bit = get_ind_bit(adapter_int->ind_addr,
-			  adapter_int->ind_offset, adapter->swap);
-	set_bit(bit, map);
-	mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
-	set_page_dirty_lock(ind_page);
-	map = page_address(summary_page);
-	bit = get_ind_bit(adapter_int->summary_addr,
-			  adapter_int->summary_offset, adapter->swap);
-	summary_set = test_and_set_bit(bit, map);
-	mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
-	set_page_dirty_lock(summary_page);
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	unpin_user_page(ind_page);
-	unpin_user_page(summary_page);
 	return summary_set ? 0 : 1;
 }
 
-- 
2.54.0

