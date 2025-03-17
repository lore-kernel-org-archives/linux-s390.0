Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268A17D355
	for <linux-s390@vger.kernel.org>; Mon, 17 Mar 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228065; cv=none; b=NgdBlvrAtdS2o3PEkUYhVKKT6ULvbVCsh02L41Gk37100SGjCTVigvDs4LD5Do80PA7vdxRJObl/FvEAjmVa00FdGCA+5++9oX1CFAE/JvG7JHgj4OMAy+vMzYLa/j+Q/8RpvYW52pmsGFOdhdFPAmK5EkFbAzhEXPHbbFV+8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228065; c=relaxed/simple;
	bh=oqWhvhkzZQZqzo/xMUCSlE0m7fqxUwLBFYhHXILwVCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imwnWoYlyODMUHv1bSwJiVpD0k4Vhxbo9XxzAF6eKyKrJznUqLgYrOraHNdqFpy+i2XEj0m01rdojFCe7a5D/dagQ3DOsdHR+vwCz4R4kOpyrbcTzBTn8khE8GHRvjJpegjMu9KjDpwwu3hlZFsjb0crbDb/2deGx1huKaHTqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nGbdTv6Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nGbdTv6Z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HDa3po021832;
	Mon, 17 Mar 2025 16:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QEIFIe
	XajaAyZwqhVLYnJKgopJ+wJgBHjn41r1XWliw=; b=nGbdTv6ZOA6sBRuwb2lVTz
	MzcjohiI95vN4vxxVa+lLQpKiC5LxVxtnCX+LwpvXQECDvph1RzJ9g4ayd+oke89
	cbj5cHFmcpo1/AhSK/oF4ICyaz4jeGQsxqg+iR6ts1H/9oW8fpx0Y0ZSsSuTuZs6
	nom4q5icj28+h3s7JHoixiFdALbpPLBVTndm+6RBLjr28m2Gd7mxWUwxP0BOiHJC
	Es7T5ntCBpWWSrCgMzKxGKFEUbr+nGiC/hP3xCNn5F4w9F847Ee7/2RHYl0u00pE
	ckTIKUPQio1EBC1iD/V7Nfoxofkmh1FXrwE/fTHM4QvCEyIHKKHVP4R24VpmbHTg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eks99915-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 16:14:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HDYOBj001039;
	Mon, 17 Mar 2025 16:14:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3kewr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 16:14:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52HGEFZT30408996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 16:14:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FCBE20049;
	Mon, 17 Mar 2025 16:14:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DFC820040;
	Mon, 17 Mar 2025 16:14:15 +0000 (GMT)
Received: from [9.179.25.138] (unknown [9.179.25.138])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 16:14:14 +0000 (GMT)
Message-ID: <1935a111-c0a3-4d7e-85f5-f7218253f1fc@linux.ibm.com>
Date: Mon, 17 Mar 2025 17:14:13 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] s390/ap: Introduce ap message buffer pool
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-4-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FOf27q37GBw33P41-Vyrcf9iWktOuGvE
X-Proofpoint-ORIG-GUID: FOf27q37GBw33P41-Vyrcf9iWktOuGvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170115

On 04/03/2025 18:20, Harald Freudenberger wrote:
> There is a need for a do-not-allocate-memory path through the
> ap bus layer. When ap_init_apmsg() with use_mempool set to true
> is called, instead of kmalloc() the ap message buffer is
> allocated from the ap_msg_pool. This pool only holds a limited
> amount of buffers: ap_msg_pool_min_items with the item size
> AP_DEFAULT_MAX_MSG_SIZE and exactly one of these items (if available)
> is returned if ap_init_apmsg() with the use_mempool arg set to true
> is called. When this pool is exhausted and use_mempool is set true,
> ap_init_apmsg() returns -ENOMEM without any attempt to allocate
> memory.
> 
> Default values for this mempool of ap messages is:
>  * Each buffer is 12KB (that is the default AP bus size
>    and all the urgend messages should fit into this space).

typo: urgent

>  * Minimum items held in the pool is 8. This value is adjustable
>    via module parameter ap.msgpool_min_items.
> 
> The zcrypt layer may use this flag to indicate to the ap bus
> that the processing path for this message should not allocate
> memory but should use pre-allocated memory buffer instead.
> This is to prevent deadlocks with crypto and io for example
> with encrypted swap volumes.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

With the typo and the changed indent (see comment below)
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/ap_bus.c     | 57 ++++++++++++++++++++++++++++----
>  drivers/s390/crypto/ap_bus.h     |  9 ++---
>  drivers/s390/crypto/zcrypt_api.c | 10 +++---
>  3 files changed, 60 insertions(+), 16 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
> index 483231bcdea6..a7bd44e5cc76 100644
> --- a/drivers/s390/crypto/ap_bus.h
> +++ b/drivers/s390/crypto/ap_bus.h
> @@ -233,11 +233,12 @@ struct ap_message {
>  			struct ap_message *);
>  };
>  
> -#define AP_MSG_FLAG_SPECIAL  0x0001	/* flag msg as 'special' with NQAP */
> -#define AP_MSG_FLAG_USAGE    0x0002	/* CCA, EP11: usage (no admin) msg */
> -#define AP_MSG_FLAG_ADMIN    0x0004	/* CCA, EP11: admin (=control) msg */
> +#define AP_MSG_FLAG_SPECIAL  0x0001   /* flag msg as 'special' with NQAP */
> +#define AP_MSG_FLAG_USAGE    0x0002   /* CCA, EP11: usage (no admin) msg */
> +#define AP_MSG_FLAG_ADMIN    0x0004   /* CCA, EP11: admin (=control) msg */
> +#define AP_MSG_FLAG_MEMPOOL  0x0008   /* ap msg buffer allocated from mempool */

Please do not change the indent here. The change is not required, but it makes the life of reviewers much harder.

>  
> -int ap_init_apmsg(struct ap_message *ap_msg);
> +int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool);
>  void ap_release_apmsg(struct ap_message *ap_msg);
>  
>  enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

