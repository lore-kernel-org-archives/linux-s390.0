Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B636F8FD;
	Mon,  3 Aug 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773382; cv=none; b=TmPWVR+dWGHq9CBIJ3bAykrnRWwDpUNvrgqgT75qcLxfYwKdT/cQ6qeZ4bqLnsJU/IV5F5b3DuM1c6OjyyHq2ej5usEMjJ0s1dYpyzmANBjx04VGRIY53EaLXxwKbc/yABJJz1F5HCQ5xvfOeMt+L6M5ppaWcCY+Z+ydttB+R40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773382; c=relaxed/simple;
	bh=f9HScrLM9ccfgKE3cdGQVfqi4+cLfkG7X64DV1UedyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHb5KeH/zt49tcSNxcwzbzx8rIKpBxGuhD0h814WqE59BfITpPW9jwdMV32Y+a5v9INj68U/02sskp6BtfFxDIBaDcR8T0t4i55kN7j8RWDg3roYryFMGfNSQ1ha2pat9+yBWFKgkLM2EyDbqS8Lc1yLy5WxKQ8yYzi6YSlpBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W9DXlOyc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W9DXlOyc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EIJHe2263794;
	Mon, 3 Aug 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GPPpHXBvxfBlkkSsB
	HPgQnIkZE8qMnffSiCz4c1gvaI=; b=W9DXlOyc+WsspNnntNzU68YNn8mpCijK4
	MVWVpDvKamjgO7hBYt5CbmyCLtZHed4kNS/EZbIkvGLAfI07Xxmlk6+VX0PILmZM
	SRDaTSpHHi9SKlgZiSAANCQXFB3iH+8E2NFsUPFmVoj0Q1qYmyp6mPAEgq00EhAI
	9UJ6sTFzDOm9+VPL/XacPGrxjEyLjeu+8OWyya1qvhiI20A+XtOz7y5RXFGLgOvd
	IuDEq8AwKIq1TUvYh3BFSU0orlziix7m4LpnJvekc1CNjrvt4w6ks4PbGtJUBEy/
	4vmUlApKpd9Naec2IUFHwBi/EW9Xfqpnk7ub+XwtfvdYB9pYy5xFQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3sqtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuNl7025379;
	Mon, 3 Aug 2026 16:09:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jx5yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9Qlw49545626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A00DC20043;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D0BE2004B;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 13/23] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Date: Mon,  3 Aug 2026 18:09:14 +0200
Message-ID: <20260803160924.236807-14-imbrenda@linux.ibm.com>
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
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UbkePC3kHMpujdsGQX8A:9
X-Proofpoint-ORIG-GUID: tlIvNUe6X_xg-77XLTiMTgtbWvVcFDIu
X-Proofpoint-GUID: tlIvNUe6X_xg-77XLTiMTgtbWvVcFDIu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX7iZhZ7O8UXi7
 wo+Ha6NxXNjnEt1ltStPN1sj/cq5dAiGpLTBBfSudI4S8OmaYIboi9b6YFbKtu4sChaUKiKDtu2
 GWzNhgGYZhlX+SWZ2p9oFHGT8qv1O6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX3E9pjCX7wmHI
 xYC6l32SXb5aW9RbK3BK3hGdNf3wVfOZwFtSZ08ORERnTh7uGp8FpcJgw7nh2rd1xCkWORxJmLo
 6RX1zOrEUuZ9AIGTTBofFF0nCyypuZzVJ7PMBdLxNM2ua8wZhrwH1Zl6i6rKRcOOz1qBjWSSmqL
 l5a7Eh9opUPqNx0OdAYmI0QbVuuJN8TCRRAoADchIcg+VgUKL6ZHHZKWHpCteD+oLP5fLu6jyuU
 Yg5pDMhGD535Czcm3VwXa2+LTpCR+Jc98tbZhaFjfff7JhtvzIyU4+w8HeYNUe3s/l2JCGS22wc
 qthUnPK/BOipiAOnTjNlyjy/+yOuYxNv+CEu78BckNBmiufjU/SySHUyn+t8+Z3CWYwFtcBGNp9
 7C4lI+xhrxUHUPDy6GTot3rPM5TgqDJ5dEhmmiyt+lBwTGZH8zIuUDOym2ZJXaxeID8BwDhk3Ih
 48GFK6zi+1dhNVRMB1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141

In some cases kvm_s390_vcpu_unsetup_cmma() can be called with a 0
cbrlo; in such cases, if running with V != R, free_page() will attempt
to free physical page 0.

Fix by freeing cbrlo only if it's non-zero.

Fixes: b31605c12f4e ("KVM: s390: make cmma usage conditionally")
Fixes: 29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle handling")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-4-imbrenda@linux.ibm.com>
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

