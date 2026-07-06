Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513D4DB55F;
	Mon,  6 Jul 2026 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328012; cv=none; b=fJGweDe+vWB6YTCQea2ywSEwM1q7Wk7hn8/MsDXvAkL86eZ/lk+hKkFRom0rnKX2WsTyrjtfh9HwGbTe2Taa7FAjULM1OkePepMZjdWn8caVGVaXU4IOxVMSfGR86fHe/3dnNHjRRNoZBjdkbVOa9HRR/sGaJqmFc9wKvY0lQig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328012; c=relaxed/simple;
	bh=lqDTG7lV3mB3onFgoMz/96Ql+vjE/WeRZPha3jhfK3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eB567GGNm5HRfZhULF7ku0Sb5cgvbzMAxGSrCSqQ455u666unUI29Nx5UxyOGCXFghllhAQi9lDt7IeDZMIRvwIqA+qvpYMWyv4rvI+l4WyHn1DltMl1u3fLj+xUJ83HwCNfyurDZhWWHom2FotpMw7kdv1eXq1bvEzZ03lSCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h+qOQbZR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h+qOQbZR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MJ5IC2200370;
	Mon, 6 Jul 2026 08:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zp2qWRI51xbo0sDAF
	Bj60LHtZKOMxrKZwpCffwrL/bA=; b=h+qOQbZRZ7pRyZ2RY6WQr3GG2OL+rFT1r
	GDJ4O/scpa2MF6iZlrRS5xk3QWRnt0LH1gwZefRNprxkTtxlf2uSzklhyvnQDm+U
	iEYehCstaD/02FiIZ92AvDnGak8Xm85NlDI9NKx0dIrSV7mSZWrVYD+MLSLjiKZC
	qGCYiie/9/wMckW7k8phvloyK8CbVVFn8xXrE62yTO2sbvPwt1EB3eFZc+baH/lS
	qy3mzlasumLqRbiMJfvX+WKPzPoV84GGMMdgOQ9XC5N2yyBum5XdN5xrUxqmtDom
	EjsDrvVwSMHb9Db07JwSI7xAlHCrhbmLo1pUaam4I1kUoUF95EfNg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4ghfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668ndrr023223;
	Mon, 6 Jul 2026 08:52:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvvyhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qbFS58327496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90F4C20043;
	Mon,  6 Jul 2026 08:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35F3A2004D;
	Mon,  6 Jul 2026 08:52:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:37 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v4 18/27] KVM: s390: Prepare kvm-s390 for a second kvm module
Date: Mon,  6 Jul 2026 10:52:18 +0200
Message-ID: <20260706085229.979525-19-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QMjEdZ2bbssdu6vflsDIUOqXzoyItmAt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX80TN2/2lLeOT
 NTNcmvI5E5sQk46MZPXg5L4eoQwOBr+K3ydMedBj9VyS9YETHCMPzWEWE+pNbBJquusLlVBmb6W
 t8SdEx0tTA7je9kPhDQUaEh3ayjLzxyzf5ilumccODcmC/TJ5KVroJfpAcQpEFIP3YF87h/oCx8
 /hYV2+XQMuY7hwOaNdgVYHYQ39H4EC9AwYR9CNUzFIjhU3c0JLgXYfhSVXTJMm/6krDNKQ8z6z/
 RxVUAiovwHQnzvoXbUNlDM2Lo26YMkwoNLR1GHO0e1vDwvvB7hPNVmcAZtXxpwPP1xCOGFTKSkM
 Iat095K4OOb6OAA9UdTX13cKdH/jZF1N2CzELws5Ty4Dlz137TrqCv7i0OeDQ+tbgwbIxnB3bPL
 ISgZ2v55y1OpLHlUutK2SNimbQmBSZYoLiEtWXrNlLMMqUsPQNvv47pQHGeVIRrZJoQDmCC/fQS
 +HiFlKSm3PdEZfn37gA==
X-Proofpoint-ORIG-GUID: QMjEdZ2bbssdu6vflsDIUOqXzoyItmAt
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6cdd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=PZUUAhoRKHYmhUnXTvEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX2ooPM4sdiPex
 aFREtHdW8iPwKK+EAbbPW4kfp/jypParoj9gWSpzuyz1gWe1qFBHuSyHIfD2VQmU+N3xd8CRVW2
 qpbnchVJcB7gBqZ1fppmK+9hhozJ4/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

The second KVM module will have a different Kconfig set.
When both modules are compiled the Kconfig sets get merged and
the native s390 KVM needs to implement functionality required by the
respective config options. Ensure that s390-KVM will still compile by
implementing a stub for kvm_arch_vcpu_run_pid_change if
CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE is enabled.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 30c273f5377e..b560c1e57926 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5808,6 +5808,14 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, range->end);
 }
 
+#ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
+/* Make s390 compile if arm64-on-s390 is selected */
+int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+#endif /* CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE */
+
 static inline unsigned long nonhyp_mask(int i)
 {
 	unsigned int nonhyp_fai = (sclp.hmfai << i * 2) >> 30;
-- 
2.53.0

