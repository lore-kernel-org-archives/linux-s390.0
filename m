Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE137F8D2;
	Thu,  2 Apr 2026 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103760; cv=none; b=bljYg8cVKA/PwQH7rhaTh6tS9R1Mr+iaEzSOMxBYQfglvCaAbXkAHjANEL40uakFf1MiSbhwlrWs0TzXlofX08clNM0c3jT3z75q8THQ/1gSCVbnkr259c9hCJA8vp9geJhaJk0yIvzQOo/8t9tU+sDtr+DC0Rx8ur/B3SlZR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103760; c=relaxed/simple;
	bh=VkNK+ZbuI9/u6/XhmhJoa6ZIwqFayPcrAC5T5GrVIpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Btbi7zjetW/gpIHVAhx4WjF15lC1mtaF9sbyXyxg7visR26y4w9ypjftK3dRFXNkaUxSzDLWUA+yJySCum1mB6ac/YFAoX9VaTb9HCG/W8v3CeB7C1CBYCDBYQsbJHeK01hxiO4CSlqBv38I9Nr7yDZG9qy4W4bBfHNtOiThAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sb31EHTs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sb31EHTs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631NM24O121068;
	Thu, 2 Apr 2026 04:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IcFHIo+pLepoq3m5x
	l/hLZtxj0SuAVf8/GCNIJe1qGk=; b=sb31EHTsSWxcDDRQp0ZbsIwV/uGUap2TF
	a4xf0pkP8SEAezXxZxdeDnqknyu4csNRrEmS387gNmpzQGdnrlJefaPDr4v2e5Ny
	1Gm06wkYVWnfwEivjo9VjlYB3tGGziJ/zgzgmyCieupsDfM6pdSgLi21wSLUFzSp
	nSkTb+eEkoxhZvfLzzFs2KkiIechTM7ABAj++oDFnm+45XrGsyqO6N+HM1/bSjgW
	k1mPYN4Pc565NKFOD9FSpxlN1DT5qZVteTD17gSQCBj3jT1n1Ap1+O88yh6kR3Sj
	AvS6e/W3XpumZGLR6IapBydQAKKO83KO4I9vnmWJXfB/3EtYSrDOA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msabrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63202nL9022210;
	Thu, 2 Apr 2026 04:21:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan8kb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LWlW48497044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB57220043;
	Thu,  2 Apr 2026 04:21:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9229C2004D;
	Thu,  2 Apr 2026 04:21:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:32 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v1 18/27] KVM: s390: Prepare kvm-s390 for a second kvm module
Date: Thu,  2 Apr 2026 06:21:14 +0200
Message-ID: <20260402042125.3948963-19-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cdeed1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=D2QCReHFeZxoMWIWDosA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX6UZXpx/4ZhAJ
 QcgMTeAXwN9+Qsd8Rzx/3JOxBmSTwOM42XkfhiFCjPSRg/RQXR6H/NAuDiT3fsxDOQT9qB/ehJt
 3vtwrlgS3OaYDDfv/pwuFNL6AgvzfjkW8zNKUIL29RJf1+Y+BQzVZHBZyce++XK/UzbAXXSZZ5T
 mXEJre07AKNnHdy9lGnorWp7PxHnmTliZA2E+pIqvasOJ1cDZNq1LWXUeF3CGjEWGQAxYyXVk2Q
 fy3bNcNGK7pyAAHnuoqKyEyUiN4nh8SBeGVhwJC6QJt7bcKjVTeFIAC5MebCk/KK2uAv5DXOfi1
 JVeLI0VEWm81z9cFDGjEL/iHBoJLF9RZcOigkNeuWPQa2vGxvnupeMrcXsfxYn8HjsaAb/PlyJS
 oOWacaNfwOhcQAUUr8RKpYi/cut5gWPA8a/NlCDNyApUt0+nFsk9W5HWHz41reyrxb2j5dfRLrW
 RX6lG3RtwrhRp7AyC1A==
X-Proofpoint-GUID: xShedHgmipJadQcfrrCtIu10WxyaoFSK
X-Proofpoint-ORIG-GUID: xShedHgmipJadQcfrrCtIu10WxyaoFSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

The second KVM module will have a different Kconfig set.
When both modules are compiled the Kconfig sets get merged and
the native s390 KVM needs to implement functionality required by
the respective config options. Ensure that s390-KVM will still compile.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 497abe3a83f4..8a99d6e9f7e7 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5665,6 +5665,14 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
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

