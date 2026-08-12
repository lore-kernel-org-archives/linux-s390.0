Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D64334C3;
	Wed, 12 Aug 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542770; cv=none; b=Ax0WORoM3PQv+5n/Yp7cdjhcpnTPIo0mkVatGxCbJpo5/hzVyOwLu07VI4GhWlJpSY89BmQHuGhM3zUU6fWHkzg2bMGdpI4W7/cMHW6jEpjpgaQovq9cXvONlK+3XrDFEqxD/i/F1jmmOLjsGbWz+FJZvSXxVrX10vz2ZCqIoxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542770; c=relaxed/simple;
	bh=txzrggCk/SjT0uTgRlfcn1uxCYIWrqZaNPEUnLEzeJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oievKh2S0xI99T4uXuQRrirChLAk7+7zUlUhCbKdtN1Ks/CPAvVb9ekNpWDAGcawi/R83YQmyS6+ZpVi7HPKWdri1GbG3XzgoWGc0W0AU8i7zD4coNOFwl0YuxZWkCotAObVt/rFDHTP/VHWIJfNhcEE6y330HyYdNLInX9iTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OihgVjiK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OihgVjiK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3oTs3214510;
	Wed, 12 Aug 2026 13:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/It4p1
	ia4MuKxONKbsHb08W2EZf3Q0zBKcTa/OT+DJU=; b=OihgVjiKdU7ahvOfoKpfuq
	o4v8MDamy8ZhHmYI+AZzA7ilQ22Ce7iuPoxAP1BQJEnLMHZnQxYdZ0Kbka7FG01m
	sxgUts7i62gTO1sdtpNAsaTAHf6sZcTL55H3flXlhP4gF6ZmIyuikPP9vsMjTCaq
	4qbmgFz3dHZAPnt29OBwxQZAYkCELcqs1YHvY0kxEDXQQ5JpJKAfeTbEOaePMOtu
	Ghk6tTJ1hpdKcoMBX057dug71g9qOUSZx7TH5TFs+Q5WYa+JO9nysgfbognwtPwD
	W//3GCj68+P5LzaUXBYeSMnLgkHs1VLAZ9OrCJ/4ceMl95OowyW1O2yvZegA2yTg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31wqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfd7Z009967;
	Wed, 12 Aug 2026 13:52:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6dmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqeVL45547922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62E0F20040;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 369892004D;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:46 +0200
Subject: [PATCH v4 17/20] KVM: s390: vsie: Add VSIE max shadow
 configuration
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-17-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=txzrggCk/SjT0uTgRlfcn1uxCYIWrqZaNPEUnLEzeJE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VUvqPLaumXRHKGrO7DnrDz37nfdvjqIOtz7nlKK3u
 4/t09Fu7ihlYRDjYpAVU2SpFrfOq+prXTrnoOU1mDmsTCBDGLg4BWAiZyYyMqz7njhZYRWT/uQ2
 uztLXJ6mc81MOzYtqmHZutvPFGxn/n/ByHDmnvUKtSDp1XtYv5366f/IPTjtAofStP2xt3f2Tjm
 td4ATAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c7aad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=NT-WFI3kCPxDzj7wveAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VyEr13SgbJFl9M4F03LlpleL7UvQjXX3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX27GcQN+whSjJ
 jvUSJNwtkWvcOx1ypd7LrNKsoOVqZkP3nSYmAYiqOjuonPzFBIdvymhq9FLZB/d9a3AyuaY31au
 PMfPqw/wExzkkKAGmwg6cVWvJ5i62hgaT6LzPbQ0au+SUzKdO0jOjeR5kQV2ukNVGmcYMWEw+7h
 MhlZHZEyUgyk8a7jhfo95IgWU8KRBmxW0xg61/JLE7HZ3AKaQ8Fv/88ZYserYTBu3EvmZ3EmMQt
 ptNa3INAyxLCPZBqIKJRm96h8PRsfgdZfs2BvCN/A1GEu8+8j3AD5YxOeoUDUQJ//+yhoIocf5i
 XBCb9K26SYhryvOQ8v7bxysaEFJ+PKBCfyMW9p32jKSQQva5mN5uQc52FE3vqXyucjXDN3ILjeP
 y2rtu9+3tV463n7ag7ERPTdiLkT2bXQGMhA4MUgFHrzYsCKTVpXYK8qnzAacS1hIk++ZzXhLD3Z
 MnEg+7GQ8G75DuPyURQ==
X-Proofpoint-ORIG-GUID: VyEr13SgbJFl9M4F03LlpleL7UvQjXX3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfXytDyb27erjvv
 VsCKh52y8HUG2aL2mguPdkHtxmn98NcV4RDguyUTOzqexdWu8Eou4Y6LvUCol3DPHnXOC8SRXKp
 QROcGZEF1JtQ/9W4uvGb9vB/wH8jHsM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

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
 arch/s390/kvm/vsie.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 6088a9c31564..5f6dd4b9e9fd 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -106,6 +106,16 @@ struct vsie_sca {
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
@@ -1063,7 +1073,8 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 	 * We want at least #online_vcpus shadows, so every VCPU can execute the
 	 * VSIE in parallel. (Worst case all single core VMs.)
 	 */
-	max_vsie_sca = MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE_VCPUS);
+	max_vsie_sca = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+				vsie_shadow_sca_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
 		vsie_sca_new = alloc_vsie_sca();
@@ -1940,7 +1951,8 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		put_vsie_page(vsie_page);
 	}
 
-	max_vsie_page = atomic_read(&kvm->online_vcpus);
+	max_vsie_page = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+				vsie_shadow_scb_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	/* allocate new vsie_page - we will likely need it */
 	if (kvm->arch.vsie.page_count < max_vsie_page) {

-- 
2.55.0

