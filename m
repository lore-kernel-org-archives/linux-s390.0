Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230CE392C24;
	Tue, 11 Aug 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463813; cv=none; b=tDK48mL+0S+njpai7E9ANNiq6YMZeskrCTeEAqcBIz+soRSpTC7VAKvOzk4P6jDn0zwNky6mh6++MT6i4DEKc+PnX0z73qWy0q+Rermr7tsiMtSL2TOTo1iyeka+s4lY0xoTOI0z+B+yVF92TUSsiztkkyuM9BQRCjpjbBPZ4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463813; c=relaxed/simple;
	bh=TsfXF1uoAvHw8iOKgbJyGyELUJ+QFJtep+Z9D3N7NYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFBzvYXkpaqujnNi8Sc65j2eLlClkdFF/eMcWi/AM/1NDVzsreQuAqOBHAm4TR9AWk9wSJrYyBWxrLW23RphKvyVx8pJERW08lRcf9Cog/0Ol+tY6GfujPlo04uxsmwH/y3VACAGbB7hBSwMTiLOkPdVF9Q/YUfuTBU0o3eheBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s2AGl1GP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s2AGl1GP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWwUI3633650;
	Tue, 11 Aug 2026 15:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gONXhuZ0/B75f/7Lb
	vu3yDtRU/HMGcTlvdKx7KnRp1s=; b=s2AGl1GPKlYnnzeqKFDfcyJil0qi1yxgC
	D4wRG9ClGWDOltXyizOn+4vZN+2ncD10bCmLL8P0g7PyQqzZmkw8eQ4hLXq3HVZO
	kEvvq70XfUAv49y5J5dWTmu8SAb2//gh/T3ka4kUCbHlVooImy3YcTlagJ+ZfsCx
	zZeGJ0LNTisTKYisx8YonVWi9Nru/nUu0EOUMmLyNA1aACaN0bMHLMZvG4Vh917p
	4lz++0c9IW0+lybXQHNc5YgdTNoqQDFqhEXOkW85P0Tp6rAMcB/r2ZUsPfG+E785
	30kppjEt5E5syquIn2Sccfv+yd8C8mptaqxluwcFs96ezlMv72njQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pgg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuLOY032272;
	Tue, 11 Aug 2026 15:56:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g9ftx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFugnl16187866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9490820040;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6198B2004D;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 01/11] KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key()
Date: Tue, 11 Aug 2026 17:56:31 +0200
Message-ID: <20260811155641.219777-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b4641 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=XqUKgKXUM3VPc0qgLoAA:9
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX9jkbhe2OXDuX
 /EBusXZ5VaK8O1qUcTCErHWpE5YvmMPtkeJN6vsc5rKx5TKY2hxOTWfUVlstFLJ2TR3/u4bAgu3
 cV30UDLm5jmJExxuHYQ6QD/Zcy56Ivqi3dkDGOJViMerANsaGfnrNAeS12m9T3JwwbPt+xScBIG
 VHGsM8cK719IEma+oxcrtnE88MNFKYmMiPYfIoIsVd+7HKReMY7SC45aq0w4hilgNyk+kEqJVN5
 4bHXhuXcdQzGRj7CsAmbgoU1PY3jrjks8VF6gm1WrdSc0HQdAgi5ANjlqQMAqj7wttdElpySmOa
 quxmGia5IkIy6wXZ/fyob7IVX1ht6BaLDHVDY9qz+HdqASVcb6tk/0Qy5QakC8V0B7LoQ9Uf2+N
 E5swG8Tbk5dtFC0f2YkHK8JkjjCDdFP/H1LLup6QZ+ATQg2x0ZNj5U29+ddEgCfZVUwyxyIlVkg
 7bJRwzj16hIeQ8r3LUQ==
X-Proofpoint-ORIG-GUID: nsfr9dHt5wV2_Wj41cZWlpncrkU_Lu8n
X-Proofpoint-GUID: nsfr9dHt5wV2_Wj41cZWlpncrkU_Lu8n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX/k3smm2wUHV+
 IHlnSkRk3TnlCnFmTxD1GiVGbtLG6MGhtAfnAEV4Kck7x7X5GlPg9f/SacFcQZzmE5jLoqiUhVH
 vFDK5G7oxCqjKrKBqGiPsB04pAehAqA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

Some callers pass NULL as oldkey. Calling page_cond_set_storage_key()
will cause that NULL pointer to get dereferenced.

Fix by checking for NULL and assigning the pointer to a dummy local
variable to avoid crashes.

Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: storage keys")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 3f2d6e8902d7..165c704fcf29 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -722,9 +722,12 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	if (rc)
 		return rc;
 
-	if (!ptep)
+	if (!ptep) {
+		if (!oldkey)
+			oldkey = &prev;
 		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), skey, oldkey,
 						 nq, mr, mc);
+	}
 
 	old = pgste_get_lock(ptep);
 	pgste = old;
-- 
2.55.0

