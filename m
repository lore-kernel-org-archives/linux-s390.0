Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73AA4A206D
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440870; cv=none; b=K+kIkYQrzNMwTpuEf5aNUppVH/dCfhlUnEA+4JyvN8eMQ3c5TK8oWqU4HXsn5p782sHW5VtvleJ0EP0oaFaQdcAXqwXcEnHCiKldlPxB+plMne9vub2aGXqdFXrYQA2VGfrLvoAwscCCABiNSpq55g37zxSKgLmtCEenJnbpohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440870; c=relaxed/simple;
	bh=m8oF7vXxL6MUm7NkEafU5P4EfygfyLOisgPHac3VQ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1hR/FpSOzVMtQ90EqquLCtO8NH/vXyeiWcauxyNu1/zencl/XRSJ+Dmq4eAAbwzFfwRMb0Vz7pzSJzLldy/UUez9nRcZWfdf5o1/MlBeuJvt50LqOUu3ZJpGLe6vS1H2jkxTi4uf29yM7mizAuW9dmHe6EluB32RI9tzHR3OLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtBZPqnj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtBZPqnj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVXtV862447
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 13:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7b2vpWQCiaOr82rW5
	1Es/xPSUl+UVeDdicVdj3UhcnE=; b=qtBZPqnjMCgakZJgLfzYS2CmXp8HBKu1A
	pZ4onBCZGAdtA9DSeP7Zxc6foT9f9N+0SsTbAK1TDmHe8iyFMUA17H8eh48Oio0o
	/0fyvxsl9mQC8AGDM/0myBmjqYEB+ibyIEXSzTjtHzFuPV0l97A60ANRkQwNixm7
	ZCdUuxJN4yrEqEQj3i8iHxgAmR98sZTdvg+BX6Uzrm/xxIogQz/buqjx9OP5DVwV
	jHuk+8rcW8d5U9VVg3UpFQUPmVE/EAVBhXH1O6ExCOAqZhur8L0fpvlNxz+byva4
	x4ICFfV2yx/rin+Sr7eSTj0+iUbGJyz1esVuCXsG6Yjlu6iVqLang==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rmxr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:07:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683CfJ8x007441
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 13:07:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyfjje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:07:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683D7Y4g32113220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 13:07:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 466AD20043;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B6F72004B;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH v3 1/3] s390/debug: Fix NULL pointer dereference in debug_set_level()
Date: Thu,  3 Sep 2026 15:07:31 +0200
Message-ID: <20260903130733.709001-2-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903130733.709001-1-zaslonko@linux.ibm.com>
References: <20260903130733.709001-1-zaslonko@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a99711b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=rWNA1FonZI2w8RDMTWgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX2PZJKVgOI6v3
 hWYS9CC6TjcUrag8+AAHEAOX1cgYZli/YHuRoE320dnPTpkS8m3EZFK8DBl6w+Cj5h/Ykrl/wqx
 XetFziwStjgqUzYw3ggr4X2isUsDAi1cg/Dyx/A9wj8yWepcR5RAbet0E3iGhrA8NFcQrV2hKos
 lhjhc2qSgpSsomwENlfI30mIE3KpQZESteT/kUgno4TASo8qXkcvQttRLzvMQHo9/UzTnObNynX
 vCSYXP9k6JzRpy4iwIC2WWZZMycLFTrd6XGZwrOOOOtXqOGA0gf9LCVEdjVIGxGxDArULKbbztP
 RulvzO8WJONPs315uuRZUbvqmpVdq31RNecmJYmkWGczYCozqAJtyF9r0chFD2LMhPr3zzMy4ZL
 AXDWZhZ0RJqEG6QpO5T1iKVdDFQjMlqZ39GprTTu01TslauVllGLu8c8Kc9JnymYfJW82jXk6nL
 zsfvqSHgkPM+kCVWEMg==
X-Proofpoint-GUID: nNKNexFCcQdndz-qDW7ZubZJZaqzzu8k
X-Proofpoint-ORIG-GUID: nNKNexFCcQdndz-qDW7ZubZJZaqzzu8k
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX5QGOrE8l5p41
 s+taPIY1oWh0jWM2YGIQo1z753RUpbh3HTa7+5cyJdU+pFE1Y8QOHFe5hCtIPXJBxwii8p7ZUvk
 N39JVl4dp0lm+SuCXR0sSRG1EaChOUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030113

Commit a2cec6863709 ("s390/debug: Add s390dbf kernel parameter")
incorrectly removed a null-id check from debug_set_level(), introducing
a possible NULL pointer dereference for debug-API users that put
debug_register() results unchecked into debug_set_level().

Fix this by moving the check from the internal _debug_set_level()
variant back to the external debug_set_level() wrapper.

Fixes: a2cec6863709 ("s390/debug: Add s390dbf kernel parameter")

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 arch/s390/kernel/debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 14d2b58ad093..e06abf1dbc21 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1074,9 +1074,6 @@ static void _debug_set_level(debug_info_t *id, int new_level)
 {
 	unsigned long flags;
 
-	if (!id)
-		return;
-
 	if (new_level == DEBUG_OFF_LEVEL) {
 		pr_info("%s: switched off\n", id->name);
 	} else if ((new_level > DEBUG_MAX_LEVEL) || (new_level < 0)) {
@@ -1101,6 +1098,9 @@ static void _debug_set_level(debug_info_t *id, int new_level)
  */
 void debug_set_level(debug_info_t *id, int new_level)
 {
+	if (!id)
+		return;
+
 	/* Level specified via kernel parameter takes precedence */
 	debug_get_param(id->name, &new_level, NULL);
 
-- 
2.55.0

