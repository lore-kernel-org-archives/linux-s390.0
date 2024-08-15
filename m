Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553215572E;
	Thu, 15 Aug 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705416; cv=none; b=COQhJbyB/uIlH6tTWBmyhXU0rjblrHbcKA4QpTI0WU1wOCYqw7WDKAeqlmiIDY0co1IFiDveDSzRLC4M7p2sDiQoeA16F7QFtrYXH+tVZq0Ck2N8Qw0Mo9uzwiZBMYqHXbK/lgDv8onT52qg+X9TQiaLsI4caqi/aQGsdm265b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705416; c=relaxed/simple;
	bh=BEfDmDLiFad+5GzVwyb3AAz0mwzIqaWk0/6y5E/Ryy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KisQFH0iOLgigKKFyxt4VybO8DF/AgtSXY/6CyN7OB5IzGNwSc1r3u7C4h2e0AD8SXKtF0tmzaBGwlDQLRPlxYxIUnbFdT5GDSCh+RBBkxy+Ko4p37y9Ka/PuSW3o7a4dN66GsPS59zuCgh+GZDZfKFmhEfy1+RZPJYnzq8qoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FN6ZGRz9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FN6ZGRz9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHsaPD025265;
	Thu, 15 Aug 2024 07:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=M
	6fGN17QXNey//B4JZT3qXU3ULMgMp5zqQzwbf/Z44k=; b=FN6ZGRz9HpIZgE1bm
	37x4J3ZNDUDX1++wuvHvsm7FIfXq9m3RpdzzMKiRO07G0997pmPZXwihbuQ1UHc/
	qBkd9mff1YR6qIFoE3faOExzFWXvTDSrC+B9WdpTu0mobI0/fzPSfJj3c/KyVkvD
	b/4bcXWqRtxmHFlgkAPyebRf0rnF79NIvoP9bBPaFgtLvKTFU8Lgx8CO05j2I4P2
	U1ASgNbYTIsTD9B725Pr0PRCe1UNqWyOQRnTEfc8RjA6dX4tTZQZ2cAwjzshpSuM
	sLB/Ekc/jW3kJdurGtrMvg6C7jdbx3P/adsqUbGB+Ij4rwbdKOvIek9TYRlcBg/S
	KCUqw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6jcu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:03:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47F73G4B015275;
	Thu, 15 Aug 2024 07:03:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6jctv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:03:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47F6pghY020901;
	Thu, 15 Aug 2024 07:03:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn83d495-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:03:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47F739ku42139976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 07:03:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE7EF2004D;
	Thu, 15 Aug 2024 07:03:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F3C32004B;
	Thu, 15 Aug 2024 07:03:09 +0000 (GMT)
Received: from [9.152.224.208] (unknown [9.152.224.208])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Aug 2024 07:03:09 +0000 (GMT)
Message-ID: <c9c35759-33e7-4103-a4f0-af1d5fdefcdf@linux.ibm.com>
Date: Thu, 15 Aug 2024 09:03:09 +0200
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
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <6bcd6097-13dd-44fd-aa67-39a3bcc69af2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EGurLq0YklRQv9tWU13end9SdZk8U2QN
X-Proofpoint-ORIG-GUID: lVMeSkxC0gWET55WUyUgRCNYIhoOziXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_22,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150049



On 15.08.24 08:43, D. Wythe wrote:
> 
> 
> On 8/15/24 11:15 AM, Jeongjun Park wrote:
>> 2024년 8월 15일 (목) 오전 11:51, D. Wythe <alibuda@linux.alibaba.com>님이 작성:
>>>
>>>
>>> On 8/14/24 11:05 PM, Jeongjun Park wrote:
>>>> Alexandra Winter wrote:
>>>>> On 14.08.24 15:11, D. Wythe wrote:
>>>>>>       struct smc_sock {                /* smc sock container */
>>>>>> -    struct sock        sk;
>>>>>> +    union {
>>>>>> +        struct sock        sk;
>>>>>> +        struct inet_sock    inet;
>>>>>> +    };
>>>>> I don't see a path where this breaks, but it looks risky to me.
>>>>> Is an smc_sock always an inet_sock as well? Then can't you go with smc_sock->inet_sock->sk ?
>>>>> Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an inet_sock?
>>>
>>> There is no smc_sock->inet_sock->sk before. And this part here was to
>>> make smc_sock also
>>> be an inet_sock.
>>>
>>> For IPPROTO_SMC, smc_sock should be an inet_sock, but it is not before.
>>> So, the initialization of certain fields
>>> in smc_sock(for example, clcsk) will overwrite modifications made to the
>>> inet_sock part in inet(6)_create.
>>>
>>> For AF_SMC,  the only problem is that  some space will be wasted. Since
>>> AF_SMC don't care the inet_sock part.
>>> However, make the use of sock by AF_SMC and IPPROTO_SMC separately for
>>> the sake of avoid wasting some space
>>> is a little bit extreme.
>>>


Thank you for the explanation D. Wythe. That was my impression also. 
I think it is not very clean and risky to use the same structure (smc_sock)
as inet_sock for IPPROTO_SMC and as smc_sock type for AF_SMC.
I am not concerned about wasting space, mroe about maintainability.



>> Okay. I think using inet_sock instead of sock is also a good idea, but I
>> understand for now.
>>
>> However, for some reason this patch status has become Changes Requested


Afaiu, changes requested in this case means that there is discussion ongoing.


>> , so we will split the patch into two and resend the v5 patch.
>>
>> Regards,
>> Jeongjun Park
> 
> Why so hurry ? Are you rushing for some tasks ? Please be patient.
> 
> The discussion is still ongoing, and you need to wait for everyone's opinions,
> at least you can wait a few days to see if there are any other opinions, even if you think
> your patch is correct.
> 
[...]
> 
> Best wishes,
> D. Wythe


I understand that we have a real problem and need a fix. But I agree with D. Wythe,
please give people a chance for discussion before sending new versions.
Also a version history would be helpful (what changed and why)


>>>> hmm... then how about changing it to something like this?
>>>>
>>>> @@ -283,7 +283,7 @@ struct smc_connection {
>>>>    };
>>>>
>>>>    struct smc_sock {                           /* smc sock container */
>>>> -     struct sock             sk;
>>>> +     struct inet_sock        inet;
>>>>        struct socket           *clcsock;       /* internal tcp socket */
>>>>        void                    (*clcsk_state_change)(struct sock *sk);
>>>
>>> Don't.
>>>
>>>>                                                /* original stat_change fct. */
>>>> @@ -327,7 +327,7 @@ struct smc_sock {                         /* smc sock container */
>>>>                                                 * */
>>>>    };
>>>>
>>>> -#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
>>>> +#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
>>>>
>>>>    static inline void smc_init_saved_callbacks(struct smc_sock *smc)
>>>>    {
>>>>
>>>> It is definitely not normal to make the first member of smc_sock as sock.
>>>>
>>>> Therefore, I think it would be appropriate to modify it to use inet_sock
>>>> as the first member like other protocols (sctp, dccp) and access sk in a
>>>> way like &smc->inet.sk.
>>>>
>>>> Although this fix would require more code changes, we tested the bug and
>>>> confirmed that it was not triggered and the functionality was working
>>>> normally.
>>>>
>>>> What do you think?


Yes, that looks like what I had in mind. 
I am not familiar enough with the details of the SMC code to judge all implications.


>>>>
>>>> Regards,
>>>> Jeongjun Park
> 
> 
