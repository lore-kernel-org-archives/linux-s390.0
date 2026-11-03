Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723860;
	b=Q7rbw44nO67CBTyLjCg6P+QkRoiuSrNM9sh93+ANpToq2xKh3eT3NR0UhnOeohwjc+x7
	 Jf/qfKeD/9fQEGELVgn90LkLVq3FcMD2lD8g7Il0Y9Z+tEg7ACDACjCIadLQNc+vodJ4R
	 on618WHi6cyapg1yI6UMbxBX41cvg34kCvDxdNQv+qx6TRZTT9bDYTsO5MQk1LEFXxBk3
	 fue/ieouaggHPIjLpNrZtyPmQQJKC0jpRT/zt3baNmfcYVovkOHqPY95kNmht4QO9SPSU
	 PRcqTv1+n8ZnaT5VEo2z4Z7qMuQ8ybT4QcQwZV+7x2z0znZ91LlBq50jDRmu6ut3XTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723860;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZZIzQK05TfIYV9VpJ/xrXN6Ek3gH9NTHaG7l7rbBDEo=;
	b=a/s/z3hAwOVLRX5E6/ddm4A+RM/ZwmAMBxrMzKBQb5lZYR3hZGXhOeP8qK5CcAnsToUX
	 QT+NedEQFtCN4T4tmcp4FVNfAiK9YUVNfdm9U0q/XjEWFjsC31B++9AMbgJXvyCm2u0D+
	 XOSUmyVUXEf2/xtB+gfEP0giI/ds+GrLGCdkTRtLUvGRRsYLIh/BFRE7UbxaEPyJAanMh
	 7BZfXa8VXLRk1a9rqJb5mjl5EA2llSSnj5dcASwAypKxjUG7uht4TqD7pnoZuyz/gCbTv
	 xffh3I21YdT/N3IbvrFZHAsynKxpzan5NpaDucmoB0SMX5kofwzWq0li2nCqcP5GdBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jQmYmHDH;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D0606A338;
	Tue,  3 Nov 2026 16:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A59D0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jQmYmHDH
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEHmV407299;
	Tue, 3 Nov 2026 16:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZZIzQK
	05TfIYV9VpJ/xrXN6Ek3gH9NTHaG7l7rbBDEo=; b=jQmYmHDHG64K2kd6HplC4G
	VfCclwqCemHCgS+Ex5fpe69RtU4Qw4BJx1H+S5i3auBPYq1dneXumSPEdQe5v2uo
	WDgWaAXHa2DLSeOV9+aw7Qo323Fp+A3TE+lM94xUayZGLJmxA9+PIbY77+7S43RJ
	fjEyWeL0QXQUL2W2AmJZ6GCPVjXKNAXhkKjw1sgsz1PE0QaP95jwJyNnFLO8wh1G
	4Fm8jj9OE+jjDu8bnPdu78BWLOvViHRT4O8rJm0ITjJx++9oFBc+yL/hVN9+bGj3
	XEvmm7N9d6hRFSxZvkGDpH7Wu5PSfDUThzlZ7Xw1oXcasmMyf9FFFsXIctT4gupA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sq05k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:37:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK4S42695639;
	Tue, 3 Nov 2026 16:37:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gucrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:37:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3GaeP941222632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 16:36:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45FFD58043;
	Tue,  3 Nov 2026 16:37:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB465805D;
	Tue,  3 Nov 2026 16:37:26 +0000 (GMT)
