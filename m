Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE24AF9C3;
	Wed,  7 Oct 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382084; cv=none; b=FHADAsN4rUC2BW5X/NE84eNmixTra/PpaJWgxKnkQVBEMhEDk6kx+NkJD2SNU0L4R65cHnUOiWB7/wLEXqdejMdrb/HQq8GkTSekjIg9aNtWddZGL1zc7xIBxtpyVQCxB+yso/5RYNMfRQM7fQBDLGiEVrhXeQ0sXVtJOTq2Yq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382084; c=relaxed/simple;
	bh=LJSLgoDNB+XgK9kpKAkXJf4MzAoCuQNS4pQYKSDexyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbOi7lvANtJ3W2Rn82TwwPobj+G6vvGoCJv86RdCPTB9cDc4uFfM2hK72jENxDSz5NsztcoFm4R4VwAhKeOhuSi7aoCYUqQugxNwqnVwk9s4V88gyp7ShjkUnucGCaw90ZUL15yz3HIIQG1sqgv0Ctpb1NExGSD3VaKtdtVMCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DBgBoRJG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DBgBoRJG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZQDu2375607;
	Wed, 7 Oct 2026 14:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/steh8
	4+QJeR6z87WppOgi09xRdp3S8pE/ok/Y5MFi8=; b=DBgBoRJG7M8zfyBgh4I8pH
	ylAMHQs6/ElnqG8yYLgCvCyWyNgWgx/J5TtJNRklk64Ta/iS4rgf0uUMoNB/4tQU
	iiyM+vW1xtEYIzz20Umk/iuyENZkREVEBYbCcRogPkoTb3SHDi3LvsDN6ZWTfou/
	W+NViPa8aGv6rMP1yyd3LEI2tqrtcH4UsuqyEzeF0jA8lDAdSPGp1SUF1TCyNQHV
	jbSVHUEoi0aWnlPit2jVpa7LIQk10JIwllZS2pKicaTaGoQRt85Y+jWJ/3aKuEXC
	IGNMU9P6ejv9w/4cKuUmFipRekasZR9iTU9s0HINd0gXC3PfR8yKLl1xf9xKzEgw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5nt15-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 14:07:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWorD1841635;
	Wed, 7 Oct 2026 14:07:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6djsaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 14:07:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697E7pUK43188678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 14:07:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA06B20040;
	Wed,  7 Oct 2026 14:07:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5343220043;
	Wed,  7 Oct 2026 14:07:51 +0000 (GMT)
Received: from [9.111.136.203] (unknown [9.111.136.203])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 14:07:51 +0000 (GMT)
Message-ID: <46dd244e-db3b-4c34-a156-3101a080e67e@linux.ibm.com>
Date: Wed, 7 Oct 2026 16:07:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/ap: Support new APMLM field with PQAP/TAPQ
 instruction
To: freude@linux.ibm.com, sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>
References: <20261006145823.8421-1-freude@linux.ibm.com>
 <20261006150932.5AD671F0089B@smtp.kernel.org>
 <a2ef55c1888274840a45b3b5792251ce@linux.ibm.com>
Content-Language: en-GB
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <a2ef55c1888274840a45b3b5792251ce@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NiBTYWx0ZWRfX1AOnC0i+L0ZR
 m5QUlEHegIlhdYE1YRFXMTePSyDBi+KViuskbHOdwPBrkGsGqBT0OpRLQWATz+J+nZcLd48s7kd
 3us0xGQFgaksMlCuGKzYh4dvw26HemU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NiBTYWx0ZWRfX0vN1iCd2A/39
 e4UkH1Oia7SxQKKJ3l/wdObwVwwQVytRGqWv5lBXfimXjwlurD41z2ze30UH7uA1AJ5TcH9oJpE
 3EpX/T+bF60X3cNxqb1sW2GBmt9cFJK9BTOlrVnVOE4Cq7zNdS9sMl2D1oFRWDGIEhJYdQg1DDf
 jHDupzbe3gAFZ4RFAuw9J133UEFTuTTNyjffSKaAhNc/q5VXLPp4h18lR3yZYRGQhZf11OGLP1G
 ut1XOi4hj2YMTuIIeBl7V/glQEl7R/WrbF26H37+Ub4u1zM6zZhLS078cUfdNwSNdlsrHccNMCd
 9FIAdvKbjxoO29h0jd1aCXYhDi9ddynsN5e0ogNR7Za0iVS+FaSuJbi12aMuejqfYcksOvyTw/c
 MJl2YRXT3zlvLhu3Ru5Z3hAH2wFzlm0bG3MVfhDSd1LS32PlQUiaEZqSlmDK5IUEVNII9dvhqL7
 3IdWz+3EG35XOr3rFUw==
