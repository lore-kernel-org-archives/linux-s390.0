Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F53B0595;
	Fri,  9 Oct 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526660; cv=none; b=hdcjj8ZeEsLL1S53phRGRv3mhLeZWn+JEvyk8NAs72j+pmBK3u8b8lQqJZnQn62Uq6F+DAdvqA4VV35Pv2Np3QQZSuADsRk2sSw8S2MHXLncZvv/oX3Zy7dGb2mzOJceGReZbQ/d88i7ngqtUnCMpht5cBSYp5V6KcKKajUDc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526660; c=relaxed/simple;
	bh=fOOnZeTgzBtYI0Sf3JBv+yhYhqmdePIskaLCACgSydI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t//x838E09PFfRJ0cGq4+lS2qHv+WGXXZ4uI2SmsXTvN0BtXo/8QON1Yuek6g2C2NXFxpg+Uo/so2Vq9k6IGCZ3AfSsSDqUbFLkqmOJ1Bu5S8ZIG1FaehofxTJSsjmdXvl1L6muITDPDWPfp26hvVyfGu7HPE9eix1Qm7c5s+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gefy2Aor; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gefy2Aor"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZPxT3169854;
	Fri, 9 Oct 2026 06:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=wScE9FHRW4mDS2qeFuqW2FdDzmTj
	FI8/2agmmr5U/lY=; b=gefy2AorRdAl6mz8DoW01aufIQgczo8Hvlil+vRHizOM
	n+iWyegRDx0+xxUUO/9QTBSDXsuxKl1P0WIkTUiMfHb74Cfn3RPgclx3AgXKk+TL
	YJDQ8LS8OlPMA7bnmHyIgXWSYz8PaUzuJSGzMd+HD2Tx5pSXgqeq5X5/O1IPD6g5
	lB9AEPvb5bIC68Urrr9DN7pCdzc0SgGYvwQdyTSvEtvN2Rn18ovDxlxNTXe7DJd3
	suJVdsgiUyzK+wcSL7fb/4FV1HOJmA6HiVmNqVZ+wFk2e1pcxibHIqYCBdCrZwod
	O3KaV0Xa91OT2lZ9V5lB/Tnv1KTY7NfNr5tWv1y6lg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvgt5h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993WTIU249701;
	Fri, 9 Oct 2026 06:17:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34yfh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HWjh31916732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A501E20040;
	Fri,  9 Oct 2026 06:17:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49B4020049;
	Fri,  9 Oct 2026 06:17:32 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:32 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v3 0/8] s390/pci: Fix bugs in IRQ domain migration and
 resource cleanup
Date: Fri, 09 Oct 2026 08:15:47 +0200
Message-Id: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBAF4KuQri3pH7S48h7GEEqLTCJFW20wh
 LtbSHRhwvK9yftmRsF6sAEdsxl5GyHA6FLghwy1feOuFoNJGTHCSqKowoFXpAb/qM04NODqDiY
 bcGOk0Jxy0RYUpe3d2+2QpudLyj2E5+jf25tI1/YrVjtipJhgxcquY1KXtpKnG7jXlIMe8nYc0
 KpG9pMoIcWexJJkRKEVE0qKlvxLy7J8AMxb5q8IAQAA
X-Change-ID: 20260818-s390_irq_domain_fixes-ad74b3134c51
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1pVxqMkj8w68RTc47lG02Idcx24g40hP
X-Proofpoint-ORIG-GUID: 1pVxqMkj8w68RTc47lG02Idcx24g40hP
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac88701 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YyLuS3IB_UvxabcRwncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX7U5f+zVhC3ix
 hInVhWwb/3Q3A3RqXBkuhbDS8/vUEYrrOzMuqb8yFkWVTZ5ULvsNUH5Cio03sOS8WaFvhTmTg6j
 AQ4fM7xT61V92TrBKSOcFw4PoRBKQjc+NfzPxM0flFL9Bk1lfVmniiht1PWPOQ8KpmRy+XlUm0S
 A2xYDq9VLzHU0VP2HiRrpJ6tBExbit7ayMaUTzUdwlh0HHlxJ8BiBsZRHEPavSmZKO7Q9EDhr//
 mXVXJgtWNKXrBJ5p178gHrkJGd9SGCQBSknwYy4F5pFc4MJ1Qr3IJeuJSpj2YPYO8aOe4y1WRSO
 kRAplkp/w9X/jDEYs1PA6HZNAHPWPsNF7dH+IV4e3YwrNWm7yIJDasB6XvOcBx1Cco3oambBzpn
 +McpSJL7EMgfrD8HN+OEkwe1VU6sZ4Sfugl5VGu6gs2tR9Y0B35VSB+Omijw/zmknK/96G68PBD
 +EQLPKiapvDXnluXdHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfXxGQoY6L2EbvB
 feovinRO0el7BBb3p7c9Kd8fTN/JcsCweJnt6LQMsq+Aw8WxHhnI2KO1YDxg7hM84X9StP+bG8a
 lkSMa0rSA9Ty7vrfx8HZqsCOQVjy3QY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024

Commit f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ
domain API") introduced several bugs in error handling and cleanup
paths. This series fixes these issues:

1. Double-free and NULL dereference in the parent MSI domain cleanup
2. Leak of a zpci_sbv summary bit when AIBV creation fails
3. Directed-mode teardown freeing zdev->max_msi bits instead of the
   zdev->msi_nr_irqs bits that were allocated
4. Use-after-free race between floating IRQ delivery and teardown

Patch 5 is unrelated to the migration. zpci_directed_irq_init() has
leaked its allocations on the -ENOMEM paths since it was added in
e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts").

Patch 6 is a cleanup that removes an unnecessary update of
zpci_msi_parent_ops from the per-bus domain creation path.

Patch 7 is a cleanup that drops the unused index argument of
zpci_msi_clear_airq(). The doubled index it removes never selected a
wrong entry, so it is not a fix.

Patch 8 is a cleanup that unregisters the adapter interrupt first in
zpci_irq_exit().

Patches 1 to 5 carry Cc: stable. Patches 6 to 8 do not; none of them
changes behaviour.

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
Changes in v3:
- Reverted ordering change in zpci_msi_teardown_floating() (patch 4)
- Patch 5: move zpci_set_irq_ctrl() after allocations in
  zpci_directed_irq_init()
- Patch 5: add Cc: stable
- Added patch 8 which changes teardown ordering in zpci_irq_exit()
- Link to v2: https://lore.kernel.org/r/20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com

Changes in v2:
- Capitalize the word after the "s390/pci:" prefix on all subjects
- Replace the "add NULL check in zpci_msi_clear_airq()" patch with a
  cleanup that drops the unused index argument, and move it to the end
  of the series
- Patch 4: clear zpci_ibv[] before the grace period, free the summary
  bit after it, publish with rcu_assign_pointer()
- Patch 5: correct the Fixes: tag, drop Cc: stable
- Link to v1: https://lore.kernel.org/r/20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com

---
Tobias Schumacher (8):
      s390/pci: Fix double-free and NULL deref in zpci MSI domain cleanup
      s390/pci: Fix resource leak in zpci MSI setup
      s390/pci: Fix MSI directed-mode teardown IRQ bit count
      s390/pci: Fix use-after-free race in zpci floating interrupt cleanup
      s390/pci: Add error cleanup in zpci_directed_irq_init()
      s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init time
      s390/pci: Drop the unused index argument of zpci_msi_clear_airq()
      s390/pci: Unregister the adapter interrupt first in zpci_irq_exit()

 arch/s390/pci/pci_irq.c | 109 +++++++++++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 42 deletions(-)
---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20260818-s390_irq_domain_fixes-ad74b3134c51

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

