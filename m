Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500E380FD0;
	Mon, 15 Jun 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548537; cv=none; b=XVMmbPkaHtAOSBvMH7/mH50Z044r0QJCl/R88yiyHjx/eyyrEDEpHweaf42cnHr+jCf0StHkWk1G7DOid9h243vfs6SvD8rJQWdEjGUkw6pml+jde3SameFyLdVWgJJUpjLDqs2w7z8fuBRIjaYeDDsaE0ca5xwkrwqbGGY24do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548537; c=relaxed/simple;
	bh=aXtnh1XDkfyl9Qchb57izKfvAET1OL/16TRuqGUY3os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO5/hVLRC5e/2yyFNS8F1LOx76HtY8VoDk4e7c9Rrbj4Djw2EzpiQw2OKA9gNiL7fi9vmz+5L67qRFn/cxzDFJHMmec4c3RBYQtkZS9XvsruOfHMOIqtKVysIrO/SxSWQ9tkfWZlU9JHeuS9+RMx+NMWEgYT2i98Pg07vG3MUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDtonnRG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDtonnRG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFnLlY2888440;
	Mon, 15 Jun 2026 18:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X3l7SLvrNZOlg/Grb
	Nj/MWNHBcQ/IvPqQwU6/jfIaaA=; b=lDtonnRG+fKg4oTgcdLUGAJ4TMaF2M3Zw
	IUTHzuGy/cGjVw/gmFV4O7tapIl+7gE4AnhgcYvJfCo4R0KJIbS4inbaP+s9oerc
	8uz968jJ5RHrBHjRUhbLqHqRKcmkFCSKRyKG/40d5RUM85nU8yn+BpYoM3NrK7Vo
	i3JXnpL9KHEoNE8ZgEGVWT+2iKGxPxqIxM1f4MpgA+otnzqbUJw5nzBQwXocQwQM
	iN2amY1Hvt7xOgfDbelXIigxgBf99ZoYqbndulB6Ci+FWGvoQFsghLbZnWnU0zo+
	TnBBd35wzHsG6ULiWvX/PdeCfI/ujQkLRKSXH0+ie1yUyXYpzC0BA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0hknv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYbii003237;
	Mon, 15 Jun 2026 18:35:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvyy9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIYxjf29426002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:34:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC06C5803F;
	Mon, 15 Jun 2026 18:35:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEEF35804E;
	Mon, 15 Jun 2026 18:35:29 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:35:29 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v19 3/4] PCI: Fail FLR when config space is inaccessible
Date: Mon, 15 Jun 2026 11:35:23 -0700
Message-ID: <20260615183524.2880-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615183524.2880-1-alifm@linux.ibm.com>
References: <20260615183524.2880-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2k1MISizus3NTMbakLeFCoWGCJtXr8Po
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a3045f4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX/x9VoueXOOtu
 0tgrqHKf+zDiAqsZ+i0jT+8wZ4kR7GhdfEDMp+dxmRLG5ObCzvkTAd6V2f6TFPgm2mbEvZlbuTS
 I6BdYbn7+a9Z/3bUmzqJkiBp1f3HI68wAOAobkDQe9Uhc9PsnttRr0qbrNP665jmWgmgEu+4JMW
 ar0+0twcY6N3sYXxAypgWovlNphmJjRsYKmIbzUI2GR7aq/eCrjs0ne4lHa1KklJWdM6lyVmkcm
 SrxETy7lOF5WBHArYZJPTDNCEbAiXqSk7gDLClZXLFA+dTQD/BimBypT6aLVj6nALBE6fK1ujnr
 zgoP2L8N/p9VvuhtLlTHAMIcjRj7POoGfhaFUNZLQ+fpAZSlj1glFBHBPsvPWcIerLiCka8EZzW
 nzHPgrRanbbwtKPU+9BlEKiuU9t96O+tdXQNEuzCXZ3d8Y9vw6hV0a2S6edC38RWjM6v04abjO8
 ZfkeALCduqGElphxgXQ==
X-Proofpoint-ORIG-GUID: 2k1MISizus3NTMbakLeFCoWGCJtXr8Po
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfXwpIw+ZBwZ2Xa
 zQSw+Q8UUzP3GVek5Xg29WD1eSDmuKemB3j+E9kPFY3OZlKoRMfOqSefPZYmUpJfxyv/pOsuaFE
 XCfEZIPksjLNxnCUfGusl5Ll7PQO3Ms=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150194

If a device is in an error state, then it's config space may not be
accssible. Add additional check to validate if a device's config space is
accessible before doing an FLR reset.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 973d23e41c48..521a4bb189d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4352,6 +4352,9 @@ int pcie_flr(struct pci_dev *dev)
 {
 	int ret;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
-- 
2.43.0