X-Proofpoint-GUID: hwPq3SB-CSABMv5k1LabMcuJOKZEgnFj
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac6523c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DrZ9VmzCylkJuAQuiiAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hwPq3SB-CSABMv5k1LabMcuJOKZEgnFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070056



On 06.10.26 17:53, Harald Freudenberger wrote:
> On 2026-10-06 17:09, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider:
>> - [High] s390/ap: order-8 kmalloc allocation causes DoS for crypto 
>> requests
>> -- 
>>
>> commit c12ee44fe3064032047e06539777b0c95c7b1201
>> Author: Harald Freudenberger <freude@linux.ibm.com>
>>
>> s390/ap: Support new APMLM field with PQAP/TAPQ instruction
>>
>> This commit adds support for the new AP message limit multiplier field 
>> in the
>> GR2 register for the PQAP instruction. It updates the HWINFO mask and
>> modifies the formula used to calculate the AP maximum message limit.
>>
>>> diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ 
>>> ap_card.c
>>> --- a/drivers/s390/crypto/ap_card.c
>>> +++ b/drivers/s390/crypto/ap_card.c
>>> @@ -242,7 +242,8 @@ struct ap_card *ap_card_create(int id, struct 
>>> ap_tapq_hwinfo hwinfo,
>>>      ac->hwinfo = hwinfo;
>>>      ac->id = id;
>>>      ac->maxmsgsize = hwinfo.ml > 3 ?
>>> -        hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : 
>>> AP_DEFAULT_MAX_MSG_SIZE;
>>> +        hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
>>> +        AP_DEFAULT_MAX_MSG_SIZE;
>>
>> [Severity: High]
>> Will this scaling of the maximum message size cause order-8 physically
>> contiguous memory allocation failures?
>>
>> By introducing the hwinfo.mlm multiplier, the maximum message size can 
>> now
>> scale up to around 960KB. This value is used to set the global maximum 
>> message
>> size.
>>
>> However, looking at how messages are allocated in
>> drivers/s390/crypto/ap_bus.c in ap_init_apmsg():
>>
>> void ap_init_apmsg(...)
>> {
>>         ...
>>         maxmsgsize = atomic_read(&ap_max_msg_size);
>>         ap_msg->msg = kmalloc(maxmsgsize, GFP_KERNEL);
>>         ...
>> }
>>
>> And similarly in drivers/s390/crypto/zcrypt_queue.c in 
>> zcrypt_queue_alloc():
>>
>>         zq->reply.msg = kmalloc(reply_buf_size, GFP_KERNEL);
>>
>> Since these functions unconditionally use kmalloc() for the maximum size,
>> user-space crypto requests will trigger massive order-8 allocations. On a
>> system with fragmented memory, these physically contiguous allocations 
>> are
>> highly likely to fail. This could lead to a reliable denial of service 
>> for
>> hardware cryptographic services since the underlying AP instruction 
>> operates
>> on absolute memory addresses requiring physically contiguous memory.
>>
>> Is there a plan to adjust the allocation strategy alongside this limit
>> increase, or otherwise cap the unconditional allocation sizes?
> 
> Hm this leads to the question if there should be an upper limit for this
> AP max message size. However this is then a protection against malicious
> firmware as the both fields ml and mlm are provided via TAPQ from firmware.
> 
> @Holger, @Finn any suggestions ?

I think when firmware is compromised this is not our biggest problem...
We could add a maximum valid apml which is whatever the firmware reports 
for the most current card generation. (Currently 24k)

