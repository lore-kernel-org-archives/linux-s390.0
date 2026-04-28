Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D2449EA6;
	Tue, 28 Apr 2026 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392367; cv=none; b=L1I63n0NBViyi1gkE6NsjAftfOac4xIni8GtI7Zd3ziwqp1oZMIiudrFbGzOl4y75GBGehwB31zqBdvryejTcaVqHBUW+veJdsdNgZPb/t3bpFQKMUCjcXSTFD96HZBLKrjkCKRPs6y6l+ab50Cug8d+8YclL5+w9TKVLwN9dBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392367; c=relaxed/simple;
	bh=xk09SoE+nxNe6XBp08N7xCYfVEnLmcIw0TxmNiSzIGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghpp64u43ollA6g8/ojQOL8CszGn9gya4PUpsL+zIYu6R05DRlar7zWqwF4bWbRNOQLN+SwDB3kRTZnuHhtb4h94RtwtOZQzZv8EJtVXUOBucp9z7xKKNnPBMAbZQ4RNcOEjaw04ucqS7OXPlKASfge0o29Lb+Mkj5qMuKlD7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SNe7BBiW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SNe7BBiW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S81S353102032;
	Tue, 28 Apr 2026 16:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bpCEDly7MH6bByxak
	mIbQ1R0PHyCTelNjZ+wTgtP6dA=; b=SNe7BBiWeLtUPbeZXs+y6B/i5iSZx/f6w
	pafZb37hkDx4YoZ764c0THNIet/vR9Qf7JMxoZk5K9bqisJ/0M3ZWGRUaPV7JpEZ
	JwU7VlPJ9VyfpqUFbA1YvceegUhmXUffgZ8jYj+5mPxXsZAHLG7f281LeyrsdTII
	Y1OVNvUwmgYXzgmDRz1BWuxfDF9E3RBWutSrYXq5FJJLTumEduTeHSkLeCQvZhCI
	z0vEUoFmM2hnCThcwvrayHQE/FGt3OlGfl4dgCT1G105SX9eR/x1gsU4i1aAvpo1
	P+KA4TVQxQz/5k6ELSCy6B8xKubroEQeu5P9/scXBGRKR8S0KrHrA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pgqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFroAQ001931;
	Tue, 28 Apr 2026 16:05:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5ga9en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5Zbm51511756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A34720040;
	Tue, 28 Apr 2026 16:05:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC1EB2004B;
	Tue, 28 Apr 2026 16:05:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:34 +0000 (GMT)
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
Subject: [RFC PATCH v2 20/28] KVM: s390: Prepare kvm-s390 for a second kvm module
Date: Tue, 28 Apr 2026 18:05:17 +0200
Message-ID: <20260428160527.1378085-21-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428160527.1378085-1-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vyoDx_scQYZbYBDeoFq3c7osnpRWlBfQ
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0dad3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ncMJ9zR-EkmSMqSD_lAA:9
X-Proofpoint-GUID: vyoDx_scQYZbYBDeoFq3c7osnpRWlBfQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfXyofQI0ArX0OR
 d28m0nfBOaHcZAT9J+NepG5rtcO0n0Jemm+yVamECpqowlJndtYK9XGnvjP7d+UPeXWKr+b0Q7m
 /v435LAZLm2xYAF3g3SYY9E5wsX1/M7jCtrclkzMtSxPDcIWsuOfrvyuosvnKGwQZp1fCnJYrqB
 nS5cwqnYYVqj2SZLwsAp5fGPdAKT0EmXrQ7NEQeJtZUX7yNLKD8SfguOoB4hhYa8kN1AaTXjSzg
 I6Djx+vqkwBtkS6zCIyNopCUOoqszUL220VMmGVTrAVd5GXo4wzSb3L62o+Y4VSsnT9PfNQLVz1
 lBgeph6Hp7qKoN3C5CIjwOp06zTZ5Q87JisxixV5qtBtNolqpgcJ3wwoKE5+2bR+Qw/8nE2sA6B
 yxTHQMekZuuwA1vKFpPLGQo22hwKi6V+q0RsC/mRgOdWgzV459ppRQcWDQQXGY7ARLHc60s28ht
 z/FAf252hXK39vSbN1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
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

