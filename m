Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FCA39D3D0;
	Tue, 28 Jul 2026 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258447; cv=none; b=UZL5WR999xdNy87riqpYa+JDk8r7oBYG/Hkd4fCzCeDmeHod6dZM5NLFSyOCToRDcG9m6G1YoqpMhorEU5rSF6qXQURsuF+0VdG7O8bK6qNeRvh64gAJaBntigN2WjwgESuFHowL4IDhJj2nhprj0R3ES72VCtWM1QmYHRWRvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258447; c=relaxed/simple;
	bh=FFqVMgQpp3Ae53IkoMxa7b1ret+B1w1pxXomO/ex+Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnqQ26zsBAFpmPocC4II77hRg4XCiEo074LFI70tH3jytt1JvSn+6L0DpJSWocybmbKv8KapOjaetpWzuiy5a4m2Jc+ywITiZsAcgUmorW+Q7gNod4AvZ406yQo6ToqUvw+jUcixDurrGjy43OE9mk4MsN+EKP+NMbCmDfdQLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nj99EW4i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nj99EW4i"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEm0s11491756;
	Tue, 28 Jul 2026 17:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g8XyqZpiMksyjw/Jp
	swVeqbspnLPls3dQtWs6b+3zJ4=; b=nj99EW4ifYCQP6Wsu6m0OCcjMQnfl9u8u
	FrkVJbia1i4Tzy4ZmgNvkD4VLYy6tq1tcdwkCgm1jqiRRlzRqz7VSLhhWuqQUq+U
	X5fyqWWaPZFZu13+9Qa3nJmzTEGZZXrMfZBWkI9D32Fvh/Q2BgUKRPKjp4LMwhlf
	Ewxl8uuxMAB9eoW8l4orRA6WxIIGstFdtmCESwBrHj488APQY4cVIMuVluWMLiV0
	5ZkCy8coaf+1bzFabBZUCDFoY4jrOvaOUKFZArYZgNQF929R3gKdeJx7Kf7nDMYY
	RojmT+gWj3wMJMvLlkXJTKjVhl3a4DxBp6y95QOAYzb1oekKPiAsw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xphrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuEm2005265;
	Tue, 28 Jul 2026 17:07:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgarnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7EBB31326610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26F3820049;
	Tue, 28 Jul 2026 17:07:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3767820040;
	Tue, 28 Jul 2026 17:07:13 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:13 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 05/13] KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
Date: Tue, 28 Jul 2026 19:07:00 +0200
Message-ID: <20260728170708.294400-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nxNRJDox0aI8I8hfPkVZ-K0y-hsRFxH9
X-Proofpoint-ORIG-GUID: nxNRJDox0aI8I8hfPkVZ-K0y-hsRFxH9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX0FJrVJLQ7TtQ
 boQHOrhttWVHatk+gOd3WaZJ3Wzl+KDkGKvPaMOat6YCHG+N0Z6nOCNviYaiamfS8eXvx4v6DSi
 WOCdeP5367H/zt6jL+lgEDs2eN5idLI=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68e1c8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=qtdt0r206yBj_IGTItsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX4dZyl4TamRTp
 djndJDA9DCcep1tdPeWsRWEqYZQd0i0DOxXOMQmAQlFVfgc4SgGhZbiOLL7N2tinbWlSZAo1nAI
 +U6NcTcogZ2AuGLahwamBds/J10fYDamyH1u4JsUF9EJpC7yr/e70t2k8pEjUbFC6XUPx1JD4Xn
 Qsq8z7WCj7lYBMWd3lXAbNschY5gjSJrc6e2KicDyEhdwq/kr7kHKsPyUParxvsRb9ZiAUgNhhV
 z07bnnvbXDqkXs3nvHQpZm5wbx4A6jDAiZS02UCrGtYwQh5fFI97KI3uYQpsWPLzaMnDCEX7J+q
 lIESOR5UjRUro533bNh7QjQpnx8SH8K1+JgAc/DE4NWpnYhPIn6WIKk1ca5kP15RWlGQ8lv1yW/
 HUXF4qHWLdR5fCc8NAEbrZTpDPiTLyX7SKnTbjgjQ9s9t19upgryyxnNNf1/OnKkf0fObQ0gvaM
 l1R6JMKx3JFEM6lmtpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280149

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

Fix by adding the missing lock.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7b37e410d416..82c6c8632e1b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3870,7 +3870,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 out_ucontrol_uninit:
 	if (kvm_is_ucontrol(vcpu->kvm)) {
+		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
 		gmap_remove_child(vcpu->arch.gmap);
+		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
 		vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
 	}
 out_free_sie_block:
-- 
2.55.0

