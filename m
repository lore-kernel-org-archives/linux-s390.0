Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5C198842;
	Mon,  9 Dec 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772441; cv=none; b=cCX/xFTl3uK+Wvr3Jt5z2wvAeJnxbwzy8bDsJeJp/ZjGe04A3upUZn/oMxevwrXmFM8c7zOm7A5QRvcFklVyr5vuiAH6pievInPQNHDQjD1tliZLVGBw62PMHX5+vffxjXT6Tdv9tdCrl0tZv/gdoGi6H69WIBDlxfYljE7AmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772441; c=relaxed/simple;
	bh=/BsNHbrcv3s4s2IAEhYs3v2rp07nACpzmzRlhe0t3ZE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C9UrcZsmiq1ii7VZZocxdMKtv3TzjjIjUk8UHbnU5oaC3GLGsQEnD4JcECblXphMABDt2rI2QekGUAIpVN9A1IEqBM7aJNZ9Mlg/wMDTX0N584koCF+OCBUp9jDU+ocamlNVajFVLQzM+0itF5qUgJeukdVHlhrHmTwEDTv9JXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s2NC1M45; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s2NC1M45"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9D7sci028575;
	Mon, 9 Dec 2024 19:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ph6TEC
	816Gb0LbNU4lHBaeB9vPEyNrpX3fhUwRJiDwY=; b=s2NC1M45aZc8tBwzT6AhVE
	HD1S0z76KKD4pmXZrMPaZb7+Xpw2xlgyFdsiVel3z5Bif9FRTiSvwkdcl1ODmDFA
	K/FYpw07J056CYdaeqyGe1d8LrhsOCnX2geK4xmo/K6ILjiOYorz/wQaPkv9u1Oi
	bhYmInp7R2VzEvuhGEAa2RVYZhTtKYx5NsK/gsu1Q9ylkLuK92KSx7PZYVdtki/d
	jf4iHJ3b2Mjn6Va8gyn44vTjztO4c1XOzXtxcX32SFsPGNGf7+kA06Mirz8vh1zu
	1qXmo9vMh14CbaSnA/WZSNcVVr+YzyKfQdWEm/qpjLwh6dL7Mm1DhxUkY1mtA+Zg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjab96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:27:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HlDYa032760;
	Mon, 9 Dec 2024 19:27:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps8a0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:27:08 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JR6fO61341954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:27:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5DC45804B;
	Mon,  9 Dec 2024 19:27:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4545058055;
	Mon,  9 Dec 2024 19:27:05 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:27:05 +0000 (GMT)
Message-ID: <ed43d5bb-313f-477b-b453-375c9721cafb@linux.ibm.com>
Date: Mon, 9 Dec 2024 14:27:04 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] iommu/s390: support additional table regions
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20241209192549.107226-1-mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241209192549.107226-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V5TMX_n6sUGWN6X9taIZ_7qtmtBO552f
X-Proofpoint-ORIG-GUID: V5TMX_n6sUGWN6X9taIZ_7qtmtBO552f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=906
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090147

On 12/9/24 2:25 PM, Matthew Rosato wrote:
> The series extends the maximum table size allowed by s390-iommu by
> increasing the number of table regions supported.  It also adds logic to
> construct the table use the minimum number of regions based upon aperture
> calculation.
> 
> Matthew Rosato (7):
>   iommu/s390: add initial fields to track table size
>   s390/pci: set appropriate IOTA region type
>   iommu/s390: add basic routines for region 1st and 2nd tables
>   iommu/s390: support cleanup of additional table regions
>   iommu/s390: support iova_to_phys for additional table regions
>   iommu/s390: support map/unmap for additional table regions
>   iommu/s390: allow larger region tables
> 
>  arch/s390/include/asm/pci.h     |   2 +
>  arch/s390/include/asm/pci_dma.h |   3 +
>  arch/s390/pci/pci.c             |  17 +-
>  drivers/iommu/s390-iommu.c      | 289 +++++++++++++++++++++++++++++---
>  4 files changed, 285 insertions(+), 26 deletions(-)
> 

One note:  this series and 'iommu/s390: add support for IOMMU passthrough' have a minor merge conflict but are otherwise independent.  If anyone would care to test with both series simultaneously here is the conflict resolution of merging this series on top of 'iommu/s390: add support for IOMMU passthrough':

diff --cc arch/s390/pci/pci.c
index 758b23331754,9f7adf913729..291a3ee4d059
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@@ -130,10 -146,7 +145,10 @@@ int zpci_register_ioat(struct zpci_dev 
                fib.pal = limit + (1 << 12);
        else
                fib.pal = limit;
 -      fib.iota = iota | zpci_get_iota_region_flag(zdev);
 +      if (iota == 0)
 +              fib.iota = iota;
 +      else
-               fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
++              fib.iota = iota | zpci_get_iota_region_flag(zdev);
        fib.gd = zdev->gisa;
        cc = zpci_mod_fc(req, &fib, status);
        if (cc)
