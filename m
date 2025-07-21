Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C557BA27;
	Mon, 21 Jul 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085870; cv=none; b=DijMuWHjCvhWEZni0n5BvEnRLVt1nAmbq0w1hHFlXxjNkPzzi/Lc+f/2I2cJmiZE6i+2Lr3nb4kvSoESHM+Wl02bAIpSMes0uYPcy9AdLTRR2biU/OqBugZDxGbAsyaOBp6wdZ/j+8a0suZC1uuNdZfHFtVGHf7DMPWHpgDVNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085870; c=relaxed/simple;
	bh=a804sze2eSEvabyJeJGTtXcPhavwSfNkfdmAlQPR0Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4eq7fx93PXZJAb3REWdPOqHB1d5ekR2kRbQ3gh8lT90JL6MF9oQUOTnktgrWE91K/EUVm0bWnGb7Y3BNOA4934S6FhK+ivylQs1gPk4xVMONspN4MiB/HAe3DEqj0JnIkOSjcDmK46+KPyhm45jqJz7BShaPqeqWuUfrdIUKAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YksZrAQE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YksZrAQE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L65xmV008027;
	Mon, 21 Jul 2025 08:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q48Npr
	QEGhXIinQIM8N4K8V2AgpIZDRX3PPG5pO3Pvo=; b=YksZrAQEih0AHdlyxeLnyd
	9R90OVLAABpbKDYrAf5WHtplHDz2Hytq9j+MgYGJjgKFyhMM6OHck3jxzihl4d6I
	l0KLdfiZ7aPDZBr5b4kFlilux7pqWu80tA2/lDmIIfxgacwBO8zLofYPYBcFd+6x
	wyZIFP/JzdVgFrjSweGasEsoZi3H2+TnbT5ACWNS6MUI/YB3VrpH5ODG4ezkGoWS
	0xj7wfMS72pCTyMbBcY2RgQRFHTnEHui7nIvfjR+XpHcck5TKKaFht5zh0UsGsLy
	n8ttbdLRUqA+IICVFT/Ecb/BMlcIYqKw+KRjzQ/YYI3SXvVJiLkYtlCtwyrWJVVQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfqduf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 08:17:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56L8GXpA012126;
	Mon, 21 Jul 2025 08:17:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfqdub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 08:17:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56L8HRlu004046;
	Mon, 21 Jul 2025 08:17:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvqmcs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 08:17:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56L8HVEc51970406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 08:17:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F6AD20049;
	Mon, 21 Jul 2025 08:17:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D57F20040;
	Mon, 21 Jul 2025 08:17:31 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 08:17:31 +0000 (GMT)
Message-ID: <af7298f5-08a0-4492-834d-a348144c909e@linux.ibm.com>
Date: Mon, 21 Jul 2025 10:17:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] s390/ism: fix concurrency management in ism_cmd()
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aliaksei Makarau <Aliaksei.Makarau@ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>
References: <20250720211110.1962169-1-pasic@linux.ibm.com>
 <6b09d374-528a-4a6d-a6c6-2be840e8a52b-agordeev@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <6b09d374-528a-4a6d-a6c6-2be840e8a52b-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA3MCBTYWx0ZWRfX+kuysjCkc8TG
 hlNBHlxFXDAuDK+SfkI5wlIJMTfa5jIaC0BW6P/yZY0ZzF+eAcnZXlMC8yEXbL379Vk2/sl8IQW
 ZNp+ezIPSg/XMpBY1gRUmrFegA45M/93rXjuxfzRDkltNX2zYqt1mkp6XGq0UoXjBk+GZ0EhV1d
 Jcsm01Xl7azHh1JK2xwS08TeKCt6W9AVE844NV5ama8Ds+/7bQ+FQ74iedpQinHJn66d2xTAQeU
 AGcR7tMCK/i2BcAvG0vNUYNt4JDWaCFnzS58EkTGETeAG3k6tg5Cpat9Rajo59mH8B2H5VrTWET
 x2mNlX5fd+CL93f8H6NHDSXqIumvFKw8LWW12ZapIo8/it+1tFQGOhJxjQrFXMo4to4hyflptJK
 gnnHVegopkEB6wNNS2Sj3lgzXrAto6v3RyOdLHCw1m94Q+Uo8a+XE6BlmM8mDh1kQJgVbZWE
X-Proofpoint-GUID: Fr7qEZE_Y6tNPL_DsKWroJAaamlfoA4n
X-Proofpoint-ORIG-GUID: IbThzE3dxjrHS0PyoWR5wMWtAnF-ownJ
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687df7a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=n0eagUHsWyY7jrG6XxkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=658 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210070



On 21.07.25 09:30, Alexander Gordeev wrote:
> On Sun, Jul 20, 2025 at 11:11:09PM +0200, Halil Pasic wrote:
> 
> Hi Halil,
> 
> ...
>> @@ -129,7 +129,9 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
>>  {
>>  	struct ism_req_hdr *req = cmd;
>>  	struct ism_resp_hdr *resp = cmd;
>> +	unsigned long flags;
>>  
>> +	spin_lock_irqsave(&ism->cmd_lock, flags);
> 
> I only found smcd_handle_irq() scheduling a tasklet, but no commands issued.
> Do we really need disable interrupts?

You are right in current code, the interrupt and event handlers of ism and smcd
never issue a control command that calls ism_cmd().
OTOH, future ism clients could do that.
The control commands are not part of the data path, but of connection establish.
So I don't really expect a performance impact.
I have it on my ToDo list, to change this to threaded interrupts in the future.
So no strong opinion on my side.
Simple spin_lock is fine with me.



> 
>>  	__ism_write_cmd(ism, req + 1, sizeof(*req), req->len - sizeof(*req));
>>  	__ism_write_cmd(ism, req, 0, sizeof(*req));
>>  
>> @@ -143,6 +145,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
>>  	}
>>  	__ism_read_cmd(ism, resp + 1, sizeof(*resp), resp->len - sizeof(*resp));
>>  out:
>> +	spin_unlock_irqrestore(&ism->cmd_lock, flags);
>>  	return resp->ret;
>>  }
>>  
> ...
> 
> Thanks!
> 

