Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B917557;
	Fri,  9 Aug 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723237695; cv=none; b=Lb7gye9uraAuxAYEwIbOyIB1n+UpPq2NUMcVoJm45o0U3Crze523d8XJ5kGuA7uqO3mJQ9O9EjrvwBG9noRLTFiqhZJ+FUxgy6KQWZ7r4MV033xCiQrYjj481tzGW15gMBAnhlgOV+mp3eRNrIJ8D6Y7TV33HLGVkfU3nrsFdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723237695; c=relaxed/simple;
	bh=TgOqQo/nNgKQfxm1ZRgcugniZO2FnwfFbT0uV+1sJrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEH3J5AnaJ3iqAVIprTg49edTZzk5SEX73C7SDUi6sdTUcJKGvCTgBYNbR1cZ0ORI5pBv+ewAhRAEmZAu5bTJqM/P6kyEpArQzqe74CNRwcd/RH0BglO90t1+4nDcOZhZKuX99NaUCYp3SseqLB1Rfp9ZDaoFcW493jcTaQM3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cvOJ4Yk8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cvOJ4Yk8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479IYJXY020215;
	Fri, 9 Aug 2024 21:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=5
	Alvphok64lsLZw6Dy+9TD3ksgGFhXTGsICf7puBrco=; b=cvOJ4Yk87MLaHHVBL
	P8biApaaCAOqnh0u6nAudOBnuq5Y6D1jVQdTJVsWR9x44NuWOrM7u22gS2bsDOuF
	EFQZBTHk8PJ84hl+OjKWAAK899XG0dcnbU5I+8Z29sSy9JoHSOFgNo3tukaHlIy6
	+ygFWdrb+aZIRDjn4gXzj2cEqXpj9wgVu/FxarY+jY2B+GJm9DGoCwBuTNOh4lfx
	Ut2aQhIr+MKs4eZQ6YcHWzkkM0ogSJNCbPPvwUQ3gGwieydtxPazeKXYqbRp6+Tu
	KHdV9fqxRgMadx4E/zgQtFjlHSCEywXDQAqO4sczAwTRaGXlxzHCmpmkWDEtMY8C
	ladoQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wrgjg90h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 21:08:06 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 479L3oxF009548;
	Fri, 9 Aug 2024 21:08:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wrgjg90c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 21:08:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 479IO3Hh024352;
	Fri, 9 Aug 2024 21:08:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy915ngd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 21:08:05 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 479L82Kj46465382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 21:08:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 117C358066;
	Fri,  9 Aug 2024 21:08:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E801158043;
	Fri,  9 Aug 2024 21:07:59 +0000 (GMT)
Received: from [9.171.82.52] (unknown [9.171.82.52])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 21:07:59 +0000 (GMT)
Message-ID: <0afaeec5-f80a-4d8d-806b-d39c0eb5570e@linux.ibm.com>
Date: Fri, 9 Aug 2024 23:07:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: introduce autosplit for smc
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240709160551.40595-1-guangguan.wang@linux.alibaba.com>
 <cf07ec76-9d48-4bff-99f6-0842b5127c81@linux.ibm.com>
 <63862dcc-33fd-4757-8daf-e0a018a1c7a3@linux.alibaba.com>
 <faad0886-9ece-4a1c-a659-461b060ba70b@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <faad0886-9ece-4a1c-a659-461b060ba70b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TXeWOLRsmeghkzvaIQ20Azvvq_zbHYk-
X-Proofpoint-ORIG-GUID: lInTmsyXmRfMXCzTIeZSrwhb0l6SbDFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_17,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090152



