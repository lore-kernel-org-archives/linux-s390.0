Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF643FD943;
	Tue,  2 Jun 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422512; cv=none; b=paCieJoIexRIEZiU4M4iV86UF2S2hb0IxDhJ4U+4vcrW9z9W/ku9x3KSRcQeKBwLAKrE9MpQ9Es97D6qmxqY4Y3aaDtkE7/qe0Z1unYy8RBEJxs5TsJ5wlDm0J59dVK6pTv5hNf0mpRldhFx/0xD5rU/g6fRWXc1deMPlD4IGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422512; c=relaxed/simple;
	bh=ug2xJcBCotFvxm58C1Pc6PTGXRW7DHZc+IWul8F5Mvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tb2v2b5rGVI5zvik2e+fsgI4tWIR+ZsexMyFsiCl/GPH0r9TzgM2TrNDLMQWxZ/wgOr+N2x7ZCQmQa4v5esaTcbGRzuShy6x8icMnkAPvmcGKKDpAHy4y3H0UEwoDPFr+fPXbUkduXnyohhj3e9SBQ/dcigdfEUH5db73tqRZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q1/t6Vx9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q1/t6Vx9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652GGaD13707938;
	Tue, 2 Jun 2026 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yX0P/CCzgFVHAZZBm
	0yS8W/YatyctysnjlqEx/Yz9Ck=; b=Q1/t6Vx9DNvchYcvZxPhzC2YgP2udE9Ih
	9B0MiI6ZGuXgIF+odN3Vru5sgPxc6TOS/y7hp4LIkXmGsJWa47lth6KbQim00guH
	Wg2KwoAp6tz1N+jahwqgQQd7YHyaF3dQ3FJm3ywQsp+xG4s6VrEbzYeYMKlcD7BK
	x7ASPMd/IOO1K9D2tZcxom295IpAOkKu7guHsp8YWbRaCEn/K8lcOfwzXPe5viT7
	s140z0lKpy7gPSRlKzILhJNXMPw9VO1MWbXQUgWdvBhB0CzTxPkxcNPadWX9PhSt
	NfmciWobrLg0odMzqaYWqX/8X6vYSC4TgLj7JnCs8+187nB2ziXSQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae6uke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdTab030709;
	Tue, 2 Jun 2026 17:48:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvvhyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmKbk48955664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E3DD20040;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 820B72004F;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 09/10] KVM: s390: Fix possible reference leak in fault-in code
Date: Tue,  2 Jun 2026 19:48:18 +0200
Message-ID: <20260602174819.255785-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602174819.255785-1-imbrenda@linux.ibm.com>
References: <20260602174819.255785-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1f176b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=t-RmA2bz9KeGA92bHnoA:9
X-Proofpoint-GUID: kLUYREmSCzivN4CahWc2qt77IX0g2Z_U
X-Proofpoint-ORIG-GUID: kLUYREmSCzivN4CahWc2qt77IX0g2Z_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfXz8O8sRMBBatS
 1KBWADmUkl1cUK417135HqFO9fqXXFh7Ly5lhC4AeceqrUFbasPco/RV9yG1pzousny7MEn+yyc
 FTYew/cyz8YCqZeaWa/MtXL9Lz3xZufCxAIhXqaovcC0eW/2A8mtday7adPriCUE5Rk4HlgyFPn
 uB8RzboxaXcHkHXtjPJG0hUz1TO7CmEOVWQ2B//JdRUdnzg/EN78iPIzGQy4cTQbI+M+fzM0Dff
 +GZaRbC3Df3DTxA/5sMTBQFHtk5BXyM537c96J8QeBK1zLg58X9lmmxLuzLUMFoP6S46xoqHzu3
 QqTKGlFWH+9bM34CwmhvY10kevMQXGTppBzRJlkDGi/NT0ffRSDte6afRMdD+4d1LYGQduYhioi
 pboIZEp2FZPqIJ+gGP4qripVtB43LpsWGEApqjM0UN9mB1uRxyBe8mZbTp7U3zeP+hnkrlzmoVx
 QZ6ihY8doILjsKYp8aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

If kvm_s390_new_mmu_cache() fails, kvm_s390_faultin_gfn() returns
without releasing the faulted page.

Fix this by moving the allocation of the memory cache outside of the
loop. There is no reason to check at every iteration.

Opportunistically fix a comment.

Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-10-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/faultin.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index cf542b0a7e8e..fee80047bd94 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -54,6 +54,13 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			return 0;
 	}
 
+	if (!mc) {
+		local_mc = kvm_s390_new_mmu_cache();
+		if (!local_mc)
+			return -ENOMEM;
+		mc = local_mc;
+	}
+
 	while (rc == -EAGAIN) {
 		f->valid = false;
 		inv_seq = kvm->mmu_invalidate_seq;
@@ -94,14 +101,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		if (is_error_pfn(f->pfn))
 			return -EFAULT;
 
-		if (!mc) {
-			local_mc = kvm_s390_new_mmu_cache();
-			if (!local_mc)
-				return -ENOMEM;
-			mc = local_mc;
-		}
-
-		/* Loop, will automatically release the faulted page. */
+		/* Loop, release the faulted page. */
 		if (mmu_invalidate_retry_gfn_unsafe(kvm, inv_seq, f->gfn)) {
 			kvm_release_faultin_page(kvm, f->page, true, false);
 			continue;
-- 
2.54.0

