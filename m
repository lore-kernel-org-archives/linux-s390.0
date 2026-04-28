Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3634D382;
	Tue, 28 Apr 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391829; cv=none; b=TXeJsqo3MQhcJZmfs7LtDUeMqZLo0zuKW8n9YtPnpdlFwVzXo/b7ac7D6fhUSSRwPVTvt48CmmxpWWA18qR2ecEz2s2O6OXcCLCpDCjVRLDye97ntDv+RIWXWEyhCqXe/G1Cs0FWbXyZ6oUT8ATx6z4G3CcBxkJDfW9Sn1tBdl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391829; c=relaxed/simple;
	bh=xk09SoE+nxNe6XBp08N7xCYfVEnLmcIw0TxmNiSzIGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCwmiI43iFza/rKv+xNaIM4HjPfWJp7VQdw1Z9T296Hr22weSGeQlLTTxAzlaxy1Y+P2Mkq4WAFwDz1U471sOVHvYf24wptAB0KuHN8PaknHISv2q5L7lbaHBpGWg0w7YhuAgUoHvMbP5y3KAfQUvCp7Q5u68Qo1+ahQ3NNGrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SSXarT05; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SSXarT05"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7w8LP2939523;
	Tue, 28 Apr 2026 15:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bpCEDly7MH6bByxak
	mIbQ1R0PHyCTelNjZ+wTgtP6dA=; b=SSXarT05U0yzDmvg8CWb/VBLFd8hjHuHa
	+wmcm9oEnI9vTLaPNo2aM87NzxKnp7J7v/hI9UwjtKcokGZmLuTcSPmjq3962yMM
	R9gOptN4E7yiaSsH0/Y26DBZnA6/VFci/D1qDZBoz6MzplYclpa3U7PFEtgwhkvd
	2rOQbGFbR6oXhkYDTduiwYYbhWV7bT7/+1OlxaCbGm1Qvvy+wVjK7Pnrm6pSxGK/
	fJZfYjUdmhjUboY6tXFTseCcRh16Zc2o91/XrHq1ZKAv0cLTNyF3q/6XGyj2QF78
	TR+hki+/jK14Kh7qHnz8ErSiFdeBHGYwsmf5HTdd49nZw9btj1QVA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb56c8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrrnh015592;
	Tue, 28 Apr 2026 15:56:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avtg1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuUCV59965932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430652004E;
	Tue, 28 Apr 2026 15:56:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3BB52004B;
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 19/28] KVM: s390: Prepare kvm-s390 for a second kvm module
Date: Tue, 28 Apr 2026 17:56:11 +0200
Message-ID: <20260428155622.1361364-20-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0d8b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ncMJ9zR-EkmSMqSD_lAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX926KUkMPiKIF
 pQd4GPQ5tBYUfuvI1WRIf9nDA1fCstw2jVQLJnGHH+vG52Lkz5OGXy3QTg1Vp1a0URb/Fr5DkB1
 lxNwXnDrvqc/N6/aHLxTd1NbUdYVgYWssAtVbIiis2DdU578abaa1liv5HpcXTO1oXtSzOEFW8e
 9YxKlUQrahsurlcPzr/qD3Cd3BsvQy4jG6zmruyE8PyfbIIeiiXQoTQcFh1RjBc7o4Uqm4AZxy3
 t0ZFuvYFDpb/95wUXLPKipm+UKmFa1QnUG6lzpd+7Wt2jxqU4pkhXcGSg/Ipbyh+5wx4ZrEM2js
 s+Ly2nZkQqNoj1COxaPV7w+90m+WH6bsAT8gEyUjqphldHzmIjyyjkUehPPl+IpzBP7SIRmBEHM
 jvpp/3VvNrmX5Kz4+P7NLQFXhHGII9AgYYqMaSFbf8JmccBtPYi2bLVsr1nJEATIPSUk6LpKZlR
 2oVqZTiYKUonyKtOHAg==
X-Proofpoint-GUID: EGUvoc47c7mN22VkevCSW_qRCOi7Ei0m
X-Proofpoint-ORIG-GUID: EGUvoc47c7mN22VkevCSW_qRCOi7Ei0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

The second KVM module will have a different Kconfig set.
When both modules are compiled the Kconfig sets get merged and
the native s390 KVM needs to implement functionality required by
the respective config options. Ensure that s390-KVM will still compile.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 0e325b47d40e..5373b2347651 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5677,6 +5677,14 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
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
2.51.0

