Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DC21D5A2
	for <linux-s390@vger.kernel.org>; Mon, 17 Mar 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204310; cv=none; b=FCpwkPAKx1O8UmDYQchNJQgFNO2o7nYlyJsiQyps+AIix+Uxkjv/S7cYAE3ALU7VQysXcEl3dzMo7PZ/98oxoh6M4Z+5py7KAl29jr5tI0lO0N3vBXFnLuX+AQq5Hz6dQWmoC1LZuyu5WW4WHYRcDPKLOclOxQRWIDGtMuOSZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204310; c=relaxed/simple;
	bh=qC0OlvHV8MBMtgObHVLI5xgkIqukMxeir9LDU+9Us3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjBnbs+4VgJ6d2RjtCIlWeXxUYOV9mtGX8Hw5zSr8s2wlkA+efKUp8vuKbCQkr/VMA2JpbvYqvxu7d0BUFFgjnOmxtfCHdWQopBl0YjW3Wwf3NwYqlC9SlbMliDxODT5Z6nD6ehHBqlR/oDbqFGIPjF3SZT+UEsMc13Xkc4wqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BUxn+hLO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BUxn+hLO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GNU2QI005637;
	Mon, 17 Mar 2025 09:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N7raye
	62YHJTwIXvSmDrHDR2sPVOFObm9VUZK1cKbbk=; b=BUxn+hLOnNNRwf/0sYKvaw
	5xYlceVr0O+D7NhMUtJKCk3GPRTZVGi5faA7XM8PtYgUpGG1p9HsNk1KQ2A83Uu9
	MrgbE6jf/Qlf5n1dcw9IkXNAlszDEa0ttL140Rvp0Jti1mlpVF1P6myg93RnC3p0
	trNvBvuuvrXsB/+R1u2c7VcHcs+c9YX6BY20xOV+SLZfV8Tv1fIJxYwTG4m7mWGy
	3hnJ2uaulOzMPjo4Q8jpA4PxNKQLz2q2Bei9dneKcL5FT5WSvwgLU2zy3jZAn7Wz
	220UsdQcaRFD2eXh6uaW87SpiijcgcQYyxSuhDcx960yvgwkz1eSq7VbwGdBEefA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5tpafbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 09:38:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H88l6q032356;
	Mon, 17 Mar 2025 09:38:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvt5mad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 09:38:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52H9cJYj34472480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:38:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C71C20124;
	Mon, 17 Mar 2025 09:38:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0019D20123;
	Mon, 17 Mar 2025 09:38:18 +0000 (GMT)
Received: from [9.179.25.138] (unknown [9.179.25.138])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 09:38:18 +0000 (GMT)
Message-ID: <e8bc8844-7aa9-4c8d-8538-5896436573dd@linux.ibm.com>
Date: Mon, 17 Mar 2025 10:38:18 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] s390/ap: Move response_type struct into ap_msg
 struct
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-2-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z5eHklLTGQh8V5IfR9uU_GoSyTKILIAW
X-Proofpoint-ORIG-GUID: z5eHklLTGQh8V5IfR9uU_GoSyTKILIAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170069

On 04/03/2025 18:20, Harald Freudenberger wrote:
> Move the very small response_type struct into struct ap_msg.
> So there is no need to kmalloc this tiny struct with each
> ap message preparation.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

See my comment below. Beside that
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/ap_bus.h           |  8 ++-
>  drivers/s390/crypto/zcrypt_msgtype50.c | 16 ++----
>  drivers/s390/crypto/zcrypt_msgtype6.c  | 74 ++++++++++----------------
>  3 files changed, 38 insertions(+), 60 deletions(-)
[...]
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index b64c9d9fc613..521cc0b39990 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -31,10 +31,7 @@
>  
>  #define CEIL4(x) ((((x) + 3) / 4) * 4)
>  
> -struct response_type {
> -	struct completion work;
> -	int type;
> -};
> +struct response_type;

This struct is only defined, but not used. Remove it.

>  
>  #define CEXXC_RESPONSE_TYPE_ICA  0
>  #define CEXXC_RESPONSE_TYPE_XCRB 1
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

