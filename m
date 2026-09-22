Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7F55C324;
	Tue, 22 Sep 2026 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096082; cv=none; b=e6nhfbv4zuVHq4bFqi8GrMDsX24wyG631pVkvvXza67APKCF2VwKrMdbtwUXJHix5cuUKhwnlcN/pyeGl3TM7ztqwd1HOg65JAh9hfRsG15tF6Pw6pMrxx23fRUmYgvOP8wP1IR03Fe6aaIQaD+M7qvW9hHf+wXOtxZSnxVIZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096082; c=relaxed/simple;
	bh=MvTUjjcJ+wzgwN061c9UIGIEsmHQchPQbXG2ZlZJPMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBJcGbyhuTcnk/a8Y7FW20DDYjztR6k3HfpBqR1tBfnA8lU46EJr5dXzEL/m3oJSEgjU2YD/ueYV0WEZa7NFG8a7L9fkQKJ4uTnCiiCdSHftjuw+9uMLDq/JbglqPMVDZjigw3/ihzdfCM+OiM6xxdQeSDLFp6h6aea3W1/QVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZaV5bDF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZaV5bDF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MF5MQ7752126;
	Tue, 22 Sep 2026 16:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RHhdT7
	TfofmqZJ+W6Cs0TiKWVV4My8Cbhj1Lz18Va2Q=; b=QZaV5bDFGAiJgE44C1drIc
	liiNpXEiyzvXKxCBS+1xwoZUN1nN0rmnkm+8IsMtsBJrjqE6LlvlCHgDk66fj6/+
	WGV6x6wpUOL3TqsGRvMKu/hauYyT4JYepEfPWN0khoQ2JmyXJNAH88shn1+DBPF6
	mpVoQfSgJ5TJ10j5gh1seyYjfx/E12UY1bXb9f5HTMfQIei4FKv83WZp3smZCXIH
	vY/hxsptcjU4k4AkYnpaGmEn65ESqr+6cfXZeadr5CaAWULvH+4S9X4bY+o25ROh
	PLs2ZZ1Jq3Vh/xYtLt7EEmYRdmNL9Wmi+2bnj9w9Ua5+UbXZBEEKbZpvkgN2pW3Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs6yy1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 16:54:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEm3FB1738239;
	Tue, 22 Sep 2026 16:54:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkd7uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 16:54:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MGsZ1i36176344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 16:54:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBAC420040;
	Tue, 22 Sep 2026 16:54:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F0B520043;
	Tue, 22 Sep 2026 16:54:35 +0000 (GMT)
Received: from [9.111.77.23] (unknown [9.111.77.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 16:54:35 +0000 (GMT)
Message-ID: <e9d6ba2e-3751-480b-83ce-3c6854cbcd4b@linux.ibm.com>
Date: Tue, 22 Sep 2026 18:54:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] s390/vfio-ap: Fix leaks of pinned NIB and
 registered GISC
To: Anthony Krowiak <akrowiak@linux.ibm.com>, sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-2-akrowiak@linux.ibm.com>
 <20260904225127.A201D1F00A3E@smtp.kernel.org>
 <a0a5fbf4-829f-42bc-98f1-a8ee022b6c4b@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <a0a5fbf4-829f-42bc-98f1-a8ee022b6c4b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2b2d0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mOUY6zfcnlmDl48CfG8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -CqmjneKNy4jRxLXDjoPjHnIVYFyIKar
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0MiBTYWx0ZWRfXw35bN6OYqMU8
 PoNYbLAVeiSNrqqeXPNpJqzaPdhJcon8Tv+CtTwMcMzFxnODE69iDodUmPhu9x9w3IpY5yNOAuU
 4UeO2ko9946C5TpQzIXsIHHr0DNfJDz144LSu6IcnVtZe5zA0G2tnCdY5TzQ02P0oFupev5j6uS
 PH7uhWzGZQl8US4UgT6ifiQFYkBFK/sl4tBBAyuMfhRnx1pYy0B7qIhP0FdZmpujQe7lUyTEHt7
 TylE3aTnvHFP73fKf90SABIcG168uoav1pBHutB1UZM8IIJQC5ShPkxJvXz/6RmSbwFgAQGFkOQ
 7RwnTCGgbjEfnK/iRoF3aAlfUIJgioL0iMLBP726ZWEy3kji1eovufk8or3qRKYyNtLe3iKseXh
 aqxVahtL2VjVLnYMyim1jJcahvmSebUWT1DXaPdbQb2Fi0Ca6TxBGqYypV4/BNuOxz1xwXTyA96
 iqEm4FZhGn/TsoC7gFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0MiBTYWx0ZWRfX/QM9rqEYkYgP
 2KEWKVXm/71miaybY1AXlaVmaoNr0ms0C7QD/8FCr3/RonkkGdwg983lg2uilLd3+kaeaAFulbO
 0/yUxsQB2nYE8Lf5pDQHudIKjbHQoC0=
X-Proofpoint-GUID: -CqmjneKNy4jRxLXDjoPjHnIVYFyIKar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220242



Am 22.09.26 um 16:29 schrieb Anthony Krowiak:
> 
> 
> On 9/4/26 6:51 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Critical] Eagerly freeing AQIC resources when ap_zapq() or ap_tapq() returns an unrecognized response allows wild DMA writes to freed host memory.
>> -- 
>>
>> commit 6c73d9ea4d311d5d68e8f5501374842cccbe2c90
>> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>>
>> s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
>>
>> Several code paths in the vfio_ap driver failed to free the AQIC
>> resources — the pinned guest NIB page and the registered guest ISC
>> used to enable interrupts for a queue — when a queue became unavailable
>> or when unexpected response codes were returned. This could cause memory
>> exhaustion and depletion of KVM interrupt subclass registrations over time
>> with repeated dynamic AP reconfiguration.
>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 940c0ff668bee..9d4f5b9e3301f 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> [ ... ]
>>> @@ -1959,8 +2087,16 @@ static void apq_reset_check(struct work_struct *reset_work)
>>>           elapsed += AP_RESET_INTERVAL;
>>>           status = ap_tapq(q->apqn, NULL);
>>>           ret = apq_status_check(q->apqn, &status);
>>> -        if (ret == -EIO)
>>> +        if (ret == -EIO) {
>>> +            /*
>>> +             * TAPQ returned an invalid response code. This
>>> +             * indicates a hardware or firmware bug; the queue
>>> +             * cannot generate AP interrupts or DMA-write to the
>>> +             * NIB, so free the AQIC resources rather than leak them.
>>> +             */
>>> +            vfio_ap_free_aqic_resources(q);
>>>               return;
>>> +        }
>> [Severity: Critical]
>> If apq_status_check() returns -EIO due to an unrecognized TAPQ response,
>> is it safe to eagerly free the AQIC resources?
>>
>> If the hardware is in an unknown state (due to a bug or unrecognized code),
>> could it still be actively DMA-writing to the pinned Notification Indicator
>> Byte (NIB) page?
>>
>> If vfio_ap_free_aqic_resources() unpins the page and returns it to the
>> system allocator, could a subsequent wild DMA write from the malfunctioning
>> AP queue corrupt memory belonging to a new owner, potentially causing a host
>> panic?
> 
> Since we don't know the state of the queue, the AQIC resources should be
> intentionally leaked here lest the NIB page be re-allocated to another
> process potentially resulting in a wild DMA-write.

Yes, we should not free the ressources and rather leak them to avoid reuse.
