Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C504FECE0;
	Fri, 18 Sep 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744183; cv=none; b=SUIFPcNKYeYVWK9tewa6qwvnV21c73Z5KuTVwlqd7z8tKEXP2LczInw5XXtFp3qx1WVtZkp0CIVQEc3LFsadwVE62whS7sNNve1RJN9K7DwfAq8+QkMO7EoZAZqjlDt/S7YFp2DUfEKjp3Tf3MF+IuWzgDjA+huhPco6Ygh5+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744183; c=relaxed/simple;
	bh=V4HbsfI2pYUPkmn8tlci7EFaFet7C5Gz2K4iT2PASkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eez0JoS+29H5M3YNWRuzWguyTY1DLmmHk/mBdAPXlig/QoDkQ0P7m1ob08R03ml7p5CCUniw054DobzU8X0mSOPLzxm670b6Itj1S6yDZ7umCA00d4v05Y8NTTtBcDIL2mHb5amSsYq5QuRxcCuI5XN0AXC1sAlFLrXOkp8bQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UAETgt/I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UAETgt/I"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVnFh1394150;
	Fri, 18 Sep 2026 15:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EawxfB
	yVCxZV8wl4WZ3USXO4DBROisUO9TVRaXdLcTM=; b=UAETgt/ICbt5kA1xFil3m5
	i9nKNb6aBgIbERVdLAKDEw4tds2nd2gt0JRJOilllt+QiTV5vcAQ/2RCq7iB1z8a
	c2eIdIfdUQzU5DLq3YyoIeGg6LDsza4PX+8G6AFsqnmXDZW3+oA85yeuo6x8YSvL
	gw9vILep/A4JPWkBKXJIYZTs7t4/0um1sw4YrrkiIt21LrIHItMKkECstS4PnA2C
	Q2mt7ukno06nRhVa+eGlKk/omcyGT+arAsoykSA9MQgUCY2trr8OWvNEZjAmrnKA
	tTyfMRKCtourV2ZkNLbotIZwL/WpOtnk2SmVkZR4KTteU5w9dGPZeWzfNbpmzL8A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5gtx6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNvDK771806;
	Fri, 18 Sep 2026 15:09:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5fffvrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9OYu32244300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5D8720040;
	Fri, 18 Sep 2026 15:09:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C6EA20043;
	Fri, 18 Sep 2026 15:09:24 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:24 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:19 +0200
Subject: [PATCH v7 02/21] KVM: s390: vsie: Move SCAO validation into a
 function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-2-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2755;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=V4HbsfI2pYUPkmn8tlci7EFaFet7C5Gz2K4iT2PASkk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxScza2lrbT8j2lNzw+NYLa6wJNyaXOR0pONRr0x6
 xd9+WTSUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwES22DH8Lzq99Bqz4r32TLYV
 iu9CqzJZPIo2fw5bm+z13sG4mOOhEcM/tb1OttqHc+0bGv0qsk5/4u3ZETKdUf3YGvaNy711G2T
 4AQ==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: O5hDOwjU6cKCehkYR_5RKWcHuyMFcas1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX0ki12bkGU0jx
 bGsBbTsNmNY37htJIhUGTvvB4/Ai3aenAgvJ4pCsGlizJgcDVimDVWX0JPtsMDseYTEchkQdey6
 E9KKsqf8mmKNd/oY0AAnRSicjZeKDrA=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aad5429 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=e9sD66FpFztUsjZjJoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: faHiLSL5RLkJkEfle1nl2eqebOqF2Bz1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXziVzVEZWOthQ
 l0q+93+W9y1/MDrU9YifKVAfHITcvtNC4ybABZ6yLBsm/rlsLRBcc4nNs0BmuLrjcq9yNNSOvUh
 xm0l0LsrY9lkSHHYY4HSlRUM+GDHjq5IaEESiaIXqBAdWfve8zJ2iz2AJ8kewrqA/Kl0/Tyt6Us
 794ZC8EntoFpiHQWJIuMj5KmtivZYxvbKWUDyr2iqVBqcKpivKH1GsQAKT7o/x/IIfm4DnFkd/L
 779OuXsbNFczqRZEAsMzPcHonnOcMqjyc2fv9slkXM+8Qas5fE0manGT1zZuDakU88xyHlEOtzM
 3GbOj/sOjFwFOjVix7J74W1FpG/t7jhft+qm4pB3i3eFNt9Bopajo6EGSuqDL+kHyejgyntAvYb
 +phNuZ4W4daXszOq42XyLU9cUKGSS6HUdhqVEceCaeBFrN4JAq08yzCBfMb52NPt8+Usa9S0u2T
 MpLJmclLhgHj+WZWb/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

Improve readability as well as allow re-use in coming patches.

In particular add the logic to be able to check the validity of BSCA and
ESCA origin addresses.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 61096ee991c8..04cb38aad33c 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -71,6 +71,11 @@ static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
 static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
 
+static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
+{
+	return (scb->ecb2 & ECB2_ESCA);
+}
+
 static unsigned long read_scao(struct kvm *kvm, struct kvm_s390_sie_block *scb)
 {
 	unsigned long vsie_sca = READ_ONCE(scb->scaol) & ~0xfUL;
@@ -97,6 +102,25 @@ static int set_validity_icpt(struct kvm_s390_sie_block *scb,
 	return 1;
 }
 
+/* The sca header must not cross pages etc. */
+static int validate_scao(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb, gpa_t gpa)
+{
+	int offset;
+
+	if (gpa < 2 * PAGE_SIZE)
+		return set_validity_icpt(scb, 0x0038U);
+	if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
+		return set_validity_icpt(scb, 0x0011U);
+
+	if (sie_uses_esca(scb))
+		offset = offsetof(struct esca_block, cpu[0]) - 1;
+	else
+		offset = offsetof(struct bsca_block, cpu[0]) - 1;
+	if ((gpa & PAGE_MASK) != ((gpa + offset) & PAGE_MASK))
+		return set_validity_icpt(scb, 0x003bU);
+	return 0;
+}
+
 /* mark the prefix as unmapped, this will block the VSIE */
 static void prefix_unmapped(struct vsie_page *vsie_page)
 {
@@ -788,20 +812,14 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	gpa = read_scao(vcpu->kvm, scb_o);
 	if (gpa) {
-		if (gpa < 2 * PAGE_SIZE)
-			rc = set_validity_icpt(scb_s, 0x0038U);
-		else if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
-			rc = set_validity_icpt(scb_s, 0x0011U);
-		else if ((gpa & PAGE_MASK) !=
-			 ((gpa + offsetof(struct bsca_block, cpu[0]) - 1) & PAGE_MASK))
-			rc = set_validity_icpt(scb_s, 0x003bU);
-		if (!rc) {
-			rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-			if (rc)
-				rc = set_validity_icpt(scb_s, 0x0034U);
-		}
+		rc = validate_scao(vcpu, scb_s, gpa);
 		if (rc)
 			goto unpin;
+		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+		if (rc) {
+			rc = set_validity_icpt(scb_s, 0x0034U);
+			goto unpin;
+		}
 		vsie_page->sca_gpa = gpa;
 		write_scao(scb_s, hpa);
 	}

-- 
2.55.0

