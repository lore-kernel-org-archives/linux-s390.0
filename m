Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C108369990;
	Mon,  3 Aug 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773378; cv=none; b=tCIvZA4/RWC+m1EQsn5gzU6oEvPgm5xlQ4A+h94Gh2sin6iWhcA1Oo6ymNqgr71roEoAVyCmOrZTCpbWPTVeG8fbjbomw59YMcXLLZhI3I0zgw4KtEBZAjitDBXO6Fi4Dd+ov+MIWB/5v/v5ND3GiycpWt4hqNeCOASUZxX9mSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773378; c=relaxed/simple;
	bh=yf9Yectc25JSpdMsJ5XIssvXqTVjTR2TimRSqaP9T54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVn40TIlVoqDZ5LBQngtjrHiFsDRN3zuRZfeOG3Qez/HFtXelZRRGrR+cN0622ajhBSNGEXBI3WIYrTrnDQO7yIdcVgIORAmb+fAaaxe8erxv9WqYkuf8xkNK8BXn/SX2AXQccGPaGZZncD/0xF49+iTJWzGWxldY8F7N9yz738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sj1yg3eY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sj1yg3eY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHXrP2282530;
	Mon, 3 Aug 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ExQZvWnBnPmHyUh7j
	3fz/GXaW4K4cnhvKL35V8HbPS8=; b=Sj1yg3eY4WJqgcxRvZGhubzlq39ev04QR
	r05y0o5tPf3RtKjZOuMAivxIr48V132bMpaXtHI4BIFTpu+ICSUmncLx2w7g6Uuu
	znVJbCEcM3E+oo9Dn97tYVzF1d1wVCyEM2ki20uxPOgQDHc+h+43LKkGHJ7mqTDQ
	p+8D9QCLCPtyDd6dUweasMhN8Fb2XzeU51AGD8ZeW8MfeMSuLTVY8jo1E07tB2hd
	/7Tsu7UrRtyxrMjCrt8TyGW7v37mnGI0BnMLqmkR59M9JxBDaR52892eAipBOq7/
	bF/QiaYBwNLCN6G0VgHa0nHxi0cK/FIAFBuV/wSx9d3yMCsp9l7rg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4sqf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuMMK001231;
	Mon, 3 Aug 2026 16:09:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvx8kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9QZc42926486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE5112004B;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4E412004E;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 14/23] KVM: s390: Fix overclearing ESCA in case of error
Date: Mon,  3 Aug 2026 18:09:15 +0200
Message-ID: <20260803160924.236807-15-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXwT24Po9SFSYc
 wHqFFKlPQnUuoiwW/MpwKYiiR1SECNwS78XBEBECa4mfu2lkJxw/uRyk+Z9qIUH+8kO9E9+HgyG
 3MHlA7xKme264JdzlOe4DE4C2C5N4Y8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXzOgkK5ktxYMu
 VyMbpXIb/+yt32OwSvfbIYge2tolBt6Xt+Aa54vHvs7fywZqlVuBnK7lhchfkHl5dwILSOCzGZR
 2/Hi74MN9+OVfW5KmNW64RmwQVXhDK6o1HtBigEPSpDPFnBYCuYTtwU823duAygkstqMOX/C0BY
 hn4kTkGsshq0l176Z+DFr7UsiafUlnw8R9rdd2tDtHGDDhRBUQvJPahiNAqSiq86ZI+1pvTgrsG
 V81GOY4jxIzTwdrGYWFlC0plDTPwurPGMZzWKGGnEi7FpQ3LZsojW7zlfgkfpfZ+mqWPiixHvl8
 yQwcL1ZqS9cS95N87DKi/HfN764MNx1szr6F/a2ly9PVbbFn+w8JhARuWWZn7CJN4euSqsn6ZpR
 m/dkvfqM/IPvKC6pE6fXlviMH9iY4z+6Dh+hZYHfc0pik7sHmEPq948Eq4ii7i0je0wz2HqCZo9
 HQHRzVJtTiWGfpB4WlQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a70bd3e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=D5IZcPaqysaIEbzteRoA:9
X-Proofpoint-ORIG-GUID: w8cjD9ka0vkvjA_RW9X2t4o8pKFKXxCk
X-Proofpoint-GUID: w8cjD9ka0vkvjA_RW9X2t4o8pKFKXxCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. In the above scenario, the spurious
duplicate vCPU is destroyed, but the ESCA entry corresponding to the
original vCPU is cleared.

Fix by skipping clearing the ESCA entry if the vCPU creation was not
successful, i.e. if the vcpu->arch.initialized is still zero.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: abf4a71ed95f ("KVM: s390: Unlink vcpu on destroy - v2")
[ Added Fixes tag while picking -- Claudio ]
Message-ID: <20260803124040.126471-5-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 arch/s390/kvm/kvm-s390.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7514d9e2403c..bb4e72466043 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9be27db0a21e..5b2727d7dfd1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3462,7 +3462,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
 		return;
 
 	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-- 
2.55.0

