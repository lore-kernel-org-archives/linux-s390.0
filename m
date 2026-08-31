Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21D41E6CE;
	Mon, 31 Aug 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188211; cv=none; b=G2Cz/yDglmfHMyPhaAqsxaUIYmZwu8T8PIT4qowBEadp9Er1Ivdex1C+72qwMHH5U0t+tFRHNHMHAZZ1mmTQCwUQ9sRDA1YtdcwGqIdJqKLFNY7a40TjuqJUI8C30gojh+uAoEOnb7Y7kxYYnlMQzG0nLmXrDxjwRehaQbW7Q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188211; c=relaxed/simple;
	bh=JgriUXeiR4dWwHFe6B/GfzfIrtr+PymrVVkRtR02RXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qj1zrXwqTqMEg9e7lrWHvtdQjJVZgfeGIeXLoCxcpAszCBIboRhoW4BYPg1Hl0gUTOr/5PgX5VpLzLoLsE5M+Y/pJ4RDfla7N5pzYoOCs5b8+DVlHyOcRPa29Oe5rDqiN32V7B/uo7vP7Bh2CnENMqzFIJNmvM005rBR27lzkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T+JbyT0R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T+JbyT0R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZXVK2415431;
	Mon, 31 Aug 2026 14:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E469Zn0ZWGSg5jB5h
	qbX7wXKfoOWuCSVKRZd9tuvveY=; b=T+JbyT0RFpG8pztHtSP44oMvvolkzrep+
	HCAkKq6gs0jhdVDImJrjxrHLAqQrjJ1v4hNkwwv/80w1+b0wUyKcwlKNz5jdZjXP
	8C4JZUBNmSO6K1OFHb6PA3Y2UMci6SDWA93QenugxEmgNedBvzX6gRZwsIBh1IvU
	6NXdTqlw7OE7LlRlAZixzX6IoKX2htS5koLPp1H3vhPhAmUeYjnivaE9zJfXZ6oy
	sjxfsdeceVAHfNhyJ2du+w3yj4GywAwcZpd0n5QKwFRY5q/HdPnWYwABl9gOtxWj
	HU3OstkQbFcTwP3buywpY+8yPOlC76CUNSgOXt75MkiFim8D4fSHw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj65v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfkbd015618;
	Mon, 31 Aug 2026 14:55:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6nbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtekG48759126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E802E2004D;
	Mon, 31 Aug 2026 14:55:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 770822004B;
	Mon, 31 Aug 2026 14:55:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 05/20] KVM: s390: arm64: Prepare for sharing more arm64 code
Date: Mon, 31 Aug 2026 16:55:20 +0200
Message-ID: <20260831145536.913567-6-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: p-c3AW8SKTUCsy2-biXaILle2jf1XXcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX+IHiw1y7pzKN
 xPaKxv4jEGl2mzppZC3e5ty9Q3+z9VKTvAz27Gw/BSCqXl1TNUl9sdTHoG+Buyi/ZP6OW3GZ0gx
 CjgIYRvyuhKH+0aRvtiRJh2Rss9FK5MQ97gLkdtjR92vTxbOmKkT+ZhwYdHCeS6rkdpGJ8KLyo6
 Sij29U7jCqgSTp4riR5k4MjgdZPw5GcIn2LLQaurBZiXMX77yB2EvoMW06BTZRC7OTYeSnB1kEe
 D8FlG1Po5w6IK/WOj6H1NG0etrQXgxCFMvg1eSpxTFfK8Vnwuo+Nu/TJF2uvWAD2DxN3rbVx3QK
 5lvNc8cRt+eJT67Ab+yDj31f6qJgByp2GH+P8MgB108bynLSAiiWZbCLcKKtnp/r1PRyQtM+G3G
 mWxyByXCaY2qAQuAo4sTQqUKpibsgP216sO+oCBupGv1Az2vvtgW+2HLWvSsUF26GTkmwXUXQiA
 Z3GmfrPim8ElGjixi0A==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9595f5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2KF_O6z7hVLubVMqFCsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX9IBZBmYIC5H/
 B8s+HPx+6aizBhHf+Lh9OPOY0Ejcsma6HvznaQIPl307xECc+Qn+OvdsODXlLYnE5ilIq/CZI/l
 ykpeZ3XDrBxifTE5SnQSMEi+0VtJJIM=
X-Proofpoint-ORIG-GUID: RheUh-09W2a3-PN2uxRgCigWMwhsZAqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Add required SVE definitions to the arm64 on s390 host code. The
definitions are required to be able to build shared SVE related code.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/guest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
index 4ea6fe2c270d..8b5ee9e79a4f 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -5,6 +5,12 @@
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
 
+#define SVE_VQ_MIN	__SVE_VQ_MIN
+#define SVE_NUM_ZREGS	KVM_ARM64_SVE_NUM_ZREGS
+#define SVE_NUM_PREGS	KVM_ARM64_SVE_NUM_PREGS
+
+#define vcpu_sve_slices(_vcpu) 1
+
 #define __INCL_GEN_ARM_FILE
 #include "generated/guest.inc"
 #undef __INCL_GEN_ARM_FILE
-- 
2.53.0

