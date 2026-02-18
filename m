Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAA33375A;
	Wed, 18 Feb 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424423; cv=none; b=csg1NAunbnzbD2XhB5X0yZ+VJfmmgcpufRRhCvPneV9r2KP7xTfw7dIf1WTO0tA2z3Q8iisVeDowCj7PkXjsnNU07rf4p65vYYbmH4occ0hJU8A9boEiC+LQaAizRxBMYky/biR8WpA43vTK0BN2UVVDP1iWoACQT6I41DIKYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424423; c=relaxed/simple;
	bh=AzO8qn5Es8351c4DVXFkVW86beJOaZUPsL+q9ceLsCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z65m8XdHR/NM5r3T6Lp0JLAU1g5r6xCkmlhMdMpaZWHDrsXIcljO+fNaYpZXLB9fHSlKaZhA9unXIfP39GT3dZKHi/qVt9w3SLc6MgqWHYw7rUgFQQ+sfM/rNmKLXiEE5DZKQtQ489RKzpu0Maix6U+kTZGrA+xdFia/r1RIpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cr4xg/TE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cr4xg/TE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ID0DbX3334363;
	Wed, 18 Feb 2026 14:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yeGWdE8uNY5P7s+vQ
	uu05pHnoMk6lEZ85TtCMCLs57E=; b=Cr4xg/TErbyl9aY6Z7xo4kADJVKwd6JYz
	HPy1N0/X5T+N7f3WwLgmXD4Gbm0XPDkz7MeQQ//aQ2KqD8U7aCWrGZeSzrNcg18B
	VjMkc9b68ki9lODhU3UeNFhHWIaoyUsXWloAHgamphheaDag8qGEZThOLK+tS740
	cZTC1IydKXVQv0xT850eEzB6AE5dg2sYN8WyGyb/s/sfM+EJ/lZpVvU4m0mwYLIU
	D5Wt4NQ+4GB0DwJJSxi4WDIbAXD6Qv/3jAKFxP6Z9aNLSQTINU/ktyXFbGh770OV
	XTPQ8y2VI1Q4pcu5E8E9Hc+oYsoHLZw+3ycPQS5IZ7EQpyYKSXE/A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4kgdt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDIE42017891;
	Wed, 18 Feb 2026 14:20:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28g3cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKEYL15204764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C1220040;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9857320043;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 9/9] s390/idle: Remove psw_idle() prototype
Date: Wed, 18 Feb 2026 15:20:12 +0100
Message-ID: <20260218142012.863464-10-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218142012.863464-1-hca@linux.ibm.com>
References: <20260218142012.863464-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfX+yihf1auqkZm
 wlfxr8zlV10gnStpMkxy2+QPp9K3PDMxKgH1GO/6QncClz404x4TbGsP3IdNbq/JMOLm/kuXVdY
 AJpkZBCy7kbS/5goa2lciipu9ompefk1pNMQFGSZwIWBTGDdYD/mNKvJuP56FUsoCfLul9g9heX
 oqm4Jm27PBnY5LAJsrhoyjdkQArpiZyIZg67UnMoi/VM/OE6BCJsx4CdA+n4OoWenyOLj5r1rsS
 ENM2G8eXUv4CyJY4fFOVOBhBvuo2jHQEUL/bVaDGlnFy3ErdbGXJQYlJsZlMYQiw8BWeg1xRxRy
 xBfwWBsUzDdmPcmu8jcM5Sz+BBSIt1po3IwCPyrjGWPJz1noHYCCO9fwWe9EW6dnq28icK4b+t7
 n5HPMmd3uC1rswn+LnD71ErJpiFCXlddGbXQ6cvDp0+HNmGWjAo0fg2z1Qa3ks0xxDjx3NFTU7K
 uXh0dnNV0dOs3qwK6Gw==
X-Proofpoint-ORIG-GUID: BUG1jwINBmkA0QlvIMQj6puRGX8UCm1Z
X-Proofpoint-GUID: BUG1jwINBmkA0QlvIMQj6puRGX8UCm1Z
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6995caa3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=aUtqUClxCCh-7yMeKAEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180120

psw_idle() does not exist anymore. Remove its prototype.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 8c5aa7329461..32536ee34aa0 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -24,6 +24,4 @@ DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
 extern struct device_attribute dev_attr_idle_count;
 extern struct device_attribute dev_attr_idle_time_us;
 
-void psw_idle(struct s390_idle_data *data, unsigned long psw_mask);
-
 #endif /* _S390_IDLE_H */
-- 
2.51.0

