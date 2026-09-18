Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FEF5013A9;
	Fri, 18 Sep 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744191; cv=none; b=celrJXEj6pOg9H5An0IUUnfRyBYWXPAng8mAk/M0vZbQohWLLHPLR2E58gZspxMPSip2TYRgSaL1K9OO+BLzbbD0+QWW+O3OS3mliy48EK8sCFDnHBclrQgA77DUqqO7iAfr/pvXfnhjvNXJvKd0TkEr0DXwI2no60CvhSgD13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744191; c=relaxed/simple;
	bh=r38lklOz4IOuUrPbqHfwWvXFp/6MoWuaYlleBM2XAAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHdW7jexculvMbt2j0VOeyR9/nbQq4fY4E/HZ3emDWw1tmuRuAw44ZG6v5BX6yUVgXKe5wEz/4GYyBqBlI0AlVWypzCSORPnBQSn3lAVA9lKiyZeoU7cAIOYX62l/hkIjUU3thtxO9hpdmlR44AYVX+vtcXhf3LaOVopX96SDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G6/C3GFn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G6/C3GFn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVkpi1394073;
	Fri, 18 Sep 2026 15:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SoXnbu
	ZWuw4WNX67SwJpRr7Eyz7Ki8qTohztU0DVsys=; b=G6/C3GFnxEtmponchBCD4q
	93577dKKA5w1VfEki2ATWaeb76oQeASj2moquhRxL2kVPDQ8Q0mBecksgWRgyohV
	n3iuDK4u5N/BdV8IDE0zcKru+42rpENDNRE9HEpXuGYJUwhe8MbtE688Q/xdYxsq
	hXgxXTOMS99SL2Y2unpkHB5rIaGgNFiupDos4IEa//DWOqJxUkkAp53mD4t4Lxuh
	5DAW2Fi6X/PaTLbMI3JzGtMPHNSR3ttKBWjIP0Qnh6ShYxSgkHM6qZj7nZcKViyu
	DfgZLM7naeYx1bNcB7lG0HHBLI78Sj2tnZAkztTPIku7KPjM2bUM5qwHXPRr8muQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5gtxs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO0t9695620;
	Fri, 18 Sep 2026 15:09:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fexfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9XdR49742116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7563A20040;
	Fri, 18 Sep 2026 15:09:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB2D920043;
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:35 +0200
Subject: [PATCH v7 18/21] KVM: s390: vsie: Add VSIE max shadow
 configuration
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-18-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3001;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=r38lklOz4IOuUrPbqHfwWvXFp/6MoWuaYlleBM2XAAA=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQ5S6Ei+vT1jMe17plU/crVAr49MXJGUv9GVOn/kxL
 rJqv8TvjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACaSb8bI8DfCVM951YIX9fzO
 n20Uv5clr+bnUY3gynNfJjQ3TP3sPob/6U3vylZeeXbu3cvpbtJzPi1sk9DUUHJ6a7l4EefCbOV
 LrAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nlAnOh80EXQMq5ygDuG1STqCfQ-7RZ5B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXxGwo7T7uRxMT
 acJCzhAoCjhZ1rtxisNhWt+u9zzAfhuQ8jOtje8TzeZch97yw7y1aWf+N3FAu/QFpx7ugoFnUhb
 OqSsRWKJDSde++ueu1jUQy8uiiPtx6s=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aad5433 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=NT-WFI3kCPxDzj7wveAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: enHPwD7oKRL3o9-AxzVzkctxRfUH_2Gx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX0/gTqi/Rf3sZ
 5t9bqIgxbZlftvjUP9tmJ6d9dwMBniV14WpBeKD/kggLH/iB/8IjWmFIjXDm0707GdueGI2di5A
 fUyyTKzsQlGVMWByH6NjizNOBpvca5p88mUBpb/vobfemMIWk9PMTiFLbfIhxbHGFQwDJkcfiIa
 sthRfmVssp8m1p2Ppsp2t0NZE9eU2gu1WYauqseOgQHSPFDnnVrM1S1p42jWwTMsyv+MJisUYre
 ud8H5WAncvGAKXwf7kvcte4BWbj7vT7XqJBgR/cjiGTn3EvGnSwI9aYJkpZ6s469u2gjnHmqiYN
 zW9UIaqKSyL4MOHUKv+qeUEAejYJSv3fzEKIKlYon+h0ZuYAfb3WbSxMc6UzIR9BoJ8D7nsiXCB
 mABQoiYCO+2IjstUq5LgMEYqviRRpKd04Ig6MqhTbDzz2OiPiDTk+vq5svklljqADgO//KV0MGX
 94k5fpGPhqqHNGkdYVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

Introduce two new module parameters allowing to keep more shadow
structures

* vsie_shadow_scb_max
  Override the maximum number of VSIE control blocks / vsie_pages to
  shadow in guest-1 that are not using the SSCA. KVM will either use
  this value or the number of current VCPUs. Either way the number will
  be capped to 256. This is the number of guest-3 control blocks / CPUs
  to keep shadowed to minimize the repeated shadowing effort.

* vsie_shadow_sca_max
  Override the maximum number of VSIE system control areas / SSCAs to
  shadow in guest-1. KVM will use a minimum of the current number of
  vCPUs and a maximum of 256 or this value if it is lower.
  This is the number of guest-3 system control areas / VMs to keep
  shadowed to minimize repeated shadowing effort.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 698f17a5f19d..30e24b9b3eaa 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -107,6 +107,16 @@ struct vsie_sca {
  */
 static_assert(!(offsetof(struct vsie_sca, ssca)));
 
+/* maximum vsie shadow scb */
+static unsigned int vsie_shadow_scb_max = 1;
+module_param(vsie_shadow_scb_max, uint, 0644);
+MODULE_PARM_DESC(vsie_shadow_scb_max, "Maximum number of VSIE shadow control blocks to keep. Values smaller number VCPUs uses number of VCPUs; maximum 256");
+
+/* maximum vsie shadow sca */
+static unsigned int vsie_shadow_sca_max = 1;
+module_param(vsie_shadow_sca_max, uint, 0644);
+MODULE_PARM_DESC(vsie_shadow_sca_max, "Maximum number of VSIE shadow system control areas to keep. Values smaller number of VCPUs uses number of VCPUs; maximum 256");
+
 static inline hpa_t sca_o_hpa(struct vsie_sca *vsie_sca)
 {
 	return vsie_sca->sca_o_pages[0].hpa | (vsie_sca->sca_gpa & ~PAGE_MASK);
@@ -1086,7 +1096,8 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb_o,
 	 * We want at least #online_vcpus shadows, so every VCPU can execute the
 	 * VSIE in parallel. (Worst case all single core VMs.)
 	 */
-	max_vsie_sca = MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE_VCPUS);
+	max_vsie_sca = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+			     vsie_shadow_sca_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
 		vsie_sca_new = alloc_vsie_sca();
@@ -1976,7 +1987,8 @@ static int get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr,
 		put_vsie_page(vsie_page);
 	}
 
-	max_vsie_page = atomic_read(&kvm->online_vcpus);
+	max_vsie_page = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+			      vsie_shadow_scb_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	/* allocate new vsie_page - we will likely need it */
 	if (kvm->arch.vsie.page_count < max_vsie_page) {

-- 
2.55.0

