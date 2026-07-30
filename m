Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6245040C;
	Thu, 30 Jul 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428848; cv=none; b=HKCG7uppgdc0FanlXqV0u/fkomaO+bnsHqxXtRY+RL9ZcD0YcgwXH3799V69kY8ugRXsJav4zGNiOEW24a8PHbwe55Ga/a73nDfCF/fuXt9w7UTWiOriSgwP8k9xLF8e/Tv81JCLB32y4gxPAzT/sfucTqWAu+hZ/rOvx2s/+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428848; c=relaxed/simple;
	bh=lrLXFoXGkCQqajiFzpvyyVTqja9Wibw9Q7qbE7OIzeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUjdYyTxY37zGt3E75FqeDvdxhOfpda+qtuCdyIjVSNBXdmSsSGiNQ+TsAP9ZQkY/ryBHtKjq+IAXBV1eWq+zbwfZ7a6pCsxk2tgHDAcnN1c5A5APAFut42VbwRoowWOCWAK92gE0Z+L1+9B94QRHVnRniCek77Nj+S/Zb/P7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NNyTuQhi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NNyTuQhi"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFmGYA3355273;
	Thu, 30 Jul 2026 16:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J5ryilsnnfEEjhv+w
	mZlP5DZ1N22K6iGMAkWi7r5uEo=; b=NNyTuQhiXscQF7m0tzOh4UBRsSRsxdMTh
	V8Dwc6UXXxqeoGk67C0MHCyazo2kKLpaXvJa/j9sY0qrnSdTdOqK36nc2XwWKi2U
	wx26+uk1pAYxInFJEEDjW7Rxxqwk1d3U55HQkP6BSeQlnEzYDBpL7ki47PxePhfs
	FQjD9S0n2N6si/+5/oOD8I9sm6GBAxHzmEQ737hHU/JCCJkONLBdYJBEIVn8qn3g
	mt++AsRmdD0OYoI/y9ihhLnEFGlffrjEOWM/PNYHWL3AnL/gAIKOuy35q01eB8i6
	Vm01qd6RGEsSYbs+A05qrCt0sVhv0TDrWFDJzn7Y1fkSFqb8y3LJA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nyvd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQNT1010830;
	Thu, 30 Jul 2026 16:27:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhm1vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRG6n17826100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABCB120043;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 884802004B;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 10/14] KVM: s390: Return -EINTR if a signal is pending while faulting-in
Date: Thu, 30 Jul 2026 18:27:10 +0200
Message-ID: <20260730162714.133327-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX28FDGj+vmj2z
 rAKLvcoeiy6NvRiVkG8hYW7T/3wW+fIzX3KgZQ7NZDxv9DBtvbG9WTdvDq3P4DntX+/bHhMocuT
 Xt9N8IHKbTpdB22GqSCmlu/kgvz/n7I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX080tpDR6W9Lp
 06DyDg5I1zxLJIi+TDpqLiYq9Lwyf83V/o5BFb8YLI2kiJySKeo1Koh56dVQZHRlXs1Y+CvJqta
 JQG20fksDgujlj+C+m5LXegT8HBUlD5LZAP4/2PwuzJB0lq9dUtuF6OeeLJ0YrO5MiBgOXlk/qZ
 dDMGPg9Rgi4gX0ptoHtj5lBMqMVJh0xHZV0pxB0GXQ2LEL+QDIT6b51282QQKoMHBNx2LW22deA
 CexJW3mzyGHt0IFSouVqOWjho4moYGcHZj8qS0gfMctI80CoyzDkEVi9EnmH+EbdrCHHOIDzlSz
 CzoXl2xeY8gtE2dYMMfgvi5VJT1/GjOBK43j8ln2WzywJEbtpD3MSvHa/VfdrjQ7JN/mMU34oM1
 lt+kBFeVPrb2ZlXrXr6Qv2kQqfGL/OBgqhJHHKj44dsqvDmq+Qyr+Yum5IorfFAXSP21Mer1odG
 ixAeJ2egzQbMhlWEtzw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b7b6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4yawSYOjwzvXb9KGJXwA:9
X-Proofpoint-GUID: 0EteWC9sefiM3wEAe6f5W6wQlg1Zzs4B
X-Proofpoint-ORIG-GUID: 0EteWC9sefiM3wEAe6f5W6wQlg1Zzs4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300123

If a fatal signal is pending while trying to fault-in a page, return
-EINTR instead of -EAGAIN.

Also fix unpack_one() to handle -EINTR properly.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
---
 arch/s390/kvm/faultin.c | 6 +++---
 arch/s390/kvm/pv.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..3cc45f7f5b2d 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -91,9 +91,9 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		/* Access outside memory, addressing exception. */
 		if (is_noslot_pfn(f->pfn))
 			return PGM_ADDRESSING;
-		/* Signal pending: try again. */
-		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
-			return -EAGAIN;
+		/* Fatal signal pending: bail out. */
+		if (is_sigpending_pfn(f->pfn))
+			return -EINTR;
 		/* Check if it's read-only memory; don't try to actually handle that case. */
 		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
 			return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..dc204b521052 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -809,7 +809,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
 			return -EAGAIN;
 	}
 
-	if (ret && ret != -EAGAIN)
+	if (ret && ret != -EAGAIN && ret != -EINTR)
 		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
 			     uvcb.gaddr, *rc, *rrc);
 	return ret;
-- 
2.55.0

