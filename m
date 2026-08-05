Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEE43635D;
	Wed,  5 Aug 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927910; cv=none; b=bnWv5WMAhorBpecmWDFFHOuMEFDmZsdhhaVzV/GGAIjO8HPcL+SR4h8eG4y/ffJtBrTDnIChUqMvbH+J0yeSueN1KDPZPeyPYeZtNVRMlgb6B3dbjkL7nzjtjJbl683ra7AgDScWI7HLjK47zWneUUVZ+mPUoSSYzoQsbr5b1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927910; c=relaxed/simple;
	bh=HMWabie3mVP2NStld5EMwsMM3q/SSzYw4QAXsc86q5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8FficfrpLic4KtcnEwHzLVCwdWi+yru+GdzVe4i65mN1w27dyW7aagP9aDive/xZ5JwEAdYYK2SpNI0K/6zYxMLR9kkLWzgKR4sdRld1He9IJVDREpRJIj4ZGr+tb1LWFJXChfxELKcTLCF8r9dG4hNNpZ2cxJl2+uLEVQXWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GVNCA5Z8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GVNCA5Z8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lhcJ3387357;
	Wed, 5 Aug 2026 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dWq4Jb+bgww5xmgVu
	yIFEQqsfCrDhbCuPvAL6fM6Uns=; b=GVNCA5Z8grQrujZ1/Ax4uQ+zuZh6jzDFO
	TCFJPUEHE7B0JANjnG0NeOX9aUsxAJBM5LSNSJyq8Vnmtl8bqPAUdfPFfl0SH8tw
	I1PRWsxeudhY3zak3TytO7cWdsYAvoeBhAoo/bcxV2PWAMkjk2MXhMqertO0W0AY
	lfYsjmrr7pMx+Q1WzrlxhWbUFMhiXwOvMRY0g8taD3J+wRAgJBBHjmoT4Pu7BupW
	Tx3F+2lB67C/aVeUIozyCfF1SqmkskVHPB3Q+3Wu2Iqz5dYcnlc2hL/VBHYjg2LZ
	uCFXmtWK8mGHLc8Ci/10hc6acAskKdUoGk02pYfrBP7CCzVniW4lQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52nrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuIML011203;
	Wed, 5 Aug 2026 11:05:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhe4r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B55Ir29950590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:05:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D89758217;
	Wed,  5 Aug 2026 11:05:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35D9158215;
	Wed,  5 Aug 2026 11:05:03 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:05:03 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH v3 3/8] KVM: s390: Zero initialize irq in reinject_machine_check
Date: Wed,  5 Aug 2026 13:04:50 +0200
Message-ID: <20260805110455.7200-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805110455.7200-1-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX8bNUXxs0wS9e
 h+bYZm8pKG28Fx1rC1+Gp5C7eWenVowzWOkZWgNVPbeF028ZOqjshRtWOlponP3KWpL+2sdznX8
 wYpk9a6TonuX7YyA4zraeQ6u1VItnwU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX1lx+AtFYDjti
 odyxCd3kTDteukRCoIvadlX8u88aLxjcrmU/8nOCINiogb+0ddspq1Wxr2djkZzhO0Hi2E7ONfw
 OtCGJExo9o4NCOvYCnB+lLcy79B8+NRWtF+PfWom/KuB1NsJpt1OtF+g2jzj+gId5N+RXwVi9pJ
 tFq4EO8QZ9fKF728D0Kuv0tvfsJpL28smCHDKGc3ksnfp6Ig8bRa024KwDvBCgEbu4lozhL1MOy
 GV9J8BjvqUwL//PrDrn6aaJqlMW8ZH7MONYYAgFSmDTdrmiKnTpCruuclFQvBTXHPCGfTwXKZ6j
 1OW3v0kDOqqCAxtCC8DW3YOL14GjQo+/NjpqKoKH/DjbfbyA7SZB2vc4KuJkmju7lv7B9sAizZ0
 LU/jIe2L2xGB0rEWrJsR0VTB60bNFThFF902PL941tVSUBvYkKNKU1gNPUI9mfpxuDa1kgvbKFk
 zOVDtAQqVS4Kvz+VYWg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7318e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=51UJv2RdcPi40xg5ARAA:9
X-Proofpoint-ORIG-GUID: bYd-dQZ1oadHPoNwZf_AnuGx5T-D0xq3
X-Proofpoint-GUID: bYd-dQZ1oadHPoNwZf_AnuGx5T-D0xq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

kvm_s390_reinject_machine_check() fills cr14, mcic, ext_damage_code and
failing_storage_address of the on-stack struct kvm_s390_irq, but struct
kvm_s390_mchk_info also has a pad word and a 16 byte fixed_logout array.
struct mcck_volatile_info carries no logout data, so there is nothing to
copy there and both stay whatever was on the stack.

__inject_mchk() then memcpy()s fixed_logout into the vcpu local
interrupt state unconditionally. This will reach the guest during
deliver and userspace during migration.

Reflecting zeroes is the correct behaviour here, as KVM has no logout
data for a reinjected machine check.

This needs a host machine check while the cpu is in SIE so not trivial
to trigger.

Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 23f0e0821474..009d6a845d59 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3109,7 +3109,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
 	struct kvm_s390_interrupt_info inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_irq irq = {};
 	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
-- 
2.53.0

