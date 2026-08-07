Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9223F0A96;
	Fri,  7 Aug 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096674; cv=none; b=A3NjvQlyrUO+eIXCQ7AUvR0/RORVKTB+qBc+zFgbhB73VF1QRA1QAfa4jDswVYuJc38thHRVHd8LnydbmooJMlKQHIqtrOQmiLBOZV434LlDN0YZChrtDHKgd5ZSlQajCXlSv4iIzWDQ7umdLHsmcleGHoGldyqcyvbI2I9QAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096674; c=relaxed/simple;
	bh=TOlQZt7EVr/qA4BgGrENpGu1NDlhJE5z7zs388qbPCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E98FzF190TzkizbfEiIee6eyCfZF2SQjfrelhZaX1brWapXHPh1Z14ZS8DZVZzujK3GJffCuNv/JQ/760pqA0MfcLndxgZ3Klstob9/1I7/mWxx+lN41kR1JsvWCmHR5jocoyey3RxvFpmP+tu4uLBDHR6E/faqWPOEPaQ96jSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dcU7cdMq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dcU7cdMq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HqQe4161789;
	Fri, 7 Aug 2026 09:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BMXWyB
	XwKv1RHvFfCXPr7a/NUKP7F4r3MXv6bQcW7QU=; b=dcU7cdMqMmsp4CKMKlJUqW
	cnyzoRqRC6ybORMBXpbqmq23SMaa8Q0AFAebpxPTdx6DtgIE5f32M7ER3a879RKS
	z2PM34FCwDAAo8wKfcl9+VS5pxewzQrKMDQyBlzLPsyWBJyfyE02zxTwGo2OavD+
	AQNir6nmK1uC2H7kG4I+cQAYeeMijqtBekDi0Lstj2iiEQ1O2Mu1Qc9MD+jz02ty
	Fp7EAKIzvhNMCtkuI1RKrMwpMN8qJMDSMEqVfDT34wHqxQgmzU7xiq8fWA1eunH5
	IOzmZMORulVG6Xqaab+eI5qtFJbynXgJSehcONy1138NMulKKXW/bLNCtslRUiJw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyua6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779uFXx014345;
	Fri, 7 Aug 2026 09:57:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgpyw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779vkop37421424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:57:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFF162004B;
	Fri,  7 Aug 2026 09:57:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3645820040;
	Fri,  7 Aug 2026 09:57:46 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.87.136.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 09:57:46 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 07 Aug 2026 11:57:43 +0200
Subject: [PATCH 2/6] KVM: s390: vsie: Remove duplicate assertion
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-vsie-cleanup-202607-v1-2-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=TOlQZt7EVr/qA4BgGrENpGu1NDlhJE5z7zs388qbPCM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmlayT2rDa17PNq9fgeZ3tUTFdeUeTGigvnH4rwstpdq
 dkyaf62jlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACay6SDD/3q9iafZmibeLVM/
 vXx3fQLH9d2MJZG7KhlNde13hv4868zwv3rS3L0h25ayWbpvCdr6VXzJITbrteEcB3NexGaqJ81
 j4AMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75ac1f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=TUp8s0cp9ye6Ph6o2uoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX1+bhyLCUzsm/
 9tcJ/TSMmzYy4ZI0fTrMHoATLNgl00Xj2kKuRVXQdPMrX+2H4YmmcHnlNjvmyW4YGnoOs5Zrucw
 4bC7wEF5p0InWLhXWgmE/+loibhiGss=
X-Proofpoint-ORIG-GUID: 44KUc0oPhHuOCN989nerXbJ7gyv6SDOX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX3sRxY4mD4zTW
 9upZnMBDs/zjEQcEK6PcGnAfyCzuBvHtZ0zWJrnbxj1qKfzd9ztoXSS0HSRHM0rVm8J0RSmmFTL
 S0uGfQ52AwGNWhugqwicX2oHDQiJoaNCve8AQUVorhy29ylIlGsG9bXA5kk7a3QqQNmefdVQ5ki
 ILx3xZ+Ewn/IXudqNKUghTDc2l5VnF9ZO72GbparOsqV9IIqK/rwgEBt+97Ux4PsIU9clFWCxUE
 pVAjrZjfkToAowhtqKkRj8f6YG/hD7aTFABSXkgqbMvEWqCD48pl/WjIBtUNxlI8Yj3+1b/CXNc
 hmrPD9U9qIv4v6oimZ0A7/Dn/EzVXRC+qaYR8xLftgT9JgUQEgssgj1id6DZQHIO7gNRfhMVv97
 ngfK96tsH08mEOrR0SSvePboniZZQXXBl59MKrYiS8jk0nsfJbNPiYbMnr9VTdiXUtiwll0LBhj
 hd0CaVOQlLNlbghGmpw==
X-Proofpoint-GUID: 44KUc0oPhHuOCN989nerXbJ7gyv6SDOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070074

This is covered by a static_assert at the struct vsie_page definition.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eea24562e7db..3e956c7faa4b 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1565,7 +1565,6 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	BUILD_BUG_ON(sizeof(struct vsie_page) != PAGE_SIZE);
 	scb_addr = kvm_s390_get_base_disp_s(vcpu, NULL);
 
 	/* 512 byte alignment */

-- 
2.55.0

