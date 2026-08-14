Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2A3CB8FB;
	Fri, 14 Aug 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718457; cv=none; b=enpKAjObQ1TBtA2UgZDCf0y3y7HDnHwlh3uEAjkaf0nS3H12hr/IhGVEXChzzHvQrIaSWviPxsUp08BaftgutjBXVgKj95mbODoJNLJeUONsTUUE4p5IUYaZ7HQdT+fuTsnk4gozyAWAyqJCs8BLhp+MQu6RZAm51IWXN3d2Sqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718457; c=relaxed/simple;
	bh=VEKAH2aG04ikBOa58wfLWv6i5MqNixHfm/v3B+TXtfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsG4hsZWim2gVOUq2zXQDeJw9IhmPSZnZh9LcQ9xncsQOR7RKN3ITx0zkqPGV3JE+w8BouBFjIsS3vJNn7oxddRpb+3f6+k95VJ2XS5n+mwgUY7+aJLhYSAqA7U7SO0pE4eQSMb1dk43/HWFsHR46CUeSYCNVNtOF11ZS/b39hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KZ62X/tr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KZ62X/tr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5iI31248029;
	Fri, 14 Aug 2026 14:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1hBt1xRXRrpPDYAMS
	UBIqNuNmxmAp4rOicpCbXJ+0F4=; b=KZ62X/trNuHT5kkX/RSBUTOMIC8d4DOPT
	werNAGgLDMlj510JnN4uAqHNTdbOFW6Uhvn6B+zYSlGimMg7/zSanEdif1tYFZMN
	swLk8VOiHkDmdg93FNmyH05jGkRqZVOfWn0wIADXeHSXgj+ew7tK9mHsTNn5i3X8
	DTVVkyLUSAVhwfJ0R//NoKkzqSe+utIMqxcMiTmN6kY4kzA4jNX797+zkg/QryGn
	dDxQAWrbUdNqGETM/oPQimr/+/+AELa3qak/ldEPXkrWCaVHt6XHHXH4QPaZ/TJB
	cIz2EwyqcuTHUrVyJyWpgxiWwuI8PqUONzC1iMu5hF4zWfwx/Cwmg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3c34m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEQIbO003910;
	Fri, 14 Aug 2026 14:40:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqftv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EEehp615860026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 14:40:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2065020040;
	Fri, 14 Aug 2026 14:40:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6E422004E;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 5/6] KVM: s390: Add missing srcu in kvm_arch_vcpu_ioctl()
Date: Fri, 14 Aug 2026 16:40:40 +0200
Message-ID: <20260814144041.169025-6-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7f28f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1i_NNJWgbIsdAUWwImEA:9
X-Proofpoint-GUID: 9VAmW-eZ23UNx-Ftx3N0-nvKuvA7x9jx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX/W3xgwZN2csl
 +COX6sPxz4wtxT4QyZOGJScZ9dsK3ksHxunU64q9JQY7vkRR6emdE4hySe1lDBXf9oM5cTfYT6u
 7DBB6826nYepsnVUhybYlOV4yDA99SlrIv+oInwk/JL7+YA0R9yDpgpv6RedUycOlBG5qcvaKuA
 qexR9IIofPLyhn8Wk5psyLE5kUm5bHU2VRgz9wWT5O5YNutUpPUmsXnfe94QruhGxjxhXenei3Z
 Q2nf5nYaG0Bd7nRauOvlUG54Op3Q5nPj8+hgfLQ0xitmorEOTTh8F32v2xoIEDoztTV24ASQEJ8
 0wuWpInger5dhWvbnLcGjN1wf5+cMmmWNuDXup9VxwJJIW2j6gRvYi+3p0/TcKLK9P68fptDbA5
 VQ42PETfdUIDXlAufdib4iQjsoZdBWS+w2We1b2qjXB/QSaQ0DFca39fIFHwR9oY9KXyvd+kcmq
 LpYLaBn9AuVVmeejPUw==
X-Proofpoint-ORIG-GUID: 9VAmW-eZ23UNx-Ftx3N0-nvKuvA7x9jx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfXx5pBghOfN537
 AS00LsvDPAJNatGyqx2Z7Mv4H+q/Y4FPdffzPXCSwDCH7R70i2NHjc8G86gDitWoMwQEDqU7i1n
 FwMNkfMGs9s/8bTGl7pngXO51U1TsBM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140111

Like kvm_s390_inject_vcpu(), kvm_s390_set_irq_state() also needs to be
called holding kvm->srcu or the slots lock. When fixing
kvm_s390_inject_vcpu() in a previous patch, the path through
kvm_s390_set_irq_state() was missed.

Fix by taking kvm->srcu in kvm_arch_vcpu_ioctl().

Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
Fixes: 062e44a9319f ("KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 50eb72447fd5..7fb5a566e2d8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5697,9 +5697,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			break;
 		}
 		/* do not use irq_state.flags, it will break old QEMUs */
-		r = kvm_s390_set_irq_state(vcpu,
-					   (void __user *) irq_state.buf,
-					   irq_state.len);
+		scoped_guard(srcu, &vcpu->kvm->srcu) {
+			r = kvm_s390_set_irq_state(vcpu, (void __user *)irq_state.buf,
+						   irq_state.len);
+		}
 		break;
 	}
 	case KVM_S390_GET_IRQ_STATE: {
-- 
2.55.0

