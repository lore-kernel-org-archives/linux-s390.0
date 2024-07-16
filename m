Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D303224;
	Tue, 16 Jul 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118034; cv=none; b=ptL+tX6KNZCBRwIzdVBSm6kFojntUFXQ9wuMchHQX+Mnz9QIJMyAKyz5N4HvOK6+CkbJ+KdXl30PG4gf08YtS3dY8BM/0wF0siBvvEhUT5qLwfk4XcB29PqRsq0HEMNzXHpxLo2MWFRDln6RFEpzbBy2+zKbmU8JbrfJ/hF6ZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118034; c=relaxed/simple;
	bh=RGHFPf9WIT0FeAlOqROa14SHBOw/KaGBaGRH1b2nz/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMCGpmVe17ijTovoWnalu3wlH7hgBNesT8PPy0FZqr8GfyEqJwzECdLXRuHvyJsQ+Gw05xFI+iW8BC7t3kMOoe5QHJWxH3ZWYCcC4lH+Dh3YCNM6ScpuNXgoaKTICwiqhC7+0eFYfSXd1egd9kTr2CSM0OmlX3G6JvXhpLS7eKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WTbb/F4w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WTbb/F4w"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G84MER001748;
	Tue, 16 Jul 2024 08:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=a
	Cr2OURIQq7Sr00CP5aHRAvmfuV4sRpVqwaUFLdGLl0=; b=WTbb/F4ww4ICgAp1S
	qhiCXvE4aLQvarOxc5dj2VHotM34HFO9bOuLRH+wWs/i5nxPmhrADxBq3TKUu10p
	gIvpAjbxDMP/4XYqJMQtaHy9qt53zo7Wu7d/ACfqNDg3IN8LTMaovt6IFutcrhnv
	6Nb2KKQe730p6pWyrTyiY2pPj0zxOJ+D6hNQA39s4iUKXhlTRrOzyDhpUtaonH1m
	Byfml6XS0YXhwC2ODKACkahicwDC2p9bqzAS7TLaLrOg8WIaDbKooN8Hqpj+A9tY
	y+5mIIsduTX8uRDXyblzHDIh/IOsh4iknRbxT9R9rHIdWAXtp6Y3ZVVWnVTgjwmU
	EPJnA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dk6agbcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 08:20:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46G6KZr9023092;
	Tue, 16 Jul 2024 08:20:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c64m2uhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 08:20:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46G8KNX027263548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 08:20:25 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F8DE58060;
	Tue, 16 Jul 2024 08:20:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27ED55805B;
	Tue, 16 Jul 2024 08:20:21 +0000 (GMT)
Received: from [9.171.67.160] (unknown [9.171.67.160])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jul 2024 08:20:20 +0000 (GMT)
Message-ID: <c12b2289-aca5-4b2d-9599-e9ca8daa2003@linux.ibm.com>
Date: Tue, 16 Jul 2024 10:20:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20240615-md-s390-drivers-s390-block-dasd-v1-1-36b200f14344@quicinc.com>
 <2c2655ad-2a2a-4180-8a31-828a7531af1b@linux.ibm.com>
 <87bace58-eec4-4b05-981d-5c6f70b7a798@quicinc.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <87bace58-eec4-4b05-981d-5c6f70b7a798@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oG9LhWPnZ1C-FiCtr9vVL4YjzqBz2axC
X-Proofpoint-GUID: oG9LhWPnZ1C-FiCtr9vVL4YjzqBz2axC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160058

Am 14.07.24 um 18:58 schrieb Jeff Johnson:
> On 7/1/24 03:57, Stefan Haberland wrote:
>> Am 16.06.24 um 04:19 schrieb Jeff Johnson:
>>> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>>> drivers/s390/block/dasd_diag_mod.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>>> drivers/s390/block/dasd_eckd_mod.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>>> drivers/s390/block/dasd_fba_mod.o
>>>
>>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> ---
>>
>> Applied, thanks.
>>
>
> I still don't see this in linux-next. Does your tree feed into 
> linux-next, or will it go into Linus' tree during the merge window?
>
> Hoping to have these warnings fixed tree-wide in 6.11

Sorry for the delay.

The DASD patches usually go upstream through the linux-block tree. I 
have sent them yesterday and Jens already applied them.

