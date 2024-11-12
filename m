Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E620B1FA;
	Tue, 12 Nov 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396987; cv=none; b=GUr0xrNCaxwsEIAUCt+mn+kjmq9akzzgQVUioMPBDks0/7z7keIxQckuSM/GW0CSI8Qd2RZus9DRkschgZNsLyv973ynsTeBTx55+8JIyh0JX9xa4uCpRv+Ylyk+kKKT7fhenML0YqSHp5gUZttWGKmIf7+1mENVAlcwfG4A+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396987; c=relaxed/simple;
	bh=k4zTfjT84si84xCq8iTqVbTWKrn2+mUh2Lh8rW5aaGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J1MqvYFMaL51yvJ4sQuJKbBAavHDeHS4jHPnTQrldmxQDLiDYCba9rfJN29fayB2BZsgybNvBNa4q8OxWUTkZPj4/aRYChVehOn5WsMBG0YtP6z93P9b2ejFULswXcwLhRXUfItRo8Ies3O8TNdy8Ixr406+NRJp23CYzYyPwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y6gSJDLu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y6gSJDLu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC5Y0iB023042;
	Tue, 12 Nov 2024 07:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/9p8ZN
	ikNrrp5jzJZQo7AZkbhesZPvKcmOnCsNX8aGw=; b=Y6gSJDLu6VYoXFKq11fI8j
	ON1q2CYCXMgmdpHQHTwDkT9UcyCNTua9A4ff7Y8mU3tl11Ut2F4djdZxGXNMAc6L
	S2rIas1zE12mBbatYBfwpEj3dELJHP6Wk/EbVQuIkC6O4IaMzF1RRDBYy9BWiZyf
	EbPI8gt9Ohk669JFO1pK43h2Sb2CYeeMfGKm6JxVLl5Z0IhvjoLcZKMHBuCaQS3y
	JP9jr3tev7D1wj0WNjs5vX0HfOP4sDdTBH94qIZVOcQGcr8252+vQoggmY4l1wnN
	ZhCqvLKs6iM/X2qVsXCbD/y3zeU75OhYIXSTyBE1V1a04r2f1zwV+yDAoB2D/ahQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v0ynrdgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:36:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AC7aI2C003686;
	Tue, 12 Nov 2024 07:36:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v0ynrdgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:36:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABMpg2I027901;
	Tue, 12 Nov 2024 07:36:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s3w08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:36:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AC7aGvv52298178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 07:36:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D125841D;
	Tue, 12 Nov 2024 07:36:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B04058427;
	Tue, 12 Nov 2024 07:36:14 +0000 (GMT)
Received: from [9.152.224.138] (unknown [9.152.224.138])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 07:36:14 +0000 (GMT)
Message-ID: <538b7781-0d57-45e6-a00a-fb03c0c30a52@linux.ibm.com>
Date: Tue, 12 Nov 2024 08:36:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove unused function parameter in __smc_diag_dump
To: Manas <manas18244@iiitd.ac.in>
Cc: Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
 <ae8e61c6-e407-4303-aece-b7ce4060d73e@linux.ibm.com>
 <niqf7e6xbvkloosm7auwb4wlulkfr66dagdfnbigsn3fedclui@qoag5bzbd3ys>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <niqf7e6xbvkloosm7auwb4wlulkfr66dagdfnbigsn3fedclui@qoag5bzbd3ys>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sfYniwUHAwkfgzaFpbBjHpFGg9vlxRjb
X-Proofpoint-GUID: oYBnNRG1D8cmFhwqIDESKdzO8_8B8fCg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=988 suspectscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120061



On 11.11.24 16:10, Manas wrote:
> On 11.11.2024 15:11, Wenjia Zhang wrote:
>>
>>
>> On 09.11.24 07:28, Manas via B4 Relay wrote:
>>> From: Manas <manas18244@iiitd.ac.in>
>>>
>>> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
>>> There is only one instance of this function being called and its passed
>>> with a NULL value in place of bc.
>>>
>>> Signed-off-by: Manas <manas18244@iiitd.ac.in>
>>> ---
>>> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
>>> There is only one instance of this function being called and its passed
>>> with a NULL value in place of bc.
>>>
>>> Though, the compiler (gcc) optimizes it. Looking at the object dump of
>>> vmlinux (via `objdump -D vmlinux`), a new function clone
>>> (__smc_diag_dump.constprop.0) is added which removes this parameter from
>>> calling convention altogether.
>>>
>>> ffffffff8a701770 <__smc_diag_dump.constprop.0>:
>>> ffffffff8a701770:       41 57                   push   %r15
>>> ffffffff8a701772:       41 56                   push   %r14
>>> ffffffff8a701774:       41 55                   push   %r13
>>> ffffffff8a701776:       41 54                   push   %r12
>>>
>>> There are 5 parameters in original function, but in the cloned function
>>> only 4.
>>>
>>> I believe this patch also fixes this oops bug[1], which arises in the
>>> same function __smc_diag_dump. But I couldn't verify it further. Can
>>> someone please test this?
>>>
>>> [1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
>>> ---
>>>  net/smc/smc_diag.c | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
>>> index 
>>> 6fdb2d96777ad704c394709ec845f9ddef5e599a..8f7bd40f475945171a0afa5a2cce12d9aa2b1eb4 100644
>>> --- a/net/smc/smc_diag.c
>>> +++ b/net/smc/smc_diag.c
>>> @@ -71,8 +71,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, 
>>> struct sk_buff *skb,
>>>  static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>>>                 struct netlink_callback *cb,
>>> -               const struct smc_diag_req *req,
>>> -               struct nlattr *bc)
>>> +               const struct smc_diag_req *req)
>>>  {
>>>      struct smc_sock *smc = smc_sk(sk);
>>>      struct smc_diag_fallback fallback;
>>> @@ -199,7 +198,6 @@ static int smc_diag_dump_proto(struct proto 
>>> *prot, struct sk_buff *skb,
>>>      struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
>>>      struct net *net = sock_net(skb->sk);
>>>      int snum = cb_ctx->pos[p_type];
>>> -    struct nlattr *bc = NULL;
>>>      struct hlist_head *head;
>>>      int rc = 0, num = 0;
>>>      struct sock *sk;
>>> @@ -214,7 +212,7 @@ static int smc_diag_dump_proto(struct proto 
>>> *prot, struct sk_buff *skb,
>>>              continue;
>>>          if (num < snum)
>>>              goto next;
>>> -        rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
>>> +        rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
>>>          if (rc < 0)
>>>              goto out;
>>>  next:
>>>
>>> ---
>>> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
>>> change-id: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4
>>>
>>> Best regards,
>>
>> That's true that the last parameter is not used. And the patch you 
>> suggested as a cleanup patch looks good to me. However, it should not 
>> fix the bug[1], because it does not match what the bug[1] described. 
>> Thank you, Jeongjun, for testing it! That verified that it indeed 
>> didn't fix the issue. I think the root cause is on handling 
>> idiag_sport. I'll look into it.
>>
>> [1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
>>
>> Thanks,
>> Wenjia
> 
> Thank you Wenjia for reviewing this.
> 
> Should I make any changes to the commit message if we are going forward 
> with it
> being as a cleanup patch? The commit message itself (barring the cover 
> letter)
> should be enough, I reckon.
> 
I think it is ok as it is.

Thanks,
Wenjia
