Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3645516B;
	Wed, 29 Jul 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338986; cv=none; b=P/53Jzn1KufyQjw0xGFjPJrfxWKM9CZgDlgm791/yUgJAeGqAc389zp2wsWKdfBdZsbJEfqlIt1TcQHwx1q7VsTz/JhOW2yjHF8Me3Cq3oTHqnEosAZP/gBPsiJm6JQilOhApnJrhvmoTvCBAUj3QJmnp2Zx4J1jcFGD/EtBBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338986; c=relaxed/simple;
	bh=A0i25W7MlkvjzeQs5wtngaZo62H/Gv/6M9BbUBUH4h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTlCB8ZqJw2EuALzOjlRvFm4ZIp0qbm2i+8c5Qud/4GE2pn0HiII1W3PaquIboF6Rb3hHcou93OLgeOQx+StwIvrRsUHQ4C9KvwS9YlsNow/eDEKhCUYfiAq7uZTBQMPttO54F8qcDxJh4H5Qph5oBQ2/ZDE7k4Qxn8Y/Z/D5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P72H3Eq/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P72H3Eq/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHZLm2684329;
	Wed, 29 Jul 2026 15:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=syx1RmfvDe3NQRynO
	3NqRemsSeiyDeWgBlgoLuLrFdc=; b=P72H3Eq/jT8yf+6KmhXJOsjUD+8bN9GIG
	PqqSB+76G4gmTtfWT3KzrMUy8jgqoNUPPHzviH4s27qGORJ+ngbgvHzFjSrgqOOi
	gIO/0P10syDW+YetHKXAaOQEaZpI49g0Tdvcsy194RyKikIvBD9OlWviAGzpB/pu
	fuFIw+KvWUtxNYnh96rnqSKppTn5PmPTNHfwQ8y82gid6G6lreofk/g7mNA9kcyq
	NeQXJUlyyW86MvdHEq9e3sR2wTYmTIF1m3t6rVhoc46wAg+dxQXS7Hr+SdbXyCmV
	rE7owKDFna6f5leF/GLearTpnoOqiffL+ZbZkrHvvVgUV5TxRkp7w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyckbry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQIxt018566;
	Wed, 29 Jul 2026 15:29:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk79wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTcPX45875696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E51F420040;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B64D42004D;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 02/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Date: Wed, 29 Jul 2026 17:29:27 +0200
Message-ID: <20260729152938.782383-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729152938.782383-1-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sgH4-LEvW6Shc0Kh11GWSTDBD3gwxmRS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX3FeW0ohd1lUG
 AsgIuA8rxx5nkEQYAklJ8GvSdI2Bt1G+GKDKlz6X65ZM+DUZchcgRKDVsmVeyF8yYAM/HNKdVB/
 EGcTvee3KTpkGg/RoUpipVK2S437aek2FbDp3rJMkcE1RaKTqRTpL/HFxqgMSkSBJ2/ltK0ZINx
 +1u0qGNCBHPbgFMoTnIZ+8jBxESmAGm+ZJ8oYzLZyQgjFBXgK34ka0+3Vw2tY13JXnv+fwcIPky
 NPCyJH6Tl0qgl/CNqJNRdv0/G3VOl126RrsES/oSOCnISwcELh53YWrGlwXDKrqhjY+fDuNPBnt
 7sB9c3T4NH5RtR7YuQiP/5bJdspmiGkWobHQFrprhbJKWiyw4Cx7NkAGwThPgLiISt0BncxIhgt
 lQJOKy7O14hjODVgRzE2aYPZqYIZaZPT3+IyGBUrL6AZqqP52one5le50eWL69F73LfcrreMfdz
 68WvQXSs9S2HpUXmBBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX2gitL1DPwAB1
 uuGGvCnlR7R9wCJOgpTXEUsaxlEdFul2kUotwsG19Akq9GVshqZEMBsqV5RX/YZ5+WAp5yDtmDe
 im6FrVz2NavHOZDUter9sP3Sead3wQU=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a1c68 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=UbkePC3kHMpujdsGQX8A:9
X-Proofpoint-GUID: sgH4-LEvW6Shc0Kh11GWSTDBD3gwxmRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

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
index f86b4b0b356f..9ec5833a0973 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3677,7 +3677,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
 {
-	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
+	if (vcpu->arch.sie_block->cbrlo)
+		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
 	vcpu->arch.sie_block->cbrlo = 0;
 }
 
-- 
2.55.0

