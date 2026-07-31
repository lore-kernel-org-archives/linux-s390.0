Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645442980C;
	Fri, 31 Jul 2026 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503379; cv=none; b=crh4Z4dNE3dhaIebUz72JVrKtGyt0fwGWxxjp7dfYVObjxKVbyFACq8FCzTh12IobYZwY4X78xWjdJgt/Q413FOQJSWjGlcCLo+5cdx6TAsWYVai1vpW12znJkgjDP45b0whPTA2Te9yYzYxM3vBF5ZyFTsCoY1TsIsAdSOGkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503379; c=relaxed/simple;
	bh=CdRBGytXIXa1zx9eXOvGAuzKgsrn2BprzimKUV3/4dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYjVAr9kzxG7uA6XXLejr3yxlJ/oCbRsGyDr6ZGqTB/1psPdNmi51A20IpNufIhF/avpYLAYULrbSZnm2Dx2CykoPdwTgK6HlcG627+4dPBSk8pP3A6cQjAyqGXXoDow3IUQG1CnmrdzPgDsBCFGxhlwUGxFPpIwzdEezuVZRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZeS7T9fN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZeS7T9fN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmZTt1672199;
	Fri, 31 Jul 2026 13:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eGPgAnjtKT6ftTAM6
	aOkUfJetBSRY7Y8hfEs8FIUvWE=; b=ZeS7T9fNdcrXHdAGoCFzonlihd6wN7PyC
	GNqfp/I3alnQlVQ3Z8ExsFDZ5KRAonSQEPgvn9zU9mNj3/u9+fS0g1BeoD26VcuK
	GQitZtXRSrBuvoWfSO33wYqBjSF3A8h5wZt+JqWB0TiftEtuL16wc1XjaSlJRBmL
	62nDrSJxoF1paBQPHI/hZ6ku+tP0Tawof1m4XD/9+LqOOwj4S55VfKookUuZ2KvX
	gtypmtXpJeZuAvSalCBMNVbDhpAjpl/+xuV/LEPh2OuXINULXUtulAkVOpaSTgcI
	aryPgEhPuswTeqYhfVSSXpRtqfUGdpqen0qsx3tTiqONP4SFTCLGw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjm3v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuMcr012670;
	Fri, 31 Jul 2026 13:09:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkg07u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD95xp28705276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E7AD2004D;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 987132004E;
	Fri, 31 Jul 2026 13:09:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:04 +0000 (GMT)
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
Subject: [PATCH v5 04/31] arm64: Use proper include variant
Date: Fri, 31 Jul 2026 15:08:32 +0200
Message-ID: <20260731130902.654679-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXzcRgvUGaGUIE
 OBMw2u1r4MU8XZRv5I7xWgA8EMjex+IsFxynOSU5uGOLOPDzh5YqLCFrjUocK9dqY7vIaqym78V
 co1P3GchEEHVmPDiaLq84Ef/AmbIqfg=
X-Proofpoint-GUID: QXD5bBxWjvwBFSApnVrk3-n4ykBoB8QY
X-Proofpoint-ORIG-GUID: T0xzpMAGbAR7DhOqDV7OE6ZIOJWkbLYg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX+q3Ksfo+buTb
 awIjyybs65q3ImQnnYe03LkaryQqFSIN80CstLcHANxoxl3I7J+sce5nwLNTBlEyMHQeIkulV7T
 idmWMu11VhQeyhA2u1jXxT+CREGpsG0/OsumVYVwduKW9dN7GoQR19hn8Cc5jkIruKMCdo0t90W
 C7ukQGwKujV7yFhC73Pcwt4qHlTQR77ed/57ZhR9tiuix/vAIM+xDhdC8XYPeMunNLFAdqrCTvH
 OeOrFFGJwt1x9grJdufYu57hTAwwCVxW0uyQjWow3NAxG795VBKDyn7uoM/QTsOBbt0Ec0Oirez
 8fCHN4SMV4iR/lYtJhzYJOp5NAUaI4+MkAUjHO38sqMeNlzCAKQ+gIEXVMZSJFB0C0C/UXEGTbb
 9YgXndPxjP9/EUna/gHUnmDj3JwEBlBmfRqROYmFNSrcyoOaLosp35lRcGiYEIflMUnkJ/npAiF
 Yb1EyKv8WzyRMQmt5yA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6c9e7a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=d3WjOe2bLlXSZPWdUOEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

Use <> for including the sysreg header as it is not discoverable from
the current directory.

Fixes: c07d8017bceb ("arm64/sysreg: Enable automatic generation of system register definitions")
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

