Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092586;
	b=ski9XeKvyzBmM7pKRzdVpbwwJUoQUtAoXXv94hWjTC7Ln7GHtzJDePo3w+0He3UjGyam
	 s1mv46mqWugeDe5frP4ADeDu6wnjz/DvX3wmVR6BYh1LeRdRsoHLT7C7DP3RUB+Hv95f5
	 tCBpNTsQt4MaFOn/2TOw6df+EmIbYJ80U5R4m/sSuEWaPOdAOhZXwcIcIQAzeSPp8f8Xl
	 XCtZsXlNZC24dqpKWj29JaU5mgREObxv3iLGpGAw7b8UTGco7G4SfUESLOZQS6Ej8wQ+M
	 Sde4pfK3pIQaI9F46cHPX/dKJjgGAYrAaFGo0Wv/HmUsQqV/77716rWE7vAi/q+Hoaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092586;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ofAWNxo4YL/BtaHCscfaG6PCmTdORj+jpCMmQSe4qBg=;
	b=Mn2YmsBl7W+7INAuW+eVqPOK+gFRAXTkXwEqvCTRPMJ/1npbOLzqn2QJsIfmVNki7+ph
	 GbXC7uDYltwA0d/zF3UvMcsUlyIRpK1i0+qouNpOxNZSvTj9mJEPWC8L0bhDIv5zVlpf0
	 rDTt1gZ/i3twJQ5wjk7RzU3qUQT6L2k29xRktsCc9jtiNdjj8B5MGHmb2v8AtN/cIQoih
	 sx4D83HnjAGGmGVU+mqdfqSDq9fm6TWJDYrrZYUXWCheBkJ1/HmaAJ7ImJzAyAk8r8c8o
	 qTCUoFjHwVYHg4r8WHkmR29/KbrXpIuwbeGiSGHvozXhaSTNKQbDCZmTlxxi4EGOJ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Doy0Y6/C";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C498606A320;
	Thu, 19 Nov 2026 12:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C498606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Doy0Y6/C
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBu95d037221;
	Thu, 19 Nov 2026 12:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ofAWNxo4YL/BtaHCscfaG6PCmTdORj+jpCMmQSe4q
	Bg=; b=Doy0Y6/CHh68mOd6t7+1wPF0nKMBpuak5xsF6t7sclc2fahtg97kjNxMP
	19ZTtBYHN2WzV6XiZecQZv7ePrtt9Qh8QvHLck54QJ/nrHOKixRR4tVizlcxOtAk
	UJwSGJUbqEs/KyBrZrv53tCWAGrEcJSBvkJL+rLXisj3UNqEM/ZgTWJMp49IOXvq
	TluTQw9zCBvFyniecLu6r0DMMBTZsk129dpNNGw7mkf7+nM+KRC9tk4YsKUPPH8y
	r0Fv7uQBhPvIXxwRU4UMDULq5W8I8jwZ2mqNoTqa+y5hu9MLKQm7Co3D4bATOTTB
	IA2ShIafTO8X3IBjsSR4JCaalpPSw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nh2qu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 12:49:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJC4qE62919168;
	Thu, 19 Nov 2026 12:49:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvqjvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 12:49:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJCndHa32768564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 12:49:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACECA58056;
	Thu, 19 Nov 2026 12:49:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B14458052;
	Thu, 19 Nov 2026 12:49:37 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 12:49:37 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, pbonzini@redhat.com,
        seanjc@google.com, shuah@kernel.org, ggala@linux.ibm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] KVM: s390: vsie: Do not overwrite guest 3 state on early validity icpt
Date: Thu, 19 Nov 2026 13:49:34 +0100
Message-ID: <20261119124936.33396-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX9RR/E4LMceoh
 HC5FIY/zS3xXKMfP1KAPpPxBnY8Bze6X+OFkxRcrBrOwtZtwRwAT5kbcNAgqiSxd60aDk1B1SMJ
 Oqx3i9SpfP5Zsip9nelozms5nkz2WWnsgGlB3zM/EBXUbr/ZvsI2SoZtzfBq/MYDF1TbP2grKiS
 34y+2L8TbEIjqavdbI8LRu8fyJn71hxjBqQr8mdEYB5tuk7RpbL5sw+wOildiAjj2z2kHv2MJN3
 OPkuJZOlb+rzqRfqw/g4xGuWsl+Fu4wtQVkgedkIQQPO9QhWrmDMm8DjZRAWb8e68Pp9eACwwCW
 8bPVJVqEjWOqYE4taGsH3svLo1gQmRTjyi4xZKZOJu3qFQPG2dWAV2BvATZyDO6y+5u1J0YdwfV
 wwm7CxsZ1Xju0RhnLZlCG+kFDICK6ergXhixAcfoLZA4o+3hc+kL+/Ke2B5mpVIyPR1vM18lYAD
 We+JlD4ZHrAith+trTA==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afef066 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=nU7F8ZVPbku0Jee06QcA:9
X-Proofpoint-GUID: WkiUeVjOpZmlEQWlCf2Q1UVcaRQ_Znr-
X-Proofpoint-ORIG-GUID: Yz_DS_F9XIa8PGzv-KZ9zWFKJxGKTPuL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfXxNx58amhCYU+
 +02zx4H9gaj/tBgvq64U9I68NgJMRLCVi9eTmljqmCnFk5ujoULSQjkkF+po+F1LSd4sFTA+aZh
 fG7s+E8Y/hoLaY2LN61GB05PaTPDarU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190049

If prepare_cpuflags() rejects the SCB provided by guest 2 with a
validity interception, shadow_scb() still calls unshadow_scb(). That
copies the guest state from the shadow SCB back into the guest 2 SCB,
although the shadow SCB does not hold guest 3 state at that point. Guest
2 then sees its guest 3 state overwritten with zeroes (new or recycled
vsie page) or with the state of the previous run (cached vsie page),
without guest 3 having run.

Patch 1 copies back only the interception data in this case and clears
the stale interception data (icptstatus, ipa, ipb) when a shadow SCB is
reused.

Patch 2 adds a selftest for early and late validity interceptions.

Gautam Gala (2):
  KVM: s390: vsie: Do not overwrite guest 3 state on early validity icpt
  KVM: s390: selftests: Add vsie validity interception tests

 arch/s390/kvm/s390/vsie.c                     |  24 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/s390/vsie_validity_test.c   | 435 ++++++++++++++++++
 3 files changed, 453 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390/vsie_validity_test.c

-- 
2.56.0

