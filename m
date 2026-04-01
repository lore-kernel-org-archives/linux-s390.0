Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A13C7E12;
	Wed,  1 Apr 2026 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050985; cv=none; b=VVRiXYoLrx3qAid8eKPkhMQljM37/a6Q0+b6iKD8ypHAQl9yvvnB/vLwRIDcuOcs4uaBvhE3Rcu8eIq0XJGa0zHltUUfoERE6g8IENKjucBYIX2Q13hAcv22Ol/bVlxkwNJkVwlPn8RgXye/txxW8ct9+jJh31vux7pT1w9IxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050985; c=relaxed/simple;
	bh=0LpDogvBDYaVYtVEgVgzbj45MgDeGEcBFLP7NB0ZK4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+JFOnlyq9vo3qCjJFHy6SidCvmcxtqRht9MFSubbsSTnMRF0wxGJNEuh3fTyPwaY9UdLqUJeGkAhP3jxJDb8NI+HC6jU9cQ5Jd83CHQgfRD4AaGNemtPlES0gPcxQGzpEt5pn8O+z7cRccUAq+Yp+GIlBy2maqpuTTRvtxJTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aicwtxVA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aicwtxVA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631A99dh105889;
	Wed, 1 Apr 2026 13:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/C6bDsj/e6fJBtMF+927CdDscdW+ifURrScsiIi7W
	/w=; b=aicwtxVAm0kNBGMGKgwtvvkEjRmJ3cl/R4DE9KwKMdDgt1ZalA8Q1i/g5
	+YJNjsyqhmzd8dWzPSOcIUVtb1MpXx2LYslVWDgD5IlXqEfjEOI1/xegwf1wiSSD
	XW9o+Bhil2oqRhdO+qBmJ8RDaEPjjjR7jD9uFQOuwiBMjGrODp69GNLCq5lacdEi
	DTQprQ8JWGCsIcjn7HSohLtxRvzRbt/GGn18rICtADeYGpBkZf7io6UxaiNgeDwq
	7fXpixFuSz9g/1p+84jFpGJI1NNY2nsFHnXVWevCdpKPNfO8R9woDfwoB5Cbbt2R
	ThJqhshFkJJcOUej39LYauA1AAg3Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms7jkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:43:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CBK1V030952;
	Wed, 1 Apr 2026 13:42:59 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjwkqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:42:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631DgwO633882702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 13:42:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD415805D;
	Wed,  1 Apr 2026 13:42:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFC0658057;
	Wed,  1 Apr 2026 13:42:56 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 13:42:56 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH] KVM: s390: move some facilities from FACILITIES_KVM_CPUMODEL to FACILITIES_KVM
Date: Wed,  1 Apr 2026 15:42:54 +0200
Message-ID: <20260401134254.259873-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd20e4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ZCGCvbL1H74fiaApoBgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyMyBTYWx0ZWRfX0JAFi2fFp12U
 pB2MQTe20lrbw0FGYJWzVTPFU3Q2U4hOkxmwja71uLv+VUBv38+ascZFSTRNqKVx+FnM7RyIZbk
 Ks9C8VFhkorCAHBbhutDHvxcPnnAfWdliJCgx0LV7spkJPabCDBOJ2kOi08UbGVQNpQdaxPFT0M
 7QZENY3Qycm4f3qtvltl5r4b+S+shxyo2zzw18PE00bm9JPyHhoJAC/SgSegXOmY9E4G5dOR3qv
 BDgacxhmoz6n7P8r2fr72OeRPQ5ZBmhEwI0Lq5djEuSzbqxJCIEBeKV34Cy7L+twhxfRejPaV9h
 elCA7QNszowzfqlk5btYZ1bNl4Y7PF3MxJrh1kCZkOUPg7haBHMzUmBwigu6tMUp5yqu3zV5fTq
 zIrCaTbrm4DMf3ypxquw2Pg/d+ILSXyLMychBvfkI0Uy1cRiK9Okul/DozxLrGUy1bUwbXqTKMR
 GMpJ+K23FYKaz157RmQ==
X-Proofpoint-GUID: 7ngP-zQIyMtq5oicrzfrxSyya5i9icrr
X-Proofpoint-ORIG-GUID: 7ngP-zQIyMtq5oicrzfrxSyya5i9icrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010123

Some facilities have been put into FACILITIES_KVM_CPUMODEL to be on the
safe side with older VMMs. Unfortunately this has some unwanted side
effects for VMMs without a CPU model (like kvm unit test) and IBC/VAL is
not used in that case.

Ideally the guest visible STFLE bits, the behaviour when running
interpreted (HW supported) and the behaviour when running emulated (kvm
or qemu) should be in sync.

For LPSWEY this was not the case. STFLE.193 was off, but interpretion
did work, emulation did not. As emulation only happened in rare cases
(e.g. deliver a machine check) the result was inconsistency for the
guest.
Move beareh to FACILITIES_KVM to fix the inconsistency.

NNPA (facility 165) has no fencing and no KVM emulation. The instruction
will work, despite STFLE.165 being off in the guest. Move also to
FACILITIES_KVM.

Facility 170 (ineffective-nonconstrained-transaction facility) is an
anti facility and should be passed along as well as KVM cannot simulate
the missing function.

KVM also does not implement trapping for guest RDP and there is no
additional hypervisor control. Move 194 to FACILITIES_KVM as well.

Facilities 196 and 197 (PAI) also do not have a hypervisor control and
need to be passed on as well.

The PFCR is also not intercepted by KVM and needs to be moved (stfle.201).

The other facilities are fine (stfle, emulation, interpretion in sync):
Both AP related features (12 and 15) require a userspace added AP via vfio.
156 etoken facility is fenced off for interpretion via ECD_ETOKENF so
everything is in sync

Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/tools/gen_facilities.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 2d28a569f793..32dd5a57240d 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -96,6 +96,13 @@ static struct facility_def facility_defs[] = {
 			150, /* enhanced sort */
 			151, /* deflate conversion */
 			155, /* msa extension 9 */
+			165, /* nnpa facility */
+			170, /* ineffective-nonconstrained-transaction facility */
+			193, /* bear enhancement facility */
+			194, /* rdp enhancement facility */
+			196, /* processor activity instrumentation facility */
+			197, /* processor activity instrumentation extension 1 */
+			201, /* concurrent-functions facility */
 			-1  /* END */
 		}
 	},
@@ -112,13 +119,6 @@ static struct facility_def facility_defs[] = {
 			12, /* AP Query Configuration Information */
 			15, /* AP Facilities Test */
 			156, /* etoken facility */
-			165, /* nnpa facility */
-			170, /* ineffective-nonconstrained-transaction facility */
-			193, /* bear enhancement facility */
-			194, /* rdp enhancement facility */
-			196, /* processor activity instrumentation facility */
-			197, /* processor activity instrumentation extension 1 */
-			201, /* concurrent-functions facility */
 			-1  /* END */
 		}
 	},
-- 
2.53.0

