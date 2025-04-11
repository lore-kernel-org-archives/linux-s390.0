Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256929CE1
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376941; cv=none; b=JKXKY45nER7BNlH0FNSBpm0zO1ZH/byxauGkTrPjWkUpOfCYvLb61xNvdUtU48s9d3UwSG1YG1ipHvIpzq560AgRERpHBdacl9BUxiFw10xN+2A86mdAufvjQoRRjGyv8yfKShdlE9EVrqo0M7xoCmCuiwR5aRi9CHSWP6y4Gl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376941; c=relaxed/simple;
	bh=nXMrjTxb2NWf+0RO/F0mXP/zJt4NGIz3PR+zp3MWNak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZpDdXXNbgOfTa0DbIL+0qr9soFArN7QAsxgIwhDdt9DhGTyYLsZXs9TBv9T0694pTalCPX5zDT90x4kNBzEcBEdBcpPm5YAyhHmln2MxZ5fEZUJfU759XQumkz1Bhk/whI0BA0Y6+PGz8UH5GhqSD6u4zhfmwRowaDWHlLNK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rlKKzP5Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rlKKzP5Q"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B7peDT012018;
	Fri, 11 Apr 2025 13:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NIHCdr
	BzHW1HP6bvKI0HhGAyExLssEFjqATkZ1HO85I=; b=rlKKzP5QejKViQvpU6y32B
	NCI2ss2Sd+zaiiSdco/ProSVeCNJkdeahNlCFBHFzLHVb4BME+2+pcdH9oYSSev6
	Fs2fBtGBhU1Iuc52P6aPyIx8QnPOks5bPPPSVjQ19omBXCUWWCk93INzLY8DTu3T
	PMXoKPqKr0YlyhkvqeqLJoSiXhdPHgzx5A5o23gHGBTexSJfPj7JoBs6fUf3UMVO
	a48upgIJcTmaUBe5z3HBqSfUycN37NMCnXrmXMQ0cyQHMLTeVG/C0knnSTroqplT
	lqzx40jt9/iwXEl3swJec0388WB85vS7WJIbGL9Y0xXOHXIU/jKa0yuHSWAY2xzA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn71bmjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:08:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BADgEs013860;
	Fri, 11 Apr 2025 13:08:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup32kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:08:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BD8qGV41943428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 13:08:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 427122004B;
	Fri, 11 Apr 2025 13:08:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7F2720040;
	Fri, 11 Apr 2025 13:08:51 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 13:08:51 +0000 (GMT)
Message-ID: <2a777f6f-3614-4703-af8e-fef440a16887@linux.ibm.com>
Date: Fri, 11 Apr 2025 15:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/24] s390/zcrypt: Introduce pre-allocated device
 status array for ep11 misc
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-11-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-11-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QA_Zqor7tkjTkVlfsT7puupRFs_-qAuH
X-Proofpoint-GUID: QA_Zqor7tkjTkVlfsT7puupRFs_-qAuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110083

On 09/04/2025 16:02, Harald Freudenberger wrote:
> Introduce a pre-allocated device status array memory together with
> a mutex controlling the occupation to be used by the findcard()

findcard2()?
(sorry, missed that one for the previous patch)

> function. Limit the device status array to max 128 cards and max
> 128 domains to reduce the size of this pre-allocated memory to 64 KB.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 48 +++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index e1a1d047ac8a..688624b75500 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -39,6 +39,22 @@ static const u8 def_iv[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
>  #define CPRB_MEMPOOL_ITEM_SIZE (8 * 1024)
>  static mempool_t *cprb_mempool;
>  
> +/*
> + * This is a pre-allocated memory for the device status array
> + * used within the findcard() functions. It is currently

findcard2()?

> + * 128 * 128 * 4 bytes = 64 KB big. Usage of this memory is
> + * controlled via dev_status_mem_mutex. Needs adaption if more
> + * than 128 cards or domains to be are supported.
> + */
> +#define ZCRYPT_DEV_STATUS_CARD_MAX 128
> +#define ZCRYPT_DEV_STATUS_QUEUE_MAX 128
> +#define ZCRYPT_DEV_STATUS_ENTRIES (ZCRYPT_DEV_STATUS_CARD_MAX * \
> +				   ZCRYPT_DEV_STATUS_QUEUE_MAX)
> +#define ZCRYPT_DEV_STATUS_EXT_SIZE (ZCRYPT_DEV_STATUS_ENTRIES * \
> +		sizeof(struct zcrypt_device_status_ext))
> +static void *dev_status_mem;
> +static DEFINE_MUTEX(dev_status_mem_mutex);
> +
>  /* ep11 card info cache */
>  struct card_list_entry {
>  	struct list_head list;
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

