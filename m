Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC8213E9C;
	Thu,  2 Jul 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005861; cv=none; b=JllwHtL/FdNDGSm9WicBtKOyHv80Wf1hYM7oiSM3bmPcQ+X5wmFjBaV0eZbPlV4usbi6WwcjInL4PlLMnxOAI2pjt+IaCTT+cao1T1tJ4f7WjTZ5nfTtOsFUH5xKFjcz7cWzZbenGzqp9QEV7FqiWSfz+iyeIZdK3tBC4E95cLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005861; c=relaxed/simple;
	bh=tUsMRhczOrq0LBIex1ZH1kPoCws0xjxxWYT3YCoKmeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ/Nzx61JnikgobnyCX8yol/VHOl2+08jFSrbuJzioWBtwPy6aZtU2oHLpSVDTp+U+0K71PQ/6JJ7Xz5x+Umn+9vrt6V35Ahd1pJ2ekOjAOHT+CK6BOuYWTjykPsKu4juTEQOw3FkqZ4oRVtXagtfLKZmIOF1NWUdpsjXtas3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jbAnPmFW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jbAnPmFW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIJov4015614;
	Thu, 2 Jul 2026 15:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fB9vf873jATBry5et
	YaO3rIGlV90uoSf0Bzwq4K2zZY=; b=jbAnPmFWA23Fh8RFh7SjW/9jBhOpOFnOF
	0Nqf5eJdXskpy/MTq4ZubHpQxjiFxU4mbftFOtU6TzlLxWVbG+GtDi013V0dDuWa
	DS0QFWqwC8Equr6qZlV3+tpDKjaBB/TQ9IGGqd2aVoRsrKPjIJ2fsl6+M6FHP4Al
	tBeXczxX41VvhKORDSccqr252+1xo1mnW2xPkdMiq9yJd2GL7gOFM1NkkzoMQu6T
	iubERLKDP6Pj74MTYL6Pso5xP3TVDtyE7kqpASuoDcysMF+R1qbOLiu0lwWmTM2k
	n7pP3dLxOyctwb8/yzt1FuQZKzQlool9OJ57WpyyCBI5QRgOPepIQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qaa9rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJknS016352;
	Thu, 2 Jul 2026 15:24:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhmgk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FOAQi39911830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 002892004E;
	Thu,  2 Jul 2026 15:24:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34CC32004D;
	Thu,  2 Jul 2026 15:24:09 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:09 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 2/8] KVM: s390: Fix unlikely NULL gmap dereference
Date: Thu,  2 Jul 2026 17:24:00 +0200
Message-ID: <20260702152406.204782-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702152406.204782-1-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX2zsYfYJKYL45
 8J0JsgCNiHuGVVD5brE6oSMe/tBCv8BpdQVc5nNXq9VUkwlGOrW0ZTVX7UQxSC1I7lmTFfDZ8hm
 6xnMdpg4gRcF6/YGcjhseajUOlKjrN2aaSpavdAky2n177pH3XSZTeXQplIPV9GqNHuhdfDmALa
 lu/6cWOCoMua1fifB9EWSbIc3tz4xDp0ub+lZzV0TH7EEyS2Qgd+iAWXfgnwg5W84JBsLY33mNq
 kvFUNAAH1JYaKETnHtE1Dft9e4ell13cTuePyluYh/iTxDi5FqfqHQh9XHNKPCmg+zyOYUJWaJi
 8+cleIqBcMfHyJ5CzbllOghisD1Bw6fZuO5SONCn1y+2ReFY5puv4dS3eCFjFbonyVPf7prufpf
 RpS4Bhlu/nU1qXedjacWv71MouL13UyZs38DSW6shkn4BNzMJTAdwuvWLbRAANOmQijhNWOhfnj
 3lZtawl2S5ocTj+igwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX3Ta/nyuABKOh
 U6OFkaNHp9P8AHw1jqiAC6gbRtIVWT7TjqUBDMABoWLGWXQXoyfUw05nXnKi4DeMf4eZ9ORyL9S
 tfpAsrudnYgoy/KwAqwG8itIWDOxNWU=
X-Proofpoint-GUID: 0zTI2uKWSvrchTUyhFuT8qmyaBEQ9EYD
X-Proofpoint-ORIG-GUID: 0zTI2uKWSvrchTUyhFuT8qmyaBEQ9EYD
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a4682a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=gM4Du8xaWekBHLCPAVwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020160

When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
has been created. The new file descriptor has not been returned yet,
but a malicious userspace program could try to guess it.

If a malicious userspace program manages to start the newly created vCPU
before kvm_arch_vcpu_postcreate() is called, __vcpu_run() will try to
dereference vcpu->arch.gmap and trigger a NULL pointer dereference.

Fix this by moving the initialization of vcpu->arch.gmap into
kvm_arch_vcpu_create(), which is called before the file descriptor for
the vCPU is created.

Fixes: dafd032a15f8 ("KVM: s390: move vcpu specific initalization to a later point")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 23c817595e28..4a6d903e3523 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3604,10 +3604,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
 	preempt_enable();
 	mutex_unlock(&vcpu->kvm->lock);
-	if (!kvm_is_ucontrol(vcpu->kvm)) {
-		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
+	if (!kvm_is_ucontrol(vcpu->kvm))
 		sca_add_vcpu(vcpu);
-	}
 	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
 	    vcpu->kvm->arch.user_operexec)
 		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
@@ -3850,6 +3848,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		vcpu->arch.gmap = gmap_new_child(vcpu->kvm->arch.gmap, -1UL);
 		if (!vcpu->arch.gmap)
 			goto out_free_sie_block;
+	} else {
+		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 	}
 
 	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
-- 
2.55.0

