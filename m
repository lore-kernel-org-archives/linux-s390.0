Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA519D884;
	Thu, 15 Aug 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708585; cv=none; b=sSv0FU8hDE8wPT68gvZ0IhAMQ+gf0K9dPxdwXN1FlA1W+oRiB8y0pfMbfM6BCqUFpp2BaysFaFZVrBuDaO5TPtaG2fhwsfIahu2EgmVPu04hY1tCj7rhJBogr9IVrTW9uO+4y+h64jZ7ugqHPL2MBT0ZGZUmFRqVsFNtJxsZ5UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708585; c=relaxed/simple;
	bh=6BhjSpizZ0Gn/gEBSMDptr/RtW/vCUqv/gmT0WSuE6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuNt48YVa67K+T8ydmafA+6jmOGu1D6QVvaTrYBjFi1REtrBD25zRpCeGJRSBG8bYwknZJXnvwKH4DUgXYiS2NhoHb2H51yqTwzKzSuJcjJqjSCuYcdryox7w0dhRo+hzfiam1t3BDaaN3KMCnFwn7eiiW95Nyi9TXO7Oh1Xf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EDlgqko4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EDlgqko4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EMulLa012207;
	Thu, 15 Aug 2024 07:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=7
	io1MFeoMtoJwh/jXFpWzsxYD5WXCgYN5/FHgaGKZB4=; b=EDlgqko4wp66Ckj8A
	VNkaLHiQytwW0DEZF5eSjng/CtoukA+JK98ba1IhEU9UfTab2j7jxOP1jgBuOIlJ
	LXyLdcBqRGuE3w0dScAyN3905gQIwWVpNfxtYDsrANXUHVhkyYNmeKiKfIZB4kYv
	MIxdsTaI3baVDpunIjdqtoY1/CKAM9rK6iw6cWFqSWAvWLKZU6A2S694Ao2kY6pp
	vLZMupSVkQDB2tX2gAi65wFoC/wejjRD2MLiaSrTpR6a0wIR0oscOANne2jz8/9V
	TtRInXt6Q6gbME/MrZiUPU0erQcXa8aDlF0ovt4GmANFtIHUCKoxHj1V7erp6f5h
	aTQxg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6an73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:56:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47F7sSJJ023422;
	Thu, 15 Aug 2024 07:56:18 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6an6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:56:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47F6p6DJ029698;
	Thu, 15 Aug 2024 07:56:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrmneqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:56:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47F7uBBw31523504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 07:56:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27A9F20043;
	Thu, 15 Aug 2024 07:56:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E66982004D;
	Thu, 15 Aug 2024 07:56:10 +0000 (GMT)
Received: from [9.152.224.208] (unknown [9.152.224.208])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Aug 2024 07:56:10 +0000 (GMT)
Message-ID: <5ad4de6f-48d4-4d1b-b062-e1cd2e8b3600@linux.ibm.com>
Date: Thu, 15 Aug 2024 09:56:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v4] net/smc: prevent NULL pointer dereference in
 txopt_get
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Jeongjun Park <aha310510@gmail.com>
Cc: gbayer@linux.ibm.com, guwen@linux.alibaba.com, jaka@linux.ibm.com,
        tonylu@linux.alibaba.com, wenjia@linux.ibm.com, davem@davemloft.net,
        dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
References: <64c2d755-eb4b-42fa-befb-c4afd7e95f03@linux.ibm.com>
 <20240814150558.46178-1-aha310510@gmail.com>
 <9db86945-c889-4c0f-adcf-119a9cbeb0cc@linux.alibaba.com>
 <CAO9qdTGFGxgD_8RYQKTx9NJbwa0fiFziFyx2FJpnYk3ZvFbUmw@mail.gmail.com>
 <6bcd6097-13dd-44fd-aa67-39a3bcc69af2@linux.alibaba.com>
 <c9c35759-33e7-4103-a4f0-af1d5fdefcdf@linux.ibm.com>
 <08f4d3cf-4d9a-47e6-a033-ed8c03ee5a0e@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <08f4d3cf-4d9a-47e6-a033-ed8c03ee5a0e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FoRFb1DcaXsE1uMC0uGfVmIPg14Ei-bt
X-Proofpoint-ORIG-GUID: 0fO5n6-BJHdT4GfMqX3VCxvwOPa4PuZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_22,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=961 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150053



On 15.08.24 09:34, D. Wythe wrote:
> 
> 
> On 8/15/24 3:03 PM, Alexandra Winter wrote:
>>
>> On 15.08.24 08:43, D. Wythe wrote:
>>>
>>> On 8/15/24 11:15 AM, Jeongjun Park wrote:
>>>> 2024년 8월 15일 (목) 오전 11:51, D. Wythe <alibuda@linux.alibaba.com>님이 작성:
>>>>>
>>>>> On 8/14/24 11:05 PM, Jeongjun Park wrote:
>>>>>> Alexandra Winter wrote:
>>>>>>> On 14.08.24 15:11, D. Wythe wrote:
>>>>>>>>        struct smc_sock {                /* smc sock container */
>>>>>>>> -    struct sock        sk;
>>>>>>>> +    union {
>>>>>>>> +        struct sock        sk;
>>>>>>>> +        struct inet_sock    inet;
>>>>>>>> +    };
>>>>>>> I don't see a path where this breaks, but it looks risky to me.
>>>>>>> Is an smc_sock always an inet_sock as well? Then can't you go with smc_sock->inet_sock->sk ?
>>>>>>> Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an inet_sock?
>>>>> There is no smc_sock->inet_sock->sk before. And this part here was to
>>>>> make smc_sock also
>>>>> be an inet_sock.
>>>>>
>>>>> For IPPROTO_SMC, smc_sock should be an inet_sock, but it is not before.
>>>>> So, the initialization of certain fields
>>>>> in smc_sock(for example, clcsk) will overwrite modifications made to the
>>>>> inet_sock part in inet(6)_create.
>>>>>
>>>>> For AF_SMC,  the only problem is that  some space will be wasted. Since
>>>>> AF_SMC don't care the inet_sock part.
>>>>> However, make the use of sock by AF_SMC and IPPROTO_SMC separately for
>>>>> the sake of avoid wasting some space
>>>>> is a little bit extreme.
>>>>>
>>
>> Thank you for the explanation D. Wythe. That was my impression also.
>> I think it is not very clean and risky to use the same structure (smc_sock)
>> as inet_sock for IPPROTO_SMC and as smc_sock type for AF_SMC.
>> I am not concerned about wasting space, mroe about maintainability.
>>
>>
> 
> Hi Alexandra,
> 
> I understand your concern, the maintainability is of course the most important. But if we use different
> sock types for IPPROTO_SMC and AF_SMC, it would actually be detrimental to maintenance because
> we have to use a judgment of which type of sock is to use in all the code of smc, it's really dirty.
> 
> In fact, because a sock is either given to IPPROTO_SMC as inet_sock or to AF_SMC as smc_sock,
> it cannot exist the same time.  So it's hard to say what risks there are.
> 
> Of course, I have to say that this may not be that clean, but compared to adding a type judgment
> for every sock usage, it is already a very clean approach.
> 


At least the union makes it visible now, so it is cleaner than before. 
Maybe add a comment to the union, which one is used in which case?


> Best wishes,
> D. Wythe
> 

[...]

>>>>>>
>>>>>> -#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
>>>>>> +#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
>>>>>>


Just an idea: Maybe it would be sufficient to do the type judgement in smc_sk() ?



