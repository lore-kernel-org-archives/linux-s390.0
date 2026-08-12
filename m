Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793742A792;
	Wed, 12 Aug 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531489; cv=none; b=cY3onStwl2kMN7yrYv02T5v3ECXxN6F3qevaJkC4I/VDxuA/s1BQoTTpTn2DCswnHal4y/aypNBSti3ooxlqEUY0ZKLFOANfh0EDINatK49zM5cRghDiPY9j98tTQuwIbO9/ewP4ZPXBW6GDVECW3QbPVBuIdCxT2KZsr2NZJLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531489; c=relaxed/simple;
	bh=B+bU9YSpB0TYXntQhrUYlqd31TL7yh7e15RGlAhPAqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5XcDcJHx1bSwXQL/VfPdHmiJZZa5yojX3VAbJjJAs77mjz9JJKS2x96VLTQu2etdLykDuPJPR6xFDGkFnUZZDh3uNe9qYMVfrLmuL7a8Gdf/9HlY9ERbG6jizwVjN2a8ajoCMFeidI26RJIV74Jezn32461nrd1FphKi3CKNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YLnl66v+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YLnl66v+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1cCx3206607;
	Wed, 12 Aug 2026 10:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hPPoKDOrhgcw4CJUp
	UhW0xb99grtv8JmAtpk/TYqLXU=; b=YLnl66v+v+rsq73acUL8E1M0eEaoEsbpi
	4J3BpS70fMtNJWdUWNJnja9e9+iUi5Z7NRJ4b9Xa+M32yyuDiS41xilCi0vc8z5f
	2aaxjPcYGGlqg2wXDPiP6exoOZ5J/ArWS+MIo6dUH4Tijxft26ymjOxXVG0705qV
	n9Uy/paeC3S+Zm5oZyFjlsRsX6r4rAwRXmna8O5LtZsxFWUq9ue3EgV9DR/7Tf0M
	siajhWMvWta4uFY2y46J1kBkjQ9Y+BZ4TkMCA7G3YQBw/QC3mbZadrUD5QmO1Yi7
	nW7TWueNO6mfhq5oiThmFajXiPLZt/N3yvNJ3MZLochANLGBAw2rw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw976f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfSsm025167;
	Wed, 12 Aug 2026 10:44:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5hxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAickJ47448562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5963820040;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B2CE2004D;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 7/9] KVM: s390: Fix kvm_s390_clear_pv_state()
Date: Wed, 12 Aug 2026 12:44:34 +0200
Message-ID: <20260812104436.109741-8-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c4e9b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=aapLlF3kuFkAvhSc48UA:9
X-Proofpoint-GUID: 3NCI1x_aID3q9IptVdl2AUSiyz78WQnj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX+5pj0zb0RCDN
 gtabMvKckJIF5mNs0T1R9+FvWSlQbKBCDWnD23mIKqS5pzmb6YgeO27onjpbXWEV4S9nuRbfghP
 rmx77H1Ys+WYdnoFfue7+iBcsNW4cEVr/S41UAJI4Q3u2zkc89xrMQrkhJ1xP3gTHsI9VhP+dff
 rNJk70F8hM3a7OY431SyJjeH4OyBgxem+2DI8tqTiwfXQPm/CexubJ2Prct/zCLyNWCnmnBeUmO
 uNl6nxQtVP3qDUJ3L8K9/vIcPC4XJotoyN1nxoc43Oaar657hVjTppHDNj5UeRL3BSW4pG87mN5
 KlXIlLtdSGcK+6TkbC1V7gA2HALa01ubtqKD1eHY2tVISINY7UFvvPxtNU7lQQqja8kYaaRyeXn
 cFUbUeXB4/C12NKILstgP3P5q3C3MyIpcqte1g2zSMbDoIHz/bLqCTGr0GcEfxiGHZIrWxUmmaB
 a9Rb0sK1yfaAPcRJBKw==
X-Proofpoint-ORIG-GUID: 3NCI1x_aID3q9IptVdl2AUSiyz78WQnj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfXxmUBrwR395K9
 Gv/Y1x8AEhqeYXzFvjgzZHdr77KuzS+F0Td7YzYMrKjDwL+2ki+BEK2+Uag/LBNiynkMAdlzVi1
 5qtbhC8YYQR4WbVZ1BEUo0LKBymGrgk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120084

kvm_s390_clear_pv_state() needs to also clear the dumping flag, to
allow the protected VM to be started again (as non-protected, with all
protected state safely destroyed) after a forced reboot while a
protected dump was ongoing and not completed.

Fixes: e40df9efd68a ("KVM: s390: pv: clear the state without memset")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/pv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index b02e0159d3cd..98a9a57f71b9 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -242,6 +242,10 @@ static void kvm_s390_clear_pv_state(struct kvm *kvm)
 	kvm->arch.pv.guest_len = 0;
 	kvm->arch.pv.stor_base = 0;
 	kvm->arch.pv.stor_var = NULL;
+	if (kvm->arch.pv.dumping) {
+		kvm_s390_vcpu_unblock_all(kvm);
+		kvm->arch.pv.dumping = false;
+	}
 }
 
 static void kvm_s390_pv_dispose_cpu(struct kvm_vcpu *vcpu, bool free_stor_base)
-- 
2.55.0

