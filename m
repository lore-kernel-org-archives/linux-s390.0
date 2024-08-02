Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FE1DAC6C;
	Fri,  2 Aug 2024 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597478; cv=none; b=M6izX96Io29zIughrsEvWizPos99pJgIS7U3h8Q0v2wrMu01YJBbZE9GBz/H1jqLCCYQMi401BolsJdega6ELyw1jma7+4FmgjpJOiYdiPsXUNznU31NsjIi9JB9IcpcHe82nuKpqVZOIDtcSg33t4cvhbAAdMRPzSMBC5Qc9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597478; c=relaxed/simple;
	bh=z2Nh80bf4FBnauFxgHw19z6FQSwpa3j+v8OTo2V+2EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufuMPFyPQ9l3xEPlEpopr/vPSRIirxYSSIOU12IKKj3c0Fa8Z+D7rVQwW+do/6rO+RQ1zp+As8dR54ZB0PB/BTa9M5AAETZVn3Jz7HzhtcSxqAqWUb4mMiVI/apQbstg9rKyrltQfBUkYl2efWBfWMSDxDSXYnB4LB07KuYUAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kFD6Hepg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kFD6Hepg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472AxPF5020500;
	Fri, 2 Aug 2024 11:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=G
	lqqVAj+Ob5OUpRMsA/EkiVIIsDfu2tE5QDc9aQ+K+E=; b=kFD6HepgYnInaMNuA
	rGMnNE9swYWlfr1eLApG/9impzY7J9uXlF8AR6FJxIGL1iIQsJnwfxAoS9NnEHCY
	/R8aWRuE2NYzkzB+i5r8Vjwgb+v9rohC0EGIZMSgFWVUx3fguZMy6C5JsvDuyEHS
	s91yx/wq9oPqEPKWJToycmZ0jTcv/+wSQbD33+UxzgbOmtm3PejCss3LL3qdF/Kv
	GPzNJCTtkv4UU0dEpMdRIPT9Erqf5aIbd3aiUwxovl+G6qA3ytuWwAw475FBRVP3
	D08p/8t2BOsB5xoydmiQAjaQRipwREOl0gReYUM+APJltyZmMKJ9DjurgFCY6+rr
	plPBQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rx6eg175-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 11:17:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472BHaGg017981;
	Fri, 2 Aug 2024 11:17:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rx6eg170-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 11:17:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472AGDqP029094;
	Fri, 2 Aug 2024 11:17:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm17255-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 11:17:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472BHXi951577132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 11:17:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 909135805A;
	Fri,  2 Aug 2024 11:17:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44AC58051;
	Fri,  2 Aug 2024 11:17:31 +0000 (GMT)
Received: from [9.179.25.59] (unknown [9.179.25.59])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 11:17:31 +0000 (GMT)
Message-ID: <4213b756-a92f-4be9-951d-893f4a6590b4@linux.ibm.com>
Date: Fri, 2 Aug 2024 13:17:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add the max value of fallback reason
 count
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: jaka@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240801113549.98301-1-shaozhengchao@huawei.com>
 <a69bfb91-3cfa-4e98-b655-e8f0d462c55d@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <a69bfb91-3cfa-4e98-b655-e8f0d462c55d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ykj1ECCnJGEzHCYKLJRX8lALZXrbIYa_
X-Proofpoint-ORIG-GUID: 8k6MWiaA6Sd9Lkhnyhi0_5XEaPT9PLfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_07,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020073



On 02.08.24 04:38, D. Wythe wrote:
> 
> 
> On 8/1/24 7:35 PM, Zhengchao Shao wrote:
>> The number of fallback reasons defined in the smc_clc.h file has reached
>> 36. For historical reasons, some are no longer quoted, and there's 33
>> actually in use. So, add the max value of fallback reason count to 50.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   net/smc/smc_stats.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
>> index 9d32058db2b5..ab5aafc6f44c 100644
>> --- a/net/smc/smc_stats.h
>> +++ b/net/smc/smc_stats.h
>> @@ -19,7 +19,7 @@
>>   #include "smc_clc.h"
>> -#define SMC_MAX_FBACK_RSN_CNT 30
>> +#define SMC_MAX_FBACK_RSN_CNT 50
> It feels more like a fix ？
> 
>>   enum {
>>       SMC_BUF_8K,
> 

Hi Zhengchao,

IMO It should be 36 instead of 50 because of unnecessary smc_stats_fback 
element and  unnecessary scanning e.g. in smc_stat_inc_fback_rsn_cnt(). 
If there is any new reason code coming later, the one who are 
introducing the new reason code should update the the value correspondingly.
Btw, I also it is a bug fix other than feature.

Thanks,
Wenjia
