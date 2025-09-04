Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42482BDC09;
	Thu,  4 Sep 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976414; cv=none; b=UXggxHUXIR5vvx+rkgsY7L5WoDUIjFBNCcYITRjyVuAUiju4y3n8kjcmkSQlMsVBITizGzDXMgB+AKrLPkrTPe9FHHfOtiK5ie076xf9Be5q13lSh6KR5jaddnqeauHa/hCwLrQANA4xQFvkYQQfSvkOCKcJECiSc5u4uvjW9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976414; c=relaxed/simple;
	bh=TFFfUvhxqaFd/gHshGEFwVzVNLWfQjKnfIqWkvKbeR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PFZH3ykAMTfKtXKqsRd50P0KiFy3JbktRs7eM1m5g28oQQgz04NLc7ksg6PQF8b+TKivlB+1YAX2+Y17/Wobdq6Pedo8zgNwhqw079BAVt6xGZvfUkIRrOqCjX7YtpOMTtzdCyHbkYM8caAWv9po87Gi3BUqJSkDqhnUWHrzTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lSCecDel; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lSCecDel"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5846NAg7001901;
	Thu, 4 Sep 2025 09:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=uYuPVU7lYcVijx2HbOhM3ji35lRz
	A7nkC0yf5H9kA+c=; b=lSCecDelzYx64ptOHQH9CfRY0pmDIp8o50hmY7PuiKox
	7iuCxt2J0QvbfCRkvj4vtzggjQXswQRvJA2hztNMu7Sy/GC2GoyOIP5SenVa99Ku
	76iXeemRcf/lgOVStp0hT1D/0zpb5bFxqQod9ACSLPX15B/LESGQMkx/6+JiXryj
	GebQVaWqGcdcs37xD1q9boy3IXj6lwcKNdd2pCn3n2zQ0cLznUAd6m54Jqfzo57q
	Q4MrzpyFD2lfJI7mXG6n+GQzeMry2WLZjXCExPgHQ5nF6Bw4pZCnrxsu/GhJWBHE
	RxhDcQvtCa9FYOs6e0tB7AKmUO58oVHAolBgveOQ2A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usua8p5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:00:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5848jK9e014145;
	Thu, 4 Sep 2025 09:00:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3kdfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:00:03 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584902q427591346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 09:00:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 947DD58051;
	Thu,  4 Sep 2025 09:00:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E0035805A;
	Thu,  4 Sep 2025 09:00:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 08:59:59 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 04 Sep 2025 10:59:49 +0200
Subject: [PATCH] iommu/s390: Make attach succeed when the device was
 surprise removed
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAARVuWgC/x3MQQrDIBAF0KuEWVewoov0KqXIMP4kszAWTUIg5
 O6VLt/mXdRQFY1ew0UVhzYta8fzMZAsvM4wmrrJWRfsaL3RkvMe2y4CpMjbxrLEilwOJDOJd8x
 BfPCJevGtmPT89+/Pff8AvUhMc24AAAA=
X-Change-ID: 20250904-iommu_succeed_attach_removed-fc42aa5c454d
To: Matthew Rosato <mjrosato@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4693;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=TFFfUvhxqaFd/gHshGEFwVzVNLWfQjKnfIqWkvKbeR8=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDJ2hvJvZ/zl9Lzws1LNuc/TTeZv/NkRyv3FqzuldlN/s
 uTyvvfNHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzES5CRYVHPTI2cWQ7zNzDe
 EJ4QEVhsY8Ph3/NfOCWj7d7O3oCfixj+O0seOCrWEb1UbmGtdNvUi7u3WBulHnUMkdVtue+rej6
 PDQA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rAYiH5mYImII8-LPi44ai9mGwCaOvHd_
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68b95514 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8
 a=VnNF1IyMAAAA:8 a=AK43WZpHVXGhaup9WPQA:9 a=QEXdDO2ut3YA:10
 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX/EGk2+i49h/v
 l6oC57Nd1f4rUCAjs21Tv+Ug/C4mJ3GRxnF043mF2xUjG4nTH/wNHJlvXx2eu4MUDd9u7K9N8wD
 SeR4ybKOfEtD+M6jYkKo22zgjuP6qTwB3FVEGtlJFedbeR01Fon1K0mM5YJreLMwIzIIyiChBu2
 S5HRy7YK+HyVKAFpeeTqHmGYRgLPPU/eqMvW8Vb+DtCFjHyFn2WuSZAOkmvUDtlAFq4SlkUi4s3
 M5fBvTr6MntEuyAPcHqMCqHEMb4VmgZh6f8cOk/8iPpFESDwBbVT249Rj5aTkRBXqDGF8K/Mj6J
 +yViBRfyCt7tPL8RBCHPg+zsER7RdV9aTDUc4TbWVA7M003YdE2XBKbEoeJPxeOoUOFCRXS1+BQ
 PsB+T1ji
