Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665E44BCB8;
	Tue, 28 Apr 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392366; cv=none; b=Sk4kYj+yztr4uhVsFk1jEmKUSldYKYMZlBa690MU/2X6z4vmUpcq9cXQLIXua0CVSsJQaXXnLT5yDN3A1om4r1zwDjwPRVRwMpFlqGVZaqgtZBWwRRXJt7A2LYal0Pr6t4Pe7A9AELDiJP5/c9p9scmZ+QlfAwvjJIlUYmLfkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392366; c=relaxed/simple;
	bh=mXxzFr+BQ5O1y8FUCGvLMuK3NOlwR6DQOokJPngZUiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/YoyZJaPB5AghUWOYrYYAMFqVdGbwDLcnGrkhpJ2iqEib9l9AZPYdPsBQheZX6M0IGmv8rS7u2F/gnDiF0/TGVhCZjkIt0mwHLK+8gA5y9yYe+yZQnorma8UZ+sRddexY+GKbJMWZhf7D5hGOVTx79TGJ03jaecYMC6rx4Ersw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YpNWFxHa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YpNWFxHa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SB0EM3584793;
	Tue, 28 Apr 2026 16:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v04zGq+pk2AFIVLTj
	VznhliSgYqvYsTVKWmiBCchCqY=; b=YpNWFxHaP8vGz+OXXMkuKmSThw8BetkFP
	F8pHNuG9CGZZFIB4yV0RUXQIqsD4OEPlOS7yAKBoU7vOjrdH/urbPiRYu1O04RpM
	BYsL4dtl/pNtDJWtRJPgg85Hho5ql4DHtu+LDQNLNdxRTAe0aPPC7cjiQCLcfWZt
	L9O9Tlvm45ZIGjppMyjIQGEf8ZLmks4WvHq5dNBki3Vve1T/191n9RhVqrFnCYnj
	I8wjuejYnGOobnKPkK5vv9AuXuwFJkNS6N6+EinoMXYeGXG2mf5CwodPyjpL49C5
	egZVf1EoJmVqcrOrZh3NYrVreRqOfvFVhetjqarusavkEh3ZrQfwg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r6dpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrnfw027712;
	Tue, 28 Apr 2026 16:05:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamya6gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5Xa941156954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3758820040;
	Tue, 28 Apr 2026 16:05:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9C9320043;
	Tue, 28 Apr 2026 16:05:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:32 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC PATCH v2 15/28] MAINTAINERS: Add Steffen as reviewer for KVM/arm64
Date: Tue, 28 Apr 2026 18:05:12 +0200
Message-ID: <20260428160527.1378085-16-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428160527.1378085-1-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -p9ZKmtFu6vBqfD4T6QT7oFv22Kjfvw5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfXw+0zIeNFScjy
 vJphXSskEUtli0lFXKAJgrNY9TJ90hXVdeM6COTWEVsmlJNj0kvwQeP55EOG7qbhGO2iJigHTbq
 9mohaOJvbGY5Q9dkg+KKNRJ6hF35Gli1upV+GEoei3yYyKb0fV3HSVWjhrGIA3FdF9FFQQ2SBlG
 iiKwIbBPALUpc5OGMPaqxlS4KWD6DwqUk+rdxp+le9LlH19IFD0IFBjDB3fifMG/wrh7RJscHmk
 PXT/eFZFKVIX/aW2RXU94WjmWWfFGtp0sv2Fcg4BumTAo0HT18A6Ev3CyAfonxdtoOmXS+VmTmT
 W37vXPFP1NecXtALQ8953TDLUPiY1DNah4AB3K5sOHtX3ueRFywNZ654Qt4ccAMjx86uHH7tuau
 KB596XFeQVDpi/fB7R7SFj0z8CnTiGlM+zBzBuoqI8Kyd3JliXOv8esP2ycSR8ILgvZIIjzt0Ky
 HIbAzF0b8PYCiQZl5og==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0dad2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=i0EeH86SAAAA:8 a=JfrnYn6hAAAA:8 a=LyeO4m0CWtv-FIbIQ4UA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: -p9ZKmtFu6vBqfD4T6QT7oFv22Kjfvw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

KVM/arm64 and KVM/s390 now share some code.Add me as a cross-reviewer
from the s390 team to arm64 to help to keep both architectures in sync.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ddac3f73d9e..cd1485362a54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13993,6 +13993,7 @@ KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
 M:	Marc Zyngier <maz@kernel.org>
 M:	Oliver Upton <oupton@kernel.org>
 R:	Joey Gouly <joey.gouly@arm.com>
+R:	Steffen Eiden <seiden@linux.ibm.com>
 R:	Suzuki K Poulose <suzuki.poulose@arm.com>
 R:	Zenghui Yu <yuzenghui@huawei.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.51.0

