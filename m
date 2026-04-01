Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17239A064;
	Wed,  1 Apr 2026 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056363; cv=none; b=eZSxOlpYQ5t/mTN5Izit3uWR2y57w/cx8sAMcXsYqK65Y1ZCjMsKAHBkGxeYRSv4eIhrD+UJZ3S419w5qe065yKXSrznTd92u8P2+A4pTR9036gV/kIRmYtJD2M3Yn/XpoZQgpFVIaF0j9PaDQGEwTd5ZiPOmAKpvOHQB8LzTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056363; c=relaxed/simple;
	bh=UqD6UggNvD+lC+lzX0idoPdCDx+A/bNcVuYsFGc3tzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlUrvdPkXpLtXFz7w3PZemP5GD8a2z7BUlelZ3yM4LyDZdHlBQJPx10QjnYvC1KFsrO+34Ts6lL1GkwuQc7H8nnjHjbBrXPkD8llxVlTCb8+QIxVGh7T3HN5CNdDFWJs8nik+2M9dSPB8/Cehf+PjvANIZwrmHXW0jCtfm6UoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nuoB3u0U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nuoB3u0U"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AFNAh332417;
	Wed, 1 Apr 2026 15:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d+HZdQv5th5XwZotg
	s0Gd3yN+6FdGWkyq1XSEl1IvGU=; b=nuoB3u0UgRVtZAeAsSdHRyYtmTMZydbmM
	ibao5gHJO4cb9yC3JlDxYcjkKyZ75kyqpWDthje+gyrpM/GC8iHGeZ929uu48xI+
	uLDzsRQPi/0hN/jaMQer0myYLcXOy5K4D30xvdge7E+e6Bzkj8AwDq+mtit2qHz5
	f+l1DQRpxOwZKVkH9385hywYGdWw0fvg7zgujMGDr3vpKWvezTHhUYflbVtyUKzT
	Gz2doE4XPWjtcHM2U4aTB3A2c2X5AygeMYPYFuqmc4AO76KjUvFjizJ0izqolGp0
	mbJ8HNtlTh4Izuvtt776FkqMagvJU/Dp7GoTcPIV+Y/wGGbvHeXtw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgr802-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CDsM6031034;
	Wed, 1 Apr 2026 15:12:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjx064-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:12:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631FCO9E43254162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 15:12:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E3F2004B;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A73282004E;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2026 15:12:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 8C807E067D; Wed, 01 Apr 2026 17:12:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 2/4] KVM: s390: vsie: Disable some bits when in ESA mode
Date: Wed,  1 Apr 2026 17:12:19 +0200
Message-ID: <20260401151221.2272408-3-farman@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzOCBTYWx0ZWRfX3NLBMjaqTUdC
 tsBWEGJ8VDUgT3Q8fbzftvxsKasCBmnAwiTKX8UsZEIaeP/npc3g8uydxUCSBIdHqFUmcHX5cup
 ST1kE2gGydUi7z7RkBoQ1T45O2/yZ80W/4t3g4tBCIed8ZbhslJd7STTvSZRbyaqCQJT9GfHD79
 Y70bXqwdqxr8y+cDR3Twmjrfqaq0vU+QimvMPpg2wvBB+POjbAQNBcsM9uKLeBDHXfdV+RcOkef
 ViqVbZ6yc+nXBXda3GtZ9eVsjb82R7lJLtQ4xdlheqatCj0h+FWBcXGsqzo4avzEFeLeGYjHM8J
 ElYoTafk8QuAkXgHrwbEzxM+1L8bLkcMwp6LlKwm4RWW3xDeKCQJK213ZT1U3e1moKs6TrybvEv
 fdVYDpaxsT/S3Biu6Z6UjA8iAODNqQ192Mm83K42wjjdwXxoUHNN7zybfbSw1hBwL3FCeEIk9Tx
 sLu+Fn4b0qaplTueYyA==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cd35dd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=hR3koBuu2k_ba2zxy-8A:9
X-Proofpoint-GUID: f9YIUmB71QT6b067ErQe8u5AsQAZ1MUr
X-Proofpoint-ORIG-GUID: f9YIUmB71QT6b067ErQe8u5AsQAZ1MUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010138

In the event that a nested guest is put in ESA mode,
ensure that some bits are scrubbed from the shadow SCB.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eee1b72e14df..a3cf1d89d573 100644
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
+	scb_s->ecb &=3D ~(ECB_GS | ECB_TE);
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

