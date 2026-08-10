Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B250330D43;
	Mon, 10 Aug 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377273; cv=none; b=FP2CweOe0ZtlpOqgNUhHAQUvEcuPhsRS7sPf6dWQjgEl3AyEW/A9DVHpYnPQBq90ZkENaYuct46Le3r3HgCEMUPBKMCLZUfM+eGdXsbBA62+6x9RYl3SsjrMv2HGgWcu1E2Z0sSeTlf/ePALdEWKjwRWDu6ri/iXZDQXeU+O/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377273; c=relaxed/simple;
	bh=08SPRI8ptPprvTID/9LOu+3HA1h/wOwZiiV6dFp0TE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+qFTOOIW7JSkoOFtnvifkQecfAYF0TL4grh/c87rXycKU+MYnaaY9FtkkSZbzjMc2NIYGjodgEjg3Ny1AEEaIP2OJfFfJLgRB94dXvQR4/UuvKxIuzGoFVJqbDsRZAA8b9Xv6uRB0Y6gvH2k3J7Y7Q2qoXcbF2aOeuRqkUsGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Htu1jesZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Htu1jesZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWtYR1982993;
	Mon, 10 Aug 2026 15:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0fmHCn
	92oToxkZO/JfHLcl4X/xW3IEAf2XYf0i+gmNY=; b=Htu1jesZpFP9pgZdowAPos
	ODbgj8Raktr/rRP9991cRC72fK1QPb6p2x1mGeC5WO8TbEx3ya01L0jsC5d8TtS9
	ihnnkRDQJcps7skC0lOu8UwPzPXHyqt5AnPgyUKpGoTDv0PA4D8mwLXNE76yRCPJ
	3xDluXd57ipqMu/AfUJKhPev0LSZOnXxE5CYj9zv9wF+Ki62uqjmeBnqDV+oJXu8
	n8zR9ooPRvFppVVQN9GR8fGfrohkhD+YbEbtJQSyH6mYmlv3YW7dcJVeMQEF0cWm
	BlUO8ORoXsL0AIg6ovoNb5W1sdArYxloqGpF/esZA8nwv9PAGr7iP/RpNs02rGng
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq98t6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgYL9012280;
	Mon, 10 Aug 2026 15:54:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxw6r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsOpx39584142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0680C20040;
	Mon, 10 Aug 2026 15:54:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A2CE20049;
	Mon, 10 Aug 2026 15:54:23 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:23 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:54:05 +0200
Subject: [PATCH v2 17/20] KVM: s390: vsie: Add VSIE max shadow
 configuration
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-17-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
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
 bh=08SPRI8ptPprvTID/9LOu+3HA1h/wOwZiiV6dFp0TE4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVX5TmVJ8wd3DbEbA5Y8HymTGXq89FBt35y62cl6B7L
 Ut7+7qvHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzE/gAjQ9MN7ZrK8rOvwiJm
 H3xurLZ815Hvt38cErS+KKlpsebHoViGn4zvtnJ1hM9wlj5ysoxX6WrGo4MOzjuqazzTQ997pCQ
 9YwQA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dpJgiLFihW-fjhvDsP-dYdd4fWzfwvsX
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a79f434 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=NT-WFI3kCPxDzj7wveAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfXxN+vn9qb0IY7
 aNN0PSIvhPMj+oXjrGQmLR2F9o1JRv1LqJ9r/UdOV9dfc+icEaCPo65YwXOvEwIkF7eSw4Dfdbr
 d90DNqTg65KhKt+eSEwvZQTgKQfAJgLLq9Y57/TabbwpTVrb/YotUdn31bP0RjjK7f38MMCEd9K
 6C4LJ1sJRv92wy+A/bYVIh02MhJ4NgBBt+OxFVZuVH+9p8oQ5qGt780zGxTmAZaka6KDeppQLEn
 eqOVuiC7MrNHRAKPzgFNrjrOmFaetdTe2Fq8GJV+Lk2HChBs97nu8QIVdz/RyKZk9o+QGoS4OHO
 UqcGIEHq2GjSnsT66bAbg1hRPUIIo167v/A0J8CCINySxfTXk2S9MAOgeYLjNxh3+7yYPmG3HVL
 mgG3Y8B6eWw1/kt/2MOlk3NJ9wRuniUKGucHeWYmOPY3ZxCTDeFLZshsSyt+PW6cbKQ/gu2c/LE
 EtocldPspflakryvnTQ==
X-Proofpoint-ORIG-GUID: dpJgiLFihW-fjhvDsP-dYdd4fWzfwvsX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX5D/EYUcztRKY
 J9g23he3LdL64woFYufABS8z5Y+qLqm8W3SQxxgQMEdFOTZOyiM/+8wzfqqhdTwKfXOZ3kCVT4E
 2n6fxK0l7SgbwomZcag2otVVKr/SUgc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100134

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
index 3ae346265b81..892023dc92d4 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -105,6 +105,16 @@ struct vsie_sca {
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
@@ -1062,7 +1072,8 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 	 * We want at least #online_vcpus shadows, so every VCPU can execute the
 	 * VSIE in parallel. (Worst case all single core VMs.)
 	 */
-	max_vsie_sca = MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE_VCPUS);
+	max_vsie_sca = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+				vsie_shadow_sca_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
 		vsie_sca_new = alloc_vsie_sca();
@@ -1939,7 +1950,8 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		put_vsie_page(vsie_page);
 	}
 
-	max_vsie_page = atomic_read(&kvm->online_vcpus);
+	max_vsie_page = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+				vsie_shadow_scb_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	/* allocate new vsie_page - we will likely need it */
 	if (kvm->arch.vsie.page_count < max_vsie_page) {

-- 
2.55.0

