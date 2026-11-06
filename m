Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983821;
	b=1xHtFH17SKILWMqM5WhHu4lvsfxvx1NDg+sxWhuPc/5RXp7yQoos5LwpWjf1ElDsITty
	 fUgdmYDpcYaoSqNgCAWZRBgiiGwFAnbf0OhHlMXcAhQnE4rRktT3XyACdaN2uHJulLFPs
	 VysC4Pii067ycNVjHvOf1p5ZbFD2nRVu0NONQEIfsV/7K6qyy3VXF/Ee3ndcBFO7CkZwX
	 vtxNLDjo5HQ6tizUxLkTIaDQFVx1c92Xqxg4fz0fe9Y95wrqSzm5W3H4W6Kf/tJ8HBp2c
	 7Zc2gyLCrHqSAxNIhW2OSG9Q+HCKiirNPA/fTfR9vZp50qg/QAJGQRccTSSFP78LniQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983821;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CeF3UdpHmwQRokWaRENNTwW55PXEuXmh8P2wqLxFekM=;
	b=RVMeHNCPNMUsnx+gFncPQ6VYhddg/5vD2LzNg++spHCI7nt2+2Z4gBJNv1d3DG7s0FBv
	 rR4YnrZLQQXymAyQno0clBPN83plTEVUxjVS0lrKs1SpbpmG8mCu0YBlSspVkJ3CkhjUc
	 9pD18G621/hMz8Y17QxsNHQ3Jvbk8BXxGxrp+Q5uypwf9VON5GFPrxSKeRDtJ1xHjpIbe
	 58SMFImTxFi5XfIKYgkGLr9DJuOjwb90rx9RxksbS3Bx8q0n7h4/kAyagTcDCsIMc5nCy
	 Fd6ZqJpfwNghhdoWqJfOHQu4gXkcdTBCUBoHg4KoNAZWjhXE4yliUMNOSykh7PL50ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="n7RPi/zN";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E9606A33F;
	Fri,  6 Nov 2026 16:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159E9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n7RPi/zN
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FECGC2656391;
	Fri, 6 Nov 2026 16:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CeF3UdpHmwQRokWaR
	ENNTwW55PXEuXmh8P2wqLxFekM=; b=n7RPi/zNyBXtKAjryjDNEz2fc0m6C1miB
	kurdo2vwgmAkWgHdfjwqNTSrU5Nxrv0ZZVR8wH+NwV5FSeH+meFL2ke7sAcIJuJI
	sx2VDM0swaHJNjBVmbFcND9w3rJBHQx2932JJA85xxHuCM5w+I9/00pVhS+kyA7y
	BVD4En1AquxqMYqXzfdv/LBNuJPU6YNpynDyLDa3vezchfUnd4aKGLzBQyz13d33
	E/Kp3bQqXBRJg+QUU9/+fWM0TjjvFEiggejSKmHtLof83y80T4tXZ4vq7nltc//e
	95ZKyrfnNdZ+Mh1sPUeikabDwr/5FpKriLVNx4PKfwrI4HuJbgXvw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc5vc0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4vcD3617215;
	Fri, 6 Nov 2026 16:50:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7uyrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6GoFYA33292876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:50:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B5515805A;
	Fri,  6 Nov 2026 16:50:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E6C95805F;
	Fri,  6 Nov 2026 16:50:13 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:50:13 +0000 (GMT)
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
        Steffen Eiden <seiden@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [GIT PULL 5/6] KVM: s390: arm64: Fix kvm_arm64 module naming consistency
Date: Fri,  6 Nov 2026 17:49:57 +0100
Message-ID: <20261106164958.431978-6-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106164958.431978-1-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX1FIrDAPvRqc8
 oZsLXM7ta9tZ+lw3fM17ZNPbbslcUhE34ivMT+2pPNZQd2itYsNPyh3xdMDFMk7AijzqMHyg69x
 FyoHMcmTDwKyAQCNm4YEy7SJH4R/aW4=
