Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05E1991BB;
	Mon,  9 Dec 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772366; cv=none; b=AKwQcWJeu9fz+Uhe7L9QYjvdZwlMpP5qhFqXAwe3ziCyrqQPNeiIoTjOLVJ938f/Y4Gv/Hn9ZgqVN+35Q0TlNGG1j/iVLyHhEY7xfBQ1OrkNJHLqnB48+M5RnJSt3vD+SdNPet9SO3IqG78qk7v0JxJkGRUeg4UzMjJgyoOUM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772366; c=relaxed/simple;
	bh=MOxUnTPqC4lNkYcr6hcNIssZn/uxBRlqjsb8SWYozhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzHn2lzjduUe99aM9Zt2mpRCjaj3Q6xFZpJwHrLEQKNgLrS+nlBNFJ1uH2XZHnvzE+c4KZpfTU4zYpws5n9u9A169uDf8XTXY1ORiPngdjfR9fRHkka53ZMmkVi02LcqI0etgWXTNr+s2HWN50+f0ubgD5451CGE8NjuQYD+m/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KtdiSQrn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KtdiSQrn"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9BQYSn018470;
	Mon, 9 Dec 2024 19:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BlZLtE/1kHwAY0hj6
	Hv/ahaeet1ErQycBmfqpNmPhL8=; b=KtdiSQrnQ+Aj4Jjy0qk8Zf5R55NPz9K78
	zFup0VM8v8eQR+jC7HTmff2AHz/N+27dWf4sIYeQA9tklaZ96irWUxXXpp7tiCkM
	xxcp+uRGQ52svDGghRb8Z33ktR3l1PjmYfEQAecUn/fnmenTPBMB5qL04INu0MDz
	oEmZ4bB4Mym/Em0DfSwm+b4x49jdOGAAxfFWBbIZBLQITmkmlh0dMejB85P80h/+
	S6B++bs7gF7KHcQ9g/r8Xgjhdk5a2LNAzkTZEl3FYg9e7/AGPC+9uax7+mUxSD7i
	YxF8YrxWitn/jTfRohaYofk+lJntPX7g0uEBcla1PJ+a5CUN6dNbA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq2hud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9J7RYi000582;
	Mon, 9 Dec 2024 19:25:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn02k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JPrEp31457822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:25:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B13A75805D;
	Mon,  9 Dec 2024 19:25:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BC6A58043;
	Mon,  9 Dec 2024 19:25:52 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:25:52 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 2/7] s390/pci: set appropriate IOTA region type
Date: Mon,  9 Dec 2024 14:25:44 -0500
Message-ID: <20241209192549.107226-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209192549.107226-1-mjrosato@linux.ibm.com>
References: <20241209192549.107226-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b7G-fD-krmbx2VkrGPRfUlyLwzfkVK4I
X-Proofpoint-GUID: b7G-fD-krmbx2VkrGPRfUlyLwzfkVK4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=881 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

When registering the I/O Translation Anchor, use the current table type
stored in the zdev to set the apporpriate region type indication.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 88f72745fa59..9f7adf913729 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -116,6 +116,21 @@ int pci_proc_domain(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_proc_domain);
 
+static u64 zpci_get_iota_region_flag(struct zpci_dev *zdev)
+{
+	switch (zdev->origin_type) {
+	case ZPCI_TABLE_TYPE_RTX:
+		return ZPCI_IOTA_RTTO_FLAG;
+	case ZPCI_TABLE_TYPE_RSX:
+		return ZPCI_IOTA_RSTO_FLAG;
+	case ZPCI_TABLE_TYPE_RFX:
+		return ZPCI_IOTA_RFTO_FLAG;
+	default:
+		WARN_ONCE(1, "Invalid IOMMU table (%x)\n", zdev->origin_type);
+		return 0;
+	}
+}
+
 /* Modify PCI: Register I/O address translation parameters */
 int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 		       u64 base, u64 limit, u64 iota, u8 *status)
@@ -131,7 +146,7 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 		fib.pal = limit + (1 << 12);
 	else
 		fib.pal = limit;
-	fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
+	fib.iota = iota | zpci_get_iota_region_flag(zdev);
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, status);
 	if (cc)
-- 
2.47.0

