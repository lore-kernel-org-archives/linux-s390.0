Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80D206261;
	Mon, 16 Dec 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367935; cv=none; b=BopSDKblhRHMUNdKkzkG/7QJbWNNBAjzNhz+pyHWos0AN8xAUVoMMfeRzSwOh0e8LMqYQgTZpQkkPkn8wTCydso6F8SsJWlTLBpB0KX5UxYtJA/jxZE25LLv/CFcXuzELBEx8be90zhkSeB6gn9/VbJFlW+I0v1eTUH2isgOq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367935; c=relaxed/simple;
	bh=hQJh06npzFZQuNN/PchXcArER1Wj6OUszuaLkyZFTeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfmuf1JQ2U+ls5EtY9z1GIF9Igvm7EbQyCkVI+Nw1YhkZ47T5kROPzuO8IvQf9ocTfV6LoOjqySzVZbhLZY2NMjtcFuXx8xWs04+7ZwG8D3Zou0DT0HGtqTOd8cPln6ZGyukYXQb3P2xnI7CVlWhGgB307LX2PAYLAy9Erhu6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kuEF7d+j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kuEF7d+j"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGFI1OJ011975;
	Mon, 16 Dec 2024 16:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wFc0sC
	e4Q4o5YSv/KTFMGIlY5wASucyUHTBeVufP2Tg=; b=kuEF7d+jps6tvCm+3rEvHK
	kwWdQorZ1dk6avAm2DoM3SC4d5VFdG/Xy1iMWIaRSqwyjuM+G/09HVoV5WLbZYev
	+vUqPaAUyFzMcX7lYh+CLomrqavbJoRBy6sTTNX3tGiPBkbSFV7JyccuokncdmIY
	MU3u3/a1+3c1G9xyl1FNG+fg2cLTplQhd8OfKf9Hlk8wXbUx3xYjmIymjswAbL5Q
	Osu7LxmgK0Xr7NqiX9w/R2VVxrBO7xna0+7FgLm/hDL4cSc2CISiqKTD4eOSkIGZ
	U9Ppk1evT6LJZqh+npqyCQwgZH3JLBRVZxgGbxut28k3ABYJdqyymX6tJB6SQGXg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb3k7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:52:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCsQok029338;
	Mon, 16 Dec 2024 16:52:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsf0ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:52:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGGq0c313828648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 16:52:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A607E58053;
	Mon, 16 Dec 2024 16:52:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3958658043;
	Mon, 16 Dec 2024 16:51:59 +0000 (GMT)
Received: from [9.61.117.46] (unknown [9.61.117.46])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 16:51:59 +0000 (GMT)
Message-ID: <ddebeba2-e32c-4c00-8107-4f4e3850c477@linux.ibm.com>
Date: Mon, 16 Dec 2024 11:51:58 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] s390/pci: store DMA offset in bus_dma_region
To: Niklas Schnelle <schnelle@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20241213224941.571060-1-mjrosato@linux.ibm.com>
 <20241213224941.571060-3-mjrosato@linux.ibm.com>
 <1a1c9b992a9a957e200d55b0a1330a0c3d75baa0.camel@linux.ibm.com>
 <d2d6c27d12a5d7770952a9c027d290204c4fac6d.camel@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <d2d6c27d12a5d7770952a9c027d290204c4fac6d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1tfxrZ2Zr4OaY_uVG5jy5pHR5KAjetBZ
X-Proofpoint-GUID: 1tfxrZ2Zr4OaY_uVG5jy5pHR5KAjetBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=773 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160137


>>> +	map->cpu_start = 0;
>>> +	map->dma_start = PAGE_ALIGN(zdev->start_dma);
>>> +	map->size = (u64)virt_to_phys(high_memory);
>>
>> I don't think we should restrict the size here to the size of memory.
>> Instead I think it should be zdev->end_dma - zdev->start_dma.
>>
>> Since we handle the restriction to memory size as reserved regions I
>> think that should be compatible. Also I think otherwise this might
>> break the admittedly odd s390_iommu_aperture=X kernel parameter on
>> LPARs.
> 
> Correction, zdev->end_dma - zdev->start_dma + 1 because zdev->end_dma
> is inclusive ;-)
> 

Forgot about that parameter, thanks...  OK, will change to:

map->size = zdev->end_dma - zdev->start_dma + 1;