X-Proofpoint-GUID: tDSWhTwZXyqlg8kWmvFCfOtklb1PY1YG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX4v/YMaVtS971
 Np11lhg6lXdAPNfFvsbUkHN2RA22gd9ANuy7sikBupdRwdNjaYsShAn6INZ7KiU/CBoLepOQEpw
 meb3lWDW8OQuTKYkEqedUj2cY7OkvNWKg2gUBjvR3BvAap/YUmMmLugGc9IQROoOnHQR810XQJb
 /A+/LL0tQ7Rs9+YeQ4sx53gwCOtxgf2r2pYjxVkLAOjsf9hXD5ULN+tgqng5BFVC8xyjlho1xu+
 8PHx+wl8EZfb7CqQ7tKdroUQIoMIz+zlPzwCdoqclP8uSGy54yE8vP5AQ7SoAaYBSDXUqE6cIQv
 NAAHBf67TeePT7e9gqFr8DRU2f8Xpv55rcvI8nalDw7AEaVHv8pW+Nfn9Ww8FCo0vjx8YIpR+Cq
 snydxQi+UZxC2l19WBDaYKtL4uhG5I2OtnbA4SeHGDSHAzO8EsT1+p/75hg/gyb9RKxAlsijNRw
 UwJTpA+KhKBynvcOYig==
X-Proofpoint-ORIG-GUID: tDSWhTwZXyqlg8kWmvFCfOtklb1PY1YG
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aee0549 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=XONUHcErLIjENKkZD9UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060066

From: Andreas Grapentin <gra@linux.ibm.com>

the module build for the kvm_arm64 module produced kvm-arm64.ko, fix the
Makefile to produce kvm_arm64.ko instead, so the output file name
matches the module name.

Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Fixes: 91b87e6eea4d0 ("KVM: s390: arm64: Integrate arm on s390")
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/arm64/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index 3f0fe5c9f0a17..b48dc65b7aaab 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -29,7 +29,7 @@ $(obj)/%-arm64.o: $(src)/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
-# %-arm64.o stems don't match any kvm-arm64-y entry so Kbuild derives wrong
+# %-arm64.o stems don't match any kvm_arm64-y entry so Kbuild derives wrong
 # KBUILD_MODNAME/KBUILD_MODFILE. Force include a generated header to override.
 KVM_ARM64_MODNAME_H := $(obj)/generated/kvm_arm64_modname.h
 ccflags-y += -include $(KVM_ARM64_MODNAME_H)
@@ -48,7 +48,7 @@ define filechk_kvm_arm64_modname
 	echo '#undef __KBUILD_MODNAME';				\
 	echo '#define __KBUILD_MODNAME $(KVM_DEV_NAME)';	\
 	echo '#undef KBUILD_MODFILE';				\
-	echo '#define KBUILD_MODFILE "$(obj)/kvm-arm64"';	\
+	echo '#define KBUILD_MODFILE "$(obj)/kvm_arm64"';	\
 	echo '#endif /* __KVM_ARM64_MODNAME_H */'
 endef
 
@@ -60,7 +60,7 @@ $(addprefix $(obj)/,$(kvm-arm64-obj)): private part-of-builtin := y
 
 ifeq ($(CONFIG_KVM),m)
 
-kvm-arm64-y = $(kvm-arm64-obj)
+kvm_arm64-y = $(kvm-arm64-obj)
 
 else ifeq ($(CONFIG_KVM),y)
 
@@ -86,7 +86,7 @@ $(obj)/kvm_symbol_list: $(obj)/kvm-unnamespaced.o FORCE
 
 # cmd_oc_o_o carries -DKBUILD_MODFILE so generate_builtin_ranges.awk
 # can attribute kvm-namespaced.o to kvm_arm64 via its .cmd file.
-cmd_oc_o_o = $(cmd_objcopy) -DKBUILD_MODFILE='"$(obj)/kvm-arm64"'
+cmd_oc_o_o = $(cmd_objcopy) -DKBUILD_MODFILE='"$(obj)/kvm_arm64"'
 define rule_oc_o_o
 	$(call cmd,objcopy)
 	@printf '%s\n' 'savedcmd_$@ := $(call make-cmd,oc_o_o)' > $(dot-target).cmd
@@ -98,7 +98,7 @@ OBJCOPYFLAGS_kvm-namespaced.o := -O $(LD_BFD) --localize-symbols=$(obj)/kvm_symb
 $(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_list FORCE
 	$(call if_changed_rule,oc_o_o)
 
-kvm-arm64-y = kvm-namespaced.o
+kvm_arm64-y = kvm-namespaced.o
 
 targets += kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
 
@@ -106,5 +106,5 @@ endif
 
 clean-files += kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
 
-obj-$(CONFIG_KVM) += kvm-arm64.o
+obj-$(CONFIG_KVM) += kvm_arm64.o
 
-- 
2.53.0

