Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8942642D;
	Fri, 31 Jul 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502913; cv=none; b=ssFMuMka7cQTggFE2Z0ekWZ+v0d6o6FfKrbSxBC5d3Mg2nlZq9o+JecQgOIE5v7bvUMK15acRrdOmOOFg+2Vizyb4+4dUz1H6SsJRSFDSYi9c8BMuUhV7H63YIhNBGznYfZPGu+jNySk4BmqjTeq9s2LezQ4fTjnFFSaB/x8hx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502913; c=relaxed/simple;
	bh=gjC05m1OzVU6ocGE5L+jHOcr3zUGxe45T29GvIBP5+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdjiu4yygYJhmjukFXvxnwZxIgPJDBButuycgFnJAqQbmDI5OKKzSIR8C1qKqZlGj2Wk7m/6pmbK+v5oxB7JicFfd4vfSvZMVi6mfDRS8SDdc1QMnurFxOOmOSEYK9mfLCpInnnzU+eEjEfhsXwrrR9T4VoJcANxJulTQshmvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FItTn5Nh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FItTn5Nh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBli9H4072800;
	Fri, 31 Jul 2026 13:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yWmkzZNBaUHHdbmCX
	wJZMsl7NEMhcYeY8y5RhUHgjik=; b=FItTn5Nh8SpfkXIHrRKh42gEDtSLMMoLX
	hTqC1i/EQdhsqjFLmDOKi5igYCrwAw5IwC1u6xvykmYHWW9JDq4dZWP+SIuGOhKI
	4OpkFMsF+tGKlRq/6Ai0YxecuzpNM06beGCYzXJ0dDAk+JLpETUO2LvjXUqAaVbL
	6037hpztUegpjhzAokX1JaoetA6BqIKK2uKNM1MOpzWB3bU5SPnHRGcHa9cOF+hT
	cV4WHNoTnURCPIs+y1ekHMvkPZnOwGYMSnqUZXkFRknEQg3dOlArNPRaP4aI4Okz
	A57+ZWjQO4IHCeXT4Bv6fsVFS+ovp6iywLY6WH1/biw0jkSK9LG8g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw1da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEM3026831;
	Fri, 31 Jul 2026 13:01:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqs44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1hDl28967192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C077020040;
	Fri, 31 Jul 2026 13:01:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A27A32004B;
	Fri, 31 Jul 2026 13:01:42 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 04/14] KVM: s390: Fix overclearing ESCA in case of error
Date: Fri, 31 Jul 2026 15:01:28 +0200
Message-ID: <20260731130138.173983-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TNZhiXUOmEMjCNrmjudnwxDmuqfza-Jc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX7Ze4KilxOduC
 Qipsf70+eFaNkT5uwr0JwKNJQ0lYDM4naD2fpUOoMqXeM1cmDIhy5em6t5nIovEa8oqhMtGRE+x
 jnngdDAL2u+UyynktUPaT6Bv4cLdcm10xniF9M71nJ70CnMCmJhfeoVEybJy8eBgq8bVooR2XUN
 HGpiEzY0oWKFmBWLKqVWJ2vAMju48FD1MT7frVoLAvubYlSou1CW1230r30qPmuZDJquGnKbu0h
 YhFSIadFUQrEe3N/j9HvIQvLBnzEGnoZzm3xrrleXDF/KRqWONy4cuR5x975MijnG/6+X1xtQgR
 9xM2j+qiyD/Ay58cSYU4LE61YkK57Bbv6m/9BsjkZ5SOhcPJfGpKJclCNvTICIOesTAnIBFM9mz
 lUekKf+jhr3RxE0j4aKKiSTveqkR+blOCdZE+kV3kLP48BOj2G/SfscJAjvKFrsCYdQYSaOyFl/
 uV4XUzKF/SpWAFqyV4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXxotVi0FxFyCq
 UPKSm6g8PNDc6RcV4aVDNu2q5QTzNn87Ox6ODMtYcvv758db9WaI+xDGGeOws57vj4vXvNG3FVD
 k1l84XXf8wtqZOFCLDu7qxPMucmDbN0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9cbe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=OniIQR2WiTFW0jQNa14A:9
X-Proofpoint-GUID: TNZhiXUOmEMjCNrmjudnwxDmuqfza-Jc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. In the above scenario, the spurious
duplicate vCPU is destroyed, but the ESCA entry corresponding to the
original vCPU is cleared.

Fix by skipping clearing the ESCA entry if the vCPU creation was not
successful, i.e. if the pointer to the ESCA in the state description is
not set.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 arch/s390/kvm/kvm-s390.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9e3e6b0d72ad..2acdff130fa6 100644
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

