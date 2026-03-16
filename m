Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F838D6B1;
	Mon, 16 Mar 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657586; cv=none; b=K8GDgzGfVg5eG07FSQ8KiwyggUsWM4C6zAJyq1JQse7f8y5bOdZbLeLjmyGIWs9YP40rbCJlACb8mAyMchsjaD+VWpvUXV8WpMtrPqusQaAVtknJcp/YgKZG4jZNMSEWHRcuEqSVcCSyXyfUm2z+8jlIT20WfpC0mYv0tZjPVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657586; c=relaxed/simple;
	bh=BcQPPEE4zZ8SAlllVDkHpHBeGJJr1WlNEW0PJ6ric5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AX+Ppn1QXukTsQnHjtAU53SQ1T9xr9FHdki5sVs7NGT1zT9jhX5hRse1YEWrTctHUC+PmZN8bjnU2xm4ub56pr8yMcySglqZ353fFkPdaYCqleIMi8+ciJPmrM6C5F3CLH+OgnVZ4yPuHNjUompc0R4fLydW/KFBVMKEegld2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N2n2FOz2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N2n2FOz2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G14p6f1189728;
	Mon, 16 Mar 2026 10:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aJhYOHrH0AuvHPoVDPvFjzFindld7XZx3170Jp9/f
	X8=; b=N2n2FOz2gbZZDJTEyuyi8h/AE5d7DQ5uJ+JLBGoVc6+asnOJcd69QYFbM
	gwu8cLjiqMYIBY0ZV5VngYxOFF6PjU5qXcrWMTb3UAe/7DNj3BElWe6JvoNy9M66
	vY44Nla8qotKG0Az8Z0nD7u5rOpun9HWPF4214NaXnrFzc2PTRlZa40Izt8RTtx4
	MNtpLgfV2rFpo8mYgJkc/zd+JF5gEMIGAqUa/RQQ4HzWKr5KZOF5dCaAqg2MdvyI
	3qNXq5/TL7rVhNA4AMO1fWlm92h0VaUl+uOMkcXyX08L3KRVgQ8kQ0FJNH8DinpV
	tYVIyOIgtcafw/ap/OWww2Kn2N0Dg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vf9nj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 10:39:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GA7Bv4028708;
	Mon, 16 Mar 2026 10:39:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk4cvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 10:39:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GAdbYf53412162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 10:39:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F3B058068;
	Mon, 16 Mar 2026 10:39:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACE9B58051;
	Mon, 16 Mar 2026 10:39:35 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 10:39:35 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH/RFC] KVM: s390: vsie: Avoid injecting machine check on signal
Date: Mon, 16 Mar 2026 11:39:34 +0100
Message-ID: <20260316103934.13368-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tEcABO-kJ9VlHrPCPsFydyvjas8EGe2s
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b7ddeb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=DMIkbmYdptnK3zE9wvgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3OCBTYWx0ZWRfX6wubGWLzgnwd
 2+sZDAlKG5q1fTnGf1Osi4UkRMk5qg5T4CYZbO1uJzanUWQ56jJmd0gHitMUTTMMb6GfMCrtn3g
 0OVGJz9Kt3zFB6PU5w9V+PeBrJghhuIw7DnWjGSOn3pKFJYsuHbLX4HOZ+yW0HXHnsVoSxwiehs
 O2vJl5/6s62ZHyqsV8QoK5StJXDa0ce9j7xnFy5cMrk8cjd0maYlgMU6ClA+1FEmtQL30gB1upd
 XkdhygMUXF+i3+6jJfeRZuU8Ex4FUi5MXJ61BuECZVEqGyeWBbx//t0Fmw4vojFmADbiuTi5Qv3
 d9LZBt15hpuZ11VZOT0q5z/ZWBM1yyQUmDS0Jrfb/5DRe1LlqZEtQPHHQFjR40VLKHQLUcoA2gj
 8fHwU/jn25Wckv7NbjmhwCg7lrqhKw5fuNAbgcVeCrI9nBFBDenxDy0/i2xkdADG95XCFgfEDlm
 KvxHfSR51wFZF1xbVYA==
X-Proofpoint-GUID: tEcABO-kJ9VlHrPCPsFydyvjas8EGe2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160078

The recent XFER_TO_GUEST_WORK change resulted in a situation, where the
vsie code would interpret a signal during work as a machine check during
SIE as both use the EINTR return code.

Fixes: 2bd1337a1295e ("KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c0d36afd4023..8e71393bb3d2 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1121,10 +1121,11 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
 	__acquires(vcpu->kvm->srcu)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	int guest_bp_isolation;
+	int skipped = 1;
 	int rc = 0;
 
 	handle_last_fault(vcpu, vsie_page, sg);
 
 	kvm_vcpu_srcu_read_unlock(vcpu);
@@ -1162,10 +1163,11 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
 				goto skip_sie;
 			goto xfer_to_guest_mode_check;
 		}
 		guest_timing_enter_irqoff();
 		rc = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
+		skipped = 0;
 		guest_timing_exit_irqoff();
 		local_irq_enable();
 	}
 
 skip_sie:
@@ -1176,11 +1178,11 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
 	if (!guest_bp_isolation)
 		clear_thread_flag(TIF_ISOLATE_BP_GUEST);
 
 	kvm_vcpu_srcu_read_lock(vcpu);
 
-	if (rc == -EINTR) {
+	if (!skipped && rc == -EINTR) {
 		kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
 		return 0;
 	}
 
 	if (rc > 0)
-- 
2.53.0

