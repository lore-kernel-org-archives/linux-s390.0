Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EB2F8BEE;
	Wed,  1 Apr 2026 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009370; cv=none; b=CI5/I6WUKuGiVCyUaJ1+8NJ4Uh4H59YF+IV9WgQeqF2nM2+qgeWYFKKVlxk39BnbVawIBY7GCb6RcGGFIVMbC7t5LS95uUA40kLsDMrJVDXdK8+bp8n+W76hMZmdy+pFv78jPMX1W42Jla+/OvHbCRaxxPud1WzEXjzvdE3Yim0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009370; c=relaxed/simple;
	bh=ZCNKK2nhSeXz191Ike0pmViKWMT1eFQ9+KoV535lTQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fF09dcz3anATQ3gwtA4fCC/R5nPT6UGQax0dCKMMscyd4DrSBF5vvKBrsnPbJa7WmfiSBn0kOmgJtv9aax6Wf/PK4SgCgNfTsQVvKrWZCHN0cl+gyRwQZ9YhsiRCL+z3mjGr53L4F/ehNF5OXqceY9h4swsa8bvRfQNpqhTfnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iz2ytQ6v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iz2ytQ6v"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VEF8ho2679500;
	Wed, 1 Apr 2026 02:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DzeTCFTsLI3SRc9DW
	gxTHWlfT1K21Mj/59dKNmP0pFM=; b=iz2ytQ6v7664ZQEa/cBVezY8GTL1Ie1eq
	y+cccCRi2SfHxYnHsix0HYWf9qsQ1iN5VSMySlG/oGilQNB+9sGeZdWzOpS2S9QJ
	Gv5jPKqCPsN0TBw+DieyKaCslnJUGQ32g6/MGCahPF+kMvHQGPll/TYd6GYVhs5y
	6px14tCXMPGOz4leMWfiOB3BLZJRQ/aeTyszX0Zj2TMM/drDWCYsw6QeavzX7/Cq
	l4Hr4bsbcrfFD85UL1SGWCoqIDWM73AMNxUWTxGwObclc/spcNi1vx5yrOQCLllK
	A9+0yARQ42pZ545zDhCwVGZzfFzSAWB8GY3zlbbe04TJARiO/JIMQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q364p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63121ZsL008693;
	Wed, 1 Apr 2026 02:09:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11kgvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 02:09:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63129HOp34668800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 02:09:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C55412004B;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A73420043;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 02:09:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 812A2E0AE3; Wed, 01 Apr 2026 04:09:17 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 2/4] KVM: s390: vsie: Disable some bits when in ESA mode
Date: Wed,  1 Apr 2026 04:09:13 +0200
Message-ID: <20260401020915.1339228-3-farman@linux.ibm.com>
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
X-Proofpoint-GUID: 6J31Z4MRO6vKP42ijV3bizLU0xk_1VoT
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cc7e52 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=hR3koBuu2k_ba2zxy-8A:9
X-Proofpoint-ORIG-GUID: 6J31Z4MRO6vKP42ijV3bizLU0xk_1VoT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAxMCBTYWx0ZWRfX/6y/vM/ywWqg
 fui2hCowaZoGOxOPH21In09hNvS/wKaHa+TS/UcYmS1SJx7PmTAh4UhdiwBWiCZ2iE5L1dkGX+S
 3s/SrsYBrGOLKJqoC7+ITnu+SgXDiHIkfehJfI7dwgguOQVswTObgRVSS0I+uC6VGCcsPqtm8Rx
 Z+ZlSqbSDUAxv6re3SjW12T3X1g8HR1pH0eJuOuHZGJh1OAX8jmLA4OMlX3ROUKh4OFtZO2ZXK+
 shXyz6TQ8gXK1ckhY+wZKlwjQSGdQ/k8bLe8wAETBorDEucroWIshColG5DPsH2yOFp92q+XfaP
 e2JCH7qMjtVE0IMT9fUXYIyRy+InB748byVHiiuIO2JDS7+wUU+vGePtFg66Iwx1hgNkIvzrgGA
 we9v/J2hokkEluDHMcmwnX5a7IdDA4QWKI9m0PzpduKohMJ452cS4LtIvXMj8T4FZIrZM5OFQuV
 QR3LSMp2F1Hlj6M6bmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010010

In the event that a nested guest is put in ESA mode,
ensure that some bits are scrubbed from the shadow SCB.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 888370a02ef7..584fc7803632 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -387,6 +387,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struc=
t vsie_page *vsie_page)
 	return 0;
 }
=20
+static void shadow_esa(struct kvm_vcpu *vcpu, struct vsie_page *vsie_pag=
e)
+{
+	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
+
+	/* Ensure these bits are indeed turned off */
+	scb_s->eca &=3D ~ECA_VX;
+	scb_s->ecb &=3D ~ECB_GS;
+	scb_s->ecb3 &=3D ~ECB3_RI;
+	scb_s->ecd &=3D ~ECD_HOSTREGMGMT;
+}
+
 /* shadow (round up/down) the ibc to avoid validity icpt */
 static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_pa=
ge)
 {
@@ -590,6 +601,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct v=
sie_page *vsie_page)
 	scb_s->hpid =3D HPID_VSIE;
 	scb_s->cpnc =3D scb_o->cpnc;
=20
+	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
+		shadow_esa(vcpu, vsie_page);
+
 	prepare_ibc(vcpu, vsie_page);
 	rc =3D shadow_crycb(vcpu, vsie_page);
 out:
--=20
2.51.0

