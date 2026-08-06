Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5DA30C156;
	Thu,  6 Aug 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009429; cv=none; b=fC64+6wzSYRT5tImquAKQZm0DVp2FvjCyNOgMDtR/9dq9Ocy858Mj8v0ZLaSqFdoCAwE3NUFDBm8QLCsVXCeZ2X9xWyT8n/MFUHOQL8MaN/ttxbSNznsYOuxUe6O7jsC6is2SvoND3mw7GkLI5tGtbbpex7LVKH/JPesF/5/RKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009429; c=relaxed/simple;
	bh=KWWLzRGWw8aZTytCO7Ny8bs1gi0t6dm66b4i1nLA7x8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gs1P8EioaVYmriQPPKBm9gOn0mUgbXE5ciVGpkxeJXTQnGv2s4lM+AZQNugO74u7Uzr67Kluwo7bISOCWh0VDxJzCOU3VsKvNcY9HTxtUwuvWvGClyg5Y8MczO4gcBGH6izQ2lkgurRU2bOy3HqWDm6Mk2wXE78D756+ZJ2lOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mv6eNNGQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mv6eNNGQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NnPa63406438;
	Thu, 6 Aug 2026 09:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=i5TtNb0qftMTMAyj0XM00UgUkDYb
	rShRdCVHc88V2LU=; b=Mv6eNNGQeBoNI+aWm3mHKbzRZJxjSbAQop4WBXow0pJ4
	vM8opIuEEs10Dbn/IpTi8UjBkofzwnlucnqlo6aqy5UvNt0mrp6UqvYirdjvCUo9
	8q5Gh5Q6GT5NBRqhI/YXii7lMGSDflKacX+zqphZZVzWYnQ+/PlMkLh2kUPmr0Af
	EG2VuDWXjMs7N8UvjAl9u6Wk0Q4rECYgLW6G0hwqFJhaB2DaalGXeiUMhY37ImC/
	HeBkM0Oy9rYzHcGIrB/pE0AhiTT3LcuCzpTfM1Kn944/UJKsADVeJ4fkBvu7sq8O
	xr1oRJpHoGvGfcSlTua4byJRwA9rj0KiRi4l0wNTMA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqycbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 09:43:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6769fQMa009622;
	Thu, 6 Aug 2026 09:43:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kameu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 09:43:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6769hixu28901974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 09:43:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C17E858065;
	Thu,  6 Aug 2026 09:43:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 235FB58056;
	Thu,  6 Aug 2026 09:43:42 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 09:43:41 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 06 Aug 2026 11:43:39 +0200
Subject: [PATCH v2] s390/pci: Fix leak of uninitialized kernel data in SCLP
 report
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-fix_pci_sclp_length_check-v2-1-9ee9428e659f@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6DIBREr2JYFwMoRrvqPRpD5EvlpwoGrLEx3
 r3UpNsu32TmzU6iCWgiuWY7CWbFiN4lEJeMgO3cYCj2iYlgomI1K+gDNzUDqgjjrEbjhsUqsAa
 etOuqumyk5k3DSNrPwaTy6b63iS3GxYf3ebXyb/qzyj/WlVNOey4k6JJLDcVtRPfactRTDn4i7
 XEcH8hzOwfGAAAA
X-Change-ID: 20260803-fix_pci_sclp_length_check-aa68495b1990
To: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=KWWLzRGWw8aZTytCO7Ny8bs1gi0t6dm66b4i1nLA7x8=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJKwn05+CUZZhbzSeh7TVWSX3FS4d5SEambGqsEuy98Z
 n5R+zq8o4SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgImcVWH4Z58kUD/lcdp6eYH4
 fA59Xevjtqv5Lhae9j0qULfx1x/OxQzfPaouqfAVlFrvF5SSOXjPcsWVFMbtybtZjz56MuFedhY
 3AA==
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m_XBeCM2azXLnpcCcqy_zR5TJQFNqDo-
X-Proofpoint-ORIG-GUID: m_XBeCM2azXLnpcCcqy_zR5TJQFNqDo-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3MiBTYWx0ZWRfX0hlG9WL8NIQQ
 wlebwqOB4jJveblhrw1oKIS+eIhlcm2jj1GGcEPnxjPOL7eRY3+ZhoITkSPXjw58w+uf+CzgM5p
 yQPW0fT84m0Nzl6s8FV/lkmDtWuB6Zk=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a745753 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8vt4sfDAluiG_NO8xQMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3MiBTYWx0ZWRfXwntMmITie93V
 F/E5BD64/nq+BTJ2hcdOsWvUmxuI0AOu4PWbVJGw/leoWlk/5UWgPMtBEASKZWk6HA1VltLlOh/
 4MAOJJlTgEZ/hZVT0YQMiIVcjHH4rCfS90shjKwec8QfSOlZL/vLrHv5LBufjtzbJmqhoQueDHC
 U4xV+ULU684RgKwHWIdvjV8negX2hg+B5WRvLCr4AiF/7kVfBkj81Nt57ldGxoUzzhZAK2212g4
 v++pOkIqdGnDLSCTLJVkXE6TtkmY0extvtCE7cT6rh9iGLLO9ecHK2t+uc0Eop8yVxcKFTDiALO
 wkhNZp0RXiYnpmfkxmeMAqbBpVlmQKhOjVDHUN4qeKzS7B/3xpcFX6Hzb2UO4wPwFLc77h3/ofi
 7hs+6fZpQt7oqwMHu1s7xMur2U6cC2jIfBucWGZSYcXG42U2j7VxTlruXNF/vtPp4qVrLKudqTC
 N8/eb16ZEDjptHPgO7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060072

While report_error_write() checks that the provided buffer is at least
as large as the header struct, but not that it is large enough to
contain the report with the length claimed by report->length. If
user-space provides a short buffer, meaning a larger report->length than
the actually written payload, up to around 4K of kernel data from past
the kmalloc(len + 1) sized buffer allocated in kernfs_fop_write_iter()
will leak into the SCLP report.

However, as the entity processing the SCLP is privileged and able to
access at least the page including the report, this does not leak data
that entity could not access but it is still an out of bounds read and
a malformed error report that should be rejected.

Fixes: 368704a65be8 ("s390/pci: add report_error attribute")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v2:
- Changed subsystem prefix to s390/pci
- Added Fixes tag and Cc stable
- Improved commit message
- Link to v1: https://lore.kernel.org/r/20260805-fix_pci_sclp_length_check-v1-1-d125cb415bc3@linux.ibm.com
---
 arch/s390/pci/pci_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index d98d97df792a..bbb76113a4d0 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -153,6 +153,9 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
 	if (off || (count < sizeof(*report)))
 		return -EINVAL;
 
+	if (count < (report->length + sizeof(*report)))
+		return -EINVAL;
+
 	ret = sclp_pci_report(report, zdev->fh, zdev->fid);
 
 	return ret ? ret : count;

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260803-fix_pci_sclp_length_check-aa68495b1990

Best regards,
-- 
Niklas Schnelle

