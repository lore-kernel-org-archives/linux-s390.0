Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F43AEF27;
	Wed,  1 Apr 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056362; cv=none; b=cFU7l/BvHyXE8IQU09DrrDFYlItfkP0EboPHUM+4TffWpKwWHzFO6keOXzzVH/7rYtWzG2RI4OxgmIkHYgtYpiCaQFl+1MKzm4DyLPXfWBpwBM1gHf2G8D+YTlYklijQLM7XBkxNRCXSebQ9FimObp6d721OXvXVMsxKQrBXiIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056362; c=relaxed/simple;
	bh=fy5nGluSqUE590irHKaYzBriBiSZkDcsOx2WEIWcQFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsPzvnM1s6T3m/rTO/Gcn7RFvcEbPYLWIJGn2PHZo7KHRTlXHP0KdlFbh1y8/nZ67f0P+D5Sh+4PfE6em8sNX1GyrzLy83TP4Bn6xUSxhGSKulf9PMsvxYfscTAqMOpAXqhngS4HOBR6kTRg4ouTDJu1nFK5xhID6INuBIzziRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G86IkIn6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G86IkIn6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631B2CQi138974;
	Wed, 1 Apr 2026 15:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xf4jV6+vAFBCBkNqi
	wVCGfB0u3KUmiRk2dXlwWAQ0Vg=; b=G86IkIn6kzcJn7j1QBSoPRr8BASEK+ilS
	hA2P5v6AZgo9l8Z6UTqF0mD01aC+8MLWpgtdUqBb0EJLbT7So2jrmJroVdhFvXMl
	JBbA/TGE2+3vvxnDyiJa9h5ZrET4XeXOlL8NYx13f2atvGFF5iSJfY51WpcCg5mb
	E/1n23XIEVDS0RNEDPUkojAVMkMBgdVwT4D+gbw+h3vV0rA+BNhBS2/ZQKv0c+m4
	5Vb1kk6C1i7j7tD7+cFiKu8CxJJ6mFgmta3yFFQ3WJi+fvQ/yUqHRdswWZMZ0hIH
	hMqmH1QZG1fl5RnEELu4IL+Rt37mx0AICSAHQwmcej/vfIdYiNpgA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgr805-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631EpJes005910;
	Wed, 1 Apr 2026 15:12:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy6822-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631FCOIP27919026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 15:12:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D844B20043;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A992120040;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 8F0F0E067F; Wed, 01 Apr 2026 17:12:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 3/4] KVM: s390: vsie: Accommodate ESA prefix pages
Date: Wed,  1 Apr 2026 17:12:20 +0200
Message-ID: <20260401151221.2272408-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401151221.2272408-1-farman@linux.ibm.com>
References: <20260401151221.2272408-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzOCBTYWx0ZWRfXyEd7tSiJtd2R
 A2o3pk8mp32vn9ss0BGY6sYq76fMdBhxo5Cwsa7PWYgmcps2WS1fkSM35leKq436bkoU4aRLldI
 UHaINVC9YqnqNlP+NrkGikn+DxptWggBWdYlaaQNWDLrPsED/rGGdu5NLKG+tSwVO/piKd/SmQH
 whaX3MFwh/jTOkJMpHx6R6z/FByIhGidAr6LO7EE+R4QI/zyBk+0YZXwKJRsAKtAEoYbTqrf1M9
 0yY/M+riScJDmxequg2oU89rz7gIUgOfATkdkHpqsGNUdwng47BsVg2LdFvrhj2rSI6G0xLaWGq
 ihyq7kJcuppp5+GDXOYbHMz90mPvQIN75z40Ph1X5bhMjpc6CLNmdirFn64+NpYtfSEvi9xPqLw
 ZUHHk1/L+GEUVXAonuMKJHqhn6dRk1NmqcGD16UXKGiV3Zzi1qTIY2PXcwsEHLEru6TMjtCC3kY
 DyCMupCaeKzKVTbIB8w==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cd35dd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=b85Ou7KXdJ74_8UzWO4A:9
X-Proofpoint-GUID: yIOuiux52fQFLWcqObZ96vLGKlAP-S7q
X-Proofpoint-ORIG-GUID: yIOuiux52fQFLWcqObZ96vLGKlAP-S7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010138

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
index bf1d7798c1af..dc0573b7aa4b 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -122,7 +122,9 @@ static inline int kvm_is_ucontrol(struct kvm *kvm)
 #endif
 }
=20
-#define GUEST_PREFIX_SHIFT 13
+#define GUEST_PREFIX_SHIFT 12
+#define GUEST_PREFIX_MASK_ZARCH 0x7fffe
+#define GUEST_PREFIX_MASK_ESA   0x7ffff
 static inline u32 kvm_s390_get_prefix(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.sie_block->prefix << GUEST_PREFIX_SHIFT;
@@ -133,6 +135,7 @@ static inline void kvm_s390_set_prefix(struct kvm_vcp=
u *vcpu, u32 prefix)
 	VCPU_EVENT(vcpu, 3, "set prefix of cpu %03u to 0x%x", vcpu->vcpu_id,
 		   prefix);
 	vcpu->arch.sie_block->prefix =3D prefix >> GUEST_PREFIX_SHIFT;
+	vcpu->arch.sie_block->prefix &=3D GUEST_PREFIX_MASK_ZARCH;
 	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	kvm_make_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
 }
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index a3cf1d89d573..e5a23f1c9749 100644
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
+		new_prefix &=3D GUEST_PREFIX_MASK_ESA;
+	else
+		new_prefix &=3D GUEST_PREFIX_MASK_ZARCH;
+
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_SM))
 		new_mso =3D READ_ONCE(scb_o->mso) & 0xfffffffffff00000UL;
 	/* if the hva of the prefix changes, we have to remap the prefix */
--=20
2.51.0

