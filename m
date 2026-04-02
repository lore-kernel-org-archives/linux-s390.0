Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354A3F0758;
	Thu,  2 Apr 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142111; cv=none; b=mVMD7I4hVAeVpav15PIuVK8Ovd8WTEFvTrErGpXuasGJQiRanVMOZUnXNXk5O98BjV4cTNkjZGkB00jppZY9oaZmkFnQNkUw1NMAe7UFgJN/FoCe9UL8ecS2uOpAMsAny7C9wNIRWLo2WfnWApT1Qbzx7Og34LKgFEKr+Tp7y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142111; c=relaxed/simple;
	bh=4bzpiikrqEOg5U6fMhqOPLN+lShirOVWBeTxH4aYvbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iykn67Vv9P7B5IDfA70byYVBkLWuJgmOpBPaoNxayGf0q8ON8eYKg58ExjHP70qskPJC/BYQJ2wt2AhQV9vMvtVy2tTW9+9B6ZhSjb8P52rK6WVfnhasmspQXB6Y7TpMCEMo08+fDWAI8b22/Ojs0LRpUjNq+kteQRUNzGLv5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RzDhkgte; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RzDhkgte"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6323OC9c172363;
	Thu, 2 Apr 2026 15:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ANiYZVSOka3t8+Rdk
	JZAMw4WgJDb2c6+W0sQ9f+lOr0=; b=RzDhkgte/61mIoiny2gESWSG1rm6nTYbE
	/U662Es1xoMmc5RSU6tiCszoGOmnJlQjHrCiNB9T3ql1igDcx1uCSe5gYU4calHo
	fSt1T0LboyLbuI+fqVgWl+A3iw1nbAUl3tvdpmixMOFxav/5FjYoyU1zvMG8YBGa
	KlMCpmJMvX1CgNTD3txEI1tyFk9iKtfWRxezIUNBGjQHeCFwdWhkj7XfbEppZNN1
	sAUakCcwJSGdX/y+G4HVfPYhG7t9OpqPpN1i9DklE3E6kT/4USuf0XjY+E5hqsLA
	RTCKxQNs47AGklS361BhkEZbpUS7eRJBL8OpLXbc0jDpYaXMOqemg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66mscbhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632CUKaa022217;
	Thu, 2 Apr 2026 15:01:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanaecb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632F1d3g29950394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 15:01:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27F402004D;
	Thu,  2 Apr 2026 15:01:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6789720043;
	Thu,  2 Apr 2026 15:01:38 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.129.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 15:01:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 3/6] KVM: s390: Allow 4k granularity for memslots
Date: Thu,  2 Apr 2026 17:01:32 +0200
Message-ID: <20260402150135.196943-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402150135.196943-1-imbrenda@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ce84da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=oKVxSbr36kwotj49NyIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzMyBTYWx0ZWRfX8rtiwuJrXePi
 sXtm8fD36L3OSPi40k5FHcaWvfSGCuCmAenhnlMUrwpvnyzMrCGtHlG5XuzehlO3SYkTeYw3ag/
 6XoXmy5M111YCRTisijCc7TVnFxrcxjgzZZYjvG9hfwkuE8f70iIkaybvn1gDNTiog6rIdfbfCT
 z9j3B2UPqWvfgdxSXkx8IFQHAzph/3On9WHGhPKppW97cw6/9g2VAnGHKUozlOMgercUDdbyJNh
 +9sJmA5wnaCyjmAhQBnFQv4fWAMmzu4+ZQTxGwHNWS51fulXGXAlW1xTlZPxo3fdoYeZhqRUtE9
 lsSqAqoI4lG3tBgH8orjmn6I7274WeYkTxHkI7VdblmWMwfeRKrBubweJWfru2vGeN8ZCBFVdwr
 3S8bey8b3hfuJBkxqLqZkC6zO3YY+TWGY6gmXtGdEVmaXxpZCq8KU1lkHm+pn0CghhqpwSlUEYy
 SSJO7OZttlAVO92k4fg==
X-Proofpoint-GUID: ydlUHv_YaOSvCvnrKrxi4lfZnNETQRZf
X-Proofpoint-ORIG-GUID: ydlUHv_YaOSvCvnrKrxi4lfZnNETQRZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020133

Until now memslots on s390 needed to have 1M granularity and be 1M
aligned. Since the new gmap code can handle memslots with 4k
granularity and alignment, remove the restrictions.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bc7d6fa66eaf..be2a721e2574 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5636,8 +5636,6 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	gpa_t size;
-
 	if (kvm_is_ucontrol(kvm) && new->id < KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
@@ -5647,20 +5645,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 
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

