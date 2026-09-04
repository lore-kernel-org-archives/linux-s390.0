Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68B417BCA;
	Fri,  4 Sep 2026 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502024; cv=none; b=DDHcBJGjUCETfwjhJkCQbWQudTldFmk+zQ4dK35X40UGzmntF5oCrZLBV4OJyuKLD6bucrwPnv1j4IvjdMKhzlujhppymmO83U6JQu2GE9suvGH5HyRX4a/MJnJzxoejaUT6EvpV+vgQ9N/zj4YxqBjEB6p/yLlRgNdcEFK5mpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502024; c=relaxed/simple;
	bh=iUCDd09QrUQMYt4nLhXAP0Xpv8PlYs21PcsyqNlVEAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl9hk7Bp1ybCSaD/l+rcftmvW+vLQo2OnQRfmk7Gi8BLx9A5oZjPtoQimKpAzG99JLnrDJerUc+/C+DEHuN9SmmSnTq7NWgHqAeyAb6VocR/9wHIeIKEbWg6ir4Q5uBGWaj8ZNcq3JC+ljiiW/5gkayI6pJlSPK/DdB7pjDPmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z/MbjYmQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z/MbjYmQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464iRQ3254591;
	Fri, 4 Sep 2026 06:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GgueFDCpt6Hoi1O4J
	3lSCdpPFRMN3YGj+NFMN1cUpNc=; b=Z/MbjYmQT+bO6xXBtHmFXGWR3VXvp/rF4
	ldRj7CCmAhBYpRO3oSJtygrF2djFnUNOixYPd1MBPWDlU3pjREW6Z0xrT88VtrRP
	F5FdXgf8uFs58u1c26nQiIyPhdIulrF/WpQg+hBvKNh53C0n4jeiTTi/6gmWTDzD
	HMOrVteE3Y1w120rcCU5BeHQJI+Ar0Dg0OrQuUAWHdWniVOqrVk+bdR3DtotQbvL
	lWZo5pbKTJMtsEuOOWEN8wzOf9Ehhs7p07L6zufavMJYFKDPQfy66W8KyjgJd5Qm
	YJlDvsKpRD5Mdu6LmyQG2hJbJTbiIVCX1IsuEzXi0sPZEVtKiJlyg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rs0en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uLQi023419;
	Fri, 4 Sep 2026 06:06:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyguasd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466nwp37552412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7551E20049;
	Fri,  4 Sep 2026 06:06:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13C062004B;
	Fri,  4 Sep 2026 06:06:49 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 02/11] KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
Date: Fri,  4 Sep 2026 08:06:38 +0200
Message-ID: <20260904060647.562443-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a6003 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=UaRUjzXUzZSuBrJintwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXz83jhPcLP1pu
 /gesoGpvCCwtBqRrMi8te69oAv5KnFY7FoFxJ9ALDWp5GBrjTliMNWeAm4ri42U+pr5pf10RuAX
 AoKrji33HTAfo2j2Tsh2iv01PAAaz5WFEQfOpu2qxUxhPrvv5d5ou84E7E1kIpqMYzLSKSbn1mX
 lKC+qHqthV+bnWUuqIxlhK6QxmW3RWINLZ9V2pbkN6k9llgoUia1lCLcLy/XbJBe4YeAwzib9Ve
 B14WwdwEbMAS3ocMX2kgxIWFHzjSwZ8+BdZXDtaJKGI5l7u9JyZpjjrSuAJaNM29GierlWyeZGV
 +BYzNQBAyZjizgSshUZnO7NFe8uL4UA2s6LTf0RJpeZvucYSw4QYe7yjw6HkeqFFT7wMMxOl3BZ
 GWFBNIYdudxyjoetblxYLf455rFgCCQYsxT88quzomJmCyjR5Kl2WjqYFcohtZiFqApMGDHnoJ5
 UGBktb1VnD1V7MZd3Rg==
X-Proofpoint-GUID: TMbJ2ZjxYCk_dJ9kNZX8LSDwcfnDXbYm
X-Proofpoint-ORIG-GUID: TMbJ2ZjxYCk_dJ9kNZX8LSDwcfnDXbYm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX2/u269mEu3K9
 UeqCcX1nYyc7/yM7TFOe6PuFZzdfDzKk9fRFV2c0KxyG0SzmJth4RBv94h+qW8cgE6Z9oT7cRwh
 ndN00Zze5LApPO8SNBWTRY/z2+AsSNg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040054

The parameter "old" should be marked as const, to prevent compile-time
warnings.

Fixes: d487a24041c2 ("KVM: s390: Prepare gmap for a second KVM implementation")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260828115439.145885-3-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 2 +-
 arch/s390/kvm/s390/s390.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index b0839e887221..8f7e09d7d049 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5766,7 +5766,7 @@ static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_
 	return 0;
 }
 
-void kvm_s390_update_cmma_dirty(struct kvm *kvm, struct kvm_memory_slot *old)
+void kvm_s390_update_cmma_dirty(struct kvm *kvm, const struct kvm_memory_slot *old)
 {
 	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
 
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index d284a263ba70..aa0d1d062f8d 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -472,7 +472,7 @@ int __kvm_s390_mprotect_many(struct gmap *gmap, gpa_t gpa, u8 npages, unsigned i
 			     unsigned long bits);
 
 bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
-void kvm_s390_update_cmma_dirty(struct kvm *kvm, struct kvm_memory_slot *old);
+void kvm_s390_update_cmma_dirty(struct kvm *kvm, const struct kvm_memory_slot *old);
 int kvm_s390_vm_stop_migration(struct kvm *kvm);
 
 
-- 
2.55.0

