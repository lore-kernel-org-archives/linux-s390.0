Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E6C4457A6;
	Fri, 28 Aug 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918108; cv=none; b=ohMp7lxwk1o/FXXkQbeF3I3W5iQu6ag4oT9EO/qLr/yPZqdCsx+JMmWqKl8hiHmr3jPGorVsj7gB1w8O1xLCmmLRNN9Iwgz1Z3oPXtJjRmrg17Zopi+VWne1ENKCmLYtC41RzePKHTYrArwURfvBYoYO+pXQ9/b3kYotY6SoBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918108; c=relaxed/simple;
	bh=f/bWae/hQLJZYilQXor2eUlSONxnat/edMva3cLxK3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vjq/yJEFBnihIhF838USmwNKUkFanYX9fSio2Wl/tKPqjibNGfVoghO/jkMgIhFp5jft47cwBlsPpKJjRsD5cXBATy5fMjlw/Gd7mMQ/P+lFWT3FZOTfg3ffgzS8sL3L9cn4CYYXBOavtUt4tAVtPHhnxSY48iWxf4+N7Mnw7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MS4QSmDf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MS4QSmDf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAVd5S1622909;
	Fri, 28 Aug 2026 11:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bnirQgVhquIjJ4r7+
	Eyl3TC86tJXdTToo8VCwupGmSY=; b=MS4QSmDfp24uJVXFfkQ/sRbDT2P3m5Duw
	Rww8DTSpiq6UJtXiMpfyFQccFMrp4GixrXmVf+Ci+uXclwVfzKNHZ5uNXKU16v9F
	2SrYsOJ8LMJTIZTo7HptghzWz/ui5SlNIS1bLL8tfpcrGdQkqD4wEdmEzZvYK/+O
	8tpHk8YustBrGPownLteyI8mzk/FzSUvCp3fXLpcb9yGS9gWturwah3HEthpqrUw
	jBWoTNbRvV+ed8gJqvJauvl2sVugwIif3zw3+2DajAgGev70ZgsAr1yxIr74Am5K
	cUjitO2pLOfkaD3xdBG07dz/VRGkDFiwMA1+wabdlNoL2H7sdgL1Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jbx0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBfGjs011687;
	Fri, 28 Aug 2026 11:54:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qp5p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBseKt12779998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:54:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 068D420043;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D758520040;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 2/8] KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
Date: Fri, 28 Aug 2026 13:54:33 +0200
Message-ID: <20260828115439.145885-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828115439.145885-1-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX1wKIE7ufBIs7
 NnCJlIbVeTTLcDPxhvmzlYxhlnq+O/4yS8mye2Y8k5Gg73BAVOPq+eGOVjYTy0IhEbSMD67K+yO
 Tu9RRbnel6EIYI1nSVonJxsNUjGkPIk=
X-Proofpoint-GUID: U_H33x7G5sUk7EbPchc8l-8ROj80eUiJ
X-Proofpoint-ORIG-GUID: U_H33x7G5sUk7EbPchc8l-8ROj80eUiJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX1ujIfKbASY/t
 OlI0AdNtWF/S66YrPEbmKXOiddoFe30a0lLH8NQofmQQMsfJthZHf2Ns9tTvEogh4/bWyaLnaQi
 5NPWngivY4OklddnLeON/BQzGwawmYd5taimIjaTGnjYk/UwV4xyrUZrkSquoBx3irfsuvAczZS
 G62ndotJkKNWGOfAcbkxw3Z6B1PL4qg63OUBsd2ppW+665w4L+FzBAF4urv5DNda+taxHltgP1B
 +urTHMLG1n9dNRmHYaWxVhnbrVtCayIaQvSlBvnVOkfcpAgj9lsrvkR7w5Aljmff4UElnDawRVt
 9tqezKDCF0mAn4AGwkUfhad//cfzht7aL+spoSovGjSjVuwSY4KNDRjdSiPYivNfDb7QW7a81PH
 ATFduwAuVtoBzDImFKhXo8fb4KjTU33h6nBezxYq+qprmxTjBDObW/PJMShESoYc8LKoLF9Ces6
 mk5mniqFXvaZkHsdbNw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a917707 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=UaRUjzXUzZSuBrJintwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

The parameter "old" should be marked as const, to prevent compile-time
warnings.

Fixes: d487a24041c2 ("KVM: s390: Prepare gmap for a second KVM implementation")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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

