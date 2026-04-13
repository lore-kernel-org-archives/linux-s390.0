Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108C3BED25;
	Mon, 13 Apr 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077281; cv=none; b=g3aqZ8r/+PgxG4TyVWak3oKbQzkbx8lnChfqwpR2S3S/BwkC11qD6H3FFsZZWvqDsVM4mM0WbLy4L4AoTjBveCGtVkms6KcNr6Z2U4tm+Wnefyd/hgsC99os+MUjaDO0mVKYKI7W7H62fHtnLxt7PS8ZU9JzyC5QDNxV53QW8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077281; c=relaxed/simple;
	bh=nN3G78umpQucH6LvkRa6ikL7cqKcKQaXg3vPCSY2GSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f47j8iBfPIbgDD0IDCckJUr/BYY/ggki2tEwyNTtGZnymzfcu0BxS7FQBz498sRnDzZJgG9lTxVdnlSQuwKpYyhT6Jjg0AYNTUyIm++UI5tSamTG9uWfJqllYRhpehLszQQMKw87zjjemxoNFEa1ZjK6zyWoFochBtHvL3DVhLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gTXKx8ny; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gTXKx8ny"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CMI4vJ3253924;
	Mon, 13 Apr 2026 10:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QQoSNZmaIK3YJzzeE
	afn7Fp4fndwc9TMiqGpEQoiWTI=; b=gTXKx8nyEMO0ib/NLtqCC2rqZ1XwPrvvy
	xXOG04fK9K2vc22mv7PZQUrFzjIB2GHVBOrlZ7WxOEzIk3f6+oGHPsZJH9OUNOgf
	7lzgSvL2wqhBD2r/iQgnDg1Tf5mD2KXfat696ASXaa09waGTjXpOXuZzPsSdN5MI
	RYZq3phwub5oyE2266m6sB75fP4fu2jtcyYyOxPq40bfrK31C+IcdAuxNWmVESEz
	FgB2hQd+dTbtSA71q58ODVsXmtSk2urfda7/f5P/vZ8ADvjf05vIYqP11CNWTtJX
	6zGms8yb0rAU1B3tydoIo5SIJILLQYv+SRYUP7T92sboEjtRT3DnA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfbqkf42x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D9AA4b004179;
	Mon, 13 Apr 2026 10:47:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k4q6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAloFl59965762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 234AE20043;
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC0CE20040;
	Mon, 13 Apr 2026 10:47:49 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:49 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Steffen Eiden <seiden@linux.ibm.com>
Subject: [GIT PULL 09/12] KVM: s390: Allow 4k granularity for memslots
Date: Mon, 13 Apr 2026 12:46:37 +0200
Message-ID: <20260413104721.203024-10-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I+9Vgtgg c=1 sm=1 tr=0 ts=69dcc9dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=oKVxSbr36kwotj49NyIA:9
X-Proofpoint-GUID: Rz5YicTvHKaQxGRBvMLa7YYQSGVy_lnK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX1b2GQ8Ed0jII
 v4i+6gvqJ3mhkOMR2K7v3ebjGqU8W5YBFQJTkmFc4giIj0RAq/QbiWWLJBbwhgmAHab+DQ1Q0ta
 SJFIrdLc2Yce/A8vrYWXac6jhNGKJ9fLOtwck4ocrvwKJoZLFTaejxQtP3gdgTYAuIDlfkmxbOP
 u7QX9vG406BKEODGLLHC9QxCy4cxP8JBHFQAGP8XxfrddGmG+FZFstIcaJLkuC6omLD/dF+HNSF
 563hhGZJ8LiDM2+YjY+jeYVdxWN7l7uWLRm+OO3SkVCG1ZzoJWG2lRgKjdn7ZRon4R9JLKZmPkG
 SJRFACa2NbGWxrmi483ncek9+N8jty4XO8OTvDpll+OQK2VBNkIGGWud/j2PFGWjffW9WMgTCPg
 2h8hEG45ocnuhA3Jqhj9uzWnhL9KjR/Um9Ml73xIqoMdYUMR8Jo6mWln5EkkxHIhZDTLonqOsbP
 WvUunBP2BETycdK7AUA==
X-Proofpoint-ORIG-GUID: Rz5YicTvHKaQxGRBvMLa7YYQSGVy_lnK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130106

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Until now memslots on s390 needed to have 1M granularity and be 1M
aligned. Since the new gmap code can handle memslots with 4k
granularity and alignment, remove the restrictions.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a583c0a00efd..156878c95e06 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5642,8 +5642,6 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	gpa_t size;
-
 	if (kvm_is_ucontrol(kvm) && new->id < KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
@@ -5653,20 +5651,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 
 	if (change != KVM_MR_DELETE && change != KVM_MR_FLAGS_ONLY) {
 		/*
-		 * A few sanity checks. We can have memory slots which have to be
-		 * located/ended at a segment boundary (1MB). The memory in userland is
-		 * ok to be fragmented into various different vmas. It is okay to mmap()
-		 * and munmap() stuff in this slot after doing this call at any time
+		 * A few sanity checks. The memory in userland is ok to be
+		 * fragmented into various different vmas. It is okay to mmap()
+		 * and munmap() stuff in this slot after doing this call at any
+		 * time.
 		 */
-
-		if (new->userspace_addr & 0xffffful)
+		if (new->userspace_addr & ~PAGE_MASK)
 			return -EINVAL;
-
-		size = new->npages * PAGE_SIZE;
-		if (size & 0xffffful)
-			return -EINVAL;
-
-		if ((new->base_gfn * PAGE_SIZE) + size > kvm->arch.mem_limit)
+		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
 			return -EINVAL;
 	}
 
-- 
2.53.0

