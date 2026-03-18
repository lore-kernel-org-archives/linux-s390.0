Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20963D9DD9;
	Wed, 18 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842944; cv=none; b=HZYyUQ+eIH6a4viLIC4QzWBaaD0oxtI9GPctkoLVT0yi1f50qBZP+hhLSp3ZNqE4UX49yZitevHVYaEZtizh4UOwWWZZRMqpHw9D2wOALAu2ilTbloSI3UivtUhWhOsSYoeu3V1lwyFyDq7MMc2HTGECRo6EKB5owIUdlbkvvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842944; c=relaxed/simple;
	bh=Eb5j23QL/7LuUlvNV7Z9Hpyc/odf598dfKCnpJiTMRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOzzqlhC+oyiIKpohPBQJ+beGG1ZKA961Y9SZtmd4W955zqnfaK5wdcaVuDhX/3Kt3vCIykTH8eQeb2boZt23DIw4/pe4colh/jn5VpkrfDKd7E2gOAs7VdSZ6XWhDWNKdk9W2l8WvaxnSAXWGuqHVPz1uMw7TVGsW7B7PBfFVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rw1QqcCW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rw1QqcCW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I5wVXM4073613;
	Wed, 18 Mar 2026 14:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oUKthOY+1eHEMQG37
	LhH3FSdbRrL4+pPiSXUGDw+NNE=; b=rw1QqcCW9J5KG18u0ocu3aU+sf8uqKDsj
	2cH1o7FUlB1KjSg95APHnraYJ1aDe+L5C7sbXBP6Qq7zc64GTCEfPDV7nIF9CzBW
	0B+Hhx69fzmgvgiGOWVYBXGY4tEQ00W3zl4gRsfkvgfDbYkaLLD2849P/PDd91NR
	1eiADptl5C0QHuIWh9IPLyk7XSSSu3gzJoIl2lMHA3u8mtWd50QBQM9WMXFUw43g
	VMDYVIqYdWb5RA3WVBRbuxPYZe5h3wl4jc7S6S3Jl86RAqycEi6MT/kO7Q94sMP1
	bxNB36P16Fn/lsFJ4BUFC9WDLvBWydfucnBoGX9hvPyEjNcamtDOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64te4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:09:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDnUUN014113;
	Wed, 18 Mar 2026 14:08:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy6cat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IE8shU55771516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:08:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C304220040;
	Wed, 18 Mar 2026 14:08:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 829C92004F;
	Wed, 18 Mar 2026 14:08:54 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 14:08:54 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com, seiden@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v1 2/7] KVM: s390: vsie: Fix check for pre-existing shadow mapping
Date: Wed, 18 Mar 2026 15:08:48 +0100
Message-ID: <20260318140853.119460-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140853.119460-1-imbrenda@linux.ibm.com>
References: <20260318140853.119460-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5aWCSu0ELHsr7hwv1EOuS0kFju8fmEej
X-Proofpoint-GUID: 5aWCSu0ELHsr7hwv1EOuS0kFju8fmEej
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bab1fc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PlgCcmkuhnOIsHVkaVAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX0q3sleTijXUL
 PC/AGhSwQIcraI369H7nYIbguZ5xmSY18J6054MDvv7xxroqc10a6RW33N3ENtmMNoSgs7hJrcv
 K5VMK13ttywAg55BNzZdSBhYFJqsawGq5GLV2Hk0fn1omDj2Wa/Me6fLR9ViEeDxgNbwB/u0k3r
 BePC46saZz+ntf/aHulq/jexj99s+o3/pGwuK+5HbbTWMIUUJGMet56PGTo3hWfIQ2lj1bhknTz
 21RAW+sgxK47bNhfIQK5O7AKD2ovqdvTpi/HY94qAuP27CcadTW7957XDivpdFre0EGTr5Nek3s
 cpOqlapTNUbxq2WryO1dqEkTp3Cjtt3LpqcjHzWKEwPyEM7UpBaTOqERHmj47lJODUzGu0crwx1
 uzV5QGU9p77KEcUybXMDd0trj7wLYFEo2OTvRb6IUj45erGP+a5NDZIUs6xM4Z6RzluPLc7W+sY
 1z8f/FahcE2nATbdJ1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180116

When shadowing a nested guest, a check is performed and no shadowing is
attempted if the nested guest is already shadowed.

The existing check was incomplete; fix it by also checking whether the
leaf DAT table entry in the existing shadow gmap has the same protection
as the one specified in the guest DAT entry.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index e490ae87db44..f5ffb11c8ef9 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1505,7 +1505,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 		return rc;
 
 	/* A race occourred. The shadow mapping is already valid, nothing to do */
-	if ((ptep && !ptep->h.i) || (!ptep && crste_leaf(*table)))
+	if ((ptep && !ptep->h.i && ptep->h.p == w->p) ||
+	    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p == w->p))
 		return 0;
 
 	gl = get_level(table, ptep);
-- 
2.53.0

