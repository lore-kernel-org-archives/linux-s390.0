Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B773211476;
	Thu, 12 Dec 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015972; cv=none; b=V714bVAHBuzyWvX+S85YbMB2OUMUptQGsl6yQrGWYmwC8D+zsEsYwuIAwo/SMKiLA/qFUiDaTErUtqK33+pwKBdvszerRWk2L+qT6S7b0nb4BWdCf+AcN7TOw9I+t5YUP3r5eeA5MltqCabmYEnDHsBFC1QbqL/Z67RKnFltfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015972; c=relaxed/simple;
	bh=OcB66Q420Ubip3QtsEjUK9jZPSQRj4+xByUQv4HKQrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToVypapXDG223JDCwpExz+LTDqDiZq/XRD7slFMsvcfFEgLwAGiTo/I2P8w8xw0L6KR5+s4xqKlVqfuN6fkOyhJ9kALmD2myHe1E8UmHiuqZBh4FqSUAvALicHbsZJusy6ayFmtQLbleTRNzgiNVQI0ZBSqcctbaTRH9IwOQh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A+/cQo00; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A+/cQo00"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCEv8Uh005493;
	Thu, 12 Dec 2024 15:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A3wFlE
	PsdZzBUkWZ/nTr4CdKM+UAzPoBfwV1B9uNa6U=; b=A+/cQo00vkfox+8iNsOh/7
	53x08x8HuG35+VpOrAnGS7M0I34Ww8Oozv39ww7tqD/3Icac/YzWgPDwT2qPfjly
	6ybDoPi0fojabGFKsehb+kDSRVBdVe4XMMO1k5S92cwcbv/Fuob0id3ym8jk5wUj
	6YCBsnk/x+YYDtc8FMX1yX0/KESjRUkC16f7DOoBLJ+31rkO8UypboXyZdvXZyGD
	T5lEcNh8oOacI/LqgQg9k+wATLkg97566BJDMcByIglTWvkfJQSX+4TRodp+vHEe
	07BB+ppDwlUlyryPyZ6V2vGbjHeErq1lWRNaQzSfvAh5dy38Nui/ULL4MDjKSuEQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqm3xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:06:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCD26be016919;
	Thu, 12 Dec 2024 15:06:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yh9b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:06:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCF63R335521222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 15:06:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3391C20043;
	Thu, 12 Dec 2024 15:06:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A20D20040;
	Thu, 12 Dec 2024 15:06:02 +0000 (GMT)
Received: from [9.179.9.164] (unknown [9.179.9.164])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 15:06:02 +0000 (GMT)
Message-ID: <7a1c036c-05db-4770-ace3-9cff1cb7c12d@linux.ibm.com>
Date: Thu, 12 Dec 2024 16:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390/crypto/cpacf: Constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
 <20241211-sysfs-const-bin_attr-s390-v1-1-be01f66bfcf7@weissschuh.net>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-1-be01f66bfcf7@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lMhQAL7SGzKOdOaA-LTiOGBh4uNYFCYU
X-Proofpoint-GUID: lMhQAL7SGzKOdOaA-LTiOGBh4uNYFCYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=686 adultscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120108

On 11/12/2024 18:54, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