Received: from a46lp21.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 16:37:26 +0000 (GMT)
From: Andreas Grapentin <gra@linux.ibm.com>
Date: Tue, 03 Nov 2026 17:37:04 +0100
Subject: [PATCH 3/3] KVM: s390: arm64: Fix kvm_arm64 module naming
 consistency
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-s390_arm64_kvm_fixups-v1-3-21c36fedd878@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2574; i=gra@linux.ibm.com;
 h=from:subject:message-id; bh=PgC21CRVdPxJXx+OB7Fl/D+Rgv50Tf9fZPohUYqLKp0=;
 b=owEBbQKS/ZANAwAKAXUg1t0k8konAcsmYgBq6g28F4ZqEDnPRNPuBlwb2KvOiXW6Tvopakb3w
 CgfJTopAh+JAjMEAAEKAB0WIQRrKkreGscL2VvlPix1INbdJPJKJwUCauoNvAAKCRB1INbdJPJK
 J8TVD/4iZtSMwwPddLT1NjuEAicnrmJ4WipB8owu9vpjHwckQCvlDE1nOjp2VWPq7kLH37C1Ah3
 zV25tVdwcYwaInSE5idene+k3/OrMvUi9753YHiFqxcuzxLshrOmqskU2W/TtSHqBFAjdtas/m8
 HZkq0cabpsRSs3u8Vxp3uYyK8r9kOKYykuUqDQsWLgTLAs7qbsdz0uC1Tz2Y/FV1RDh2Po+AuGQ
 HLch21xJi9BSUpUxV9uejRnNSPRjKiziyu5T56JrXt9ulNMcPudh/PD4LrOW9rQyfyjznJzCCQU
 E7ZFFhQ2mW29+L5EaBWRB4oBC7peHoY4xeWSVIWYiLGhv62h4DZxy+eNL/l8VSB/M3hU55ZyBmg
 9qouKBL96igrfHTIshnzYvRSzFbrrCzgaJqa1U3M9eK3inyG+Os0flDhZhv7WxJDrBA5y6YzJiB
 NdOmzBDbihfoTqMx9EA8quNlMD7RBiGFsRcIzXR/2mWuJG3hhGtJ+mCxw4vYtms2gX5EPp9wDg6
 RfXom1YUPb1kacwbb0X9ln4cCxLuoaiAqzxzSg9Kn06LksnD9HKZL/eaxWmvY4MrSPK35kJLdZW
 trCP9uG+ScoPl4ZHMQBBtxP7/TNOra6YtskZnXehute95BJCVQBEzsA5NEs7A3dqRlLC1jBqbns
 L4EvuyRWy08o5Zw==
X-Developer-Key: i=gra@linux.ibm.com; a=openpgp;
 fpr=3B910193D094AA78FD974A04D8BFC37DD553D93F
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zSuMry-i-4D9J2uC-z6bhg9ChctMKAwV
X-Proofpoint-ORIG-GUID: zSuMry-i-4D9J2uC-z6bhg9ChctMKAwV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX741qnu8gKPMl
 KvC9NRLt0J1k+r9eD5JwHbyTP+pNiL5kbw0vUK+aaUhey/NMzrvQBfRkF0PE5MOtFf5F/be2a9h
 1L/vZiQbikul2LABIYNs9OSuyYScPsEeuBL02aDHLWZgagMcBjxtZ6z2/dglCadGNKB5QC/Ufxs
 z3m5BKs4Dl9cLErQLbFRlZFd6bNrgu1HGktxOohHerIdz/JJC14fUo7iCjuoorwpMlzIwPlheCM
 77jGDIUxf3+s4qWeubh2lT9MnTAb784+6gX0o2x5Z3tG7nCU43opWiLmIZQmXC0X572AltcvcVO
 LhHU3xFyo7GoCxq4NiJqyAINZX2O/PUvvfrIc5qMX0ixR+3J5VFpdNrB9m+BLVdUUqd80U5czD2
 4M/rIlS05BPc1jnV58qhPYRgNASWvQQAtV5fEp9fIESzd8N9XNUBmLtan2lA+lWEW4TFPO3gbGg
 sZa0mbh6ombF0Tt8qTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX4dJ/2sNEldU1
 KLlAgQNhWrG/MNlUbxTS3s3pfv7rsi1CSZb7WqxeQ/GPYPa6Ju99mm27y3ShF6ozKvRli7dAbHI
 1oY0vKksnARCLOqXCQxkRgR9DZGXghQ=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aea0dcb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=XONUHcErLIjENKkZD9UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

the module build for the kvm_arm64 module produced kvm-arm64.ko, fix the
Makefile to produce kvm_arm64.ko instead, so the output file name
matches the module name.

Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
---
 arch/s390/kvm/arm64/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index 3f0fe5c9f0a1..b48dc65b7aaa 100644
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
2.55.0

