Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777B35C1B2;
	Wed,  5 Aug 2026 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922037; cv=none; b=vFLA5Woa8zdIR1NUHP0y+2NUqZLw/tlIx0L/lIlqRPeaVfukKX/dKYFE8/IaRusVy2d/lsimMALemMPfI5hzi0kVM9GNGG1cD03tr7/2bnHTuXTtaoAjnneoNjAyY8JkQosH4dPbT6BjdBuoRdyM9dYTRDqnF6A6L51YMkHJsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922037; c=relaxed/simple;
	bh=uGZ1+scDyaJ7kI90Xm2VJfLZefitNmNrExFErK6t4lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BUWvYbGktc+oLr28tAoYsTNzsDWbrnpJLFvl02y9Ib6rTev9EaC0R+m3IQbOT2wLQYKXlR90jrHc3W71cCZruR8tKPHmI0iXcZI9gXInAADqo4Hb5OY+TBJZN/6z6XsWH/giWzbDenv6XZ5faaT0zggw6wmUSwj2Dn7+mBfzj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xkr5dpwP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xkr5dpwP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758mPsl3356162;
	Wed, 5 Aug 2026 09:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=75JMQJjBC0DEvpAcurjbQjP7y8TI
	n5Qa+grTyGg3d2Y=; b=Xkr5dpwPpLT1a+c1jYjOpaI0QCVsQh8m776jT9qI2maf
	JnW6UsDjcMiP2HT6Lo773POEixQT66lTYUTTf1N31XOiNh9rny+o+Fb3ulk9eeFK
	3rh9nICgJpZXD52bZjrZ5iMnNz9cPhETiR4eNPZbJKb2J6Dq1OAz71dd+qTnWuqI
	5d6y6aEbC/83wPjma27JJR9z0os5Vt6yuB8wBOjUz0FaId50vV1x53h15kAfLMOm
	hvhiSKXjRkXzsqdQkZ7m24TuF7Un+Wuz/Kl/y3myPd0PwIKSldmFckDQivdXtNYX
	E4bdfu4D8Cl7RN3PwHDQQhUE4Ja/4IQM4xp28yqEBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42av1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:27:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759QJt3014524;
	Wed, 5 Aug 2026 09:27:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qp22h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:27:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6759QZWd5964430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 09:26:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A0D05805A;
	Wed,  5 Aug 2026 09:27:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A78058054;
	Wed,  5 Aug 2026 09:27:09 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 09:27:09 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 05 Aug 2026 11:27:04 +0200
Subject: [PATCH] s390/sclp: Fix leak of uninitialized kernel data in SCLP
 report
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-fix_pci_sclp_length_check-v1-1-d125cb415bc3@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL7nWBPsqtEiG1bLoWJRgTR3ZM+B
 2bmgUiBKUKfPRDo4siHS1DkGaA1biXBc2IoZdnKTlZi4Vt7ZB1x93ont55WoyXchDFtV6tmKpS
 SkHofKMn/exjf9wPjPqf8awAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=uGZ1+scDyaJ7kI90Xm2VJfLZefitNmNrExFErK6t4lg=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLKKGd+UMFd3/xayl5lxpzf3zf/mixoL3fp/r72mVzLl0
 49ZPX9aOkpZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZjIggxGhm2JbEWPG9fbWO2S
 t2fOcVSrsd99oPaOp+e/tzN/vtJ3V2b4n9x9NnVOz8H/H3ZelHW6Geb7IijsWlff9TOxU+/+lb0
 UzQUA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7301f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=l9c0U5Zvg_bttrZYlokA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 61ziWenff3aGomyYxultzv49bOO5J_3e
X-Proofpoint-GUID: 61ziWenff3aGomyYxultzv49bOO5J_3e
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3MyBTYWx0ZWRfXz9pLj9GvJO2S
 lJxx+kikEES66NFoXfH1xDJCu/lJjuvHyNi/WiWOXfpSoBmGTC98y7E0lJNRxuXMfpSueDgbe0M
 M2qWuDLTy3SyV0BfG1JRldPp5Nw3KOM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3MyBTYWx0ZWRfX3PWBLpjUWZla
 iD1klq5uACKPxeZAzw02MSHZy0jdATh/TIMiiqD/JuWgRzoxO1+RAkyumG8iHegdHSxHfXmf39M
 fol2FPf8H7xKVTKPGW5pf8M85Qjpm8jORJ4H6jPEeqx1KYR3uB7TL1zMpXNPl3fqRXWjNUh98VS
 zU9zzHbFMiVr4XANrtYY7wPqgD9X5Yqkx96SEI79aRqTS78kl8uGO2dsog7KAl9nP/u7VHf4zYs
 9/amHCOH7h2NKDRQjYbjyiVSVqneTQorUWmpEH/a0A1wof7phq46rkrMo+xrImILOrMmk82AMaQ
 PkNuMZi8VL4ft79X/AeNrUYHJFUhCxLeDK/dx72BuQ08muBFfFM+qvKz2RhZe9pUuCNG10Cb/Nm
 JaPyNfGvyJuoi0dxkULffGXQ6iC5fO9511b2Qzn0tcy/o41ee8pAbe5WBk5XZ66kkvzbD4zN5oK
 dQ43fdUd8DJAG5uSGjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050073

While report_error_write() checks that the provided buffer is at least
as large as the header struct, it does not currently check that the
buffer is large enough to contain the report with the length claimed by
report->length. If user-space provides a short buffer, i.e. a larger
report->length than the actually written payload, unininitialized kernel
data from the page allocated in kernfs_fop_write_iter() will leak into
the SCLP report.

As the entity processing the SCLP is privileged and able to access at
least the page including the report, this does not actually leak data
that it would not already be able to access. Still, the sysfs write is
malformed so reject it as invalid.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
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

