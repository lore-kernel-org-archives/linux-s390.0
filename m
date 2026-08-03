Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0203630B7;
	Mon,  3 Aug 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773378; cv=none; b=EauM5n6WHQ/fBmee0hegMEGzAgNPk91s//RA/iXLT+oJw3a7wR/0piw5TFxQjkgn6CcG0GqfQM/4fNm8ugqDlMvHaxrl7UP+v18Y/OJz1GtuCyT+0u99vi8n35pX7yUN8qcSCJb5HU2voVg61AxQihRYzRHjEu9+vsvjJtYCVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773378; c=relaxed/simple;
	bh=iCdxKDQWTC5eNzbuePoKcuw0bL5c62Hy+rVlRdo5IFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx98PAEUTD3yq15p6TfvzaH96kHTX32exapTnGngKJTtu5G5znsQsY53HWWHbFsX0rT9/9praLAq8rKVKBtskG8o97sA/LFVXdtGTeCrgR2UV4K2YnEL7lpaBewQ335bDnyBvkn9DKMYCUuL68i6zR9zK89a6fhUIs4mooX30kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IGSQ7feY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IGSQ7feY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHWHX2261760;
	Mon, 3 Aug 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OtvoNQLDbyHO9jx60
	sphk34kK72Hjn+aiO/cJLD1PjE=; b=IGSQ7feYrbSZXOhKBMgao60j3vaHy4b+A
	w1eJuyJZa70QEtzPUyc0dxlqrveaCvE2iUp2ROb3zs256HfLDbNC9GCb5uGp6R6H
	16dX6ck9HMYQuowWCU27hHrWg9eY1Y+JN2ugVbHqu/GgM2pPdY3uzLzsbTCmGNbP
	cX6Tu3UZwbrVnRnRb2w8Zr39tEUShhPDtEmQYX1El8nOPocxv9i0hD82O8L7zbdz
	1GqZ6155bDLxJNBS/DXVyoLgbX2yudxooAsThVnTBMEOD/IUfl3hXfpuNwin9ewL
	EMgGnewN7JiG+1BUBqjkj2c9VKAgMfxzi003jCw42SRq5+4bUq/Qw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3sqtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuHDX026477;
	Mon, 3 Aug 2026 16:09:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qeau1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9RUr39911746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C8A720043;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D1320040;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 19/23] KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
Date: Mon,  3 Aug 2026 18:09:20 +0200
Message-ID: <20260803160924.236807-20-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a70bd3e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=JTb5koT0SCe7HXFO7ToA:9
X-Proofpoint-ORIG-GUID: UB5XdtJHv7Ow418b6Tw9uWBpDQaT5hDb
X-Proofpoint-GUID: UB5XdtJHv7Ow418b6Tw9uWBpDQaT5hDb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX3Ij5dBy1mepr
 Czyeqt6pA6maINqc/MvWa7BzFFIJfmef8UzPit+LOey53aI9PDt3PTVhcj42I+1vLNJwF+Sw0vF
 Q5fg+Ow+TKjIYRYWAjQTGuosz5e4Rzk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX5Uw1PJKEapBw
 W8QxR+BNqIXvEBfSt6+B5QUtUefWtbFA+wYIVay10pmviLl/Gb7USNN48h2znfZtS4paFlpsZjD
 xdtTd11axUZQphNZng+4Lcdco9Vbz6NR8luu1H0DJbFcgIBsL50GpsPQdUkGpjrC5Fjz4spkZj5
 BIHeT6vBvxW9iTiXo9V+D0qLYbNp9Phazghg7MGRs3lt/Eb0dlyOJSGnVwCGjq91CPRdmHaaZ34
 cRg/JIRPTmAp8B+okczrOAeguKX+he/+oSZ3KsCajgyngEj6JPfdV+0Wj4VRgXMPiW3kKVNU7DY
 S7K+Nu4F8wnrltCvCRfxi4z/Vhd+K0S5kExBQ4Q0HKqblF9ELQNx0CxeiPOtF0Y7YDx2BIzJCxK
 05qtU2ZCUdo+eb9gZo9BPpHRIix4/JGHcz7TnljLcB9si/rJywIQVtdRLaYOe1Yhzs44cWmKrJG
 psuKQf3IssM8Xmy++Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

Fix by adding the missing lock.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-10-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ba811f0673d1..2741ca323ede 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3875,7 +3875,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
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

