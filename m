Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0F47DFAF;
	Mon,  5 Oct 2026 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201812; cv=none; b=m76KBhghvTkS627EIb0hlV05GcPiI9OSSp5oTG7vyt6xeDkLXX2Ed07FBUUu19M8go04grHyOT8VCH1wqMybB58x1gFzH5tAdpi2xn1POiK8009GOWu6ZP3/rHabT1h516zi9vjLZKaPNovqAPx6iPnkVIhNGQwACKDBdA1NTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201812; c=relaxed/simple;
	bh=JuZe0K5AwOWhuySQW59n+2VqNygN+Dvqh15OINXtXhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u1h8hY1r1wUCfSCkCKtvbNjEgjYxS3TQv/R/bRySGr+gU08xSOXDLAbJukfajfid42J7257qMb24sB9SphuXrKS79ZPpu9q3i83sCvVgs5J2hfB+6z6jNgI86ZTPYlbcdKct2+JyIclBMytOhIV9NKcDHtJMoEkETReFkjQ/cBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XdWlxm2B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XdWlxm2B"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZoNr379248;
	Mon, 5 Oct 2026 12:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=knnFkckO1VBZ9a8/dyKnCESsuoX/
	rJ55WxEATA5ov2g=; b=XdWlxm2BbFjDml2wOAtyTiz4uz1Rb63oTL98i/qvFF8P
	Yll1mTksyMAnPU1bcW0vjIPnbXIVA/xFunaHNDyQhrIbnaSh/0zHOg2V/6IPyjPZ
	nWgneAOOAy/CNIMMyypj4PmeVd+BLSjhnn7AieQvpkOvYEtIMrRMy5T9WJIGLdwN
	7+jS8Df02Lh4329KL/eO5FOeq64zaPav8ur/0uBGV0ymCN9K/2k3wEPnDNeMRtBg
	K79TKlkTy9SFlp3mRXl0tqoP94trICAmKbN8kzHSz0fxTKhUTLcEO3AB249OYZK9
	bh7B0wNBc/TPP5FIImjqv7Djo5Im0WGMtcsTg9tJiQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jhpqs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWUAc2850548;
	Mon, 5 Oct 2026 12:03:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pngf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695C3O5W42402284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 12:03:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 897AE2005A;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 576D320040;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v2 0/7] s390/pci: Fix bugs in IRQ domain migration and
 resource cleanup
Date: Mon, 05 Oct 2026 14:03:15 +0200
Message-Id: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNywrCMBREf6XctSl51D5c+R9SQh+39oJNNNFQK
 fl3Y8GlyzPDmdnAoyP0cMo2cBjIkzUJ5CGDYe7MFRmNiUFyWfJa1MyrhmtyDz3apSOjJ1rRs26
 sil4JVQxHAcm9O9yLpF7axDP5p3Xv/SaIb/pbbP4sBsE4q2U5TbLqS2yq843Ma82pX/LBLtDGG
 D+ncvi7vgAAAA==
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
X-Proofpoint-ORIG-GUID: VgBM6nvfXNL46vUJnzfA83ijTvQkgBGo
X-Proofpoint-GUID: VgBM6nvfXNL46vUJnzfA83ijTvQkgBGo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX/ej7KPv0lpsk
 26QtZ8/ys4bEiOoLTIa4g6U76+6yBD015UwLgpkK+97dQjDYoHwGXCOYFoD2CQLK+1CLLILhyfP
 NzRoEtMz8yAeljZwO3Fvf772SuI/JhI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX7cNCPl6GE8gE
 CJpid7KDqzYlOhAC6SbWm4I5vYOSWmWPl7+k+8L9lQaD2F7k2oWOKychOsnvybHY/vpUitvAI2n
 fgML5VXaL4n2/RK3Cpb300iIT9tw99U0PGAbfdB9/bjx/Uo4wvNXrvrTJuoIsWj9ccFzPKGspjj
 4e1xRCUBHvFKF1QYwoSU5yA3T85OadKVFu4+6E5N6Jld++wx8q06mwpwSCGlLZXtFuxMY/F/Ldw
 fclJIT4DKXOqGRUzSWE6Of9wEe3/A3C/FDkzZI/sDBwdvmBkH5YLNXdDL/EC5Algn2boneRbUze
 DSDHNUsV8v3vJdSRgb0nQb3h79TlgRluuYmONPcLN0lnTn3qwDYh1+pb6DjnEgiCNUv+7O7dM5Y
 c+LSF/bA7SaLtbP8sytVC7LMiOPj99zE2ux2KyIfVWtwtIk46hx5rS5oOJXf82uAfyxp/9NN7UP
 30MkV+DuyNC58aVq8Ww==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac39211 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gYRR6b9B0uOEYiCMvfwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050045

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

Patches 1 to 4 carry Cc: stable. Patches 5 to 7 do not: patch 5 only
affects a boot-time allocation failure, and patches 6 and 7 change no
behaviour.

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
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
Tobias Schumacher (7):
      s390/pci: Fix double-free and NULL deref in zpci MSI domain cleanup
      s390/pci: Fix resource leak in zpci MSI setup
      s390/pci: Fix MSI directed-mode teardown IRQ bit count
      s390/pci: Fix use-after-free race in zpci floating interrupt cleanup
      s390/pci: Add error cleanup in zpci_directed_irq_init
      s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init time
      s390/pci: Drop the unused index argument of zpci_msi_clear_airq()

 arch/s390/pci/pci_irq.c | 99 +++++++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 37 deletions(-)
---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20260818-s390_irq_domain_fixes-ad74b3134c51

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

