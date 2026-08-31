Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B95373BE0;
	Mon, 31 Aug 2026 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187711; cv=none; b=uMtr2JxowGaCvlVrVGxWIGYZIYvKRlxsIv/gkIMZxavXvoWYmA+kp9hoStZxl1AHqiW48Twnyw21ahTmPOAH/Xr0fJCAW1UljqdX9VFoTeR4i7fg8bJ0GZQzRSmVi3gHFtG1cZdEoC/1xZbA4u8Coia8go0TTN7r9K4jpn/fons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187711; c=relaxed/simple;
	bh=y4kyAuseVXdZvFmiHOyd9Ag8SRcIgA5Vfg3SW8qRIWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inpJ2Hln+UrIUxdapar4AL5y86KoIw0uQ8/c+kPX2RCA4j2kVPMuVKfFppmrBz9xGSxFu0AuqfO6L2oPi2/XkM35yGPwxpfZB04SdNcKOoDk2y8z/x50ix43ccfnVuoCZiRoweZJiEdHgFxIMtnLnc8zHX0b/aZDuDtYc/1aTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K/JrSwj7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K/JrSwj7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZAP6652970;
	Mon, 31 Aug 2026 14:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8U/24HvfSe9SvVW3M
	i1QdqXQeajeDAh9/ITv81UXOTk=; b=K/JrSwj7HU6X+MLLYxBEkD9JL8oe8FD28
	YA3s/DjeJm272CTmY6hYMBfRmcvwei7iUOcnkg0OQVUJU+Wa473y84fHCg0YJGp6
	JkLhUuNsNG0NgKQ2qlDh+zLNG6djLhI1TQZqfUh7CMaCnEJQMwaBsTafNEbe97QO
	CC7U+0dm1+OUdaRYoWDqWJJ70/xcoDC7A7VWULrBblZ2OjBx1htVnHz23m84eTzL
	SNWaax4dQL3fZBL6VXwpcS8RkH5LZWrhF53zhDcJbHj6KW5Atj/P2AEE554hkGCC
	AJ7J6PEr6PnALNaA52yIHVmbBkuUIMe1TuEuLM4M2QZVCMBr3pOPg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r1xu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfjHe000540;
	Mon, 31 Aug 2026 14:48:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg694r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm53w51970354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F279020043;
	Mon, 31 Aug 2026 14:48:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FBB22004F;
	Mon, 31 Aug 2026 14:48:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:04 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v7 04/23] arm64: Use proper include variant
Date: Mon, 31 Aug 2026 16:47:41 +0200
Message-ID: <20260831144802.834315-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95942a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=d3WjOe2bLlXSZPWdUOEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX/0+Zy+2aqMpF
 WWNrXdV/If8KIOlcqBy1qx/8vqhpSnztW0OokTSvhkSSAgdwiAxXul1jjtrYyB8o8S4JySa7Nny
 XU532B5vJHLZ52VyYHFDpebpdWqzqA5OLl14F3lAQHypKOMlcMPFqdwlkdFkdoNB03OSkaERdIq
 FByhhtkxF5gFgA3WFWo84kevzzPmWhGzkdrqFmMMAXg2/s4Gf+0xxk/dsbjajqmDLdDTYOdvd49
 e7wp3nsL1B7AZ8Vexl/ldUp9YnfFXqbWDxkJp0h2yaOLHp571WK523Obm7y9M7WhVivo5+fy4G+
 IACPWp/Wmy/bXRELj27FfaIEvH/8BDRhFZ4ihB3SUpC+WWKiImpTX9Mth5cVRUniVXY35i1bw5s
 wFLtZ4YyL8CTLBIrPnAuEV3qj3TByhbo5JOCeHOpHV21vgyi9eXa0olFaXIyGIEOp1dUAHoyTto
 fis/zTSsgkEE5/u3L+g==
X-Proofpoint-GUID: aoW96-2q4-UH_MP5aZ-1Oje6uUNugt2H
X-Proofpoint-ORIG-GUID: RuqSfEEyvLl0yV5nxPurGRu-S4UVoxx6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX1Tr4ntBwjwmw
 Kc+2tgaYaHfm3kvtZ1ZHywwFfZ1SpzzcJ52ZEZe4/B+C7fd0FPKt3BPxzY7if0Tly3xiyGWqQ/r
 goZ5XVFIuZVDGxBYfnEudGWTxNQglTE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Use <> for including the sysreg header as it is not discoverable from
the current directory.

Fixes: c07d8017bceb ("arm64/sysreg: Enable automatic generation of system register definitions")
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7aa08d59d494..4bfdac9401bd 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -173,7 +173,7 @@
  * come from here. The header relies on the definition of sys_reg()
  * earlier in this file.
  */
-#include "asm/sysreg-defs.h"
+#include <asm/sysreg-defs.h>
 
 /*
  * System registers, organised loosely by encoding but grouped together
-- 
2.53.0

