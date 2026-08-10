Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E55330656;
	Mon, 10 Aug 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377273; cv=none; b=ZVbMOOwcQmFPUYJPnEb+fPkAYxMgbCfC/Yvg9Zlu5EG8Wi7e/LXDBlaCYwjOmAxGcx8ekUd5wA0kfdbIkntD47qR1jm0vx5dDYF+PAeO01MDPhjDKVvN0ykrqBbFq3MuwKFdyFYYn/tvXu5yKleVo6nBbES93tzwyrqbwlHguio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377273; c=relaxed/simple;
	bh=/WST08KhcsKdYSN0ILh3mfCnV8h+E5KAyg+x9TPgKZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcOVJYQrB3EraCqnxfjOhPeBsQuDuNPQcdJf6M0VWyeWQvhgH4HOsrECNHe+pWf2jF2adMHNH9BD2/hh56W9UGrjYSrWB/ZMdr5h0K01qrL/yoixx+AQgFifn5NX7hKE9Vl7Lr63P93+CFPPLX8ub7CGROUswKo/jhi/7f/Jjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E1dHFWYS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E1dHFWYS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWcOp930921;
	Mon, 10 Aug 2026 15:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LhdODS
	1oB8CsrDyNqYVDah7efmTCDSFKYBt7OJje9hk=; b=E1dHFWYSQd8OAY5H49fACc
	xbLE2RWxoGReUnXtpGQNi8zvQ8Zp2nxmpfdXTYOK519bMP41MYfp14OQYBacn3gZ
	dzZunpbD+0JlYqVoKyKbhfnKi0K6Z6wzjHS4dtUDLsN1PbTzdbo8Xt6RKAjuOgH4
	bdDqP9F+Map2mvQSNjgpAyX0FB/O/1bG3ykOLEviW3XPK8tizC/DsXz1O4G3Mb5r
	47GDPDAgPSSghD/yUnpizMCV2Opgnq46YTxulJhzjXqoKJCA46eesNieL0iPcG5f
	ysRvAExc6Qa/LgFLwwleDBZKlDxX5I/JgFupIBP+ur2+Jo4huFFXGrpXPPxwhjDw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23hs2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgXW8015325;
	Mon, 10 Aug 2026 15:54:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vwh4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsMlJ29753678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD33E20040;
	Mon, 10 Aug 2026 15:54:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CCED20049;
	Mon, 10 Aug 2026 15:54:22 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:22 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:54:03 +0200
Subject: [PATCH v2 15/20] KVM: s390: vsie: Guard against invalid CPU
 address
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-15-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVX5Sai2bHuJ+NDZNYLh/YP1PZPTHustmrhEMaSd87d
 19+fVW1o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgImkbWNk+Bv//voxnZzw/tOH
 OnbaePXPdZn790Z0rlbjUesvOp8OpjL8Yqosv382QGa+WF1p2gGOiZ8aTD7ln93J89KnWat2de0
 ufgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a79f433 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YOA8uwR83rpBMXObnZwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX3FARpv2XWHwO
 WZD0WiyXkXhFWlzkIsRaWGFg5p3HnYX4SqzTFuy0RblN0WgsgHtrdNcG2VQN1QuipjIc2WkDUZd
 JEXM9RYdMN52JnIT1wDrAvEcJxZYnqvJncwmw2oSfZb/yh/zS5b+z/jyUzxgHMaf/NHem9ZjZtP
 yULBMYkQxA5GtDl+V6E12kRPcpwsfbTqhoDC9mj7GW6Cn0bsG6Z4Nc0QRL1CsklK2P76mcdbtjZ
 iCw+tQW2snXmQ8V3CAFsVdR3aJdRl4cgvy0J+it2BMvPINp+OaqYeA2N3pw9H3cpFSaSsd8Abtv
 M0niNbnKq77zzf0AxWkUv7U/9WBPXgiRra6rDEvlaMZNSlSsnWexcsaTWulb5K860cucaJ4lyAQ
 +cASrG9OiunG+CYNBGZ6kXIMpkQCN5s2oIuVYFRAsPEerww6HFyvNsv0YIMqzQdQFqbc80lzs6j
 4uzw6z+lEcXvsVXVapw==
X-Proofpoint-ORIG-GUID: dhfL1VpC2rkzsVsqrOoLOHrjpOYYr2zo
X-Proofpoint-GUID: dhfL1VpC2rkzsVsqrOoLOHrjpOYYr2zo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfXzxtZUZkTWoF/
 20VSiRTY01JSL5eqcIoSAFDZWm4D7soVQFZuNJmGNFIpiym3D/i0NRUniYbmIZWPlk99OQcU7w5
 zHfbc/DEkeMy5Y8VqNDUnr5elgo7shY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

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

