Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996C3D5C38;
	Fri, 14 Aug 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718455; cv=none; b=ncDKN7kUgv2HCjKm8TrKXzw2CPNfiMrWPzcXcY1AQFgB6mZ791F9jCnh0dOBSAMIZgqBPSNN75cMNVu5veCPolRWu+64pyzgPc5kkoRjI2zd7gBSlYP48VMWLyBZx82yWjrBcimZCU4rmbA5io2xZEGfzrycDQ0lf7c5BbU8YTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718455; c=relaxed/simple;
	bh=uYxD6tuGNGadbEzwBZNZuVeEt03Xxbyj3l4NXjwaXVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr22y7ykd/TeL5gybMms8eYsQNdgPlNwZdGaSZ6qUJsQyCwNkIpi8BozauyukoLR4hsSWeiMkQcS5GAvre3GPlj9HM1bGNbLPWFdudIE6VJDoQUHRDGD9mrLjyc73Yn7HkHpCCqSFQqmmLvUBIXXY37gV6JuQobLJjo+LQlUaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tlfKSjEs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tlfKSjEs"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5x411290155;
	Fri, 14 Aug 2026 14:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=coCVDWh+/kTksNPHX
	lLkpZ/Tkgvft3DVQ06AbqFqkeI=; b=tlfKSjEsgHzx7gpeZwXahZWwWHFvNlL2j
	TKDROIzyu1ThWOzFVza5EC8Mqo+IRGBWQrDHY26buHyEpStcuyiNMu4/xfU8GbV4
	x2nEA+XugPQHrmOqHAvXplb/Y5P6/ndqdvpp922y738hnUoWYUY2W18fe1K75xAB
	kpdN3Xmz9IEkUxan1QHHqb9nNU/unuyi6kv8Xs2eRctbYYnJBKxKz68FVuMyup51
	vIj7Qy5j6bPYxsuNO+4qMnRge9Mx52bcUclFVGlmOS+qMca0/sz39z6V0gl2jCAT
	kUvWjzp+ZqPE/Qgb4jZvQgk0yQlO+OQ9PDiCEjevIWhec7AqoFeFQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9w7k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEQbPA013118;
	Fri, 14 Aug 2026 14:40:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpvad54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EEegJN37880208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 14:40:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D8DF2004B;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680E420043;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 2/6] KVM: s390: Fix _gaccess_shadow_fault()
Date: Fri, 14 Aug 2026 16:40:37 +0200
Message-ID: <20260814144041.169025-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814144041.169025-1-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JUbLml1G-K0KOS7PaWaWSR8yH35Y7RF9
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f28f1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=nPGPQeRDbKebYXXOS2MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfXypawup8rVJOT
 dvKpMzj3nmlejlgIw+Id93bxPI+ec3Pq7MVcGetv7xXKrTrHLamIIxLCfUQwNypgwm2NgUST3Sb
 91rX2ml9FyRyqtVjJbe5JerWy+G6/yQQKYSLOjoruGcB8x5v0A4oqyPbPUcdJGylbw93aQF/uM6
 SdhTbY5w1pMf+FB9NxFeTJvHia3ax6nMlqzZtvgtf70KVbqsQEiljPCp0QqV8gPPcOyquJX90Hq
 alq/AUPguzj0WPZbU48aSkN9MdKgMQ6DresfEIbk0/gQOiC1QzumxncROmlFNKDYgQdYrSVaUai
 3I53zu70C2haSwBY4wLvkm+M5Tk6f4nScNzAcchZ9y2oO+K0/s5WfcXwrEW4392tpqou0kcg63u
 20wm4o3vln2LNn8CEXCe3PndLccM3Mn462hroAGsXkAE0r0JMVrA03WNTyCMtCUal1ebVSM5bQ2
 D3T5AiWiaxmQGl7OctA==
X-Proofpoint-ORIG-GUID: JUbLml1G-K0KOS7PaWaWSR8yH35Y7RF9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX9dSHhN3FFPwz
 Ta6YuPsTujJCPzVQ3RTIctXNlIFM/eJwdMWASjOMBLM4AeRtEhxZLE+5cYRZhdnyWevrn/TCpR5
 DxGbgWRNkiE1cswnnyEU5/KL6aFVocw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140111

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
index 36102b2727fb..0d5d46d4c66f 100644
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
+		rc = gmap_link(vcpu->arch.mc, sg->parent, entries + LEVEL_MEM, slot);
+		if (!rc)
+			goto retry;
+	}
 	if (!rc)
 		kvm_s390_release_faultin_array(vcpu->kvm, walk->raw_entries, false);
 	return rc;
-- 
2.55.0

