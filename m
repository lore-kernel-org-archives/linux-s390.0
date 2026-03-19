Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B63009E8;
	Thu, 19 Mar 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935002; cv=none; b=RoIhzcfEppWAFE8Eee4bVimkqzOezHPoFjwT2phFFRzDu24ZE5kj0UfMKdJy8IW9Lq/wVZkRkJ7AeylZMPd+Ax2vPrfwho1LqYxE5WqCIHYk1MUam5byntplSqii01gpABlidQ2B3jjRKLtlDJf0num8fm7xYEN0Jyy9xC+qnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935002; c=relaxed/simple;
	bh=YolwoJQQQPvtaLpYi8RxHxHoI0GR3Yq32egjhaaQW7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tmqAEvpC1hih8Uyqd1+jI4YhosiRoTvVdIWsg1l12Pe0k0nDD8h3IT+sz+4Z7TtAowAaBc4ljqBelKGPFssed3DzmNmhAC7hQob4Azj8fTzWm75s9Jt4qqdc76LjU7OZiTFC25B91VLkxsA0cdFZFHZNFA4slU0iePh0XqWkOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IvGz+JLc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IvGz+JLc"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J2svIp1188663;
	Thu, 19 Mar 2026 15:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9b86gA
	ukwF5Rg9g0PXAcQzbydIoHca8C0xGqHYPfCig=; b=IvGz+JLc4c3eYllLvshNA5
	Cqo06QQlsS4LpYTpku0nFGLXL7TgpLwIfaMrUZxVgbhYwaZxGkeoYicEOgKmpr5l
	uvTP8rBx4k5HXEXbc5ZsA9/7eXOdVB7CygB7TUOfzzvCV9EDyUl2J5BIBNYLsEM4
	L8uCzgBdSiyhqHcDZraFaIxg1+MflXhucR8ro24ka5CsOqWnq1IB2/ZbDnGxQ0zm
	9MnmI0/15GR3+ra0ZHFhcgj90L+a7M4alaTpJXHYavNhdte1U6FrRNTS+U0xVGkA
	zmErpgR2cYI14PB5LFildX3cQW3yBbL+KHN7Sjmp5joVj/UM1qNB0xf67D1b4WfQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfsxrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:43:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDfmAe013996;
	Thu, 19 Mar 2026 15:43:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcyb48r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:43:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JFhBwR51577138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:43:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 696FF20040;
	Thu, 19 Mar 2026 15:43:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 200692004B;
	Thu, 19 Mar 2026 15:43:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 15:43:11 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Thu, 19 Mar 2026 16:42:56 +0100
Subject: [PATCH v6 3/3] MAINTAINERS: add VFIO ISM PCI DRIVER section
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vfio_pci_ism-v6-3-c6bab675bc0a@linux.ibm.com>
References: <20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com>
In-Reply-To: <20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com>
To: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
        oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        julianr@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TKzQC5ba0CK1TwB3XoZMs4ioNylHsLJh
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bc1994 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=jBZh5NATpTL4zB9YInYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyMCBTYWx0ZWRfXwnaVNciWratp
 mAUBvag6RJXIf4lWvuxbOHEk2rCoO4+h/g2ptvOv3gfeW9d6fr/o3gGzrJfmIIUcS7T4Ln4TsCn
 7gxUmyyn/JH8EoybwObTPqNv1LZuFU2dB7rKW/Vqa6xRxH/0yJw5ux4aVDYJ1DPv7mgqnYBuI3i
 3EozU4PYn8HG9tEVSpfXyIJlely+uDRvUTdMbQEiMOzPP1hhIPqGr/wlrtdFDKpyZslmSX8/EVa
 yemQYC1t8QbUnDmK6liT+kqBT9kmJw8Uy1V4SFGPPAO/lfWrLORfGBrUnzX5D3iPzTS+pXpZrlQ
 M4VWgHVMRRIa5Z2ZFMyKQCFXNE41bp1P6X7Hv0tSgEKYebcFrGnq8xgF/APMCj+XIaz2hWJC0kq
 OZh6BnzFbxX5zxUiTUKVn7/pJqr6BDq1hkK2zwxfIF2vusss5L5v+NX5AXvwCSZaqTccKVz8q8O
 rjZ+/etns6IUaGXshEg==
X-Proofpoint-GUID: TKzQC5ba0CK1TwB3XoZMs4ioNylHsLJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190120

ism_vfio_pci is a new kernel component that allows
to use the ISM device from userspace. Add myself
as a maintainer.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7241695df968f1f62f463f1cc01b2d3201e91ee..9d07dc0ae2547bb97f6ac05163f423c0b5b86ea7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27702,6 +27702,12 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/pci/hisilicon/
 
+VFIO ISM PCI DRIVER
+M:	Julian Ruess <julianr@linux.ibm.com>
+L:	kvm@vger.kernel.org
+S:	Maintained
+F:	drivers/vfio/pci/ism/
+
 VFIO MEDIATED DEVICE DRIVERS
 M:	Kirti Wankhede <kwankhede@nvidia.com>
 L:	kvm@vger.kernel.org

-- 
2.51.0

