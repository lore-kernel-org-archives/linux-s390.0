Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8C4052A7;
	Mon,  3 Aug 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760853; cv=none; b=ah5VIxXmcsBl3RdlWGCUiAKykweDO3TXyVis94xe5yGvhiDWEcRSOr4eWjJhxzgqHHwb0RgpAtKI0eSBNGdLGiorHlQ105XiH6891VfdD3dQlWI9mGqE8C+iORalKLMMhV7q3Wf+5bjujpxbcPgcwFATuTAp+qfgQjKMZs/V6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760853; c=relaxed/simple;
	bh=PFR1XFwLxC/X4367EBT5xBpNjMhUspJXsUabptoEkM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7m+iBVPPXconslkBRTUA9NFO5lT71doD7/trIRxmIuJiK5wCi8nuF4ppRQTRYsCb+QvRLcf0+Kw7Ls/Mvh/qpr2uaN8flvd+86kXCKcXEwZVnGiCl3n8PGyeIeFoNn7yP6Nz78KIvRwHGowe2k0Ch1/bwTRtj6Fj47j5SOkZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MLpefCFc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MLpefCFc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CIAN81938639;
	Mon, 3 Aug 2026 12:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n9+ojDvm4NA40kUmQ
	i2tKXfo/PA1HooW9l+BffZSvho=; b=MLpefCFcSkbvfkd0jeKgQljtaeX6daZbG
	KGvdvXI9jkDQISNdje2m3HZEi0O7biB/cvM3M9qie6oIWpM2K10zcrY6lg72vFJ4
	vk96YwuqKiQxro9JsxQxbeALsYEzTA4iz25EWmSogl39sNWTLXJn5SA+CAxixUHv
	3an76o21Ap4VWdnQgEggQ9AETwwl3MIa+Nx5UpjNOC8JUpZhpfeHFGOWiG1p79YE
	64CjIyUIJk+LvB3GteSSsEKoLUJf2lAoP65WEIC+yIhEnhAV2BkWV+0wf37bD4dN
	iXzI9yqDcRMRfa2ZHHbXtFhFdwGSklDFx3Q2kXstqVH4Jp6xx+ATQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgqcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CBcuR016815;
	Mon, 3 Aug 2026 12:40:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwe5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CegXm52625858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD37820043;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8968F20040;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 03/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Date: Mon,  3 Aug 2026 14:40:30 +0200
Message-ID: <20260803124040.126471-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX1JwEQwnhusj0
 rYQUvR+GjKuH3f2GPeBfILQ9U1MjjoG6W0rMc9V348nfn1hqu4ICO/UeZljI/Polps2plLjon6B
 hxJClmBbPm9oz5NIlmo8Bd2QuZPkp58=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a708c51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=UbkePC3kHMpujdsGQX8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX/V1b4PMwDkXM
 e8ajnbFIwAecKOgZUnwA3nOeT/iI0TXrzk9ojsYhB/wU/qgs6jbLpEG1J27rQLtPVLgqla4CzpJ
 /1kvPGZgBlOlyDUT3oN5QKGvhAr9irlm+treDVL8v0MSS52JEvCTyJ3x41HI6XKwRSv+GqOqQY3
 fhKoJX5QdFyDvQILFCI5QnOJpa1bSr/OVHUk6aq95ppF81RBLfQaXGhP6oHFNk9xKF0K/Z5Pohz
 OSXlcsYjCFSGZo3qslirkKRnnFxM7Mjx5UiIpqlwPOxwRRMOIe6/sK5k20q9wUgnS7QLyCQiZnq
 a0GTDB79SqgCp5SvxxwaCvRnP9u76yI5Wt6q+qWWhONEqtMB8ALGffvnCLkjiRZVzw0tuPzJzdm
 xMjm98AV9NtE1yUWdK+VuxrZUhF9bxVgWTnidm/MwOWXEAcVc7F8kqq7Vocp81r1TKob68mvXIt
 3PiqTY9l2lN8mep2SZw==
X-Proofpoint-ORIG-GUID: I6y2qYh8k2PlMIGl0-hXqpd8hIOC82Y_
X-Proofpoint-GUID: I6y2qYh8k2PlMIGl0-hXqpd8hIOC82Y_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

In some cases kvm_s390_vcpu_unsetup_cmma() can be called with a 0
cbrlo; in such cases, if running with V != R, free_page() will attempt
to free physical page 0.

Fix by freeing cbrlo only if it's non-zero.

Fixes: b31605c12f4e ("KVM: s390: make cmma usage conditionally")
Fixes: 29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle handling")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1b3290a5ad1a..9be27db0a21e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3678,7 +3678,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
 {
-	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
+	if (vcpu->arch.sie_block->cbrlo)
+		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
 	vcpu->arch.sie_block->cbrlo = 0;
 }
 
-- 
2.55.0

