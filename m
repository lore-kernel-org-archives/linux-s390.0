Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14A44A3F8;
	Fri, 28 Aug 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918110; cv=none; b=l7jLHiZBI9RakR2NWYZRVn2MfgMaLz9cKm16s3wEjCOxLRpR17iJcvSLL3DtP/QUdGhLpn+iY1QlypoeEGbRq+Tcd1uDE2+5ebLFf5Qj5ItXG+zDhux8Nhgz7ruZDFsI8WyU8R/afscYcHZ+iQIsEkCvmowqaNJpXBGEYL264SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918110; c=relaxed/simple;
	bh=+8DraBJue18Yt26wTsZ6AsGQ7f/82RlVFIJXlNAaUCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9GvwpkxeMDVHTvF4tHqoWZ9iPc5ZS+IQCTCcos+EbpdNIKCZBOrVqyPf2HFT7FzDngNxjWFsSZLMRWZ0z2e77PEPtz69By/R13ZqUU5R9mV05kV6U9A+b1iYcVlCCbx7o5rnicSx6G7Fs0ZGc0PFQrVtHrDUaRlxRMwrlZZk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKKMKn61; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKKMKn61"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAW0CF1704293;
	Fri, 28 Aug 2026 11:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=70WwBe+OBFeA2xnbd
	77c7mfs6RoDmemPDc1xzByZwrE=; b=nKKMKn61gwSpAr8HeP45xM97zncLkBhZa
	TOssQ6iLFF5Jcw+BbOeKvGrd2NtaCr/AuJMllKtVPJ+O8vif5ctuXDe87Ooqdu0A
	4C5Tyrwdzqt2jyMm1LuYyA+/zpgimnmmm5gnIpBXbDAzTMQ+mkW0YX+QW8iJ3bGk
	TMILESsov4g0FCBZPlqDHMXIIMqaW1oLaP6C3BbCoK90rsvmkJL3KTLBHSLIqxgZ
	228a94hG0yxfQJhO7RwC0wmbDG+H3uY0ROpfNjPiN5m4V19RmNLu2jOxjP51y4XS
	4V9Uid97jfkuOki+RYRvFHEWUXAsplRhy1Pc4QBk6ok3kC1nlO85g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394kxhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBfL1N011735;
	Fri, 28 Aug 2026 11:54:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qp5p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBseRv7799072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:54:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE36D20040;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D042004D;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 6/8] KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
Date: Fri, 28 Aug 2026 13:54:37 +0200
Message-ID: <20260828115439.145885-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828115439.145885-1-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YgbK8BUnExdehSDP9qUgy6aNAP5erExy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX3DlQoP12FO1W
 xRJiRSH9mG4YZEe+31feVUrqfl/fPs5xzsNiNW6e4i/97gPLnkJiSN3C2SMSFwrCws3iyXM2PHa
 HEsYjHtg3x7vtMSgCfBMKxbFu/Du+ygNk76oaOa7+9lxtyazTebmVnxq+qXJ1SNMITQibfs0H2s
 C1N38z/DQbkA+q+SDV7yF0AwKdyepo3+D8qUadR6iBGxWaPxw2yVfGompmvh/jZxoRFq8dRIfYS
 lUx+pQWMK3YjqzboaVaCMe+a5fTHpmghR/VQidlj+JciPFgFFMOH2cRkcKfDxhZhNnzM54ibDVh
 Myt6VN71REEP7Rltq/BWefHpaWMYF92ULUsrW5c1muN1ZFhIzCh/6Te8AiQ6Zr2EjSUlWvJ7h4U
 Nr+wuvoLApH+YJA0Xlq46pFxDw+Hh3nIH8n26Ql6nyaO1M6kQb740j8w4V0MfFTNjBazU74mG8K
 9fK41oOckAyb/P8WSZA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a917707 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=r57P7jcG1oT3p7VFzagA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX8blD5ZBkDjEa
 Xm4XgjTY7pWFjrfRlDASoNAW6nGXLwKP4XXT65UiDxzUlTXWsKwBAGvd4D9yJvU1aThNhdBNFBY
 ofju3wYpHQgOcjcENeBACDZ6qMnJh10=
X-Proofpoint-ORIG-GUID: YgbK8BUnExdehSDP9qUgy6aNAP5erExy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

Like kvm_s390_inject_vcpu(), kvm_s390_set_irq_state() also needs the
kvm->srcu or the slots lock when performing the Store status operation.

Fix by taking kvm->srcu in kvm_s390_set_irq_state().

Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
Fixes: 062e44a9319f ("KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrupt.c
index 49b4e233e791..f892f4307883 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -3229,9 +3229,9 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len
 				break;
 		}
 	}
-
 	if (storestatus) {
-		n = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
+		scoped_guard(srcu, &vcpu->kvm->srcu)
+			n = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
 		return r ? r : n;
 	}
 
-- 
2.55.0

