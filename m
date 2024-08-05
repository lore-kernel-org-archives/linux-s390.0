Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80439149E17;
	Mon,  5 Aug 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844471; cv=none; b=CITCYVFjepH0ifkg/KcQiQCo3uzrDvLYQE3znrxbmesrVHwo9Ap24FkCYxwcZpC00CPVD1p6oxnPd8qqV76rVnS8TkTJkBTNGpOlM1UazXMxnJerKkwVRYRbenv9fyYLripojW0tdBbLGl5Qz4zmCx5icDoeeHC7LS3S7d58miY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844471; c=relaxed/simple;
	bh=jKmTSG00DMKTfg1HqHIorO/0Bgx+cvnSS5/R4xnJ11I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcpfhisaogGlUO79y1r16eso7kRrtg6zMr+BVM8+j1eGZvzSFiqH9tRLvfXPX4LsPYRUvFd39/yn4+2jeXwNlsSKsQ2hK2vIIyzx4eWy7yWoL6twxLycoS8J8tOY1PFJewNiWCt6MVcsJBu/CtucZnuumJF1lipUAVjSpfGjf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sgDME0fY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sgDME0fY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4757Sfjs001407;
	Mon, 5 Aug 2024 07:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=U
	ZoJxSgnE/yNZ+Fis1+G009jYZmw/LXvTKFFjbjBa4Y=; b=sgDME0fY90mi3ImGT
	RRobmRAAv/5T9wWWfxUqKa0KtR3hF2b3+KN/XEWQZWPfB+kbUwbBChGqcPdKf+xh
	OJglZQtwyMM1QdgoToxpX90EMABcCY6DQVOW5pr0mI+2d+VV7rEH96uRxyQwG9rY
	rdvirfuMs42jUq+e6E6tMeyeUYNsy2exmnB+1s32V2wANbPzwsmW5nOgDfz1ryBu
	p/10UHJYEiRyAFCjeKoRircQUltvA0sMG5GtZLbOQf3pXeQ/mUyhcU7hhMxv3FlB
	kE61N+/OCxqVhK/1M96GRNp3JRu9o3UERz/GeeuHXqY1hRjJ42sgQR4nRmf7tQaW
	7MCNg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ttcj81gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 07:54:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4757s3aG010596;
	Mon, 5 Aug 2024 07:54:03 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ttcj81gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 07:54:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 475670nB018783;
	Mon, 5 Aug 2024 07:54:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40sxvtwkcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 07:54:02 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4757rxWk25821820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Aug 2024 07:54:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9452158063;
	Mon,  5 Aug 2024 07:53:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7738D58052;
	Mon,  5 Aug 2024 07:53:57 +0000 (GMT)
Received: from [9.171.14.14] (unknown [9.171.14.14])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Aug 2024 07:53:57 +0000 (GMT)
Message-ID: <4cae5795-df27-45b5-9b95-9a5160f6319c@linux.ibm.com>
Date: Mon, 5 Aug 2024 09:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v2] net/smc: add the max value of fallback reason
 count
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, guangguan.wang@linux.alibaba.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240805043856.565677-1-shaozhengchao@huawei.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240805043856.565677-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IW1FqppzYvjG1GTLqFg0P3gmcs8Vyz19
X-Proofpoint-GUID: 1mPZc4zYoJg4H5tv4sEh9HR42dlOtUkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050051



On 05.08.24 06:38, Zhengchao Shao wrote:
> The number of fallback reasons defined in the smc_clc.h file has reached
> 36. For historical reasons, some are no longer quoted, and there's 33
> actually in use. So, add the max value of fallback reason count to 36.
> 
> Fixes: 6ac1e6563f59 ("net/smc: support smc v2.x features validate")
> Fixes: 7f0620b9940b ("net/smc: support max connections per lgr negotiation")
> Fixes: 69b888e3bb4b ("net/smc: support max links per lgr negotiation in clc handshake")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: add fix tag and change max value to 36
> ---
>   net/smc/smc_stats.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
> index 9d32058db2b5..e19177ce4092 100644
> --- a/net/smc/smc_stats.h
> +++ b/net/smc/smc_stats.h
> @@ -19,7 +19,7 @@
>   
>   #include "smc_clc.h"
>   
> -#define SMC_MAX_FBACK_RSN_CNT 30
> +#define SMC_MAX_FBACK_RSN_CNT 36
>   
>   enum {
>   	SMC_BUF_8K,

It looks good to me!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
