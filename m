Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375043E49D;
	Mon, 13 Jul 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955355; cv=none; b=eVwDfeERfC/9TD42qRtvp21YvvwzI82Ov4+AT6e+KpjmdgT4NZGkp7pli3iwvyBFg6Mc6fZIr8rWo6N7OCXZiroGEM5tojC6d5YTdvbzGn8Z8clmwt2xXdw9G2UnVdU0+K2eSZGTmlEmoppjxsy+cCZL1a6/nRqdZzeBUMQdm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955355; c=relaxed/simple;
	bh=TxP+xPPnUxB3nUxWCXUkuNC9Al+VspKO6JEiyfJqusE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6w8PiyT+xpzrHi/Z4UW1HuSA6oUN7D4mEnwHuzwQQ5AxLvg8LNlMmXVTMoYdsk5ILN6dhE3AzxBYpOlBWw9XVw+J1yNQ/x/eP7AlUjggvp+Vvn4QfySKYPJxD+l1XWKGUQM8K3E35eUjLbIwXPS3pnw0p2Mzwkt5VanFcBwHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aN1OjRWE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aN1OjRWE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDIdL2434183;
	Mon, 13 Jul 2026 15:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0x7yTF+EP/oOZwkh8
	8K1pJWYWWLZvipm15+0/covB1k=; b=aN1OjRWEse89A+FyHo5fWA7dlivrihvI9
	ED7+8zAuFXhVlT91xYXCuwxJJlqGTBoqI6o4CONnGPEA8N1rT9oY7Mr4nAIh12hJ
	qYkERsGhr1iqjgG+QBcOk4epwv6Oarg+DPbWmujSwBmh23paZh3qkHRh6BoxjrGo
	0G4RlPfYjEakwMhhIOI5/besixMWbngZFtXoy/A5V1bgjOqavXiZ83gVyyM09Qd8
	p0vcYg1JkRIRM6A/Y1ywsyjvVozs+v5bgY2oJ7p4XBQxTGMESd1w/nxTLX8xzXME
	CxFu7lTBB8WVU01h64W1BfHXJ3i3SiLKl9FB0wVhuLT8X98XRdNqg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbh0d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DF4vET016896;
	Mon, 13 Jul 2026 15:09:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg6111-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DF94x532178448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:09:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79B4C20040;
	Mon, 13 Jul 2026 15:09:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4FC120043;
	Mon, 13 Jul 2026 15:09:03 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:09:03 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 6/7] KVM: s390: Fix overclearing ESCA in case of error
Date: Mon, 13 Jul 2026 17:08:56 +0200
Message-ID: <20260713150857.269954-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713150857.269954-1-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54ff97 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=OniIQR2WiTFW0jQNa14A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX6geI9Wxui/x3
 52pIpf7kz6dZReIh0aykdi8CriR1Cs5LSVq/ThY3N0hmeDmTJY24JW2q3hRSDYrgxH7+xjczFF2
 XjBEsvzVicG8vaAPA0cHhuRxBka6nYEmD5yiuubeucdHZWru+/OK/Xo+JMPxznsWzIpQ4sa1dJ2
 4w5NNHXgfOSaPhQjd0x4NzOiO81Sm4h06Ry1PeLbSW/98TZGA7A7AFGZEFKV93BiKQH2p+HTJaY
 JmhOHYPoW0Rub9dum3h5Ahnt18nLwFdk+ZpmSxh/D10HxYpIhzy/JEXtg4s0vtZerS9ZiWB/uuG
 BXONaPXSU3slD1NDLQV3sNDO0WBRQowuhDiIQW0eLu+o+QrWWRaogHYtWLz0FIKwTf4qL4+cZHy
 4dssGY8bq0wwUlXoFUjqfjvcjVr290+y7fah0yLO2qXAIZaNc0nbi+fGy9MPfZTO7meaQ7cMn7k
 WLG7EGfPzLWnvuBbbBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX55Nwu295gVQN
 swPbEfO4GNyqAvqFQbn2gLvJXUlhnJhYFdqJPTM0LmVImTJoNahHj7TWrDKyy42tGs24w+7YAD8
 q3tRj9O1Y1c6+K/uzQuWOyEyV/1oY4U=
X-Proofpoint-GUID: wNOhRvPVmKGw0R9bTd-KTjIxmEVmcMoW
X-Proofpoint-ORIG-GUID: wNOhRvPVmKGw0R9bTd-KTjIxmEVmcMoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130153

If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. In the above scenario, the spurious
duplicate vCPU is destroyed, but the ESCA entry corresponding to the
original vCPU is cleared.

Fix by skipping clearing the ESCA entry if the vCPU creation was not
successful, i.e. if the pointer to the ESCA in the state description is
not set.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fc0a884d7f54..6339a327a7be 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3458,7 +3458,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
 
-	if (!kvm_s390_use_sca_entries())
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.sie_block->scaol)
 		return;
 
 	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-- 
2.55.0

