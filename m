Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FB3BC68A;
	Wed,  1 Apr 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056360; cv=none; b=q50ourHPf0+TyTWz7Tr49UjoJWs/z/ImYF67M3DEjXCjoMsq299M2kVpuKw+Q6o+3ZtRyquWKJ5PVJoG7YYDZy7H3jDcv26PhAdCjJvrhHss+LSkaP8XvT+B1tPtSEcM1gWTVpPct9yJR4RwpJqKV3oUDniNjMdSiquR7oQv7P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056360; c=relaxed/simple;
	bh=evp5WHmP65YXB+ei9SNJyT07KxvYH91Z3UcOuQuAgyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gfa8+HEMTcWji2NgT3Uv7rYNSpoqM1o73YWa5ZNl63a8axlowWHEUPAbQyhB70/2Qq+UoGBrZVYSU/LifZrr7ot42r9opch8CIj13eEKumWl3Y1Rlkk73zK+QvOBVJOL9EoRaHU3sYw+ykVtUV//J0CVFgJKKFpSHQnxB2wlnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oj15dyE3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oj15dyE3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6318ZLYb3518860;
	Wed, 1 Apr 2026 15:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y7j7t85hhaTdul5ic
	kmffTl5vlLPWKF/fkJO4lebKxw=; b=oj15dyE3XnzFJEoHOg0jog9rX2tpyrbFJ
	kRx6CRQd++Y3TK6OR9tFp0umXFF8wfHtR0SKtdYr/+2GH40sRQVL/dyJ6+n0pmdI
	BWFy+Cbdh9t4DjvbSXHUYngSUOVV64m4ZIDHl5GN7mbJGuff3B513j+e3WYs2zSi
	QI6uUpTcPOE/qP2nAhB6W0X/j0vm0Z+Tl2SWLHHTN72/gcVcbSp9sAcshUZn/r0Z
	r9Q5xEmX1cbr8ocfpbjvL9yH8IhPvENwaXNkoE3if5O8pJrzU7hHJ/F3vd1R8cEc
	zACr0vGdLvGcqJ5buYNNFXYpMzmbklyCYC2ETHKkGeu6SKrG/rI0g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q38snq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631Ek4EA021631;
	Wed, 1 Apr 2026 15:12:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6saspaex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631FCOeI59703640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 15:12:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF6942004D;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2F6320043;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 8981AE0152; Wed, 01 Apr 2026 17:12:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 1/4] KVM: s390: vsie: Allow non-zarch guests
Date: Wed,  1 Apr 2026 17:12:18 +0200
Message-ID: <20260401151221.2272408-2-farman@linux.ibm.com>
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
X-Proofpoint-GUID: kXm7WxIYu7-LlyMdFrdNEWAcI-YREi7g
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cd35dd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=TcF5ixnfVCNIaZDrkBwA:9
X-Proofpoint-ORIG-GUID: kXm7WxIYu7-LlyMdFrdNEWAcI-YREi7g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzOCBTYWx0ZWRfX2fl6+RW5wBzE
 MfEAH4nlvI2xUrwqq7pSLp3ubSoquY5VhAwhiEGuetiRw+rGcvvd72x0wjJRvStDhlle2+nWhxs
 ZMesC9/zT9fACOQh+fgBzQzsW7LClHQKnYXGh3YYclcKMDc538W/XxlnZqjEZ69a/03xLxEKeU1
 j5IjA9cYJ5GdHi3CkA07Tb1647SMD8B6k4AMwBhrdEURxJzO+v5nc/M6VJPfgfZspdt//FUO1EI
 a1Rrtc9RnjX7yq+m7hlps7Oty30u2ZQF0CW9YCq9+k5lQtvN4a+oXfASRlZwHa2Y0gt8D7sJB/C
 Sx2XIFCP5t7lqyRZxqdlrTgUnItOXNjyQo2Z7vHj49PDo2mAfnd1PyCSvNJ08Sa0dHBV1ZmiuW3
 jZpeOVIOp1rIgjdgPWJViuvkCw247L8EUtjgGkQAhFwLNB9NcKn+3MJSYx6cNctJ2kHG6n9cfCv
 hWcueEHNbpx5QXQp8GQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010138

Linux/KVM runs in z/Architecture-only mode. Although z/Architecture
is built upon a long history of hardware refinements, any other
CPU mode is not permitted.

Allow a userspace to explicitly enable the use of ESA mode for
nested guests, otherwise usage will be rejected.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
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
index 72895dddc39a..eee1b72e14df 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -125,8 +125,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, st=
ruct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
 	int newflags, cpuflags =3D atomic_read(&scb_o->cpuflags);
=20
-	/* we don't allow ESA/390 guests */
-	if (!(cpuflags & CPUSTAT_ZARCH))
+	/* we don't allow ESA/390 guests unless explicitly enabled */
+	if (!(cpuflags & CPUSTAT_ZARCH) && !vcpu->kvm->arch.allow_vsie_esamode)
 		return set_validity_icpt(scb_s, 0x0001U);
=20
 	if (cpuflags & (CPUSTAT_RRF | CPUSTAT_MCDS))
@@ -135,7 +135,9 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, st=
ruct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0007U);
=20
 	/* intervention requests will be set later */
-	newflags =3D CPUSTAT_ZARCH;
+	newflags =3D 0;
+	if (cpuflags & CPUSTAT_ZARCH)
+		newflags =3D CPUSTAT_ZARCH;
 	if (cpuflags & CPUSTAT_GED && test_kvm_facility(vcpu->kvm, 8))
 		newflags |=3D CPUSTAT_GED;
 	if (cpuflags & CPUSTAT_GED2 && test_kvm_facility(vcpu->kvm, 78)) {
--=20
2.51.0

