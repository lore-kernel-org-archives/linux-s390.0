Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8F3CFF65;
	Fri, 14 Aug 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725247; cv=none; b=I5V1NrTZnPH9srBcrCGi1CJWNuh+R3w87M2e0I+/eXMpC0NJk2OfWjaLfsNZqfl0xvITYe02X+5zDWVGqbuPQLflVpuO+IlaX7SlzzS34lhsBo+pbp5FOA3dWmc+WzfgJRugQUCv3Jx+ydXyHA7hWSDf58Vwf/OLgS8uNBClYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725247; c=relaxed/simple;
	bh=ZD4E94rMcJ+fep3qUl4Ec66Az6CdbctO0DaZr12pfoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT0pa4lhKKBlxJjKVc8JiBCCO6+rIo88ZFYWbAX8pOQ9dfVN6bsT5VY3w6i/jb263NOWa5zbRuQ2AlKU8P1RqCurL6OpTJCeZpbEtv/wLreg30uosJ8QAP4ECjzpzj4qoPWp2hYxLJdUqnXOYrWTM9QXbXa3mKbdxAZqrK4Yin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AS6DUU1K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AS6DUU1K"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5b9o1289728;
	Fri, 14 Aug 2026 16:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Zbl1efghVdfhhHNOR
	pEFurRXvKWRBRz4DpisB+Cpidg=; b=AS6DUU1KlhWf+Sq+epzzCwmKV9Iq0UB5A
	N+wz2p126BQ17gMNLgqClGTyZqoitAYY6eCW2hUlQQq8oWENoQY8RJSDi/jWyX/T
	gQqyD7azxKQ2O/rjbVrHSexFJMdNMQIm676eRBzuVLg43txWncsnI3D5f37KV6hF
	KZqCoMR+Kuu1Xt0xVyjKEYRiayjwvkHzVGvVdTPJcegO1RTXA/AQHGEcF143O6pL
	GNc4ElDokIZiQIDUhVnnLYPURmmyes0KYPEnZHGlyg7QEkiPu6cYoopaSOMBq54d
	PWBZsTeTac46h4ueWzmgCnf42b28dUWNrksyMHz3+rnpmd/WyxIBQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9wpk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EGQId7028926;
	Fri, 14 Aug 2026 16:34:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wg509-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EGXu6v39911810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 16:33:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 587C62004B;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34F0820043;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 2/6] KVM: s390: Fix _gaccess_shadow_fault()
Date: Fri, 14 Aug 2026 18:33:51 +0200
Message-ID: <20260814163355.227191-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814163355.227191-1-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3kb41jCXGi5Xc2IktiwA3mQktdkzYxX6
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f437b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=nPGPQeRDbKebYXXOS2MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX/u+8dMJmrZ2T
 BgcPpHaO1Ha00vcH7NOtlIlOE4ifCf8ePvji2BNH3sfNC5jAqF/MNMCnzIN1aUbdEvg8UU22yn9
 uV7ajxPGNBpUl2CLAiJj5qkMqwhkPkRxSWdNxLGZA6fJRZCv7kQdVDxjzlnMiwW6opiqSuLEd0w
 09OOAXztnibtakvmCEpfb/9NRvUuc7V6rX/diTWfAX+92t6hGzo+QfXNlEGtZ9PqdqaYbAJ8tcA
 NhktLybZUkipPKCm5XwAtr4yA6KWRgoNM44nRtNhSJ8Ay/APvzQrnT2cuxok2o88KjAcrNM/XR1
 TllU7CEIGzBw2gGU1C2rUC3XAZqjXHDlRCjDN2nOrWKEeObT6xOJXBM4vqiv9PodJzYYbNRrcaN
 NE3pllyRV3pSl9gSWcpkGgZFl9jebqgcqto73+12YSU6srC0N6oY5fJnAHaPV/2De/+DDBhzeBp
 01yDlAlhsl6AIythM1A==
X-Proofpoint-ORIG-GUID: 3kb41jCXGi5Xc2IktiwA3mQktdkzYxX6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX/9nxsXAVR+z4
 9wsUGIgXS99Msha/FhUZxaWmBWg8atIBVs8n7FqK0Fi4qBMTxUhDob1AvHfAWlRMKZ/2rCmKt2R
 xp+xjZ4CmyrsohN0IP7XwNvhkj2kihQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140126

In some circumstances, it is possible that the page of nested guest
memory that is being shadowed is not present at all in the parent guest
gmap. dat_entry_walk() will not find any leaf entry and return with
-ENOENT, which will erroneously be propagated all the way to userspace.

Fix by manually calling gmap_link() on the memory of the nested guest
that is being shadowed if the mapping was not already present.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 36102b2727fb..7c1f614ec314 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1593,12 +1593,25 @@ static inline int ___gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg
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

