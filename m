Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919D419FBB;
	Fri,  4 Sep 2026 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502022; cv=none; b=olg12wTe4Rxsivnb3scn38bHb1UZ8XvcoXFdB7kSgRxfRbwioUJ26M7PXrNe4D6f/IOQD4+4bU8f/mXX4sjxfNzOj9e82gtSfq5GCnoO8QCJsZc2p6zLeYUXjI9tIs8shR+96kHxOvPiCmJNwId4OKChnS6yREVEvjqQOXIVMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502022; c=relaxed/simple;
	bh=I1GJhaACHSYRoeAobjCh7+Qg8XYMVj4IeBR7Jft0fxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVlZqvaxOtZ3uKZcMH/ZA+FwqU/UI4FI8qLCM4zQ6MvVnDszGZIZm/ooQeABPtFAMC3KzOSj+kf2amU4KOh0jUQLJZyFM9NzlA0+/r12pNZKL51Fw3mmH3rKcLOBepZArH54GWfTsLD17XrUDKxYqYHkBDumdCJNbzzpnV4Kjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UoZBA7wN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UoZBA7wN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464ncL984496;
	Fri, 4 Sep 2026 06:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yLcTPOmEEUndAoW+S
	N5ivZTpSkjUaTLUeZ+hESc2J80=; b=UoZBA7wN5dRvSUEZfAa60m46YfZi8TCWO
	1tPzWQUMkBrm35q7obq8oGg8cPW7/cQd4dS763L04sqhj0puLsInnTWHe0cXmmWq
	mqDK2ADYk8T5QQmZBqjq/3PGDavgpif3udD0zCXiEKlOdqsNQF+YJufYPYy9cYux
	8aO6Vxc48ruBAKWiEvA8NV254hWlO/1ivSax+3KKX1N+CVLMXZC+2hMmVF00orGG
	ZB2koX9LpNn2f3y+5yfBonowTvvTEE+G0eY7pJfGTkOFO2vQf1LriHz4SIRnuMK8
	/73Jjiq2ZAeYXgAgIYSUp4XzRAeosvLwAeXWr4QAYcRSIlIB7leUA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2trb9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uHtn002154;
	Fri, 4 Sep 2026 06:06:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqun2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466o5640174066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01E4C20040;
	Fri,  4 Sep 2026 06:06:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 946C52004B;
	Fri,  4 Sep 2026 06:06:49 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:49 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 03/11] KVM: s390: Fix _gaccess_shadow_fault()
Date: Fri,  4 Sep 2026 08:06:39 +0200
Message-ID: <20260904060647.562443-4-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9a6001 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=E-UwkBRaFZ51XR-txJMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX1XdT45zRx7bH
 y5mbjNRmoqFpZG/5qe7r/eQGUsYaaGNFHvnXZkv/WNb6j+7XJSQFVKhB0mF6sRTLCAwZRexvhcr
 Rr8tU5+Och0jyejRwZH8UfSUhsVA1ZU=
X-Proofpoint-ORIG-GUID: FxYJf6AgzXS6CnR1I62kxMJV_qOgiamL
X-Proofpoint-GUID: FxYJf6AgzXS6CnR1I62kxMJV_qOgiamL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX6L54B772VT2b
 0nPI2nA+AfiRetiNhoyMtBU2ngB4UDRd2wkomio07YGR1PZ/F+psIuUuaolUYMFIAab88yC/OMV
 kFw7UPFg8YYpt//BDyiKDaRo7RqYmmk/360tFYt99mF86rDeVy60DJ6185c+xDr3z/4ChIabAYF
 BqKbHRYiWlD3FhAlSx1Z9J9jkRL8rMoJuuBQgpYh74K+AhcaHZBRlr15btg7eSIxeGx1+UWXfJI
 TcYX9zjx1nY86DrPwWfir30sqkcj6ltlYjs7BAHdIdK4OFF4E+xDO2jmATDcSqrdzERESGhHon7
 aIuBQKOk7sp61/I6WkomPdExMssrcH7FAdFWkmW6AFmi4tIoSHHXv14pZmFd0bZY8/3DLsnp5lu
 OHq78xtC70J8OlICjJm41Lv0LCqaKH2OANLPlueYZxHp/SQhy5zqETbGJ4dpcjhUj/cMz7Lbnpg
 4AhHqSD1k4jjGmHCYJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054

In some circumstances, it is possible that the page of nested guest
memory that is being shadowed is not present at all in the parent guest
gmap. dat_entry_walk() will not find any leaf entry and return with
-ENOENT, which will erroneously be propagated all the way to userspace.

Fix by manually calling gmap_link() on the memory of the nested guest
that is being shadowed if the mapping was not already present.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260828115439.145885-4-imbrenda@linux.ibm.com>
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

