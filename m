Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440B4E2F22;
	Fri,  9 Oct 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556117; cv=none; b=h6qs1twYJeW35Y22elbdmRVeOReRiAbk6kGYLecIlrd00Eng30sENx2vAfnIMRjxrzFp/5MFKIgzj4SW4f5MsquRcIG/96RtthYCKtqoMXlqY7ENXDVvlV5ZhHV0PubwQ8X97oYLzk2tQEodalcAcQWXRul+XGQC2ssa3ss+acQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556117; c=relaxed/simple;
	bh=2BCwNilnUPxaHJDyA8OUHbPBAUUGCGdwfcLb8A4wKeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7vqE/lbGZSdwoumUqeHPFs17tRrr6lZPHUszIL9kKhkcD7j9biRgYZADgt8cJbvhmib7hW6XGR+ivpRb8ThBmyfw5AL8gD6hP4DTvpncqvpkLIbhOGt6NYzeYZKG+GpmXNS4VZCAW+ZDTBHES+oFBlRNtWYq69MrTAoiQkZ5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rV+BL+aA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rV+BL+aA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DaD4X305968;
	Fri, 9 Oct 2026 14:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Dr17km7Ua7uU2h+Rg
	SjGT6foDYIm72jifghNlwmI7hg=; b=rV+BL+aAu5NEJbFKHDTe44VUJc2zW7yI9
	u4gHp444ZtLhMLTgqDrc/A9aIEOInyjJO6+rvkyi/ZJtgXfegYMzG4gizCA2Yjg+
	3bH8QiZO6KYuINSGinNxJDfM2UifDHO2BISZ6n8UWUlDNW3Kl5nU5LxWMcgcMwoZ
	+PbIz+cqt4vAgn0BknXqDYR7BnSocFdIKkHpmSzjdRVqnebznpdFq565U3jtSox6
	MxysDZq/oBs57p9uEpT3QfVRUoRt12SUQrhwrLavQoalnQ+Qaa+NA0puH4uFEZ9B
	ODoNDUPgZmLiPOnh/vUbxwMl+5DzpJziwwFfKhM0lgQ6RjhNwPAsQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw380p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWVWx968168;
	Fri, 9 Oct 2026 14:28:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnkbun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699ESNeh44761582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 14:28:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FFAB5805D;
	Fri,  9 Oct 2026 14:28:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E50658057;
	Fri,  9 Oct 2026 14:28:18 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 14:28:18 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL 6/6] KVM: Remove unused file_is_kvm
Date: Fri,  9 Oct 2026 16:27:49 +0200
Message-ID: <20261009142749.186650-7-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009142749.186650-1-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Emx9jl8ROIBobsIkEtaq-esDNMZNzhZ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX5LARkAmztVLi
 ZHMpvqp1r+FRbo1nQHJBchExd3hhAD+0hvGgrJuoc3i+7EGXOmNZ3ztK9bTis16G/VD/oAEVN5W
 6fs3gOr5q+WrDLsZjGgCBkQuJfnX9OfTOMNxPWaqoUeQEl7GX9jbutfz7ntHVa/zmjShNUQnArl
 rl6rkY8y0zVjnHcUXe3WAQE76HjFT3rqayAU2vjiAD+6M36etvx48vwSm9eRZq3MznO7B/iKrlr
 HQbC1bBW0FVo+rV8mIm8Xla77OeRB/Vb/JnuKS+N2lR6KazvA6I/zvG/lEFlJdpk6moedMFu2nh
 enTkrt9yqaY3CaIRAEDs7j3jUOQP/EqbvNdy5WMz+O+GpxuYK4Dv7crW5+Kr17ZzsEyi/ot2MNY
 zdODTdYq6iD+0OT8pDxlqYRZLa8vreBmhgV7xug5CgoenfQ5EXd/8okJiIKVp8WlpTa0pQaGmBW
 iXER3Bh89JgrY3dBM4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX3rYTCKbExea0
 x1Z454/3uf2yvrIO/JmTAaLfmVFjfc0IBEOVkExrqjIwlmCu47vTZPS7obOQoHezDBwvVCTSmQj
 kpYYvUokGZejX29eDetQgDEnsw1oVBY=
X-Proofpoint-GUID: RZIm7xOSLHYlr4kU1pNQPFG78ZxXGI4g
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac8fa09 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=68v37qRHxcCaehiO-JIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090056

From: Steffen Eiden <seiden@linux.ibm.com>

Remove the now unused file_is_kvm function.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 943b108f01cd..b6a1f4312a73 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1087,7 +1087,6 @@ void kvm_exit(void);
 void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
-bool file_is_kvm(struct file *file);
 
 /*
  * Architectures define kvm_file_to_kvm_arch to <arch>
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 891a67cb365a..563e7b0becc3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5492,12 +5492,6 @@ static struct file_operations kvm_vm_fops = {
 	KVM_COMPAT(kvm_vm_compat_ioctl),
 };
 
-bool file_is_kvm(struct file *file)
-{
-	return file && file->f_op == &kvm_vm_fops;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
-
 #ifdef kvm_file_to_kvm_arch
 struct kvm *kvm_file_to_kvm_fn(struct file *file)
 {
-- 
2.53.0