On 08.08.24 08:26, Guangguan Wang wrote:
> On 2024/7/15 10:53, Guangguan Wang wrote:
>>
>>
>> On 2024/7/11 23:57, Wenjia Zhang wrote:
>>>
>>>
>>> On 09.07.24 18:05, Guangguan Wang wrote:
>>>> When sending large size data in TCP, the data will be split into
>>>> several segments(packets) to transfer due to MTU config. And in
>>>> the receive side, application can be woken up to recv data every
>>>> packet arrived, the data transmission and data recv copy are
>>>> pipelined.
>>>>
>>>> But for SMC-R, it will transmit as many data as possible in one
>>>> RDMA WRITE and a CDC msg follows the RDMA WRITE, in the receive
>>>> size, the application only be woken up to recv data when all RDMA
>>>> WRITE data and the followed CDC msg arrived. The data transmission
>>>> and data recv copy are sequential.
>>>>
>>>> This patch introduce autosplit for SMC, which can automatic split
>>>> data into several segments and every segment transmitted by one RDMA
>>>> WRITE when sending large size data in SMC. Because of the split, the
>>>> data transmission and data send copy can be pipelined in the send side,
>>>> and the data transmission and data recv copy can be pipelined in the
>>>> receive side. Thus autosplit helps improving latency performance when
>>>> sending large size data. The autosplit also works for SMC-D.
>>>>
>>>> This patch also introduce a sysctl names autosplit_size for configure
>>>> the max size of the split segment, whose default value is 128KiB
>>>> (128KiB perform best in my environment).
>>>>
>>>> The sockperf benchmark shows 17%-28% latency improvement when msgsize
>>>>> = 256KB for SMC-R, 15%-32% latency improvement when msgsize >= 256KB
>>>> for SMC-D with smc-loopback.
>>>>
>>>> Test command:
>>>> sockperf sr --tcp -m 1048575
>>>> sockperf pp --tcp -i <server ip> -m <msgsize> -t 20
>>>>
>>>> Test config:
>>>> sysctl -w net.smc.wmem=524288
>>>> sysctl -w net.smc.rmem=524288
>>>>
>>>> Test results:
>>>> SMC-R
>>>> msgsize   noautosplit    autosplit
>>>> 128KB       55.546 us     55.763 us
>>>> 256KB       83.537 us     69.743 us (17% improve)
>>>> 512KB      138.306 us    100.313 us (28% improve)
>>>> 1MB        273.702 us    197.222 us (28% improve)
>>>>
>>>> SMC-D with smc-loopback
>>>> msgsize   noautosplit    autosplit
>>>> 128KB       14.672 us     14.690 us
>>>> 256KB       28.277 us     23.958 us (15% improve)
>>>> 512KB       63.047 us     45.339 us (28% improve)
>>>> 1MB        129.306 us     87.278 us (32% improve)
>>>>
>>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>>>> ---
>>>>    Documentation/networking/smc-sysctl.rst | 11 +++++++++++
>>>>    include/net/netns/smc.h                 |  1 +
>>>>    net/smc/smc_sysctl.c                    | 12 ++++++++++++
>>>>    net/smc/smc_tx.c                        | 19 ++++++++++++++++++-
>>>>    4 files changed, 42 insertions(+), 1 deletion(-)
>>>>
>>>
>>> Hi Guangguan,
>>>
>>> If I remember correctly, the intention to use one RDMA-write for a possible large data is to reduce possible many partial stores. Since many year has gone, I'm not that sure if it would still be an issue. I need some time to check on it.
>>>
>>
>> Did you mean too many partial stores will result in some issue? What's the issue?
>>
Forget it, I did verify that the partial stores should not be problem now.
>>
>>> BTW, I don't really like the idea to use sysctl to set the autosplit_size in any value at will. That makes no sense to improve the performance.
>>
>> Although 128KB autosplit_size have a good performance in most scenario, I still found some better autosplit_size for some specific network configurations.
>> For example, 128KB autosplit_size have a good performance whether the MTU is 1500 or 8500, but for 8500 MTU, 64KB autosplit_size performs better.
>>
>> Maybe the sysctl is not the best way, but I think it should have a way to set the value of autosplit_size for possible performance tuning.
>>
mhhh, that could be a good reason to use sysctl.
>> Thanks,
>> Guangguan Wang
>>
> 
> Hi Wenjia,
> 
> Is there any update comment or information about this patch?

Hi Guangguan,

sorry for the delayed answer. In the last time it is really difficult 
for me to find time to look into it and test it. With more thinking, I'm 
kind of convinced with this idea. But test is still needed. I'll be in 
vacation next 3 weeks. I hope it is okay for you that I'll test it as 
soon as possible when I'm back. If everything is ok, I think we can let 
it go upstream.

Thanks,
Wenjia


> 
>>>
>>> Thanks,
>>> Wenjia
