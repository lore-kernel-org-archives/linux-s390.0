Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5B15E83;
	Tue,  4 Jun 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513826; cv=none; b=CBc2CotA/qy3TyfA2VYQcwpIAujCTe7dvaIzJmJHoUo8G/DBMD9mTQ0tUcZia6yXdyZfw60Akf5seF+lDqbWbpQ3ecvcsr2CMDwuBP5SUFy4zcCT0hQ+AksG8JxrqUgGGBU2L6y1wzX+jKM/KejJ4pqnNK4IYlZ+Bjs5aR2OsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513826; c=relaxed/simple;
	bh=AlE9DgWtRIT3Sl1kuWd/rWKZ1j/Yhf4kD3Y4KDvJzig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6zDMestTYakQJkR6fl9b9CSvZ+j1xcrjIvl+p4UmEdUqnVcWZ4lAEFOSkUWs5nkisA8JwpSR6A5XHi5rWm952VuhExewOGfM4oCkaboew7dK0Eyvy9Vx8IxzM5HenQxMgQjuLGoqizViRCiWIwI+Bn7CKmYdLpSFxh53/Wru7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gpmdXhgr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gpmdXhgr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454ENLXt005287;
	Tue, 4 Jun 2024 15:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=EfYv5g/Zd/sx7KqBxGNFgf5KwapbaCyVevFzqEDsdxE=;
 b=gpmdXhgr/uN6nuEaX3GXtGNl5jr8DFLej9LnwMMvFFz8j5XexWt5DAMeZJUvdbvAOIak
 Vf1MzG05SVZ4YK+dZ44JfyJz/zThLI14TdjTd5UFibJRhH2CERT0UsR0WCxbxSR7nYU2
 iu86Hw1nd4UBwmHhop9IpUDGSVWydtkChGntpGlWSWB8JT10AUnm/rt8mPdwgkVjlovS
 8R0MJ7KeJWJTZLobh8PH5B+i72RZ9YoJ0L089lPiUvVcvFigm+Ah6tzaXTLEZRh/IgQm
 5vzdP2fWXUOawzcdvDWP+BtrrqGdD8uqO3z7FyuaDDObZE965X+mVfYG6Rm45HyF5sI6 vA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj4mrr5at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 15:10:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 454FAKjx023916;
	Tue, 4 Jun 2024 15:10:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj4mrr5am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 15:10:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 454F9LLj008468;
	Tue, 4 Jun 2024 15:10:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec0pwhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 15:10:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 454FAFo98979186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 15:10:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E25A58065;
	Tue,  4 Jun 2024 15:10:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BEA858058;
	Tue,  4 Jun 2024 15:10:13 +0000 (GMT)
Received: from [9.155.211.217] (unknown [9.155.211.217])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2024 15:10:13 +0000 (GMT)
Message-ID: <9f9fca15-9139-40c9-bd24-2e0f2b7e4d6e@linux.ibm.com>
Date: Tue, 4 Jun 2024 17:10:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: avoid overwriting when adjusting sock
 bufsizes
To: Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>,
        gbayer@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240531085417.43104-1-guwen@linux.alibaba.com>
 <d5e4c3093a68f38657b8061bcbf51396e1d23bab.camel@redhat.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <d5e4c3093a68f38657b8061bcbf51396e1d23bab.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pmYrMHbQCBj2dDIroL0AfLjkIQ6r3fZW
X-Proofpoint-ORIG-GUID: Tv4icvBosYcQtaS2GYnIMkwwCz5R2xZG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=992 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040121



On 04.06.24 16:04, Paolo Abeni wrote:
> On Fri, 2024-05-31 at 16:54 +0800, Wen Gu wrote:
>> When copying smc settings to clcsock, avoid setting clcsock's sk_sndbuf
>> to sysctl_tcp_wmem[1], since this may overwrite the value set by
>> tcp_sndbuf_expand() in TCP connection establishment.
>>
>> And the other setting sk_{snd|rcv}buf to sysctl value in
>> smc_adjust_sock_bufsizes() can also be omitted since the initialization
>> of smc sock and clcsock has set sk_{snd|rcv}buf to smc.sysctl_{w|r}mem
>> or ipv4_sysctl_tcp_{w|r}mem[1].
>>
>> Fixes: 30c3c4a4497c ("net/smc: Use correct buffer sizes when switching between TCP and SMC")
>> Link: https://lore.kernel.org/r/5eaf3858-e7fd-4db8-83e8-3d7a3e0e9ae2@linux.alibaba.com
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>> FYI,
>> The detailed motivation and testing can be found in the link above.
> 
> My understanding is that there is an open question here if this is the
> expected and desired behavior.
> 
> @Wenjia, @Jan: could you please have a look?
> 
> Thanks!
> 
> Paolo
> 
> @Paolo, thank you for reminding us!

@Wen, Gerd and I have looked into your patch and discussed on it. Gerd 
would send the concrete answer to your question soon.

Regarding to this patch, it looks good to me. Here you are:

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia

