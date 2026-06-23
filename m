Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E472EBB8C;
	Tue, 23 Jun 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228822; cv=none; b=EhEnIaYgvn0FA5oY5xaxIYFEdqnOcBztcqoZSe24NDeJDF85vJ4J6k6VttHzHZdcVBLi/OhCkqO7WR5J9cDMiSjOKB/GgEFU8IBMsn0YwEA5AYKlghpkZBZSv47K8KrWVEZQk1oKlIsQOK3oD+A8fgoknjtb0TDHmy5GDCAbBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228822; c=relaxed/simple;
	bh=Ys/NQf1524YFU5XV302ifwJapR5Eeo/Hq4EbaeioTOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycgf5ID8fLYbPXNG7jhdF96JkYHV13eiiByU5YTDMBCYnMxMdKs2HSVkc/M2/iDEA/KIguv0/n1naccgjH0gWcirmZrgLDv/67fbH9WFgHQ/IGDSwlswiGhtEmJx3I1sZdH+M+DojgfHqdZNf1161ILcmruDCRpUJU34znA7GDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pGAhr8CL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pGAhr8CL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmrPN1915561;
	Tue, 23 Jun 2026 15:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EWijqOrC7bPGkZuuA
	xHqQk8w9zHf5BWjkO4JpY9BXO8=; b=pGAhr8CLod2esClyhgJOz9+V0IEv8cTlE
	OF0bO3wqzXlENF+wVECmGC21CHopz9o8BNhz86HjWPyBmmUGi7IcnHe2qt4fcyfV
	CkXJawe9ewE1CQWslZn768ko1QZkGWwk3A3Ro6DEuqEPeh2DIe+5t7/TIKjhrugi
	5+fZuX8D6yQNeSMVoL+Qgxc8/NgtjcxD3Ip/Y6+M1B/jqjzPgZNEAuixizoxcLUI
	JJ9/ATs7HqksgfseE0Du9HBcSfPL9/AQDGctfUD4ic+YjB5xjJEZIbyHkVGJNx4S
	u90fpLQpjzlhryXhTQ/RtVAjxbVGzXrk4Lf9WvrCM+BrRVrdEm1pQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4fdbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJdE5012496;
	Tue, 23 Jun 2026 15:33:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykq6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXXaP44368298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9936120040;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CDF420043;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 09/10] KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits()
Date: Tue, 23 Jun 2026 17:33:30 +0200
Message-ID: <20260623153331.233784-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX/OPRhM1qubh4
 klTAuaauBROArX1TQTuvPMdkLokRC4ujj2yJr3Q8cmG735CBIs2UM8sQvD6+sne1CmRV6cwqBZx
 J2E2FYULum6XdD9Dar27R+i7XUCcjIQ=
X-Proofpoint-ORIG-GUID: gRIWATNz4rliTqi_HVDpkkpnTqJ-17PA
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3aa752 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=xmMRMRw_lv4QeeJnpVYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX/08IwIQrpyld
 F4f7GNfGxaniUC/zMdXs0PZRQluc/uHl8gJEpKD2A8IN3kgNgO0o2Tu0hWM0HP6wlHsvYuTX44W
 zYubsjEFk/EpDDZyToS/Ku5DmEh7yd58hlOHfQhEh8qvTpCPDiLcmYESP+Ne+ypQxS7GsAH3SIT
 3kIvpqDdjNIZXt1wQvVouJ1sWaQd5lYvowNJQG3y3dnM9O+LjWpDMTddCHf/hTciFX2tyuFaVWV
 LQOASkxWvMs5XMZFychsdpcrNX3WrthuEu4brsAnkVh8e1B/XoPD+pF3DSM9hpl90YtkJgK5dEK
 oF+niOz/M/XDcnbrPfw5yGgCMj+GKIHpPR7/RRphUf3Oa3wN9v0EJq8VAMLIWEmEPYTqE7t6ZfL
 iVtF4nq9W1+a1UJBwJ0hnVsEvD07ZzGAiEsc/kaG0a1/96uH0S14fhIy3D7GaKk+6vAA7EGWJQb
 ZKeQYF8/8UliBUyVQ0Q==
X-Proofpoint-GUID: gRIWATNz4rliTqi_HVDpkkpnTqJ-17PA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126

If the allocation of the bits array failed, kvm_s390_set_cmma_bits()
would return 0 instead of an error code.

Rework the function to use the __free() macros and thus simplify the
code flow; when the above mentioned allocation fails, simply return
-ENOMEM.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 91cf7a3c55c7..c08a63a1bfb9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2313,8 +2313,8 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 				  const struct kvm_s390_cmma_log *args)
 {
-	struct kvm_s390_mmu_cache *mc;
-	u8 *bits = NULL;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	u8 *bits __free(kvfree) = NULL;
 	int r = 0;
 
 	if (!kvm->arch.use_cmma)
@@ -2334,18 +2334,16 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 		return -ENOMEM;
 	bits = vmalloc(array_size(sizeof(*bits), args->count));
 	if (!bits)
-		goto out;
+		return -ENOMEM;
 
 	r = copy_from_user(bits, (void __user *)args->values, args->count);
-	if (r) {
-		r = -EFAULT;
-		goto out;
-	}
+	if (r)
+		return -EFAULT;
 
 	do {
 		r = kvm_s390_mmu_cache_topup(mc);
 		if (r)
-			break;
+			return r;
 		scoped_guard(read_lock, &kvm->mmu_lock) {
 			r = dat_set_cmma_bits(mc, kvm->arch.gmap->asce, args->start_gfn,
 					      args->count, args->mask, bits);
@@ -2353,9 +2351,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 	} while (r == -ENOMEM);
 
 	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
-out:
-	kvm_s390_free_mmu_cache(mc);
-	vfree(bits);
+
 	return r;
 }
 
-- 
2.54.0

