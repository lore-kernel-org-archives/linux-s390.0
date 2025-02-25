Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7A257420
	for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491573; cv=none; b=QYNXGqda3QjP2uuNF/cWfRIoDuSCfP5vZR7ie4mDgcMVxv1eVTvL+GseJD3FQ3SR0Tlol6sUsKdkYNxQp7Bw6G2LGUbQvJQIgs7hOFCbsUTNyu7f8VGPBwAQVXr4vWq37KSEutWPysXJusDLbsbYF8tvYSs0Evj8XXq6Y9wMs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491573; c=relaxed/simple;
	bh=nHn48dLV//yUG/6vYxCrlC+bwk5ldO95U+u7i3TD0cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGMyTsZ0D/8/+11u6cOuqJ4oG8d9h4EWgLoGFDW4Zo1Xi/Q/ONGfNrvP33RfGoUx07UYf9a3G8hGcqAHxE+rNbn4fJAZkxD/sA4kztvC7JZ9Fu0smBsIRWQhu2j1xeKnVccT47OLWrP6umIFeWWl7UZEeCmp8a78SnXLhUcyEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sFHGG6TJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sFHGG6TJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PDjYc2018817;
	Tue, 25 Feb 2025 13:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=msLFg/
	xFqFHvfxlX98gcKdsSvAI54PJBA3XeoolyzE4=; b=sFHGG6TJt5zloq9xJ03lLi
	oSiEdKEnqMDp38zA0gTi+gKLYG7508NzG+X6m8Ct5hSMkzDpPQ4VB/PHO3Fa1L6i
	xSe0QEhtkqrrby6fjXquxGgZYSZo2aJCOmabnUCw8ia8B0jjx1DyHF0e4NUkZTwW
	w/N4JaOyPbZOspt6wLvumiJXsBr13osfq0geq9GBhRjlt8FsfWtQymYQTZkg/q0d
	4GNYnFUhJ/5TfyXVPW/gpUzNnuA2E5/WFCA23INi4iHl3PPZlG8aJTl3fJP9uOUY
	w9tdWm1ATWV9cKkbLLG4yGe/NWCOOyeHTMW+gdWrn94MIGdQv4ZPw3BtabGg4OGw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4519jp9us2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:52:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PCmnaH012100;
	Tue, 25 Feb 2025 13:52:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yddk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:52:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PDqhiw45089104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:52:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B308520043;
	Tue, 25 Feb 2025 13:52:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65CFA20040;
	Tue, 25 Feb 2025 13:52:43 +0000 (GMT)
Received: from [9.171.13.48] (unknown [9.171.13.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 13:52:43 +0000 (GMT)
Message-ID: <90d1a9a3-c314-4ecc-832b-f346fcf7f94a@linux.ibm.com>
Date: Tue, 25 Feb 2025 14:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/20] s390/ap: Introduce ap message buffer pool
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-4-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250223095459.43058-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AaVJmswRd44MeSXWWsHIxsdL4bapFi4h
X-Proofpoint-GUID: AaVJmswRd44MeSXWWsHIxsdL4bapFi4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxlogscore=740 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250090

On 23/02/2025 10:54, Harald Freudenberger wrote:
> There is a need for a do-not-allocate-memory path through the
> ap bus layer. When ap_init_apmsg() with the AP_MSG_FLAG_MEMPOOL
> xflag is called, instead of kmalloc() the ap message buffer is
> allocated from the ap_msg_pool. This pool only holds a limited
> amount of buffers: AP_MSG_POOL_MIN_ITEMS with the item size
> AP_DEFAULT_MAX_MSG_SIZE and exactly one of these items (if available)
> is returned if ap_init_apmsg() with the MEMPOOL flag is called.
> When this pool is exhausted and the MEMPOOL flag is effective,
> ap_init_apmsg() returns -ENOMEM without any attempt to allocate
> memory.
> 
> The zcrypt layer may use this flag to indicate to the ap bus
> that the processing path for this message should not allocate
> memory. This is to prevent deadlocks with crypto and io for
> example with encrypted swap volumes.

See my comments below.
The rest looks good to me.

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c     | 59 +++++++++++++++++++++++++++-----
>  drivers/s390/crypto/ap_bus.h     |  3 +-
>  drivers/s390/crypto/zcrypt_api.c | 10 +++---
>  3 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index 4940eaf538e9..b585b5d11074 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
[...]
> @@ -546,16 +562,27 @@ static void ap_poll_thread_stop(void)
>  #define is_card_dev(x) ((x)->parent == ap_root_device)
>  #define is_queue_dev(x) ((x)->parent != ap_root_device)
>  
> -/**
> +/*

What is the reason for mixing coding styles?

>   * ap_init_apmsg() - Initialize ap_message.
> - * Initialize a message before using. Otherwise this might result in
> - * unexpected behaviour.
> + * Initialize struct ap_message and allocate buffer to construct
> + * the ap message.
>   */
> -int ap_init_apmsg(struct ap_message *ap_msg)
> +int ap_init_apmsg(struct ap_message *ap_msg, u32 xflags)

The xflags function parameter is very confusing (here and also in all other APIs too), because it allows to set some, but not all flags in ap_msg-flags. Why not using `bool alloc`? If you will keep the more flexible interface, please add another xflags element to struct ap_message. There is nothing in common between the ap_msg->flags and xflags, beside they're both named "flags". 

>  {
> -	unsigned int maxmsgsize = atomic_read(&ap_max_msg_size);
> +	unsigned int maxmsgsize;
>  
>  	memset(ap_msg, 0, sizeof(*ap_msg));
> +
> +	if (xflags & AP_MSG_FLAG_MEMPOOL) {
> +		ap_msg->msg = mempool_alloc_preallocated(ap_msg_pool);
> +		if (!ap_msg->msg)
> +			return -ENOMEM;
> +		ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
> +		ap_msg->flags |= AP_MSG_FLAG_MEMPOOL;
> +		return 0;
> +	}
> +
> +	maxmsgsize = atomic_read(&ap_max_msg_size);
>  	ap_msg->msg = kmalloc(maxmsgsize, GFP_KERNEL);
>  	if (!ap_msg->msg)
>  		return -ENOMEM;
> @@ -565,14 +592,18 @@ int ap_init_apmsg(struct ap_message *ap_msg)
>  }
>  EXPORT_SYMBOL(ap_init_apmsg);
>  
> -/**
> +/*

???

>   * ap_release_apmsg() - Release ap_message.
> - * Releases all memory used internal within the ap_message struct
> - * Currently this is the message and private field.
> + * Cleanup struct ap_message and release all memory held.
>   */
>  void ap_release_apmsg(struct ap_message *ap_msg)
>  {
> -	kfree_sensitive(ap_msg->msg);
> +	if (ap_msg->flags & AP_MSG_FLAG_MEMPOOL) {
> +		memzero_explicit(ap_msg->msg, ap_msg->bufsize);
> +		mempool_free(ap_msg->msg, ap_msg_pool);
> +	} else {
> +		kfree_sensitive(ap_msg->msg);
> +	}
>  }
>  EXPORT_SYMBOL(ap_release_apmsg);
>  
[...]

--
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

