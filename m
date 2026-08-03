Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336F378833;
	Mon,  3 Aug 2026 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773380; cv=none; b=LXrzsZOcw/+w3fzXd6OWFSSvEaUFILjE9rstMQKvbUb2BpjxU+D8DteMyZoJ2ZplQRDwLMJr0mnURHMrLMWsGjV04F7d7Sq5qr/z0oM53k62g9p9zLHptqPexgsRunGItK5g579C4TzfGDhTXx7ccG0PJipYMj9YMuqf9z0ywXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773380; c=relaxed/simple;
	bh=pwXqUmYYUY+a4yqYkp9V7Ubhoa/FDK74HAz7+jY90QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMUAGrgULVKMOSFtZjQBnJLRWKnlFkcgjR4sfCUpVD173pIFm8gH7ix0pTSHO3s9y9i2rqz5KLdqx0FJTp9edlE0Yn/sYcjzvgcyFFPEKjLPlLylyn52h9yZ8iacpCFfan17WSXC7kEXiRbEsWhdhKJGG+GoNdA7eAXygI3BPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BGJvZNHP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BGJvZNHP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHXDN413691;
	Mon, 3 Aug 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=giK/KNpnKaKyFv98x
	CW2yUvnMsP0QCpTOjbp3pzJ3jI=; b=BGJvZNHPRXOAFrT4DsLTGnZ8opNKPaIC8
	OFSYPslRiaJYJuCUJz8r9Nnrc800okU2vEvxeJIVoh31mexyBSP0DYPHZU31zBOh
	VRQgbLyWxK+pMCMjFwrQIHEVBemoucTL3GyLZT2LQx5UxOMgwi0bZGIhzDfC4GGb
	Ou77y0x8nC9lvEnbIh3COJyS5Kcvj6qDNW0W+8M0XDbAY2ALnEeI1eUze2EcNJ5/
	aMujYi9uufkecFmGpkqLQdfGwYKTlIBJMsdmRL4+A3lOHtFcjafMGLkwAGI4/WVt
	HzuJ1JnAl8d2juzMiMOqYTFmGMMdH6C75kZMZmUR6GIdL8oG7Fsgg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqhp90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuGH4022268;
	Mon, 3 Aug 2026 16:09:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5xyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9Rjm45941130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D50B820040;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B31A02004B;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 22/23] KVM: s390: Fix ordering when adding to SCA
Date: Mon,  3 Aug 2026 18:09:23 +0200
Message-ID: <20260803160924.236807-23-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: CbLGreLhmnohvOSUdu4p6CoTGXQyxgdA
X-Proofpoint-ORIG-GUID: CbLGreLhmnohvOSUdu4p6CoTGXQyxgdA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXxt8Op/KpwwLo
 YaA28KF75CigUUMnReJHGJ+/bU0rr5FoU9tA5rbGKv4NgyxfltEZPb+KWhuXopLBknR5RAltCmn
 jCC4t5kTtRsfJaIY1tdq/+7+CZ6wx5U=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a70bd3e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Mk4uVEwlW67fdkdk104A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX00BPcaITr0WH
 mkfZp4Vlj5/IV7Pj4rzndvztNTxSBM97UOZuk6J05HarH/HgNiSO4TqFScOhZHg8k98rP4OjyuP
 NSEX1xmsVMskoT01su6bAACs7wUc3X1oKNXMjIFVEVqEKklJIRtqbfXmGxDnZJSDlbIyjDDKvPi
 s9qSrjGltD+uWa4LPYEGKM5KzUWc5TsHfd3G/+meQwN71ohkD9kumjuQ8z5YssNPt1ob2/NIni5
 FR2I0S2Bf9+vHhkFBO0m/PIJIHLZAX5WOZ71tjZ9UT+weYuybViW4bpb29WIk88A27buBrTNkSx
 ypvMLBV5rYFuj1YxD6UcNV6SkKuPPTAXxVJmfaqxl8onCduzocA753FjLLdFe1HUOgi+4HbRj1z
 7AsAhd1Ho/CzJ336OfRl/zKqGtT3aaoyQnXrUbjQP4sh2CbfVcyLSAObwC8l06WIWqvZFbS3Zkj
 IHLK8XMBq0VMmed3VEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

When adding a new vCPU to the SCA area, the validity bit in the MCN was
set before the pointer to the state description, potentially allowing
for a race.

Fix by setting the pointer before setting the bit.

Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-13-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9b8a35e7dc82..518a69c55e85 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3485,8 +3485,8 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_s390_use_sca_entries())
 		return;
 
+	WRITE_ONCE(sca->cpu[vcpu->vcpu_id].sda, virt_to_phys(vcpu->arch.sie_block));
 	set_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-	sca->cpu[vcpu->vcpu_id].sda = virt_to_phys(vcpu->arch.sie_block);
 }
 
 static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
-- 
2.55.0

