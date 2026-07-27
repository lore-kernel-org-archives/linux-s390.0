Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA88379C38;
	Mon, 27 Jul 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162545; cv=none; b=t0hBovSuKY3/LUT47XWSuROyYypp5s70mab6EiFuX+KkByxC4dskzsSim4JSHSGHmtYGLs4EIHr1ajaBWHXxX6shTV1zH6tEXLR3XtP60l0UaIP07BSGIH919pDJkhiO3jrpRW0M9fSWg4kUSeagJwMNG0poo3uUFUX7mto1r60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162545; c=relaxed/simple;
	bh=cVjnb/Y8Ltjur5yYsLDHDxbYDnzbQ/DC319R6+E3saU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S336UzvZiAEodKdFEwkzJI7627yYgkpda5yAfHF+ZmI4qtUN8tSfCPC92ceMFyp7V/LicnaxxSSv1xmPtRCUv6wxYkpfHW9vx9N/oT6g258z5tVZ6iQSW8cyb7UPgK4+80yQfQtFUCYOQlIxFYM8Bv0pX/zeRfoCS0meW3ASLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EPIUd380; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EPIUd380"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnS342292084;
	Mon, 27 Jul 2026 14:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fJNREU
	dZC43/6SSO/j/Ll1ziL5xBV3Vdm0Nb1jZRwVw=; b=EPIUd380fMZraAe2bqhzG3
	Ww7VksbTujZo8hERXbQEum4BcgH48HRzYVNjdJerjt8fETBm98U9pe9oUhDFZkOX
	v1BAJPGzpm0I8gAaTL5xH1t3nNnHJPAJ+5RiFFBp4BNzUVdmId5uUe4q6lD7IKLQ
	4cgboudq/xpoUXRJeBE1Qi6mN+0nOaLZv2nEx1VLuz7WlT8IeGyNPE+VofRCLpQ2
	ljv+fTgvoNqvPk7WGoY9EFO/O9HHt7L65j9D8YlgqxfFVSm1VQVcLdqRZgs3BXjh
	JcBcrH3XzFbuOicX1IjfKMIZfr32DUcGUW/7ypToHphBXH6764ilbuq1bf3zY8yQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ng1ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:28:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REQVSA027927;
	Mon, 27 Jul 2026 14:28:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwr1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:28:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RESnOE50331968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:28:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B8D200C9;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AEB32010E;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/3] s390/dasd: Fix potential NULL pointer dereference
Date: Mon, 27 Jul 2026 16:28:39 +0200
Message-ID: <20260727142840.567286-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727142840.567286-1-sth@linux.ibm.com>
References: <20260727142840.567286-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX+95Mjt/6CTUm
 wFQpxM2MjmqWIWz3UHM3FdwWB9wIKcNyCu9CjOWTy46kDKYpSeeNjMho43WbtkSFc0XSQ3+Gn8P
 zkAwxMSsDpfgVp47S6il1mDwfS6D1Rw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX4AVvszK3t2Bb
 29hUS+cn2mWpW8ayWA5+YC4ZccaluU2bYfL1oOwb3PpFPTOql06vIYM3ceX/QE1MjEkdPHu29XK
 t2u1BCSazhAsu/L7SiP3JtcDxTc8qUeS7dabvNMf3QZjz14wfYbYRytqGhC2zcpXVcDps+skW38
 vhJqWiWfc2sbbfFGO3iU1yEOWdIzqfNxfVNrM4mhaoei2eWb4dfLreuZp5MZLgTVvRwg9zc4C9n
 Gi05cZ4/P+aY8vrJQcbENtk45JYUB/lJWdMcwtOAdBTV5Asz8GfaJPGFIo91Qd/sTznsgWMkc67
 EtsyzgnGa92MVXkp4sdUaKXnpNyAXM4hSE7zHgqopiCZHpsKM8wGZ35JmwFEdsKI2nexfAGRB7k
 +HoO3p+1ByvMV9F0ZN3GpJW2K3Xco6tAZWXtGjXOqQoQoaI+vDDjiefwI4McPfowQcFNSqGZHv8
 dXEBBkPg6q/LTW0nUJQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a676b28 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=CqgNFV-6TgflcM0HuHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TxIARoBAb0FvKf-IzAgZYXIMjftlp3bV
X-Proofpoint-ORIG-GUID: TxIARoBAb0FvKf-IzAgZYXIMjftlp3bV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

From: Jan Höppner <hoeppner@linux.ibm.com>

dasd_release_space() checks the implementation of the is_ese()
discipline function before calling it to determine if a given device is
an ESE DASD.

The current usage of the logical AND operator will lead to a NULL
pointer dereference as the function is called even if the function
pointer is NULL.

Fix this by using the logical OR operator.

Fixes: 91dc4a197569 ("s390/dasd: Add new ioctl to release space")
Cc: stable@vger.kernel.org # v5.3+
Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Eduard Shishkin <edward6@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index c85ee42732a3..e5b8b413f5ab 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -324,7 +324,7 @@ static int dasd_ioctl_check_format(struct block_device *bdev, void __user *argp)
 static int dasd_release_space(struct dasd_device *device,
 			      struct format_data_t *rdata)
 {
-	if (!device->discipline->is_ese && !device->discipline->is_ese(device))
+	if (!device->discipline->is_ese || !device->discipline->is_ese(device))
 		return -ENOTSUPP;
 	if (!device->discipline->release_space)
 		return -ENOTSUPP;
-- 
2.53.0

