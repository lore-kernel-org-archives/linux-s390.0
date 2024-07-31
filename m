Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7151BBBF3;
	Wed, 31 Jul 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438968; cv=none; b=jNPgU7v/iNlHpNatx5WsTRBDtD37JHr96Jpll0Od0ojopqDeVrj+edW1eakWZbDEzLpbECZvXF6VYSIaTHndQ6DByP1G5vlc6fqs+NHJvPcxkOKbHeelg0CsXTTs8MBFZFhxqfYV1ZHuLKlMvt/FJ6RuO0DFfHj1rAytelJAzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438968; c=relaxed/simple;
	bh=jolx9BGDYLP9A+4+aqGoLnq4/sxcncVL02wpEp+6Tqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLYkmT1rVehWXwicP9DMzqq4DlQJWNedFDKr657zZUqb4c0qySftdBY2tWa5/gwCEVt2gP7H5MCuCDbBJnXbtwyS43Zg8bsOlcvUkxgQM+ef8uyYUd3xDQiq9zN5Rv6fN7/FaUGmj205LAPf8NE6Mq9oxkGVjGqFH6TwrsYCKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tfo3HSHp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tfo3HSHp"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VCwGiE030529;
	Wed, 31 Jul 2024 15:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=s
	hciHTYQxY4vJQpKHVCVTxCvhqqvg3jNSW5K02Yr4kI=; b=Tfo3HSHpsEeo5PMX8
	7Zguna/2XsnAKWiBv8P4EqPX3D63EKSNfbPONHfdFhJ69MsqKMpqT/ry5xseGrUU
	7S1aQzN6AojB88n6F7Sa3gOXL2JJ/Df8TeO6fFNurdFV5fikXUKAT0DSPvAyOToH
	PzMj+bVADXZoI2AJ04AQTlsPf4DHD4H6FDjm/4Dd2eyXTvovNzqQEXJNYkYzZJwP
	zV+B28kclb9MC1u0nsMLU73SUsF/ZobUJtSdCgZN6zsu6r8pvYNh84DHz4wgyku+
	0eAXztWD19/Q43gpVSUMm4J28WyK9XlANw4HmHGGzsflkhhJREu9X7MRYAP6Elzc
	k/kUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qnr7rfqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:15:54 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46VFFril021992;
	Wed, 31 Jul 2024 15:15:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qnr7rfqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:15:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46VF0wIZ018811;
	Wed, 31 Jul 2024 15:15:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pvacv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:15:51 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VFFnPk16253560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 15:15:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47A5858063;
	Wed, 31 Jul 2024 15:15:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EF635806A;
	Wed, 31 Jul 2024 15:15:47 +0000 (GMT)
Received: from [9.171.16.65] (unknown [9.171.16.65])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 15:15:47 +0000 (GMT)
Message-ID: <4232f3fb-4088-41e0-91f7-7813d3bb99e5@linux.ibm.com>
Date: Wed, 31 Jul 2024 17:15:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net/smc: remove the fallback in
 __smc_connect
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-3-shaozhengchao@huawei.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240730012506.3317978-3-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e7BE8TNEEYsWgHAGCr98P5zusW4xsdds
X-Proofpoint-GUID: 15y9bYQaYffqyTMYumONZmytPYgPDG7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_09,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 mlxscore=0 mlxlogscore=958 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310105



On 30.07.24 03:25, Zhengchao Shao wrote:
> When the SMC client begins to connect to server, smcd_version is set
> to SMC_V1 + SMC_V2. If fail to get VLAN ID, only SMC_V2 information
> is left in smcd_version. And smcd_version will not be changed to 0.
> Therefore, remove the fallback caused by the failure to get VLAN ID.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   net/smc/af_smc.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 73a875573e7a..83f5a1849971 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1523,10 +1523,6 @@ static int __smc_connect(struct smc_sock *smc)
>   		ini->smcd_version &= ~SMC_V1;
>   		ini->smcr_version = 0;
>   		ini->smc_type_v1 = SMC_TYPE_N;
> -		if (!ini->smcd_version) {
> -			rc = SMC_CLC_DECL_GETVLANERR;
> -			goto fallback;
> -		}
>   	}
>   
>   	rc = smc_find_proposal_devices(smc, ini);

Though you're right that here smcd_version never gets 0, it actually is 
a bug from ("42042dbbc2eb net/smc: prepare for SMC-Rv2 connection"). The 
purpose of the check here was to fallback at a early phase before 
calling smc_find_proposal_devices(). However, this change is not wrong, 
just I personally like adding a check for smc_ism_is_v2_capable() more.

Thanks,
Wenjia
