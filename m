Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD024E50D6;
	Fri,  9 Oct 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556114; cv=none; b=GFSwx/E2vKe3wWzohJtxlSIloi01RnBdpJrAo/j6IUUkg+v48i/JjD8XTyztnw/Hnox8e8fD9rz1HEK57erV6R6dvp0b78ZtyjMJTEgfcCACH2W6St2hkj+8++6IP1GTTsxbvbxeFTS94g7nHEZbT5b6LZB0uEpYVEHWUXRcNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556114; c=relaxed/simple;
	bh=xe3auwXUKIoDrxR9vLeHtV4SlVH56HiLtqTlFmCgyok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVQQrIDvz6gwN2hruYBcRgWkDHNLYiQe81L9GV2y6n/yKHP38LdN5TP2r0t1E17PB9RLvDRLMdJAnphnk4rYG8ODCsOpJCDbzeuI/ndoZKCw/lN8eGZRCh3WWJahs73pTbUHV2iGbX3C3ozDnqO2rSrPjSIY4uTTAabEWF2A/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DJ0JwxQy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DJ0JwxQy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DZkfF2626434;
	Fri, 9 Oct 2026 14:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=foekcRIdiu83LIFTI
	+m1MSl1nkpCcXui3zoiW9+gSio=; b=DJ0JwxQyS5LEi717UI+3dbHNT1g2ohBF1
	hstyBOKRbck8DxlbySMEH42skaWsxSQV9v+jgArQLyaQPTiMlhsNjjLM64KSfvy4
	fRjfsvpMvENtGB7Imz1jmN5AJmohJ2zSMnzjOfpIYuMMEi2pQu66Ll2n1CfoRmig
	a6Dof9V1Xt0keQ/8j4/Ysl+Lzc0h5GcBNg+1r8l08zFH8iAUbsVdiIJ+xw5j8U/F
	1/M1hcpbbqu2twT0ELDfJWJ6tydCCZcTPbfczo2+K/dWlqHGY+ya6TgmEyOq6u/V
	BOebl+E7yZ/zVuMAoJklsAAo7A9HGWpR50qujnVuOt28m9GTwvxFg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwb9c1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWV5K3886517;
	Fri, 9 Oct 2026 14:28:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u39y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699ESIZ71442688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 14:28:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C89F58059;
	Fri,  9 Oct 2026 14:28:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E827F58058;
	Fri,  9 Oct 2026 14:28:13 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 14:28:13 +0000 (GMT)
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
Subject: [GIT PULL 5/6] KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
Date: Fri,  9 Oct 2026 16:27:48 +0200
Message-ID: <20261009142749.186650-6-borntraeger@linux.ibm.com>
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
X-Proofpoint-GUID: Ds7VW_EGni-9JuRiv7OIRw14Bm51PHay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX6roz4NcG4023
 sab4MvBoddYEiS9XFPkEQcj6n/ddVk/k9CuAYAfU+hsD6fT0FKJ/OUo66aSINzvHv2qfMrPJHuH
 Mjip8yl+GXC2j14ACZf5Wn7Qp656XSG2ZmQNxmF57KD8P377Zo2lKy0rPqGscIj8GGY53Yu/7Am
 nJonjObehvfl6mPj0I2QYlEcYGvaqNqk6HVu91sjz+FY1C5LfNmlNeMSt1BwQrRPSmzSQoNiTXk
 kDloflQQTiUAx2haOapU99r6F6uCeJqaSL2yz2Babjc/BF1fbsrLyNaFi1hWdz2Ta6Xe8H4SwiF
 foEUSZ2KY26J27sePrWM93bBKZ2G7ec9bKmbiSZ0drTpJWG4vaoVmZRDIVjw87yg9nTShMT24cz
 2Jim19weG4TZpuYo/8HzItzRfV/GiNwHvDzG5/q9NuExl/W0oX/U4d2O9pGHFiAQNcYOJJ+/FRX
 9hvnF3Y5D3ZBeCnT8cQ==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac8fa05 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=cWV-k8hB2h86IYwIXi4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfXzuhEedbJEbw4
 4EHvd1YpCClzJdMySd3u2M0UNm1f23TlzEnMbB0kMU1W2PPH5B3mqQofXnHSYw79YsRi2HBfbWT
 ziUOyNEmE3OC+wzUOzR2zxpBWO3mMU0=
X-Proofpoint-ORIG-GUID: JHd3kDXW6K5heLs4hLRlAqzFA7GdtOUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090056

From: Steffen Eiden <seiden@linux.ibm.com>

Switch kvm_get_kvm, kvm_get_kvm_safe, and kvm_put_kvm from
EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_FOR_KVM_INTERNAL. These symbols are
now only used within KVM itself. No external module needs them now that
VFIO uses file-based reference counting. Remove the corresponding
exemptions from the x86 KVM Makefile exports check.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/x86/kvm/Makefile | 5 +----
 virt/kvm/kvm_main.c   | 6 +++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index e6d395ede9e2..c6bf463f5032 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -61,10 +61,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_page_track_unregister_notifier \
 				-e kvm_write_track_add_gfn \
 				-e kvm_write_track_remove_gfn \
-				-e kvm_file_to_kvm_fn \
-				-e kvm_get_kvm \
-				-e kvm_get_kvm_safe \
-				-e kvm_put_kvm
+				-e kvm_file_to_kvm_fn
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bab71d398236..891a67cb365a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1314,7 +1314,7 @@ void kvm_get_kvm(struct kvm *kvm)
 {
 	refcount_inc(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm);
 
 /*
  * Make sure the vm is not during destruction, which is a safe version of
@@ -1324,14 +1324,14 @@ bool kvm_get_kvm_safe(struct kvm *kvm)
 {
 	return refcount_inc_not_zero(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm_safe);
 
 void kvm_put_kvm(struct kvm *kvm)
 {
 	if (refcount_dec_and_test(&kvm->users_count))
 		kvm_destroy_vm(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_put_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm);
 
 /*
  * Used to put a reference that was taken on behalf of an object associated
-- 
2.53.0

