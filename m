Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016E332604;
	Thu, 16 Apr 2026 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327745; cv=none; b=pZfumisZhLNdUlKUsfGoDoaOvF/rsVI/bIAQK2HX8QpEt3ypc2ySxhaOWeMD+qmaNQaB76uX3kMNCNbW4UZa0uRWtsGvxjssI8z+x9QbYZQeP3bIr9JbMC67H96oYDe9ET/achHOjxAwr2YtLUvgM/s4nmms59zwaHLXcbEv31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327745; c=relaxed/simple;
	bh=+annyCviDXRU6aLD48jWyvslETh/Cvy2LZ5NRoqrRpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIIjS9hzU4TeItu7QBGpeSHCms2txNLyOGIywmBEIrqrcRJWSR7ZUWmhmdHtEp21outPhS/tUm9tXwfuL69DOcKOWBTJr9LOKYjbWqEAdbXeSSUXIUxozogXjuDtSdfgAr3pLGH3ZUJaj8/f+jQ9OQ9dg1SrwAS2HE4JCCV0zFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e2Fj1hLf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e2Fj1hLf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6Edg91733184;
	Thu, 16 Apr 2026 08:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EghXYY
	nkmIraQBRylz8V08Xw1Fw8PiFljL3GV4sjMm0=; b=e2Fj1hLfI0Z8Po/oWJGVW0
	kG/Su8H3VxOIUcJipozN8A1Nh5d8pn6dKbMb4XGpU8+r3sqys4Un10OW+VGpyloE
	T2L4eq1Kj+ZxvDazOTJXRV1PAjI6D1DvWAMlJTWzE/YnUEzYghxhOZeuGBSmFC8w
	wdS5PjkoG4zUb3IjvVyBBNJWh5J3lni9lg9QlQdNKSMDNpZxJg5tz4Nt40UT8CHr
	R/cG8ESBb9p6eVhIk9AfoVlZApcVSUhmDd8dfkvJwMHqgGophpEU3sy6RxfCSw2C
	fumrNuHk+2nH2AmQ/www7b6lqruiOK1ZBfqZwJN3O/+JhJ4p0dVYx+sJ4n5f3xxw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mbk9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:22:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G6FXdP015164;
	Thu, 16 Apr 2026 08:22:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mst7rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:22:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G8MCti27984192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 08:22:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 243C02004D;
	Thu, 16 Apr 2026 08:22:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4A1C20049;
	Thu, 16 Apr 2026 08:22:11 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 08:22:11 +0000 (GMT)
Message-ID: <161ab40c-dad7-42b4-b6ad-917f8249254a@linux.ibm.com>
Date: Thu, 16 Apr 2026 10:22:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] s390/mm: Allow lazy MMU mode disabling
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <24d843c5568a8b591cbbe16eca092e7f45d18cf5.1776264097.git.agordeev@linux.ibm.com>
 <20260416054405.10407B6c-hca@linux.ibm.com>
 <2a497bff-1773-4245-a63c-784ed8853b11-agordeev@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <2a497bff-1773-4245-a63c-784ed8853b11-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69e09c38 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=bZTvA-38IwGshgt2pOQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cybN27AT70Xlug33CcVsFDGHqa-ZO9sJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3NyBTYWx0ZWRfX2Uocvty7Sfzg
 3EKlGo+vHAXe/bxw3gU+c95Q5guzP+mOtWdsoQvd1m49GlwN8B4zgT/2IRWbjrCf8Z8Ez6/mhfC
 cl+WXtWMpsbbF+rCwcVMWO1nRPPLVuOPAYWHPJ/gyZHbY53pRHZGfysgBskJH6/sHsPvq614gNR
 NK9IvglftKx10tyLUhewEHJ2IyvDcizzTPZ2eKIZzvF2eB+ivmeMoJoJHYdxaAYslB4Py3SUvV6
 +synpXrscZek6LfanKvVHcCuwdMzjruRvxdXfhqpz95+kEqqzS4HLihEXPYoyOT7+kJEmsk6byM
 dgym7Y0ddR1mmu7cLNdAcUFbaNbtzOnlIJdWWashK4VP/5eNnkMcKTkmA20aOEw0iTsqe3sNm6j
 JOruNSZ63uJCCxs1b+UGCrP+cMo+7+FkZbFZIhLT4CfyuHBXV6aAKfY0Y0m6fQPZapYTIhQh+FP
 qmEiz7gMaXcyn+nZqhQ==
X-Proofpoint-ORIG-GUID: cybN27AT70Xlug33CcVsFDGHqa-ZO9sJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160077



Am 16.04.26 um 09:00 schrieb Alexander Gordeev:
> On Thu, Apr 16, 2026 at 07:44:05AM +0200, Heiko Carstens wrote:
>>> @@ -169,6 +185,8 @@ void arch_enter_lazy_mmu_mode_for_pte_range(struct mm_struct *mm,
>>>   {
>>>   	if (!test_facility(13))
>>>   		return;
>>> +	if (!static_branch_likely(&lazy_mmu))
>>> +		return;
>>
>> Looks like there is an alternative chicken switch available: remove
>> facility bit 13 from the facility list via kernel command line option.
>>
>> Unless I am mistaken: that should be sufficient and avoids adding more
>> code.
> 
> But that would also withdraw multi-IPTE from other unrelated parts of
> the code, e.g. from __kernel_map_pages().

Which is fine. Do not over-optimize for a case that should not be
needed unless we really mess up. This parameter is way too complicated to ever
be set/unset by a customer.
