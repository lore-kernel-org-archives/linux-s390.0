Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C7444713;
	Tue, 11 Aug 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455438; cv=none; b=O6k1RtZFuO9YE5tqwXyWrp9YRZLaugSXLvTklM+YU/Gqkqy7SCYhQogVkgaIVJPxoiNDOIPLBwu1U/PCw4O2sB++aotdX1y/IeHVMJp6krILuxT2mnJ1r7uf+PfmAKDtnPoRrvSM3zmJk+3aG7OCzQdbobb+FPg/9UCT0AD4/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455438; c=relaxed/simple;
	bh=/WST08KhcsKdYSN0ILh3mfCnV8h+E5KAyg+x9TPgKZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThnBcwTOsYkOyklhBMnWECCrbNkKFDaSnzmH5CET2xPPwU/cGlT3BYjL5NTMQcD7WTL+LaF91pvEqXVIi9gR7CKt/8fpUw4LpySFGC9uch7cToqharweIs9miinbh99WhNoOr+YyXywWRMYUxr+rgH1ul5Ma4U1l/O6sKUlhCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ah+mPsRA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ah+mPsRA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXpuc571246;
	Tue, 11 Aug 2026 13:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LhdODS
	1oB8CsrDyNqYVDah7efmTCDSFKYBt7OJje9hk=; b=Ah+mPsRAEYiaOYJbXkcAhm
	Xcavrj4q4QgWyC7XlKqslGTIVFhB3+hSUGNrvIFPp6tyG/T3hDNlpJAi5RQfw7jP
	pmt18sfVY5b86iYSWgq3hy6YD9wpVBWB014IfBdO6mkxZ8Mp94PJvsHl/QMF4GX+
	DL+W2mw9PEWGUbC5s83NpZg/gSnxq+8LwoPZBzuwuZ4/x520aWYpFatFihejp2an
	tCk8KBVA+rSZycMIjtIkwPxp8bJyThGwuQNNqlG/96VvZ2Ie4pBl8u9T2Rtdf3m9
	TMSipJeLA++wVXOyJ0YJnl8o7jwNPWd88t4LW67mi3XOjxfMr+17wfL1LPfLVkOA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw4fsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQFEh030159;
	Tue, 11 Aug 2026 13:36:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h10ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDacHC50397442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBD6020040;
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3005E2004E;
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:30 +0200
Subject: [PATCH v3 15/20] KVM: s390: vsie: Guard against invalid CPU
 address
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-15-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=/WST08KhcsKdYSN0ILh3mfCnV8h+E5KAyg+x9TPgKZs=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqlHZ3L3awQKJ3+9ob7k3NX6h/tr5fyWtWdxS/3+9G
 XpJo76po5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIlMecHwT3eTThFL+J+z0w6n
 TrzZxJe6XjByv26ZicaeL+HGkhND3jH8Uy/Qzoh4YLiKYbrKVDNxLtsVXlc+LvxeFiO5wik4ecY
 STgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b256b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=YOA8uwR83rpBMXObnZwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S_5TltyBdU0k0F3RtiR-WiD-xb5c1y06
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX8iqBwtX8+RJi
 bqGGb7FznVOlO8eJKE6QkiFHfNgUcUqhN0dl/IzB8MwUDaOIyr0fGIyutS9TJzU0/74YBWkFmW0
 XtQWwz6ejXOzUsinzWBZ9ZdZj3J3nSWiH+teYjpcQNV28IlQoIWxWVp3dHIGGZLg/a1QXy2Ct9U
 7+crBekmMdDqKxgxtg/iw6iNUDa8HygA7F46qScpGdp/ocJ4uqc+sA+n3yQBOb1McTz8Fzp6cek
 So1Zhtv2aYySymggQkSQhKdyFszuCyq8YPkDtnRKniqBcSjfGP8IbDQtQvzfllqvi0A8taV420Z
 6Eh+nqfBw/Y+l1ijmDF+ZKhn2Z2Zj+U3yTokCLTDlWUY/i/wdH+c+UpHOixURUzewh2H8cx9IHi
 gi8M6Oo0k/wdUgiJSiVXUm1BKuNfuoHkz14wMKTeokxE/eVphU1cXK3xADaQt5GsRnj0YyA6gil
 Kk6HIW8VrjoJITC3Wrw==
X-Proofpoint-ORIG-GUID: S_5TltyBdU0k0F3RtiR-WiD-xb5c1y06
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX8vRKof/mIA6r
 TOMROwwVJ8axoFkItf6RZ7PsU16fBBYLqmd14XOQ8QftZTMToPD/cp06bDFWEnkufq/ca5lRFyk
 ltEkgVFkWpb78E1aFKJtpAfeU01z5D4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110113

Inject a specification interrupt if the CPU address is above 255.

It would be possible to implement a finer check here to guard against
CPU addresses over 63 when a BSCA is used. But this minimal check is
sufficient to guard against out-of-bounds accesses.

The architecture allows CPU addresses up to 255 for ESCA configurations,
so this check ensures compliance with architectural limits.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 6cd8eee9a503..844ffd3244fe 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -2167,6 +2167,11 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	scb_o = (struct kvm_s390_sie_block *)phys_to_virt(scb_hpa);
 
+	if (scb_o->icpua >= KVM_S390_MAX_VSIE_VCPUS) {
+		rc = kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+		goto out_unpin;
+	}
+
 	if (!use_ssca(vcpu->kvm, scb_o)) {
 		/* get the vsie_page with pinned scb_o */
 		vsie_page = get_vsie_page(vcpu, scb_addr);

-- 
2.55.0

