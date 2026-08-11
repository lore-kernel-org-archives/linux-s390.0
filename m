Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D973BB680;
	Tue, 11 Aug 2026 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462676; cv=none; b=F23Rqn7e9otvafJtPtQlF5zICUpcckL51yXIufxxCrKZzmbY4N0eQjDXnCPQFEiipBZn1wC3p1yIhHjcRIiSqKi5TC2x5/pLc7uU2qOONACDpKfQlLh8pSvlNtXZn6z1O1kMlvAqarJtDKVxcT5SupgDQCXOwYoMtyCoLlaeAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462676; c=relaxed/simple;
	bh=OXVkWSAC+X6wC+DKsT5NpXTXMEs+fWjl2qbrKG7ESD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5HsDmBIX8RnkJG6gR9lAbistO0rx/eG1Jrfu39H0mBdfDeDWIjJie8FRq2BuY/RKKWP06L66zBpdN56R1zqhFA4vamFcqEcd5Pal4jP2n0183qROgZnRyoTJ52o4/BkxyO5T2OeVWPrhAxm3zacbjS9HyZL3VaY0rg7qFCeRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mFegoJdD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mFegoJdD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX7nd569939;
	Tue, 11 Aug 2026 15:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=phe6RZNVLuuvWLmjB
	IUQLPmEN7VuNz2htzriNW2/iFw=; b=mFegoJdDestZSMISr09nZoVR5NGVenQEd
	gcAENnU0yTw0ns8ZBtpyPz99B7E5WgchpMwHRAHk68cAZjuxa2uoEoAxOY0GDVHd
	PwzdOh8ukCgkptHMK+HGcEqxtn9q2NJHMSb4hYBr3A4EmLHJjnKO23W/AxUDbnjR
	4i/X07I4cWzKZv5hu/Gc3Jh+826DIJTkjhak6O27apIJZoSFvUNJG5knQ1eoWa26
	ke2sFCXtKuzft2v+CgWh7vJJxYf0UJLbP7lO+AyAWPlJDXdnIJwzKGT1i2CSEWQD
	Bp+285gPAGJnlIGTDeHH9bT7oWge5nA5lHHUeLAN9cDhM+B4hRqkw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw51ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFQJ3s013865;
	Tue, 11 Aug 2026 15:37:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1fhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFbola30474804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:37:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C380C58065;
	Tue, 11 Aug 2026 15:37:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C8E58059;
	Tue, 11 Aug 2026 15:37:48 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:37:48 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 4/4] KVM: s390: Restore sigset on error path
Date: Tue, 11 Aug 2026 17:37:38 +0200
Message-ID: <20260811153738.206885-5-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811153738.206885-1-borntraeger@linux.ibm.com>
References: <20260811153738.206885-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b41d0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HjbLuaNmiay7o59Kxp4A:9
X-Proofpoint-GUID: _Zg1JUoW5_9jbgMNr4qQjiEdthxXwHMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX2AERRKt1b/w/
 Gyc4A3XPsppZtL6Fd6P4VL4ohT1cIH7n4rS0DYMx8D9c3AzoQx2FHniasefzL0L5rb8aSwueLHS
 q9wjmLFTCyXayV9IVqHHhSlyJj8f68noitsXbiSB8aXCEBieQq77Y4cPAtdVo0sfDlA8HmkTn/2
 LIVNxwVbI8TGhrYh2V0M6Rs3KUoLc+53nSWluWode8y8fChB9eSihnvyB11l6bq/GVNSdZM14i7
 MlW+R4W35UV2fP/TfLWJqp9E0CXICT4fOh5TSvXFXB8xLmKnFxUJ67tXiWQqyPU3L5WeWWUQFy/
 m447/kYgoC0G7YUKc/gg4orR1sbjCgnViIRtrTwlHoJyuL+hGh9Dohm3msZTJVEsvzQtJlSQFf2
 obELUfKeJjHKU3ke62F5mBHvBIIj0ZODw+NksmNlZgrmbNeMbf+eglhJTZ/LAyuwdu1rRdI9sCC
 7GKAOA2uLurkEsnNTaA==
X-Proofpoint-ORIG-GUID: _Zg1JUoW5_9jbgMNr4qQjiEdthxXwHMW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX+Fq7UCszz5x9
 9u8ulr95/S4LCBuvyNiIGtarQSl5H++YL/MS7Tt7Ze9olUXg9ErtVlH8fvIqrAOVsP128u9jhDT
 ZR4BPGNURIocnR2F0UK45ivlYHR1ODU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

kvm_sigset_activate() installs vcpu->sigset via sigprocmask() and
stashes the caller's mask in current->real_blocked; only
kvm_sigset_deactivate() restores it.

For KVM_RUN on a STOPPED vcpu the error path will not restore the
userspace mask.  Re-arrange the error handling to also restore the
signal mask.

Fixes: 6352e4d2dd9a3 ("KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f3814dd60184..608e40401554 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5071,7 +5071,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		pr_err_ratelimited("can't run stopped vcpu %d\n",
 				   vcpu->vcpu_id);
 		rc = -EINVAL;
-		goto out;
+		goto out_sigset;
 	}
 
 	kernel_fpu_begin(&fpu, KERNEL_FPC | KERNEL_VXR);
@@ -5101,9 +5101,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	store_regs(vcpu);
 	kernel_fpu_end(&fpu, KERNEL_FPC | KERNEL_VXR);
 
+	vcpu->stat.exit_userspace++;
+
+out_sigset:
 	kvm_sigset_deactivate(vcpu);
 
-	vcpu->stat.exit_userspace++;
 out:
 	vcpu_put(vcpu);
 	return rc;
-- 
2.53.0

