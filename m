Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5991157493;
	Thu,  1 Aug 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497056; cv=none; b=oey4SysAwFfCVYHDEYiXc2l9S4Nm9+aXe/e5soBuSRvTyYPLfYN1tInrha+t9k4gz9+Br4qLss2utbYVb8mT6obm9b7eFGhKZIygwISpGqPgeoWbQPnCoL59H206noFcwSNAU743YM8wtv7dp2KmN4qiXp7tU3sO+czkwugqWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497056; c=relaxed/simple;
	bh=a3y4+l/5DEEXcnzFWwsOoxYOa/XzqjijqIC8DQdykqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJb3/KXHBOajRewZ/W3QWghEDr4VYjTZNJJ0eO4J0eRZDnia8jVvo0YoRe3L1uoLf58CCjApB2WIO8TA6sQ5hwN+1i7GuoVOaLaWrVP2Uj3eHPkrmyaf6/Ctd1wNwfJimZfxbUvy7cJAtl2lgGidtOLEgrasCAO/3KfqYpDsduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NB6qK+er; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NB6qK+er"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4713Q6LT005686;
	Thu, 1 Aug 2024 07:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=U
	Jla+A4kFuOwPwsfgduSuWQJKdSzFuoXVPer8qWx6vU=; b=NB6qK+er5cPpIe9yl
	WI6vgKvRFfnEHDCeL6leYTJfse+JncPmD66023viYyA5nXWPXCAXXF4DdKmI3uat
	xAqNICdlntquLHeE2iPMDjJETD56I9yD6xHmPyp8fxVKEB1kBs2dInE4in/1zCZn
	wifTPsV38y4UR0myJ4AvRAEtuUCwgwxwx37icFYlW0VreKJkEC+sLtvPYXhKGilB
	RIhMFs5Y58Xm8L54JpC6acVfxMIXMf/UwbBztDPlXuTyE0EmofkpdBUG07ByeZac
	Gg7vB2R8BWQOv+1cI84HZJtnyAsRM9AwVwLL4osZI06r0awCOKeOx2tzEOefDnRo
	xu8Ig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyup8tqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:24:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4717O09q016264;
	Thu, 1 Aug 2024 07:24:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyup8tqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:24:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47158aEI018863;
	Thu, 1 Aug 2024 07:23:59 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q0e9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:23:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4717NuOb17760812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 07:23:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C45C258057;
	Thu,  1 Aug 2024 07:23:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E0858061;
	Thu,  1 Aug 2024 07:23:54 +0000 (GMT)
Received: from [9.171.74.62] (unknown [9.171.74.62])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 07:23:54 +0000 (GMT)
Message-ID: <89b65343-2345-4b4f-ad3f-5410c5436e8b@linux.ibm.com>
Date: Thu, 1 Aug 2024 09:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net/smc: remove the fallback in
 __smc_connect
To: shaozhengchao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-3-shaozhengchao@huawei.com>
 <4232f3fb-4088-41e0-91f7-7813d3bb99e5@linux.ibm.com>
 <70dea024-dfbe-1679-854f-8477e65bc0f8@huawei.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <70dea024-dfbe-1679-854f-8477e65bc0f8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0b6oiBfVunL5U75aGGK9oA0M4aJZpu6W
X-Proofpoint-ORIG-GUID: e99rFmdp3vbDim9ipw8RDjYDTMChzOKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010042



On 01.08.24 03:22, shaozhengchao wrote:
> Hi Wenjia Zhang:
>     Looks like the logic you're saying is okay. Do I need another patch
> to perfect it? As below:
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 73a875573e7a..b23d15506afc 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1523,7 +1523,7 @@ static int __smc_connect(struct smc_sock *smc)
>                  ini->smcd_version &= ~SMC_V1;
>                  ini->smcr_version = 0;
>                  ini->smc_type_v1 = SMC_TYPE_N;
> -               if (!ini->smcd_version) {
> +               if (!smc_ism_is_v2_capable()) {
>                          rc = SMC_CLC_DECL_GETVLANERR;
>                          goto fallback;
>                  }
> 
> 
> Thank you
> 
> Zhengchao Shao
> 

Hi Zhengchao,

I see your patches series were already applied yesterday. So It's okay 
to let it be now. As I said, your changes are not wrong, just not clean 
enough IMO. Anyway, thanks for your contribution to our code!

Thanks,
Wenjia
