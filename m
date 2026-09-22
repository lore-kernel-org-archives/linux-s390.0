Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2F4E01E2
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070493; cv=none; b=b+sCRKrnA0hQC7SBI/JrUb9T5NjVcpNLGg1/QoIZUD5jbFf7IAUbSHZ+ZG0XkcdYkwigm4LA+wF91wOh3CfKsLHi/PwyeB3hD4zdGGJrzMfwjeoSam0JImoEmarWKAOcX+clQGPwOogrX1tCYcjDy/53gIWyw0oYZJU6yHwf/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070493; c=relaxed/simple;
	bh=FysI3Kp8x9xYIjIe/nn8mySTfEmUNzMY+9Lcat4Qv4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKTc3LLHij5XGCxcqq5MIqA3/5aFlbX1ql+vGcFzCACZjm5uWLyqvOoTeTH+MSb4cff1v9XSBz8gh6uZJsWfr+Z2mXqzJWB9TxFfQ8I2mV+R2/F+FAs4masUC9JPdA2xUMAnNfWQbou7qXp5Go4WsZnNFTtew/iXp5ikZvP2f64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hjkg/P1B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hjkg/P1B"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05bjC1778029
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 09:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+G78v5
	y54Ampt6T9gvvPWaV7GDSIVH1S6fGLcT6IGx0=; b=Hjkg/P1B7KHdVTyHefQpW9
	5foKxqgEp5OgP9t7GmGo0UtMPOkJTNMRJ3nH/lh8ba7gHpeH2hBhbtyYo0b8kmo1
	Ub2Kyv9ls25RfiEkud/kdiaq7QfyTpWRRCOVW2rJrXB2Bt6+shQPBRfQfML3TKFz
	OwGb3kAyxyPKtTrmAcJHXBIHTEJ0ImWTIjjTfH3YmtHFL0Rvg+C8DQcYFByV/b+W
	po728K0e323qT1iFBTg7KoE8tTFqqbnbxxcDrajQJw74+KyKLek4nSrrUVJSABEK
	v+TI3o7HVHlgRTPaTmABC6F04aDLtqoGeue+ltGlsizgzqTbHYc3gSp0GVgYN9Uw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqcqp1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 09:48:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5Yp3K2024871
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 09:48:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vhbsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 09:48:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M9m5ZH39977316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 09:48:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D69B120043;
	Tue, 22 Sep 2026 09:48:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6BA920040;
	Tue, 22 Sep 2026 09:48:05 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 09:48:05 +0000 (GMT)
Message-ID: <42dea0c9-b588-4416-ac1e-e42e8187bb7a@linux.ibm.com>
Date: Tue, 22 Sep 2026 11:48:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/pai: Simplify pai_init() and always return -ENODEV
 on failure
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, japo@linux.ibm.com, sumanthk@linux.ibm.com
References: <20260903081557.2023814-1-tmricht@linux.ibm.com>
 <20260914121406.39845Aa3-hca@linux.ibm.com>
 <fc096eca-cc22-40e0-b059-39d02d84431f@linux.ibm.com>
 <20260921130116.9433D51-hca@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260921130116.9433D51-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab24eda cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=B7HdDtUPUcgZZh8Qz18A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEzOCBTYWx0ZWRfX6W53Fa0ml9GT
 +p5+02CFmBnAM15ZHnId8rZ11omTW172EnNoh0QzlToZAWVVzk96xIhvrNz+HdqoI9aI8C/BLSt
 ufubwvY3JEZxR+Q291aq8kdJ/CpmnLYnqozLo3wm/mao67qdkGKknqo+XU2dwW/QZC+tQDiNMA7
 S5jXhe3bKxkiQeaMlz82lOrWF00U/TEpDIiC3ifxA8BvqpSPhu+lP5TpJVAvGMETduQtbROUAj3
 gYvdK/E5Wceuqrk+ImeCIzryMrKjKXQnoR1FAF4oBr7OU0TL4DQRvGT6TbR/+GLa8BJEWhMNRti
 pRbvJHJgHj/QByGvqJPKzItaMVb9Pd+kh3lzq+OpCPD7r138um4lrOyafpvLlwsU2YTvIaCMIvr
 MgwIuGDjXFAooxpbKxuRzY0JnVd6LDaGO75op31ekeLFt0chYRHwa62TN/zcZacORgCnlwH/byt
 Y37lwIVkSeQ3zFZnwhw==
X-Proofpoint-ORIG-GUID: eR35j-ltTFqcx7uF4gjU2514Hhs4Y32p
X-Proofpoint-GUID: eR35j-ltTFqcx7uF4gjU2514Hhs4Y32p
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEzOCBTYWx0ZWRfXwsfQI3kCd9wA
 EO0vNoqLfVkaaq0niXjfodapbgwmgceEcokFZigqyJMkVIFQ8HlqjQmULM2btA3TAeOuKCSO0HD
 BqAnuzi7xxzbz4lBW6cGIns4oWM9v0k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220138

On 9/21/26 15:01, Heiko Carstens wrote:
> On Mon, Sep 21, 2026 at 01:40:21PM +0200, Thomas Richter wrote:
>> On 9/14/26 14:14, Heiko Carstens wrote:
>>> On Thu, Sep 03, 2026 at 10:15:57AM +0200, Thomas Richter wrote:
>>>> Code simplification and remove variable state.
>>>> Return -ENODEV in all failures to indicate the PAI PMUs are not
>>>> available.
>>>
>>> Why do you want to hide different error / return codes? That makes
>>> debugging in case of an error more difficult.
>>
>> Well, hiding was not the intent.
>>
>> The kernel common code does a lot of checks at event creation,
>> then calls the PMU event_init() call back to install the event.
>> When this fails the return code is checked and further action
>> depends on this return code. See
>>
>>   perf_init_event()
>>   +--> perf_try_event_init()
>>        +--> PMU->event_init()
>>
>> See include/linux/perf_event.h for return code meanings.
>>
>> When we return the value from cpuhp_setup_state(), it must no be
>> -ENOENT and some other values. Because those are used for postprocessing.
>>
>> Thats why I always return -ENODEV, meaning event is valid for PMU, but
>> PMU not operational. I thouhgt this might fit best.
> 
> But what does have pai_init() to do with anything of the above?
> pai_init() is called via init_call() mechanism.


Ahh well, that is correct... lets drop it. Sorry for the noise.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
