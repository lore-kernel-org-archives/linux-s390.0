Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596441E6D9;
	Wed, 12 Aug 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531487; cv=none; b=HnOd0ZaJRHaqtN48TAb/QHSQEgyIFMnbJnh95DXMzi2AznMqmBq2XH7NBTaqhdKH0lSAC5UJEsXIeT+qfbeLpdfj7G1ofyPr5IGt8B7MD/KSR7HG9KolEGJhwdyrefue/z83v6t4eIYFmotqT1t0s/9mPW4JbIrnlzQPkESgjU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531487; c=relaxed/simple;
	bh=KWXiiFp52Gmdl4BpjqFvWj2k9H5UiMBm8LMRYgxtmzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok04as0rsaIX2AhwrPKGrcaAHq6PZSgepAfn/+3MSzAwlnaOWmrE8/ctzLqg1fblyxXcXB+jAiScmmeEaf1zncZtddxbeXOVoeKKLsWM9yhZWrKW9pqS+06rXKskuYO2MboWAUWBzi/jiWdj+8wDZEN8fCyAWOt2hUk5Zi5Dj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Aw0la3j9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Aw0la3j9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1WlO1306544;
	Wed, 12 Aug 2026 10:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6G28kckuphrnEAOSB
	AMIGF8WM7d17AYjlARIQ0J3b2k=; b=Aw0la3j9xnflvvvebcdbOC1D9nX9swz/U
	QYffITWmvqEYW8xfkfTasjC0X8qwQN4jgDSiaVyWWqsUJzsTtfkj3gy0T3Avi+gb
	0MV0cMdqLoQrewNDl+WXLGqxbRjSf7cMJNpyv5dIlD8eKOUSEpFzsZrdbFBWuew/
	0k2j/EfMq/cAZs1XQzku3DgQU1DXKqeZNTph7AGKHZYR1P3p9UlUu77tTdP2w1qT
	jTv7OPEf7EH0yBe18mAcEXQS2+3TXbX3B2mzDf/TI06yrXcQrLZL3sZTd6AMDIsn
	BXnmeAIn6EsREE9S1v2TQePnCN2DolRR9CN50P61c+jnpU5LMlurg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk01ynr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfWtB017925;
	Wed, 12 Aug 2026 10:44:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w5qk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAib7b27787914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D3C020040;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76D6D20043;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 3/9] KVM: s390: Fix get_all_floating_irqs()
Date: Wed, 12 Aug 2026 12:44:30 +0200
Message-ID: <20260812104436.109741-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104436.109741-1-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX87JhDP3noibr
 JcOFJyBvvyR5v1mY3rnPd3xgDHrmxL5f+nX/3R534Ks0xOgmRFCyAChX10P3Ench1zN7rAdSnE7
 v5L2CfzQlyRazzDDjqaZYG55BJwRz6FhIYmP6AaP7/SxSwxhNh+RoyGsxZthlmtRuNvxL8ijZZx
 sUONwNZyZvUFO4gf2bGHZ0mbkoJHiUtHi+Y1z6a//fFW6FRJoIP6rRjkra+Tz53/FyWEJp/KkMd
 AO6OZvGtkOl4RkceJ+O2c+pMZLIP8XeyZjrcMzbxgod1OO4JLV21om5PBrvA9tOmcvIXvOVlJg+
 f1xbwvoemo8GXCIqeFsHn96WZXxZdAhKAvgLPRRmpF42rhNRDxUJqwSpWfrZtvk5jNkBTsaRj5t
 PEHh9S6f8Yk8gQawafd9PYYMmbURxKzPtYzJ7LrtJQHZEdWOSCzlrFd9z/TeYdi6b4QVeYlBBDv
 H7mqrb4Wz+B4e4Jgd3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX6yyIOCtTur8T
 XKzBK/lKDW+VNAwVl3lG8IpLS6XsA6cmle1cZ0NvA5YFWnar7iWB6fYm/XtIVIh3eDcPYdm4R5Z
 9dFlsSpRVMew5Ai7FZDOdOe7W4GaWEc=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c4e9b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=gHQwZfIhTCfUKq360ekA:9
X-Proofpoint-GUID: 435rJlo72pSdEDbWNk784ZqgbmIZAcBU
X-Proofpoint-ORIG-GUID: 435rJlo72pSdEDbWNk784ZqgbmIZAcBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

When attempting to report all pending floating interrupt to userspace,
the GISA IPM bits are atomically tested and cleared, and the
corresponding interrupt description is written in the output buffer. If
the output buffer is too small, an error is returned to userspace, but
the GISA IPM bits are now lost.

Moreover, the contract of KVM_DEV_FLIC_GET_ALL_IRQS, which is the only
path to get_all_floating_irqs(), states that:

> All interrupts remain pending, i.e. are not deleted from the list of
> currently pending interrupts.

Fix by non-destructively testing for the GISA IPM bits.

Fixes: 24160af6cb28 ("KVM: s390: add GISA interrupts to FLIC ioctl interface")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6b3f97a7513b..61e75d10110e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -273,6 +273,11 @@ static inline int gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
+static inline int gisa_test_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+{
+	return test_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *)gisa);
+}
+
 static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
 {
 	unsigned long pending = vcpu->kvm->arch.float_int.pending_irqs |
@@ -2242,7 +2247,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 				ret = -ENOMEM;
 				goto out_nolock;
 			}
-			if (gisa_tac_ipm_gisc(gi->origin, i)) {
+			if (gisa_test_ipm_gisc(gi->origin, i)) {
 				irq = (struct kvm_s390_irq *) &buf[n];
 				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
 				irq->u.io.io_int_word = isc_to_int_word(i);
-- 
2.55.0

