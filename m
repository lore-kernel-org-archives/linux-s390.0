Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267833BBB6;
	Wed, 26 Nov 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173205; cv=none; b=ldcOpn+Nm05+jUch2eY1LeeG8sANouVawcSDpK6BezIRXMIbGqnlrKURWY+vHORV3lL33QTj5pmoHnd12AGMenOyeHSorT1mdzpkKE7SYcRfWZQlNHXILgbdpjNJ2n3PpbGq82ZF6Kovfgm4cVEGk8DseRZpm7MhrAaKs9hTbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173205; c=relaxed/simple;
	bh=cv3+QZrNjaxOpQzg2OWhMwasUuzYONUcvBB0nRuLk1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Upe44H+13p35Z8LH9LRbL1JNk1rgE/AkBE+fAQ8Y2GUEGueHt/Vli3PVjcFXwE7w1GyrjF3WoGBD/J7bNtdpR792rGLSeGbVwkmE2448iASQNv1k/C2zvXFa9yNJZjsxAaR1O/PsetSGGDjdoP4yb/dRwYA/RLTxaVL72kUEm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jmrs1s5a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jmrs1s5a"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQBG823030902;
	Wed, 26 Nov 2025 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rY7GX09e21CJhGMojkK3XcsYQYin
	CsiKonOEQd9NWjQ=; b=jmrs1s5ahU8MOezAWea61Gznu8ufpIlzVp0VkTW+PWzX
	smAfHUv8ouvpKAHsZVQg1U8ftb6ru310DMzBM2quJe2ZRuURkXYjtBBruysPNauB
	aow8i2itP+YtLXFhUNrRHxxIp3mhTJrFdMN/BBtpFUMwFM+rttDkweDu5emWCGi9
	HVa+im2mX4k40D7ypeU8yszM1WBeRDFBmbmiRU0xHAxCkVZ6lbHUNRT9rY6WjWn/
	f0MMhV46zPP4gnwWgZ+1PAhY36kOSPGXDdCehf7xbyppGgO05905+BICLHfMW1Nv
	DEXSCmC+EQW7Y4gxLdcx3jY19fLews/ui1rKMW8CDA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pj59jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQDgZo5000831;
	Wed, 26 Nov 2025 16:06:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvy3kdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQG6YgK49480090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 16:06:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF4B52004B;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FF0120040;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 76A7EE03F5; Wed, 26 Nov 2025 17:06:34 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/4] s390/dasd: Minor cleanups and copy-pair swap fix
Date: Wed, 26 Nov 2025 17:06:30 +0100
Message-ID: <20251126160634.3446919-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX00pr9vj/gp9u
 Rf1DledgKU/6zNeKoy5FS/CfXxIixkwGH0ZHK3i2ZzhOxGAPi1shdHMyGiqBb/sDDpNGpgS3qBW
 0Iy+XkzaJC1HYhcbjpYOHWF1DeYj/2XgYZSb7XGkyTK3JMq5D6UAA8jP9zVHCCQW/vIFdUM2hRy
 CAN68GCsataX+0W3WQtDVzc9jVzdZx+1ZZ7ggjVx4+XBcxS9qrLNkzTYv6A+qk2Hv+kMwrM0lwJ
 lp10qohgDytoD1ygCMNVU/piAzqMnpGJKq5utZkeisPkg9zDZYAJo3JkJyv35fcsePuqGj66GFU
 bLkBJWPE9HQ75c5oosYUGDvs952yOW5VrwrxWw87XBjJaH6TuFljZpNNQnv/RyW2jyl8CN+PFNG
 YDwuPYN0RXcI0eyqceqOKANEF96tow==
X-Proofpoint-ORIG-GUID: KhpUmKg4Ht3hyiERVem0A0Cn8n4070us
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69272592 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-2OJmj1gXcpsmolrumkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KhpUmKg4Ht3hyiERVem0A0Cn8n4070us
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

Hi Jens,

this small series contains cleanups in the DASD driver
(string formatting, naming helper refactoring, debugfs simplification)
as well as a fix for the gendisk parent after a copy-pair swap.

Please apply. 

Thanks,
Stefan

Jan Höppner (2):
  s390/dasd: Move device name formatting into separate function
  s390/dasd: Use scnprintf() instead of sprintf()

Stefan Haberland (2):
  s390/dasd: Fix gendisk parent after copy pair swap
  s390/dasd: Remove unnecessary debugfs_create() return checks

 drivers/s390/block/dasd.c        | 64 ++++---------------------
 drivers/s390/block/dasd_devmap.c |  3 +-
 drivers/s390/block/dasd_eckd.c   |  8 ++++
 drivers/s390/block/dasd_genhd.c  | 80 +++++++++++++++++++++-----------
 4 files changed, 72 insertions(+), 83 deletions(-)

-- 
2.51.0

