Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2429428;
	Sun, 14 Jul 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976324; cv=none; b=uGtEGoqxr5oDtwC6PPV8epDIsor9azzZBxlEDhGY+H0Qk6XWqOaoBfixJbo/xQvWgUPdldZxSgm79WCS2r5XXgl8qnx8ppCbYBgT1dGlvFHxwsifXDFfBpwBeOWJrBLCHwlxxjCWRGWM3DKkEyaGF7WjG7919Xur2KGm3kQh5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976324; c=relaxed/simple;
	bh=a54VfT5Nwb9uiIkRtWmUUjo8FyQErt3IECtLkEeYqvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WBsCRkejxH3Li9poe2PEh18WxTTvTtHEX2d/v+gstfEy4XDr6yG/zVU/xxaZRlRYlbg6DhRoFlg0txGYrHOR2DOrhmdsD852J8Qc60LerETwmq5rUIKRX85EWAZHdV1el+S3gK1oI8dLa1OmAttlGsRivGUuYrm6mGvYpR5/WM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ox6dgenK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ox6dgenK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46EDkoGR009856;
	Sun, 14 Jul 2024 16:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O/dVvUlX9wnd/Ac1l/Y9f0NIITMUiL5biC8drkuTNr4=; b=Ox6dgenKoq1kLV4F
	Yg9QLGOzQGMk1QywpaV+OixbuQ04Da9rFu5CIbcp9Az2XmupubAfhBoD7DjQ23aP
	Vu4PdA0X1UDvJCrY9NYsWayHZ4MZ1IHxePzF359M6bzkfZNbv0pO28wIVCA7PRxr
	JJlxyEOrGtZB5qZY6WhfY61CiBt8OA4NxCo1nqv7LsqZRzYypuHPnYI+TdO09t75
	F0uDkJtA7lds1ns7TEEDwRgQm0qtK0CPSiCzvEy/qKeGpAgQlJPiVRHxS4YfyPBt
	d3Rn3FsMoXuLjTBNFwDz8fwl7y22s6FHMrWZR0dXx0TrkE9Hxg1fgYh4evmPbF9y
	F6R1Lg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bgwg23ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 16:58:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46EGwXUH013281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 16:58:33 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Jul
 2024 09:58:32 -0700
Message-ID: <87bace58-eec4-4b05-981d-5c6f70b7a798@quicinc.com>
Date: Sun, 14 Jul 2024 09:58:32 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: add missing MODULE_DESCRIPTION() macros
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
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <2c2655ad-2a2a-4180-8a31-828a7531af1b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kRnaLcFwQlzdX0yLua4MEANUda5zfF8o
X-Proofpoint-ORIG-GUID: kRnaLcFwQlzdX0yLua4MEANUda5zfF8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407140134

On 7/1/24 03:57, Stefan Haberland wrote:
> Am 16.06.24 um 04:19 schrieb Jeff Johnson:
>> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>> drivers/s390/block/dasd_diag_mod.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>> drivers/s390/block/dasd_eckd_mod.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>> drivers/s390/block/dasd_fba_mod.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
> 
> Applied, thanks.
> 

I still don't see this in linux-next. Does your tree feed into 
linux-next, or will it go into Linus' tree during the merge window?

Hoping to have these warnings fixed tree-wide in 6.11