X-Proofpoint-ORIG-GUID: rAYiH5mYImII8-LPi44ai9mGwCaOvHd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

When a PCI device is removed with surprise hotplug, there may still be
attempts to attach the device to the default domain as part of tear down
via (__iommu_release_dma_ownership()), or because the removal happens
during probe (__iommu_probe_device()). In both cases zpci_register_ioat()
fails with a cc value indicating that the device handle is invalid. This
is because the device is no longer part of the instance as far as the
hypervisor is concerned.

Currently this leads to an error return and s390_iommu_attach_device()
fails. This triggers the WARN_ON() in __iommu_group_set_domain_nofail()
because attaching to the default domain must never fail.

With the device fenced by the hypervisor no DMAs to or from memory are
possible and the IOMMU translations have no effect. Proceed as if the
registration was successful and let the hotplug event handling clean up
the device.

This is similar to how devices in the error state are handled since
commit 59bbf596791b ("iommu/s390: Make attach succeed even if the device
is in error state") except that for removal the domain will not be
registered later. This approach was also previously discussed at the
link.

Handle both cases, error state and removal, in a helper which checks if
the error needs to be propagated or ignored. Avoid magic number
condition codes by using the pre-existing, but never used, defines for
PCI load/store condition codes and rename them to reflect that they
apply to all PCI instructions.

Cc: stable@vger.kernel.org # v6.2
Link: https://lore.kernel.org/linux-iommu/20240808194155.GD1985367@ziepe.ca/
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/pci_insn.h | 10 +++++-----
 drivers/iommu/s390-iommu.c       | 26 +++++++++++++++++++-------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/pci_insn.h b/arch/s390/include/asm/pci_insn.h
index e5f57cfe1d458276a14a5c54409fba4c43962a3a..025c6dcbf893310b473423ab9f5a21b6eaf8c623 100644
--- a/arch/s390/include/asm/pci_insn.h
+++ b/arch/s390/include/asm/pci_insn.h
@@ -16,11 +16,11 @@
 #define ZPCI_PCI_ST_FUNC_NOT_AVAIL		40
 #define ZPCI_PCI_ST_ALREADY_IN_RQ_STATE		44
 
-/* Load/Store return codes */
-#define ZPCI_PCI_LS_OK				0
-#define ZPCI_PCI_LS_ERR				1
-#define ZPCI_PCI_LS_BUSY			2
-#define ZPCI_PCI_LS_INVAL_HANDLE		3
+/* PCI instruction condition codes */
+#define ZPCI_CC_OK				0
+#define ZPCI_CC_ERR				1
+#define ZPCI_CC_BUSY				2
+#define ZPCI_CC_INVAL_HANDLE			3
 
 /* Load/Store address space identifiers */
 #define ZPCI_PCIAS_MEMIO_0			0
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 9c80d61deb2c0bba4fae59129323cc90f998693d..f04de62288a8f0e9d640f9f2032f961c4135bc42 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -612,6 +612,23 @@ static u64 get_iota_region_flag(struct s390_domain *domain)
 	}
 }
 
+static bool reg_ioat_propagate_error(int cc, u8 status)
+{
+	/*
+	 * If the device is in the error state the reset routine
+	 * will register the IOAT of the newly set domain on re-enable
+	 */
+	if (cc == ZPCI_CC_ERR && status == ZPCI_PCI_ST_FUNC_NOT_AVAIL)
+		return false;
+	/*
+	 * If the device was removed treat registration as success
+	 * and let the subsequent error event trigger tear down.
+	 */
+	if (cc == ZPCI_CC_INVAL_HANDLE)
+		return false;
+	return cc != ZPCI_CC_OK;
+}
+
 static int s390_iommu_domain_reg_ioat(struct zpci_dev *zdev,
 				      struct iommu_domain *domain, u8 *status)
 {
@@ -696,7 +713,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 
 	/* If we fail now DMA remains blocked via blocking domain */
 	cc = s390_iommu_domain_reg_ioat(zdev, domain, &status);
-	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
+	if (reg_ioat_propagate_error(cc, status))
 		return -EIO;
 	zdev->dma_table = s390_domain->dma_table;
 	zdev_s390_domain_update(zdev, domain);
@@ -1123,12 +1140,7 @@ static int s390_attach_dev_identity(struct iommu_domain *domain,
 
 	/* If we fail now DMA remains blocked via blocking domain */
 	cc = s390_iommu_domain_reg_ioat(zdev, domain, &status);
-
-	/*
-	 * If the device is undergoing error recovery the reset code
-	 * will re-establish the new domain.
-	 */
-	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
+	if (reg_ioat_propagate_error(cc, status))
 		return -EIO;
 
 	zdev_s390_domain_update(zdev, domain);

---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250904-iommu_succeed_attach_removed-fc42aa5c454d

Best regards,
-- 
Niklas Schnelle

