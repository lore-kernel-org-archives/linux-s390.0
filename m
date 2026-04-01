Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD12FFF8F;
	Wed,  1 Apr 2026 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009372; cv=none; b=WhEx5cR+w6kQ1CEX2X33GVkVeCgJRUYn2/8TkMX9KGq3ypfae70jWFST3r9RrNuRnHqlldAPjPCF+9/xx5d+Ls5JEsZT6WWKx8D2UjRtYOu3aOK4sdP3gClFmvm0TESk6ahCz7Ei7Wx2xQ8f5kJWWav8dXsGZTcn9bdfZRlWdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009372; c=relaxed/simple;
	bh=lqAS5SHyWMQw9fSzqpivwTQPeBoLDAZaogy0xDJ01mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQzllFywkcw2v1EfDZ0i8szyBJCCVO+5qPWKawXdthjPxY8AXN4fBsVFSQ8QZnwJo24STCU8fwt8ywNk96zWFuolPDXcX4uz8sjIcE1gpeEQRwMoFzR4xIVRFyoBfmlTGRxdfmLCnroCEhMmjbqFQSWByk8mo5qv8IjARj4MTy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gN9NvlAh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gN9NvlAh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VI4O0G3676159;
	Wed, 1 Apr 2026 02:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I3oDXFCoRUSF544ep
	3/BsT39PcNNZ9lqDW+0UROjes8=; b=gN9NvlAhKefIJ1K8Uaz89WMykUTShFTY4
	707DcBaH3CMPr3PyNdNsJoEAC3GqegH8OvB5m+34Aq50iXB+pTTgNdFjxhkItqkY
	wXDB2HHu0P/dOa1C8IROpDAIlCT+C8svBt33ZYpXXWkD4THxFHilC6jmDgffMg7r
	dhQEdeh8++0hwOHBHsT7PU6toJPLqHZATij3WCIIArATashGGuzGvzY0pEP7gfrX
	9c8bmXgFDLKYWJp3m0ecqTxkg9POy4g70y6IEsENTmc7T32nYT0XgZceb0qMnW39
	OBrQphwoq2deLO/qxWGe0rSI/tqZ3EDtPCYnpfpue/a+VHgj3uiGw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms5fsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6311vACL031007;
	Wed, 1 Apr 2026 02:09:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjujyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63129HlC58720562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 02:09:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE3FF20049;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A33C2004B;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 83E1CE0AEA; Wed, 01 Apr 2026 04:09:17 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 3/4] KVM: s390: vsie: Accommodate ESA prefix pages
Date: Wed,  1 Apr 2026 04:09:14 +0200
Message-ID: <20260401020915.1339228-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401020915.1339228-1-farman@linux.ibm.com>
References: <20260401020915.1339228-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cc7e52 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=b85Ou7KXdJ74_8UzWO4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAxMCBTYWx0ZWRfX35J4OKvJR9dG
 3TAObSzG0xNjcetZ7LDQYjKHg21VR9FxJ8FufWUDXoAK0fSqFDH91CKR99Y5DFH6KZ5CXX/eRx1
 2egwXAs+VwUUpCj3HEqq8dfmktH8AD4piDVwG/cqDOevXZsVeAzb2LjA8AM0rZDoN9T5jp70Mle
 y6OULJHmQhQsP6dachwF8YZEM93epLw3i2gHfhbNrT+SIUE4epGyuoqiHtqD2wN563+5H5K540p
 ATaqC2wHDyVYJfYhQke3QyE39lPPdPkhnbsMGkq9SpPBPHQnLwcY2XuuYe+T5NDXeqiXPyzOKNP
 6/roEsZmc5eTVIuu9vnveI1rifLTnIjHTpFvspfGqi0ouinvqLl47dADgSrlPbV+Vor1djElvjs
 t19jM8akj4d0x9+WgM9v33DJoXvQTTHqFMBW1CUtc6q2pS3s6pdI5vzFYQ+mRd+Obx6voop+Txd
 U5qEwIC64B+fA7rOWhQ==
X-Proofpoint-GUID: Btuy36bm35SJnhLvbfoEr2skJScycp3x
X-Proofpoint-ORIG-GUID: Btuy36bm35SJnhLvbfoEr2skJScycp3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010010

The prefix page address occupies a different number
of bits for z/Architecture versus ESA mode. Adjust the
definition to cover both, and permit an ESA mode
address within the nested codepath.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_types.h | 3 +--
 arch/s390/kvm/kvm-s390.h               | 5 ++++-
 arch/s390/kvm/vsie.c                   | 7 ++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/a=
sm/kvm_host_types.h
index 1394d3fb648f..3f50942bdfe6 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -137,8 +137,7 @@ struct mcck_volatile_info {
 struct kvm_s390_sie_block {
 	atomic_t cpuflags;		/* 0x0000 */
 	__u32 : 1;			/* 0x0004 */
-	__u32 prefix : 18;
-	__u32 : 1;
+	__u32 prefix : 19;
 	__u32 ibc : 12;
 	__u8	reserved08[4];		/* 0x0008 */
 #define PROG_IN_SIE (1<<0)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index bf1d7798c1af..c0ad8effe3d0 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -122,7 +122,9 @@ static inline int kvm_is_ucontrol(struct kvm *kvm)
 #endif
 }
=20
-#define GUEST_PREFIX_SHIFT 13
+#define GUEST_PREFIX_SHIFT 12
+#define GUEST_PREFIX_ZARCH 0x7fffe
+#define GUEST_PREFIX_ESA   0x7ffff
 static inline u32 kvm_s390_get_prefix(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.sie_block->prefix << GUEST_PREFIX_SHIFT;
@@ -133,6 +135,7 @@ static inline void kvm_s390_set_prefix(struct kvm_vcp=
u *vcpu, u32 prefix)
 	VCPU_EVENT(vcpu, 3, "set prefix of cpu %03u to 0x%x", vcpu->vcpu_id,
 		   prefix);
 	vcpu->arch.sie_block->prefix =3D prefix >> GUEST_PREFIX_SHIFT;
+	vcpu->arch.sie_block->prefix &=3D GUEST_PREFIX_ZARCH;
 	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	kvm_make_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
 }
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 584fc7803632..e45378a01731 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -479,7 +479,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct v=
sie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
 	/* READ_ONCE does not work on bitfields - use a temporary variable */
 	const uint32_t __new_prefix =3D scb_o->prefix;
-	const uint32_t new_prefix =3D READ_ONCE(__new_prefix);
+	uint32_t new_prefix =3D READ_ONCE(__new_prefix);
 	const bool wants_tx =3D READ_ONCE(scb_o->ecb) & ECB_TE;
 	bool had_tx =3D scb_s->ecb & ECB_TE;
 	unsigned long new_mso =3D 0;
@@ -527,6 +527,11 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct =
vsie_page *vsie_page)
=20
 	scb_s->icpua =3D scb_o->icpua;
=20
+	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
+		new_prefix &=3D GUEST_PREFIX_ESA;
+	else
+		new_prefix &=3D GUEST_PREFIX_ZARCH;
+
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_SM))
 		new_mso =3D READ_ONCE(scb_o->mso) & 0xfffffffffff00000UL;
 	/* if the hva of the prefix changes, we have to remap the prefix */
--=20
2.51.0

