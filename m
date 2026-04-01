Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3C30C63A;
	Wed,  1 Apr 2026 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009372; cv=none; b=A35GBHJOF5M1pdzOXyds5ufIs2Rrl3Keof9flOsmHzD/DAWMhYLsNL0+oMQfr+Gvlih+l9Z/tBjlgs7J28AyqBuWgiX+ysmNTYXQbpOZogoXIz7r/JT0vkMMM9ZGIGRm6IVa6RcFv7eEVx7fpxrBj1He3WeCmgSqp89J6vQXDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009372; c=relaxed/simple;
	bh=xY5PTWP1mDdLUKoP0AOyAtFiRjiVmGmpCyREpH5WA8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISHzjzmoTn0VbqDAQ1UVawNL9sKikRgYfsIowaTzE3hK05MrK2vLwgvDdXjjPxvDbnvQrVuU7Ma0IDvObz7NIjvpduRTHOIm02FqHCb5VZU9A8ScXLaIAQC+4TwS9aDGBeXvRXHgrzWNcBdXNjpVg3+t/X0mVCmn50RX36EoA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oOSlUjMn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oOSlUjMn"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VJFm8b244930;
	Wed, 1 Apr 2026 02:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZEovNZ6Pd0ktLpMX2
	2LmGR79VOxcAVGmaQe/7TdJiCk=; b=oOSlUjMnIMg3LHQxJi8Jqg2mL96qGmC/R
	jINBvYuSvqiYVRO89wtiusbjSwr/Vt2nd1Vdu/rOVGD0RBXR4ZRrMBs3tL3Ex9Qd
	td608IFAtmKFZRuWrT6EYy2HtX55X2GEjDZKQnBmTNb2DMJggDvBR58QeqWFuiFf
	Km6oRLVlsrVPX6N7AQ7cRlOapALpbwA+Pn5kE8IyH6d7FrBvdTATwH39ezKXxSV1
	+rl2g2Ue8WOOF37XQBaX/XqvWJD0v/z7Opul4sXDGrf2nbwnLPaoR9YBKSRz2pie
	bnoDwtJingRcHotyreR2hD70MHzSNVPR6Zss4R0FPfO0JBVL68/Eg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgnq0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63108Sid005977;
	Wed, 1 Apr 2026 02:09:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy3u2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63129H0g52101420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 02:09:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBD3B2004E;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B0D620043;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 7E24CE023F; Wed, 01 Apr 2026 04:09:17 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 1/4] KVM: s390: vsie: Allow non-zarch guests
Date: Wed,  1 Apr 2026 04:09:12 +0200
Message-ID: <20260401020915.1339228-2-farman@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAxMCBTYWx0ZWRfX1SbC0nEfjO1l
 AnyVUJFRFF8eHJUXNv+Jn8W+HpQZIJVB9KYrZ3VRinyQb9J0ZiS9Usdzji18sYChrcNLdXfrORw
 Uz3wIu0hxHVKlh+K/Zaq7N6hhtORvzcxDloRIzctALzKZxdOP8yZ1lrCMt97vAXdZ7asKxKA6ME
 jSl2RRbwRJG3l5JG9F8FNpVyZhRCj9bFjfkd91u+lDIC1XnynFm7Gd+lHPWXrYUR6ajUz4DlNQk
 5wxuo20JaHrdm+rHnQkDt9pd7kkfMvSI1Jplh2+q5BbX0C2JKNLRSzz1DpCLuhhfXmy3YYLghni
 0VvA3UQeas/eNC3JE798O5aRRCJoBxaGjbvIwESSi1N31uq4UxlUZPgPEOUqVZ+c0Kte/kc7c4O
 q3a/FexKPEt3NN043yKvVMebuiQLUNnm23ideUBEMquK/8swM63aA+SGdpmYvlHNz3ZuwW07/OF
 j/g72ASQtbdd4A6fiGw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cc7e52 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TcF5ixnfVCNIaZDrkBwA:9
X-Proofpoint-GUID: GlugZxva1F_IyBqSMkUzvxqEHXB9oDgn
X-Proofpoint-ORIG-GUID: GlugZxva1F_IyBqSMkUzvxqEHXB9oDgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010010

Linux/KVM runs in z/Architecture-only mode. Although z/Architecture
is built upon a long history of hardware refinements, any other
CPU mode is not permitted.

Allow a userspace to explicitly enable the use of ESA mode for
nested guests, otherwise usage will be rejected.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/vsie.c             | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
index 3039c88daa63..8a4f4a39f7a2 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -656,6 +656,7 @@ struct kvm_arch {
 	int user_stsi;
 	int user_instr0;
 	int user_operexec;
+	int allow_vsie_esamode;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
 	int ipte_lock_count;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 72895dddc39a..888370a02ef7 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -125,8 +125,9 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, st=
ruct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
 	int newflags, cpuflags =3D atomic_read(&scb_o->cpuflags);
=20
-	/* we don't allow ESA/390 guests */
-	if (!(cpuflags & CPUSTAT_ZARCH))
+	newflags =3D 0;
+	/* we don't allow ESA/390 guests unless explicitly enabled */
+	if (!(cpuflags & CPUSTAT_ZARCH) && !vcpu->kvm->arch.allow_vsie_esamode)
 		return set_validity_icpt(scb_s, 0x0001U);
=20
 	if (cpuflags & (CPUSTAT_RRF | CPUSTAT_MCDS))
@@ -135,7 +136,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, st=
ruct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0007U);
=20
 	/* intervention requests will be set later */
-	newflags =3D CPUSTAT_ZARCH;
+	if (cpuflags & CPUSTAT_ZARCH)
+		newflags =3D CPUSTAT_ZARCH;
 	if (cpuflags & CPUSTAT_GED && test_kvm_facility(vcpu->kvm, 8))
 		newflags |=3D CPUSTAT_GED;
 	if (cpuflags & CPUSTAT_GED2 && test_kvm_facility(vcpu->kvm, 78)) {
--=20
2.51.0

