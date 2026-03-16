Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972218C2C;
	Mon, 16 Mar 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684267; cv=none; b=o2DIPU/jE69rEovzA2bDi4s9YFtOLiHM0X4Lc3yUgLxNkawmaedEkmBhmoaRWILqQlQL1Q3SiC8pWBeeJuz4wMFtxWcgpRmAldMzVRQbcrniDt5Ic/Q1eFwsh4Owz/h/yDbA/YzZlPkDx+8NJg82u7Xm3ix7hzdLDP4wxO4XmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684267; c=relaxed/simple;
	bh=36+QLWonRIKyIEas5xtzxkqGWvyoyckDxHUivQAA5DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5neFmjWmewhrpnF9ZYe/BSzuWjwOKpqz6z9wwgjxcT6MRH/hNOe65iAvj7mh6gSFJ+90UvWIVFwtFMgfz6l+GkolQFx0Gcjwm06o4iMfZiGqefojAGC/GWvg2JqJZET9yXM5PKNt9hm3jZW0x06eaCxq37psz8zweHG7gfovp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aQFdMnRj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aQFdMnRj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GCtfHC412294;
	Mon, 16 Mar 2026 18:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AFot0+WBqw/J+cfc1
	wuJAqFpyfZGRdCUO7FXjQSbbfU=; b=aQFdMnRjJSFuMIdOYiphjaObAPQMpjruB
	nXa1F9wrRt88cVkMU6qyCBe9Yw1jaBLDDdx20tBSPP4Wfx2Tdsv+n/lLr1Y0vOWy
	j4GqzvBKeW1g8v4e5H9LJHQPONCn8pFuS6thTlrLK6fJSTqTa14cObO9HGQn5hrQ
	6+HZ7fAsHqIrtlikCtOxPcQ1XElVKQ7v1BHd07gJ4vIqJdJN6Fx5ASE/VlhowD3d
	fScF0JrqI8LjBV73Vz5o/971ni/To0p3iymS2CO9720QwG2uCRmH2DXxM+xebeIA
	9iJa3q4Rf55e/LV7gOYGqBvFhj65nY5s0sgIQ1LvXEqINbGI1A/9Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64h7ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GGZP68028452;
	Mon, 16 Mar 2026 18:04:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq15m1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4K2W22085914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C475920043;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A55652004D;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 03/10] KVM: s390: Convert shifts to gpa_to_gfn()
Date: Mon, 16 Mar 2026 16:23:50 +0000
Message-ID: <20260316180310.17765-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316180310.17765-1-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p2W9ZGR_OzRq1YVKxJVtqhnC5LUd_QM-
X-Proofpoint-GUID: p2W9ZGR_OzRq1YVKxJVtqhnC5LUd_QM-
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b84629 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=RVVPrAsdut6_BalKNioA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX8DSIjmGVyMXS
 Wg8D/AJypjeVkJ6jl4uFxNzS30D58LD7DCKIVuqYjg3I3CmH/Y9H/mEl7W5293yILpAfS3NjbXm
 4jmhJyXtMATIgSOHeTqC2/zon+qnLQh5RzzXABD3vv8Ppv2zmRoK93mn4KoYyJZjeDcAdVfpbqV
 s8gn8sT0KILanBbV7XVjGMpfLcnBSnbgCJPzIqEg32oAfhvONahHaSaXtrkSRhz4QP97Epgx5yj
 k9xab3jnUi/YIYzJ9Tzgs48nJxz+oi6/08dq1N8GpudGxp10Ja4V06MGy3N5phisZONHFCvbqq6
 dIrKex4cZIxxEbxioWAtaiXX5k33tmcvXadiDfCoGBz4M7+LUjJsguNnZJl5W2uvTC/DqMjLToi
 7FIVU/O9k7Ru1jmJNdw//x7DsaOIG7EdF3AvFJ4QyNSDYtYdX2bMZP64VjvVgc7uelXia2MSWg6
 qSTJKqwkG5w5AX+SvIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160139

Not only do we get rid of the ugly shift but we have more chances to
do static analysis type checking since gpa_to_gfn() returns gfn_t.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++--
 arch/s390/kvm/priv.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 03fb477c7527..1b771276415c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2771,13 +2771,13 @@ static int adapter_indicators_set(struct kvm *kvm,
 	bit = get_ind_bit(adapter_int->ind_addr,
 			  adapter_int->ind_offset, adapter->swap);
 	set_bit(bit, map);
-	mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
 	set_page_dirty_lock(ind_page);
 	map = page_address(summary_page);
 	bit = get_ind_bit(adapter_int->summary_addr,
 			  adapter_int->summary_offset, adapter->swap);
 	summary_set = test_and_set_bit(bit, map);
-	mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
 	set_page_dirty_lock(summary_page);
 	srcu_read_unlock(&kvm->srcu, idx);
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index a90fc0b4fd96..780186eb6037 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1151,7 +1151,7 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 	 */
 
 	kvm_s390_get_regs_rre(vcpu, &r1, &r2);
-	gfn = vcpu->run->s.regs.gprs[r2] >> PAGE_SHIFT;
+	gfn = gpa_to_gfn(vcpu->run->s.regs.gprs[r2]);
 	entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
 
 	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state, &dirtied);
-- 
2.51.0

