Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271123B14AD
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025377; cv=none; b=FLOlyO2pP11RpwqEAnhAL8vgz8ZKEnM+rxYuVXyqgb4do8JyOe8crUteJn+UFjCOOhwkXGkGPHh95XfeUVjqMhvyI0amI0EBiEJddalCCWeLVOQC6focWjV87naQhV57C9CkfFhXSi7AH7NbHOY/ucagiE6STzA6HkZy1lEApEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025377; c=relaxed/simple;
	bh=0QvCSu6kdEXGJCRroJbgHSgDpyofHy8rrg4Hzy0eu1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foZuewZr5lLZRSwg2uxwIBkDuDGxBizZA0eg+SUDew2FKZFIiGyonkZsTDTUO5m0e3neKyBe2u23V6+DTZXIi/WyfryYpcAX4kvs5lBdDhBjlEsRMMLwjdv1ybJ7Qx84ZCznDorl+0xm8DZcHDFoWJCLK4WgLXP0NqANlhdteEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d463TS8M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d463TS8M"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NlfC13403040;
	Thu, 6 Aug 2026 14:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/dfWFV
	+YZ8OktIwwd4/13zjAuoQNSYjrs2y0fMWSNwo=; b=d463TS8MHuFw5Y+YF+RcuV
	xrBlRifMPROtpIdHJwwQUNixioc3b+L/VqI972XhUe8gmqaIv6J0IKr3GaVIp4k3
	O9m5s+5dilzHj0C3/fijJXrSffRzF+mhnWDsOYVJxDHMzw7OhbW1FI0xXlCc80+S
	4ft7FBb9Gg0QwDMer1oVBcGtLdUnwwxrjQZWZEe2JI3of1HxXpLNb8ZhAVyBia+i
	+VNq2dMG9z+t+znJM0HsKm6eMjJlWbxfiBLeU4uaNP1MIsuZBNx3vWW1uuvdF5dZ
	GkRmLEaqwBj0ek50zT3scH11onKRm4Y564tN8M3lO39xhHUwVBZQNnkdM1CUKRxg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fr0h94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:09:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676DuFkd014165;
	Thu, 6 Aug 2026 14:09:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyu8ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:09:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676E9St037748996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:09:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21E0E20040;
	Thu,  6 Aug 2026 14:09:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C10512004B;
	Thu,  6 Aug 2026 14:09:27 +0000 (GMT)
Received: from [9.111.83.204] (unknown [9.111.83.204])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 14:09:27 +0000 (GMT)
Message-ID: <0383c891-8ae8-45b8-b954-fc1fe9862814@linux.ibm.com>
Date: Thu, 6 Aug 2026 16:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390/dasd: Add __context_unsafe() attribute to
 various functions
To: Heiko Carstens <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
 <20260806130050.2057443-2-hca@linux.ibm.com>
 <20260806130917.3DD841F000E9@smtp.kernel.org>
 <20260806140620.15764D1b-hca@linux.ibm.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20260806140620.15764D1b-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qpPjbmOHnZOk-nxbMQxl5OOgB6scBO2y
X-Proofpoint-ORIG-GUID: qpPjbmOHnZOk-nxbMQxl5OOgB6scBO2y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwOCBTYWx0ZWRfXzs+45QGBn2W9
 tPK8i/coPuDJ76JIoO2NtEQwQxEFhp/j3mMnRpVEovaZ0Wz/XJV/P6vw/7OceFJOd9xB7Rb4nGk
 BMfw6UymPAHnH+NH18B4YeysyjjE3fM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a74959c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=MO-m64mJ2PgLjiyZUXIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwOCBTYWx0ZWRfXxzjsCidA4Bxg
 SEJyNdC+C85JWffqiLxmfeUu4idp4Lcl/XPSM0wZtBTwz3wSAy5Mi0r0q/RYMAIB7GzhSiKROa3
 EmIpIB/5MPw9Weh1MKTBlaD7B7jLbJlArLd2SdH55NqCA/Tug9U12ed13IdxOXl7nl1kAE6O6Yn
 YA5XOtuPGBJ5r7Hmb8ggY7zgDirXsLKyhbGaR3YmovuWxpnLypWdi7dAuLoZRRNOWbSNN1LnVKc
 5wj37MxzT2S/sejQk6wMeFyLVUfMCJjfywdkiOEQzLwb0UZQggaXRZ9GWh3eKyfQ5fhc/zKhOrF
 Bq7uPsaehpV+xG+9vd4zyGrgbDYH+eu6AIMa1gJUZQatmJTvPdwmpoGceiXAKrteAXqtD+Hyx7S
 XiTUygQP3/1cN7ptSx64+nKzolDvxW8+lNHN10Jw2b7LWcJ+56N13fmYtPjHMhYfzgVVW4K3nao
 v9yo/lNHTO234Yws3CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060108

Am 06.08.26 um 16:06 schrieb Heiko Carstens:
> On Thu, Aug 06, 2026 at 01:09:16PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> ...
>>>  static int dasd_eckd_pe_handler(struct dasd_device *device,
>>>  				__u8 tbvpm, __u8 fcsecpm)
>>> +__context_unsafe(/* Conditional locking */)
>>>  {
>>>  	struct pe_handler_work_data *data;
>>
>> [Severity: High]
>> This is a pre-existing issue, but does silencing this warning hide a
>> legitimate cross-thread mutex unlock?
>>
>> When kzalloc fails in dasd_eckd_pe_handler(), it calls mutex_trylock(),
>> establishing the current interrupted task as the lock owner:
>>
>> dasd_eckd_pe_handler() {
>>     ...
>>     data = kzalloc_obj(*data, GFP_ATOMIC | GFP_DMA);
>>     if (!data) {
>>         if (mutex_trylock(&dasd_pe_handler_mutex)) {
>>             data = pe_handler_worker;
>>             data->isglobal = 1;
>>     ...
>>     schedule_work(&data->worker);
>> }
>>
>> The lock is then released from a different task (the workqueue worker thread)
>> in do_pe_handler_work():
>>
>> do_pe_handler_work() {
>>     ...
>>     if (data->isglobal)
>>         mutex_unlock(&dasd_pe_handler_mutex);
>>     ...
>> }
>>
>> Unlocking a struct mutex from a task other than the one that acquired it
>> strictly violates mutex semantics, which could cause debug warnings or
>> panics.
>>
>> Additionally, mutex_trylock() in atomic context (inferred from GFP_ATOMIC
>> usage) violates lockdep wait-context rules and PREEMPT_RT requirements.
>>
>> Could this code be restructured to avoid the cross-thread unlock rather than
>> silencing the warning?
> 
> This looks indeed like a valid finding. Looking at the code it looks to me
> like there is no need for a mutex at all. Instead a simple integer which
> indicates if the global pe_handler_work_data is used should be
> sufficient. Exclusive access would then be tried to get with xchg().
> 
> Jens, Stefan, should this be addressed before or after this small series?
> I would prefer after this series, since in the meantime I dislike those
> "pre-existing" bugs, which pile up :)

Yes, looks valid to me.
I already have a certain amount of findings which I have to evaluate and
address. I can put this on the list as well.
