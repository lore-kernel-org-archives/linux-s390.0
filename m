Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983814;
	b=cP0vxZrC0w4ly+agHMRIw7MtWuqoJdoVUzQ7wu0JORVZGMYc/yeSJVu0vGCZf2j8q2H2
	 45bnj8q6tFtsRWHlQil1KhHx/usaU/e89VfBtWSyPNx9Iuz+UhaXhje3x9CSx9q2NoYgf
	 Iq4M7/qCqF78ukP+JdCXUCLm8NtTCiU/WtC8H0Nb6qq3fzWahDjjRlwyrZ/cWSDkQz7Ye
	 49dYAAVAUgXq7PGwUZ/PxE07efooKHCVq6f6o6jXeOobboCR7DeiBG/RYFJmzOgumSpPl
	 CrWo3/MvooAtAgLqBR3LStOF91jGvRRuF02ZL+jYx72PrY+rgsr5xjA9PQvGjN/5cSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983814;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7AOxHFOMYDCpLEAfZDWkqVq8q+edd/YtGJPQaJMemKM=;
	b=gsGt2XmZJVz1js/Rbwk4qb6YAKewb5k1sYVc8ae2/yh+hxaeDpUfaTNfZVBuFikCVwtm
	 L0XuN4mRr1+IqFIrRNpyKE+UFP1X7HiqHLqoj5nH/nZlZ8AbtM5X0bM9MaoJgH/KCHr9N
	 y1L/hteX8ifbCpdA7C6Mz8HVcrEQcRC1jep7pZWGwYhU/n3QhMlTPwu9r4l4xzoxr5MEh
	 94nYlKsiah4HNZxHSdOdoApKicl6f48bOKzrDX5C9nacF+YrJyLKwTygT2jKLi1yrgybh
	 aFp7acNJvBaeaoCr7NbX3mLPmMaQxj+9x8W95piSHEdKQNG/viU3wGSFxZ+Vjaefcpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="cdG/hBlj";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848D606A32D;
	Fri,  6 Nov 2026 16:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E848D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cdG/hBlj
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEAf42711280;
	Fri, 6 Nov 2026 16:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7AOxHFOMYDCpLEAfZ
	DWkqVq8q+edd/YtGJPQaJMemKM=; b=cdG/hBljy9xk7PuM8rbCc/9FMqRppz7Mu
	TE+fK9lTpnwAwLV0n2Ki+bAkizNtZmxcp6/oAFM7B13pKpH2a6nflo7dHhznxxKM
	UcONs2Txf9Bk52Y5no/Rg1ekk7hthjDc8d5zirTjK+QIKhqmSdHNcrMBKirYAalF
	+lhgejNh9MQYJ8GqhVJCMfjFuV0B2cSwdhhyBv8d+HQqt8lFz7N3WBge1eRilJqL
	mBaxe1MN06Hy34gS723jAiL+8IYy6WIXh9TcbrW8GJxjubAHNwvsun60hNaPy/Kc
	QTMgsaPXlwV29uaxUZoQG08BI/GOI4TuST8fd1BheNOoek4B+a86Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r95xnw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4tRw2390103;
	Fri, 6 Nov 2026 16:50:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h149vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6Go78166322766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:50:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79D0E5805E;
	Fri,  6 Nov 2026 16:50:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1198C58051;
	Fri,  6 Nov 2026 16:50:05 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:50:04 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [GIT PULL 2/6] KVM: s390: pqap: fix AP status written to wrong half of GR1
Date: Fri,  6 Nov 2026 17:49:54 +0100
Message-ID: <20261106164958.431978-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106164958.431978-1-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aee0541 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-tK4viR7p1xyhzmblcYA:9
X-Proofpoint-ORIG-GUID: 4mEPBIWlYTEm7DmLBkDrW9pIL5_afqPY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX1uww2YURF13o
 h0IpYTZPYUKCTW30BcVx8fHUyOAYTknf51PUYnOBu3/rgOCQ38QkrH1cA7m9SLKEdYm00lCibXO
 Xaq1hWA6Zeq75Yk/IhXshFcEHNSJaca5S7O0uvHfWur1DQ+Z0lsTim2Z5LkeoFc+5PoC1S6KCPC
 MXxWJU8zm7A3A/Jkk+svQLYo6v3LNYN+heMxB9AtAXWJ0Wzo5jeiV7qx+uSw846GB6u40l1aFp6
 klYpWQ84ktADFFJEJDGwV+h2fvoySTk7zEkBnoaNnRhldWC9qRcwy6Vhfg+O8q1oBoWeHlu4UIb
 4safN+/Lrw+nC48YaMmh1zNO0cKwNoV3T7DCJQ6ZaZ3Sabt0u6+2rYPuwp3BtboNEvMkRbPVzbx
 CSeXmZH2YPRJM/SjjQd55KyzlaMCqNDNAJz6/3TEn/NSpQmCQyX2sMCK2QDZcUU8IZ/pXjMG4KH
 hYLsaUCHRV8k57viMBw==
X-Proofpoint-GUID: 4mEPBIWlYTEm7DmLBkDrW9pIL5_afqPY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX7oD4dipSul0k
 zLOJ78vci6vsy/1AC/ighbiiJsyhn4DO1MR1TLbEmdYkpoYFkjg18BFJiWXfl5+/L0grDBpjy/O
 DNBVgqnFLyW5tqFC0olR5tUyuTprhfA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060066

From: Gautam Gala <ggala@linux.ibm.com>

The AP Queue Status Word (APQSW) occupies bit positions 32-63 of GR1,
i.e. the low 32 bits of the 64-bit register, while the upper 32 bits
are reserved.

The no-hook fallback path in handle_pqap() synthesizes an APQSW and
copies struct ap_queue_status directly into GPR1 using memcpy(). On
big-endian s390 this places the APQSW in the upper 32 bits of the
register rather than in the architecturally defined APQSW field.

Use union ap_queue_status_reg and assign its value directly to GPR1.
This places APQSW in the correct half of the register and aligns the
fallback path with the register layout used by the AP infrastructure.

Fixes: e5282de93105 ("s390: ap: kvm: add PQAP interception for AQIC")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/s390/priv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index b252c812dcbe7..f22612a127c96 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -593,7 +593,7 @@ EXPORT_SYMBOL_FOR_MODULES(kvm_s390_is_gpa_in_memslot, "vfio_ap");
  */
 static int handle_pqap(struct kvm_vcpu *vcpu)
 {
-	struct ap_queue_status status = {};
+	union ap_queue_status_reg status = {};
 	crypto_hook pqap_hook;
 	unsigned long reg0;
 	int ret;
@@ -662,8 +662,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	 * No hook means no driver to enable the SIE CRYCB and no queues.
 	 * We send this response to the guest.
 	 */
-	status.response_code = 0x01;
-	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
+	status.status.response_code = 0x01;
+	vcpu->run->s.regs.gprs[1] = status.value;
 	kvm_s390_set_psw_cc(vcpu, 3);
 	return 0;
 }
-- 
2.53.0

