Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14B444713;
	Fri, 28 Aug 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918105; cv=none; b=YlYuZxJsfrep9iyy2K/ZWGiyr5o6FpUFzTRos/vRIbMNlOY+FRAROwOUntp0dVCRgXnABRQxzMx4vCn7gzFRVvMNmvxXu9lLjrHXyW4rhG6zOsXol9psHWzVD4dCdxCocxolwLU1aQLsOiDR/7dN+Z6g472FJwuhv5p/IDXPEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918105; c=relaxed/simple;
	bh=4fTjndJ76uUoI7yVRhh0k5oQoMlLrUxNqcADBgeqrco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTo+WHWsRTmQbtAy9wcdRCCQAF13/7M8vAAzAYJbwuuypPW3CqtBqE+hleIWgnWz1LFrflbXxx3ZZM2M4N1O2DF1jqtzVusRp4v7iW+TB1UdlSR4kawo5LFVj0yI95Guvfr1BzH4tJsyOKdP4KTTVyJCSAcwc44UnICQbeH6tEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PawubOHO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PawubOHO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAVjgn1623140;
	Fri, 28 Aug 2026 11:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y/flbizZG3jev8wUX
	CCHvXb9riq71ahNc3V3BymdysU=; b=PawubOHOODkUAXWpHS3wiGVYEqFrDFu3V
	FgxS4QAzGAGaqryGXC4jPSGBrR9y8Sm+6ZVtIbYy8kc6AR55Z8gAK7yfmeWP12ao
	IUQvIBTZeXUTHOBGcEBsyiV3W0ToetUbPfcrS/MjrodaIr7BGXQSzWLGgwftwXkI
	E6LUi1oH/pUebcPlUFN9DnKb8aTJuB1+6hn1VWLhn/EMigyY71Gx/PcmdEntiZXK
	6Bfx63AnUI8kqaJMBlM2LLFlpRWAcVp7b2c0TzTPOKoT27IGFPG0OhXlyEQxwLIR
	9fja85D1fVpMDPndZ+UK54pYDcNso/mAJD2iBvnXULK5fZp/xC3/A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jbx0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBfbGs001311;
	Fri, 28 Aug 2026 11:54:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwp0qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBseqN28312252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:54:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E80520040;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AFBA2004B;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 3/8] KVM: s390: Fix _gaccess_shadow_fault()
Date: Fri, 28 Aug 2026 13:54:34 +0200
Message-ID: <20260828115439.145885-4-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX+fvmCLIsIRnN
 2LRTlpG/RAHvUsPNxQV2fUwLJVI+YG+p3NH1pXgmp1aDV/kmF8j59IeKcVPneLy0i+maLMyaLEM
 DANpT2Bs4r7XNQAtIXjBcgRRJkg6BZs=
X-Proofpoint-GUID: jIe1mqgYP02znFku8LQrgHiLVkkNHKR5
X-Proofpoint-ORIG-GUID: jIe1mqgYP02znFku8LQrgHiLVkkNHKR5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX3bIE8/puaqM3
 UakEeag2LCWOZUoCJ+G8fBtBpkCnhiWBa26r3c8t9GszBm8iv/AjRRWzN/ThEDrHJ1SDYz/ar0G
 VNr69TeiFo7+rqNTKIbH0mHAUJcc8YVTtBDDN5d1+DDIBgp2Gf7E2lVrtF0qf7i7bNmkpsxkKr1
 oL5N8BoVcOBhv0n6OzbJtt6Cd9BcdhM91QapPcHbSB7F77oY9+UeJYRi858WX3nhFu62Fr/4W3G
 V41kG4r7ZFOvPrK45SudxFlZXUYP8nfUMjYT/nE5ANAx4B3wQWQv6z8VjLXwW3Sl2VMc5ILDarH
 vy4xQCKpqyos94YsHWtapt+mZVnUpNXtNTVexafe/tce6DLkoIkJGIQ5WNMk7jDNFm1w4qEUc92
 1Lvt7tZFicYUiD+rcv+7C8B+ED21jcZo/vAJOU+mjinKth4kPOPG7LCNLIe2IzbceoFshzYV/Yg
 7slRq5AO5GUz1CFQaUA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a917707 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=E-UwkBRaFZ51XR-txJMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

In some circumstances, it is possible that the page of nested guest
memory that is being shadowed is not present at all in the parent guest
gmap. dat_entry_walk() will not find any leaf entry and return with
-ENOENT, which will erroneously be propagated all the way to userspace.

Fix by manually calling gmap_link() on the memory of the nested guest
that is being shadowed if the mapping was not already present.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/gaccess.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/s390/kvm/s390/gaccess.c b/arch/s390/kvm/s390/gaccess.c
index e5c064f263df..405345ccc4f1 100644
--- a/arch/s390/kvm/s390/gaccess.c
+++ b/arch/s390/kvm/s390/gaccess.c
@@ -1589,12 +1589,25 @@ static inline int ___gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg
 	parent = READ_ONCE(sg->parent);
 	if (!parent)
 		return -EAGAIN;
+retry:
 	scoped_guard(spinlock, &parent->children_lock) {
 		if (READ_ONCE(sg->parent) != parent)
 			return -EAGAIN;
 		sg->invalidated = false;
 		rc = _gaccess_do_shadow(vcpu->arch.mc, sg, saddr, walk);
 	}
+	if (rc == -ENOENT) {
+		struct kvm_memory_slot *slot;
+		struct guest_fault *entries;
+
+		entries = get_entries(walk);
+		slot = kvm_vcpu_gfn_to_memslot(vcpu, entries[LEVEL_MEM].gfn);
+		if (!slot)
+			return PGM_ADDRESSING;
+		rc = gmap_link(vcpu->arch.mc, parent, entries + LEVEL_MEM, slot);
+		if (!rc)
+			goto retry;
+	}
 	if (!rc)
 		kvm_s390_release_faultin_array(vcpu->kvm, walk->raw_entries, false);
 	return rc;
-- 
2.55.0

