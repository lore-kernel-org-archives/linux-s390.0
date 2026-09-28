Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12003F86F0;
	Mon, 28 Sep 2026 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600861; cv=none; b=YzzwHWbsxxm6wMbtYFb3GlugqMvzTP+r44b937yGU4fZx6kBkGstwgKmtrWh1VrDbiTlcnU+Luow6aWRb9njMTVu/n50emW9kOVHEslt0/ZbdiQQ19Dhn9SJsEMX0qGX8cYgh03qqxEwuWOx41+3jfEy34rDVTmWD49dC5g/nzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600861; c=relaxed/simple;
	bh=Ln2NelnXZVd6skBG/ZkopM6Y8Q2HWicPC/+MYHldobc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4XMVH46BtfT0p4NnF0aDUDhoOoEeXukmOYFO/T6e96awfXRPdEX209u0zM2Nb+jFT2Hpy/F9ikTncEnW2oEgYvqS0ZFguNeN0ULUuRUoer9aohKBtoO1p/HilqSctOcbFeHLzXkyLc2bxCUGIix67Gm3Qfx7tA2Q5IeLUfNqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fOLIAv/c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fOLIAv/c"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZV3P1046972;
	Mon, 28 Sep 2026 13:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yzmyRW
	ZNcJniykIQe4Q6DuZckST0cRIVGjGxTh8cyAo=; b=fOLIAv/cG0xcGtK5km4yOb
	JIezbfcGiMid0v8nKkGQiFCWC0rJOHtZ2DLgSCHl96GPTHq3hSzm1AnMEhbUrMKr
	8+1txONSO47kERTurioJ3L2Bq4SVPd6I4gLgDGKJ4YmcMnORazQPWW04kuUXYimQ
	JA7bIdI0+pdza3ohlK0M/mxInJD4nfUwFo14Cp2isl42J34jWFikTLm0q7afGBi7
	HxkUhnsK33rUx/IyeJRU3e3FIXG35uzW0Qud5/BIk9p5OEZTwOHsYT5o9gXNjPxg
	/EgD1HBWbIW878DKr2Ns0zF4yKQOlgsH8IHNSu8pIwq06rk02IavfJPYXjBU0UWw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j51g5c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHZfK027152;
	Mon, 28 Sep 2026 13:07:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw5d0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SD7G5Y50201030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 13:07:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40D9D20040;
	Mon, 28 Sep 2026 13:07:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F17D82004B;
	Mon, 28 Sep 2026 13:07:15 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 13:07:15 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Mon, 28 Sep 2026 15:07:06 +0200
Subject: [PATCH v4 5/6] KVM: Restrict kvm_get_kvm/kvm_put_kvm export to
 internal KVM modules
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-vfio-v4-5-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfXyWOm0qyCtBqQ
 Ca8xtFZwtxHWvdGUTWTi9LkWPyOmOn9d25Mjjl2MiWVVurxiSOfYYiArTz3fTiCKfzaQqDD/+x3
 WqQBQGPWBP+JmtZFc3TlPGC9+AAbgnQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfX55L8kkjloz+s
 pyYkuNJ9/5kIMoNzHA1Sm9bQdSgBHPBS/CCo1T7luENIcypDfetb2SibwLz+N55ZmF+VFcOqHsY
 Whwua9+CYvzzhgnsLFWR8sLO1stC9NHLBg+W2+BPqWBnlcsa4YTW+XBaSMZ7gGS4ySmWxzUs4Ss
 kkqwJlQ0We6CyExmrkYhgZ7nSU/WBduwOdXZUrmy+8ibRt7LKvJZ0f3XQKiWxmGYokN7xT/p7qu
 JVi87jLqXh1Eb71MUhCPGb24KXKEVWhFpRjeKDMM6pq++NBpdnImeXpd9JaEhClnP7NiUsPjusa
 9VjhjFitpY2SAKG2LmQQkbpJYWpAx+j58T5kWo6qWNoXImc2XpPACmh4/IYO2NQc5/AaBD/Gb8L
 k9cTLe6oA0/5VODYEBgvcEXaufscOrAjNB5SQt0/MouamiiWrTfExuc+G9NcWV93oSUT9L/U32c
 SfFWtLZiQ8vomIeFTJA==
X-Proofpoint-GUID: ysSTQk7mI_8iIrRf9NXOL_Gjh_foIKPP
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba6689 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=cWV-k8hB2h86IYwIXi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HartuN_-pSCbuwvqv1ogiBJwOlYq2n90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280052

Switch kvm_get_kvm, kvm_get_kvm_safe, and kvm_put_kvm from
EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_FOR_KVM_INTERNAL. These symbols are
now only used within KVM itself. No external module needs them now that
VFIO uses file-based reference counting. Remove the corresponding
exemptions from the x86 KVM Makefile exports check.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
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
index 8e49ea809528..ff4fab9753ca 100644
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

