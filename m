Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE631F99B;
	Fri, 14 Aug 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718455; cv=none; b=H+hC2yvLOFTRE5AZyiGuHylEdGjvax1qMN9zMnss45CIKNeCakUW9YMcPfLVFh2HjtZbnbfuRUnPfF0P5zIVoEmZBeul9uUzDIwWG2tcnd1KFYtCG0VR/+vkWQKjCJ9Dq2Qi/N5Hym2ia52v3bz+3JchFeVDuxE2c1Wkmlc4glU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718455; c=relaxed/simple;
	bh=9CzB0dUIsbPpfKpTrQoyGvH6O9B7KBM+3VhDp+w9CAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UeUfMDywYTgFpjyGwJsbB1DMK2MEeHIcIah25liqeojC1YHqCCVpihS0xuY/oQ18tHk9yzIhmCTI1hWg+5gBisAdr/GOzhE9qUjU/+GUc+ahvjfulf5UQee4HOYovZ6cq/tGXWRv8RJ3kvNXw+n8YdUrEG7qqGdC84w4AkEtR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ge/6PPGK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ge/6PPGK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5cCW1289745;
	Fri, 14 Aug 2026 14:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1JHadDRDFUZv5UD22E9SbaEnDRmLOuGGMdNS25E3j
	pU=; b=ge/6PPGKSY/aPhLgPTOQ4ACualE3ox7PQR43eL9bvEjnZdktZBNDM7k9E
	AQ3uhOGftLd9Yt4F9/0Z4jatonXHFLhtKLB1r+ix+pJ9D5MLcqBWXG1qHNdBwBsN
	0hL65ZrG/8eiRek7Tmpzb17HVefJhcnsYcfSJKGIVtm1QO64y34fbRDGrCtvWumZ
	eMm1YtSSfazbVrYMInE6zL1RJYX3vdrn5YgdiHpMcnFfeMMc3HRoFBk5SarwgzK5
	EXRNh3vSB75oxv7AI7YWRIyz4gVhcstKAGlek56WQXMBhMW22j0fc0+YDozqvNsi
	Xr5WQPYMXd8/PB6YOuYpNlCVnMCuw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9w7k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEQSu3013056;
	Fri, 14 Aug 2026 14:40:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpvad53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EEegX037880204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 14:40:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 373AC20043;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0363C20040;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 14:40:41 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 0/6] KVM: s390: Even more misc fixes
Date: Fri, 14 Aug 2026 16:40:35 +0200
Message-ID: <20260814144041.169025-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T-VjrRQ-eq-ldXwe2P_XxUhUEQ-QzniH
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f28f1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ZmXRCP5Q6UToOqpSvukA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfXyKzHoDO/K4Se
 Pezsf8xpH5CkYiG348CFdyfreIRDnepe/VxjS+ExQBTfQAYwDYcpwlvKHHVsYy0fIosh0IQxzCC
 e5yq1mWbtibzFDkWnkDan166lQlzFEnLugOsUdYjQPtelEwp36Ccez3JK2P+bUvy7lrQ6GO7L30
 ldNiIwa3oP+RjYyGRaivm7iXYaXdodB0nc8k1fX8TX9qaykwe0HUM1Q98TbzFI4k5eAG+5LEjkS
 yfwP9qzqI4Txddko1mN7rBihGK5EpK7i8PtkuRdy/twrJNV9TmDNo/7RJtH2yZy53zCq5ahyl60
 5h4ALliVUj5LC9IaibB/l2qd7Vr9A5wNNlklgC0mNNkqj/8BfxLSSftJn3N0YX+WWZ/Kk7TGXd8
 kefFj058ftZfh7lOiVhbmzcyvSwgafU1S0HEkh96cSCkb7QJ00+3hdsmYrJUMh6TCD1lOvCXGnt
 UjnDQMpYBBAhtPRaccg==
X-Proofpoint-ORIG-GUID: T-VjrRQ-eq-ldXwe2P_XxUhUEQ-QzniH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX8z1vlTVF+YHn
 h+hfzs3EUiVGWro1hY4doJNfGn4UEIf1BJhjwpgrnGPGb+qKNZg1lVNX0rTrGb7Iw4cMnIfli5C
 pqPTpL5lkCJ0yIIQtL3pefDppI4CnRM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140111

A few fixes that had been dropped from previous series due to still
having issues, plus a few new fixes.

Claudio Imbrenda (6):
  KVM: s390: Fix dirty marking in adapter_indicators_set*()
  KVM: s390: Fix _gaccess_shadow_fault()
  KVM: s390: Refactor dat_set_slot()
  KVM: s390: Move all code into kvm_arch_prepare_memory_region()
  KVM: s390: Add missing srcu in kvm_arch_vcpu_ioctl()
  KVM: s390: Fix potential race in dat_cond_set_storage_key()

 arch/s390/kvm/dat.c       |  37 +++++------
 arch/s390/kvm/dat.h       |  10 ++-
 arch/s390/kvm/gaccess.c   |  13 ++++
 arch/s390/kvm/interrupt.c |  40 ++++++------
 arch/s390/kvm/kvm-s390.c  | 129 +++++++++++++++++---------------------
 5 files changed, 113 insertions(+), 116 deletions(-)

-- 
2.55.0

