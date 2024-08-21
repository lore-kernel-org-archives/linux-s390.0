Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F32168481;
	Wed, 21 Aug 2024 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218895; cv=none; b=jAkmy0swwSNVxCbLUewEhOD+sSjot55JtXIyqMKljvT3njyFWGj3JYKT3V1Yfv5XzQQgN8AcpPJln7N2XLMu+auoZAKs/4FG4CffY+BK5UzyxHL16jUaW5JmBrnkcOcloeG+l+hcASZ3SaKV57D5TMQqAOnUdwWQvF53+TQLjdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218895; c=relaxed/simple;
	bh=NZBHryVxFojpU5sCj/uVc2of6RuYZqHTsEnPR6vIIfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bEed+IIHP1OcZntdZeBhhFT71qfWnpOItJNAqTpI1QhL6fx5V0x0sQ4FwEGHr+N3SmnQ2m++4pF4N/c5y714hT13o1SvMrd+GYr663Hl9jGWnK/fnIlrABmlsrrT/C22rvmSmuUWxCVvwc/xDMmveqo+hHXx9adMm1K6xfVeoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=saJD4FMy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="saJD4FMy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L40kuc016940;
	Wed, 21 Aug 2024 05:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	ibIwXlc6fzBzPDKDeQmnnLo8tqZKeLqZR84SDET8VlU=; b=saJD4FMygwWcVv1d
	uC7nCJ4DfT8xHHO0iNEAkgBIIq1xXWJi8lTm8btBrIq7yaVKsb8OYXwhCgy4hQF/
	uhX64kdupz+Hoz5Iu92bwRzBh0VXbZG+pQdKn2bf21OIT/vIHCTAlqrofn3xM3k4
	qZoJ3YsehnENh3M4omz+Rlvsu9Je3WAuLiskA3H2aBcKwK2ZYbGRbi5STgJuJeZu
	9Nw61TyTqKF0pJOLHejV1sZt7gf+l2Yvfp7+K4QCbOj1bWLME86THLOunIOm1+Pf
	px/YVXeBuzE989I9IBRKEftqZjATwlRBWUJajHwOFQZQrkFtTgJJB/TkLtgehFpU
	HhdRrQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma096ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:41:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L5fQRB021689;
	Wed, 21 Aug 2024 05:41:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma096k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:41:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L5ES96029443;
	Wed, 21 Aug 2024 05:41:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dme2gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:41:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L5fKts54722902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 05:41:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39C7820043;
	Wed, 21 Aug 2024 05:41:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68B3420040;
	Wed, 21 Aug 2024 05:41:19 +0000 (GMT)
Received: from [9.179.3.132] (unknown [9.179.3.132])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 05:41:19 +0000 (GMT)
Message-ID: <42f2d707-cf7e-4cb7-a10b-8bd2e851879e@linux.ibm.com>
Date: Wed, 21 Aug 2024 07:41:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v5,2/2] net/smc: modify smc_sock structure
To: Paolo Abeni <pabeni@redhat.com>, Jeongjun Park <aha310510@gmail.com>,
        wenjia@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        dust.li@linux.alibaba.com, ubraun@linux.vnet.ibm.com,
        utz.bacher@de.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815043714.38772-1-aha310510@gmail.com>
 <20240815043904.38959-1-aha310510@gmail.com>
 <e0f35083-7604-4766-990a-f77554e0202f@redhat.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <e0f35083-7604-4766-990a-f77554e0202f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aph8l7bIcRkfknxgwDDbdykuK_34DILh
X-Proofpoint-ORIG-GUID: wU-ztOuHpx7xYQ6S_9d1tUNwr6gWLN-W
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_05,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=881 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210038



On 20/08/2024 12:45, Paolo Abeni wrote:
> 
> 
> On 8/15/24 06:39, Jeongjun Park wrote:
>> Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
>> point to the same address, when smc_create_clcsk() stores the newly
>> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
>> into clcsock. This causes NULL pointer dereference and various other
>> memory corruptions.
>>
>> To solve this, we need to modify the smc_sock structure.
>>
>> Fixes: ac7138746e14 ("smc: establish new socket family")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> ---
>>   net/smc/smc.h | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>> index 34b781e463c4..0d67a02a6ab1 100644
>> --- a/net/smc/smc.h
>> +++ b/net/smc/smc.h
>> @@ -283,7 +283,10 @@ struct smc_connection {
>>   };
>>   struct smc_sock {                /* smc sock container */
>> -    struct sock        sk;
>> +    union {
>> +        struct sock        sk;
>> +        struct inet_sock    inet;
>> +    };
>>       struct socket        *clcsock;    /* internal tcp socket */
>>       void            (*clcsk_state_change)(struct sock *sk);
>>                           /* original stat_change fct. */
> 
> As per the running discussion here:
> 
> https://lore.kernel.org/all/5ad4de6f-48d4-4d1b-b062-e1cd2e8b3600@linux.ibm.com/#t
> 
> you should include at least a add a comment to the union, describing 
> which one is used in which case.
> 
> My personal preference would be directly replacing 'struct sk' with
> 'struct inet_sock inet;' and adjust all the smc->sk access accordingly, 
> likely via a new helper.
> 
> I understand that would be much more invasive, but would align with 
> other AF.

Hi all,

thanks for looking into this patch and providing your view on this topic.

My personal prefernce is clean. I want to have a clean SMC protocol, in 
order to get it on a good path for future improvements.
The union, IMO, is not clean. It makes the problem less implicit but the 
problem is still there.

Jeongjun, do i understand correct that you've tested the change proposed 
by Alexandra with more changes required?

"""
Although this fix would require more code changes, we tested the bug and
confirmed that it was not triggered and the functionality was working
normally.
"""
https://lore.kernel.org/all/20240814150558.46178-1-aha310510@gmail.com/

If so would you mind adding a helper for this check as Paolo suggested 
and send it?
This way we see which change is better for the future.

The statement that SMC would be more aligned with other AFs is already a 
  big win in my book.

Thanks
- Jan

> 
> Thanks,
> 
> Paolo
> 
