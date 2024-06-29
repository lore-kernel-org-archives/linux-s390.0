Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D53C00;
	Sat, 29 Jun 2024 03:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719631463; cv=none; b=kMVHn/Iwuu3+4IkAbhAsApDEtZGbV0O0AxszJh+TEpAdNfUnrB3Ca0WlT9Fu2OEYX3iAT/2lEHq1zWHUrnNtI2pX919sdFESoDoIy8veI65dgmKb9K5Dsxwn2qYcJEsUtDZa/dH3sYADhHEwXR9i4htziDxcUSEBsTsFYII+kR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719631463; c=relaxed/simple;
	bh=zzFzV9Hf3y2xU4IErrtSymGVyrv9lLHfRvbFW6GO8Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eh0EgwEdfQEUfb2qMtm86mexSdVVK+92z4gG2AelgjJA0ZM+1E3ij+SI941tX+wFfm8tbKfZAPafyMBQsa0dLx1X/NjJHZnnz2IWgN8XnpSxEizsWD9UgL6WbmL0l+q7Glj5Z1zQPY775I6ahuRkJVFKEpQ649a1FvqJIPp48sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UmJ4qD4t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UmJ4qD4t"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T2smtT027565;
	Sat, 29 Jun 2024 03:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SVVShuazCaLUDPTDIegp+IOHraDAN3vXNEH1dB82+0k=; b=UmJ4qD4tfmNmqDOX
	ewt+spLRRN3ja2tfpOOiJMZWEe2rtvJ4rBqOR2/xE9rmPsnPV6e8r3hsOEIGf8hQ
	/lw3v0xRBw4B5Yon0O71rmD9aru7oB+Got7syoj9Wcc6WVrgnRHUS969QP85ouPA
	6KU214FdtKBXiTyEJhnAT7w6b0/J6iw881RkZ0bTPQDWn6eaDuh7qE8r1eddB5HT
	SHaOW+c1/B61wWaCUBr7SJJzCPShCr6fnE8sGmH2ftwcj3/lMAoJLwxHJzpevBpY
	HsEXZlJ0ImLkJwGBjP7HymHb0TAfhxOmMqVqwVYpYy4MiAOY4ORjjfcsleaVfUGO
	EYBPYw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40297rg34k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:24:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T3OJtb011895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:24:19 GMT
Received: from [10.48.245.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 20:24:18 -0700
Message-ID: <0c52c041-6091-4fe2-a519-b8d26e5fc3e8@quicinc.com>
Date: Fri, 28 Jun 2024 20:24:18 -0700
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
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240615-md-s390-drivers-s390-block-dasd-v1-1-36b200f14344@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Yf5mmrD-0RqAvYnEepWgdMKZGdKY3cK6
X-Proofpoint-GUID: Yf5mmrD-0RqAvYnEepWgdMKZGdKY3cK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290023

On 6/15/2024 7:19 PM, Jeff Johnson wrote:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_diag_mod.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_eckd_mod.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_fba_mod.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Corrections to these descriptions are welcomed. I'm not an expert in
> this code so in most cases I've taken these descriptions directly from
> code comments, Kconfig descriptions, or git logs.  History has shown
> that in some cases these are originally wrong due to cut-n-paste
> errors, and in other cases the drivers have evolved such that the
> original information is no longer accurate.
> ---
>  drivers/s390/block/dasd_diag.c | 1 +
>  drivers/s390/block/dasd_eckd.c | 1 +
>  drivers/s390/block/dasd_fba.c  | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
> index ea4b1d01bb76..8245b742e4a2 100644
> --- a/drivers/s390/block/dasd_diag.c
> +++ b/drivers/s390/block/dasd_diag.c
> @@ -29,6 +29,7 @@
>  #include "dasd_int.h"
>  #include "dasd_diag.h"
>  
> +MODULE_DESCRIPTION("S/390 Support for DIAG access to DASD Disks");
>  MODULE_LICENSE("GPL");
>  
>  /* The maximum number of blocks per request (max_blocks) is dependent on the
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> index 2f16f543079b..f8113974cfba 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -44,6 +44,7 @@
>  /* 64k are 128 x 512 byte sectors  */
>  #define DASD_RAW_SECTORS_PER_TRACK 128
>  
> +MODULE_DESCRIPTION("S/390 DASD ECKD Disks device driver");
>  MODULE_LICENSE("GPL");
>  
>  static struct dasd_discipline dasd_eckd_discipline;
> diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
> index 361e9bd75257..9ef7b168aba8 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c
> @@ -32,6 +32,7 @@
>  #define DASD_FBA_CCW_LOCATE 0x43
>  #define DASD_FBA_CCW_DEFINE_EXTENT 0x63
>  
> +MODULE_DESCRIPTION("S/390 DASD FBA Disks device driver");
>  MODULE_LICENSE("GPL");
>  
>  static struct dasd_discipline dasd_fba_discipline;
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240615-md-s390-drivers-s390-block-dasd-9a143c6ca093

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff
