Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881F23ED4A;
	Tue, 10 Dec 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865820; cv=none; b=RM1Jv1W+5TaVJEIp6k3lenCM0rHVydECWgqRCIrTNE9c4MqqNYaw7JYGIT8fUuEyG9Gv3LiZZCfFkJ3t5I5uaM4ScjpdXRSnzDiwUfKRynaU4vSlygdYdvZDnu6h4DmVmNTqvpStBULECeKgb9HVu0KCJshWuxVKeTv3gLPuVmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865820; c=relaxed/simple;
	bh=AaAnJXDaNh1UdifToINIA75qFsf6izHr+hxh9++XNaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzAT/uAa8Sc1J9XITRWMjovT7n4kRenfdDpfKI+/7YHzDHMsqwWlXBFt6OVngxMPbcGgKhp/4KMBChZjK6oyYqvvh01s0B6z81qlgM8OvW++qFyjcRgjXm/K13V0gTFNPAAcSFsfXY025PAqOxKLUak+fxZID6oVOk/irjwZu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sfCAt0SE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sfCAt0SE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADrZwt025894;
	Tue, 10 Dec 2024 21:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FS0BzB
	Y5JK83fBq/MJbLezK8fLmBkNi+UguterYuiMY=; b=sfCAt0SE7F8RKscUGfNUCs
	6ooUZi/g4W5oCY8iOkngu0qzR8PbKorEZkeOcWzFEiw2qxWKmPWEKPqE9HN+hCly
	GnftiMxcioiPrte3aWaUpbgVB6VJprUAHf+Y0D1OurS7oPl3EhNgV99Nusn43Uy6
	V4dCiLWrkk1XXNGwu3POrRxIZBOzHeNJsOjEtshF9Ygsv5m9R/C+4CTWRPP9ugu/
	E3qjVEtMOAhZZ7h0O+Q41El9sTi9o2A7XpGurYOFyoTN8+NpjhQ8DhvHlw4Rdl5i
	8DPt285C1FrZmuSanOx8cG2l+MmIAAJ2rXxDLwyEfBdptBfnhmnF2IAYe4Ng+q4w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq8tnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 21:23:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJOaAo032589;
	Tue, 10 Dec 2024 21:23:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn5kwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 21:23:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BALNMi036962666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 21:23:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D22A95804B;
	Tue, 10 Dec 2024 21:23:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3973F58055;
	Tue, 10 Dec 2024 21:23:21 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 21:23:21 +0000 (GMT)
Message-ID: <49deb7fa-a0a5-4ace-b3cc-1d07e0d273b4@linux.ibm.com>
Date: Tue, 10 Dec 2024 16:23:20 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] s390: enable ARCH_HAS_PHYS_TO_DMA
To: Christoph Hellwig <hch@infradead.org>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
 <20241209192403.107090-3-mjrosato@linux.ibm.com>
 <Z1fEj_6beeRdGpJL@infradead.org>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <Z1fEj_6beeRdGpJL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yhnDXqh8mc7otoZXfW6WMDPFm7kLwqb9
X-Proofpoint-GUID: yhnDXqh8mc7otoZXfW6WMDPFm7kLwqb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=622 adultscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100152

On 12/9/24 11:33 PM, Christoph Hellwig wrote:
> On Mon, Dec 09, 2024 at 02:23:59PM -0500, Matthew Rosato wrote:
>> PCI devices on s390 have a DMA offset that is reported via CLP.  In
>> preparation for allowing identity domains, enable ARCH_HAS_PHYS_TO_DMA
>> for s390 and get the dma offset for all PCI devices from the reported
>> CLP value.
> 
> Nothing new should select ARCH_HAS_PHYS_TO_DMA, please fill out the
> bus_dma_region attached to the device instead.
> 

OK, thanks for the pointer.  I think I've got it converted, will test some more and include this change in next version.

