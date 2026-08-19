Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCD3FC5D3;
	Wed, 19 Aug 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133530; cv=none; b=uF/wLKhWjZmxRk5eLZRJCCoimL1vkd577VmnzNgLNBxpgHDS6WECQQLNcV20RGAy7JLtk5UkT/4eO5HjmbP6jr90l6lqkOkYIAMsAIRRVVJq4p8Jg/PZ4VAqzOLYjLdXOMVLSO7tB6Cx17LOKaoQx4v6KyoXShEv86OpftC2YKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133530; c=relaxed/simple;
	bh=ERZTnU54LzlAI9nZDrF86r10H42MBP3dg5JeVytzpIk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YqVLmdODf9Sy6hRctB7tNtMhcBPBqthF2n2pRMHsp5dmyeGzKM0fSg4ogrWSBmOSI3inet4nZqm+uOT1se8/JPDUKfxNfurU4j8lmvylt0myJTZiFn/+Gp0btuB7Z1kHRqlAuEk5W68Ky31sCe4jUt6qfIbamcXpg5ifzSWBUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KoGkCToY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KoGkCToY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6VxX32667017;
	Wed, 19 Aug 2026 09:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=QLmP/5WXc78KxActiQBDb5D2EOk6
	rbKKRl5rN4Y7Cdo=; b=KoGkCToYkhvSTcn9JVyfAH9cDeMK6ZKQzoS3VeDrw+AE
	YhyefZCVUlmLTblORuNhWMX+qT1PlfupjO67dsMI4Km6J00sQKsaZTSi0URvZr7h
	6tcaYDOoBEZslw6Jx1+QymugtLpGubtOxpF+Df0vOXVIxwXMhDcPnQHqEfGXQ8hR
	/Uh+ngWE6LThD0HxRqqNnUZpAh77BPAwlOsvOdmUfo86u3o7oy6IpIH6rCMu03jB
	mx+x4/2rZR7kw1EaQErnHIp57boTqsf661HyYKUhY/UMk+SQUgp7n103SxskiUq2
	eOBFPs9T8OiC3QP8ioxmrB0IYK4yRKcGLepv5lME2g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ax4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 09:58:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9uKJl003720;
	Wed, 19 Aug 2026 09:58:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq8ecu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 09:58:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9wfkY51773740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:58:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 529B358055;
	Wed, 19 Aug 2026 09:58:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A078758059;
	Wed, 19 Aug 2026 09:58:38 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:58:38 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 0/2] s390/pci: Fix missing pci_dev_put() in
 zpci_report_status()
Date: Wed, 19 Aug 2026 11:58:29 +0200
Message-Id: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNyw6CMBBFf4V0bUmnSkFX/ochDY9BJgIlLRCU8
 O8W4sqVLs9N7jkLc2gJHbsEC7M4kSPTeZCHgBV11t2RU+mZSSGVSCDmFc361RekLfbGDtoN2TA
 63Zc46QazB4ccBBRQoZDAvKa36D974pZ6rskNxj734gTb+od8Ag5c5XkWq1geyzNcG+rGOaS8D
 QvTbr2PLPlRFsUqkqI6lUIlX7J0Xdc3YChLvCEBAAA=
X-Change-ID: 20260817-fix_zpci_report_status_pdev_leak-1b101c1fe021
To: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=ERZTnU54LzlAI9nZDrF86r10H42MBP3dg5JeVytzpIk=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJa63xO1e/8sbE42GOd0dqFDC//74pQUXdtf/Dtt1b3e
 benH1/u7ShlYRDjYpAVU2RZ1OXst65giumeoP4OmDmsTCBDGLg4BWAiD6cwMkyXjNGL7Tw8WcK1
 +VrRqaAHs1JnmbY+vu58r60m80JykiUjw4rQmfvkjvfK+xULRRdsMHV0UlxYoeA1f+9vydcmbMt
 W8AEA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a857e54 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SUgNEMsb-NkE169ZmlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bqFHzSXVHVodPH4yZCJv7A5SdOiCyREZ
X-Proofpoint-GUID: bqFHzSXVHVodPH4yZCJv7A5SdOiCyREZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX+BidR4IgQL36
 acJZXLLNwVy3PuqXmkgsqVSm54DP3TRAPS20aP+VHUsHMKQlA80o2RtTCtjYwsICVsDw4Xxm9BF
 BI+A6h7t9jjaN6x+xiGcjz2IoLvNKBg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfXw3OWK33McMrT
 Ps+QEwDtrUDO6DNgHRRjfQivg8nVs47d1l+JgCqtrmqdEK+MiyNnzRHWsmMYfB5qeTavEUztnck
 eXQ9M/0Qc9AqGYIUqD8Q1HZy7EIIx2AN8Tr6WeMqoh9Bs1sjcCMV7QPHBPr8OyZuTELCvVmU6og
 21c3O4VZW9NXemxQ4Qy5KGZoW6OWO4WnbKPrW0nIhJ680AKJnGm52S1H4x0k33/q/AJfl0UaAPX
 bmJqtnLWj33CkVGqdSNRwqs0FNYEslCFR5Q0lahVjRjUrYcnXnp4ZiLiD+sPZUcmtGUB61dNp8+
 MNtmS4p4KkUxufiMOWARywMquCSEK2FhD5fHNd2OhmhX/cEyIf2wpRePenBOTavjswEV7T2tWV6
 VBNTumJ6f4TFmqQDySysCToddygcyOLsYJf7o+KLX6E0esj4OZqo52CbkIZWyGR6qlz5GNjuhaX
 uYj4JciWDpwgZzW8KWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190072

Hi All,

This series fixes two issues found in zpci_report_status() by
LLM review. A missing pci_dev_put() which could prevent proper removal
on hot unplug and a too short device lock critical section.

Thanks,
Niklas

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v2:
- Added a second fix to address Sashiko's finding of having
  to hold the device lock during the call to zpci_report_status()
- Add R-bs from Matthew and Farhan
- Link to v1: https://lore.kernel.org/r/20260818-fix_zpci_report_status_pdev_leak-v1-1-576520f4d068@linux.ibm.com

---
Niklas Schnelle (2):
      s390/pci: Fix missing pci_dev_put() in zpci_report_status()
      s390/pci: Extend device lock to cover zpci_report_status()

 arch/s390/pci/pci_event.c  | 2 +-
 arch/s390/pci/pci_report.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260817-fix_zpci_report_status_pdev_leak-1b101c1fe021

Best regards,
-- 
Niklas Schnelle

