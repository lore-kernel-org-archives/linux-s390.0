Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20219DF45;
	Tue, 16 Jul 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140398; cv=none; b=n06yIxgzElG/XiEO9PXlmzb5rxNFzp7bn1sRWE2e+WPI5luQPL/yatJzlnQk3bNzA/z/ap3fjloKxtc4x/cQi8TLdbv4U4QuqkZ8pL36loWCg//yX2AZeBguJUNBBOBZLrZQA47VvxxB/i6YYQUparT0AbpCh2neGCCZU1+/v+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140398; c=relaxed/simple;
	bh=m9NKmdoKsNarqd6m9cXGSCZPLF1ijwhfB/GRQkLKl/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TT7QUvECIHlHky/6vo9KPMTMFie00d4GHYi86SMD+nZaywhYFUqXGMgsmIUwB6GEgadug28H904fU/MgebP4TZIWttAgSsq3+VvQ7DDFT5otbPQnZ5jwsxn1SO0f6ajNQW9HlUDYTZ1Md4DYUIE1QCCW4NVPkqCqneTelHEkUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pk00c7DN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pk00c7DN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GCfZl3030065;
	Tue, 16 Jul 2024 14:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kwjQ3NZ7uHYccC/MYMKHsu+Em3bShdpRHOP+3vLllKo=; b=pk00c7DNgSDs23Bi
	VcA4wnfTdLSSKobuIhNCsp2g2QohzUubtV/DPiLtgLxo190vPlT+YGw/XWP4OdQ6
	De0EiSGQTIHutr9TWjR1M5aj7yVrvbGZ8pSsTP5dCYWQA0Oyt+Zxb2rgLDnXD+4r
	2HTsJb6biFkZtt4aEX2l8ogqpZvPcnXTK60vFhdTR3rqFrieiGdwp0ophoKGPFTe
	TT/MKenJBR5TehluU4Wv7dJqRwos4uoEJLuRqgDEXvN24VjDUhIxFNw/rWb3AHbN
	NRFNBw5mB7gd+MFKqG2Qk+liUKZ9SKZa53o6TVpHJ4B2ucPJCEG3ok4ly334Xr6V
	9DryHg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bgwg79vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 14:33:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GEXCbf017449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 14:33:12 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 07:33:05 -0700
Message-ID: <4bc3e19d-99eb-4004-a6ff-9ab9dc015cde@quicinc.com>
Date: Tue, 16 Jul 2024 07:33:04 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner
	<hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC: <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240615-md-s390-drivers-s390-block-dasd-v1-1-36b200f14344@quicinc.com>
 <2c2655ad-2a2a-4180-8a31-828a7531af1b@linux.ibm.com>
 <87bace58-eec4-4b05-981d-5c6f70b7a798@quicinc.com>
 <c12b2289-aca5-4b2d-9599-e9ca8daa2003@linux.ibm.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <c12b2289-aca5-4b2d-9599-e9ca8daa2003@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FrNlOghkI5gpsmzUr50_vpjzYBwBIGdh
X-Proofpoint-ORIG-GUID: FrNlOghkI5gpsmzUr50_vpjzYBwBIGdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160108

On 7/16/2024 1:20 AM, Stefan Haberland wrote:
> Am 14.07.24 um 18:58 schrieb Jeff Johnson:
>> On 7/1/24 03:57, Stefan Haberland wrote:
>>> Am 16.06.24 um 04:19 schrieb Jeff Johnson:
>>>> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>>>> drivers/s390/block/dasd_diag_mod.o
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>>>> drivers/s390/block/dasd_eckd_mod.o
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>>>> drivers/s390/block/dasd_fba_mod.o
>>>>
>>>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>>>
>>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>> ---
>>>
>>> Applied, thanks.
>>>
>>
>> I still don't see this in linux-next. Does your tree feed into 
>> linux-next, or will it go into Linus' tree during the merge window?
>>
>> Hoping to have these warnings fixed tree-wide in 6.11
> 
> Sorry for the delay.
> 
> The DASD patches usually go upstream through the linux-block tree. I 
> have sent them yesterday and Jens already applied them.
> 

thanks!
