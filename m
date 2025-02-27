Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7C2253A8
	for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656051; cv=none; b=U2Fj65AuoI3jl+mMgw6Cw8r62DcmVPbPU+E6yv9/Zz3IlwPXxYXkgJyhsYwDmP3+GCj3QWG4mWnzIwIGvJevJkEytfjjK6bVZicwSGTIKtgwJcVQ4fBUsATCbbGsEEh0rtH9NPmp3ZO/fi0eF5UXIIQPMUILg3d/0P/sX/3ikvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656051; c=relaxed/simple;
	bh=2NFsI18PkZyiy0G3s8PFLBgbk2QzKKNuavnCGFemDlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmK+Crfh6kBC2z7e0JWMoO6mMp8dYFxgZbJR9UYopL5nZjev47XynKxYZRBj7y/sJoeUGIUDfKN231dT/Vs2e81bW6Hakwq4uh6AMpVN6Ika8zdQ8UTbrqrLnB7Y64aTumeUNE7dBj3FfWiz1aLd8/lE2YTFLG42QR89LIzWAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AtXWH/vA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AtXWH/vA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R5O0UK019699;
	Thu, 27 Feb 2025 11:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LlVPrL
	ULXQzas6aOig4FMQl2NTbDgOZNDOwEZyexhOw=; b=AtXWH/vA14UrGrWM2k94XO
	rEGRIKllnNNRkOkv61dLXnxOvDKY2Yb7sTibJEztlYRBTJCqJVBmsK/DRc+VqQg6
	fOwNlfSJs5mgzwtXEyhtH91xNMtQZz2UoHAef8c6W4q5GVS3SO/4QSbJxWOuog8n
	bQNXREvBOLGAIJKzXkIELUJipuKXdOnvlhFd2QnU2+NE7XxOg8ZC/KzbLg3ZTRnQ
	DhusF/WG8O0C3VQsyYMBpIohi4eH+6mzxlA2CkVnnIKbthsIL4nbzBbLtpATtCFT
	Dd3xbj2xFMBmXvb0PTYdIsYB0klzs1sqG/f+G2cwCBbxhbdxmWUhZxGVKwMDtKgA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8spem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:34:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAf1ve002545;
	Thu, 27 Feb 2025 11:34:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4k0131-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:34:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51RBY1Vn34144780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:34:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B444A2004D;
	Thu, 27 Feb 2025 11:34:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 719A320043;
	Thu, 27 Feb 2025 11:34:01 +0000 (GMT)
Received: from [9.171.16.19] (unknown [9.171.16.19])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2025 11:34:01 +0000 (GMT)
Message-ID: <be1a6e43-64e7-4dab-9dbf-f1b77f2d2f5a@linux.ibm.com>
Date: Thu, 27 Feb 2025 12:34:02 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/20] s390/zcrypt: New zcrypt function
 zcrypt_device_status_mask_ext2
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-8-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250223095459.43058-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L7rPDFa6OpE_geHJHA060AlQjE94on8T
X-Proofpoint-GUID: L7rPDFa6OpE_geHJHA060AlQjE94on8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270087

On 23/02/2025 10:54, Harald Freudenberger wrote:
> Introduce a new function zcrypt_device_status_mask_ext2().
> This function gives the possibility to provide upper limits
> for cards and queues. The current implementation of
> zcrypt_device_status_mask_ext() needs an array of
> 256 * 256 * 4 = 256 KB which is huge. The new function
> is more flexible in the sense that the caller can decide
> the upper limit for cards and domains to be stored into
> the status array. So for example a caller may decide to
> only query for cards 0...127 and queues 0...127 and thus
> only an array of size 128 * 128 * 4 = 64 KB is needed.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 26 ++++++++++++++++++++++++++
>  drivers/s390/crypto/zcrypt_api.h |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index 3a521e65f3fe..fd9666ae1d26 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -1330,6 +1330,32 @@ void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus)
>  }
>  EXPORT_SYMBOL(zcrypt_device_status_mask_ext);
>  
> +void zcrypt_device_status_mask_ext2(struct zcrypt_device_status_ext *devstatus,
> +				    int maxcard, int maxqueue)
> +{
> +	struct zcrypt_card *zc;
> +	struct zcrypt_queue *zq;
> +	struct zcrypt_device_status_ext *stat;
> +	int card, queue;
> +
> +	spin_lock(&zcrypt_list_lock);
> +	for_each_zcrypt_card(zc) {
> +		for_each_zcrypt_queue(zq, zc) {
> +			card = AP_QID_CARD(zq->queue->qid);
> +			queue = AP_QID_QUEUE(zq->queue->qid);
> +			if (card >= maxcard || queue >= maxqueue)
> +				continue;

What about doing a "break" here? Or are the the cards/queues iterated non-linear?

> +			stat = &devstatus[card * maxqueue + queue];
> +			stat->hwtype = zc->card->ap_dev.device_type;
> +			stat->functions = zc->card->hwinfo.fac >> 26;
> +			stat->qid = zq->queue->qid;
> +			stat->online = zq->online ? 0x01 : 0x00;
> +		}
> +	}
> +	spin_unlock(&zcrypt_list_lock);
> +}
> +EXPORT_SYMBOL(zcrypt_device_status_mask_ext2);
> +

In my opinion, this is a lot of code duplication for an early loop termination. Either extent the zcrypt_device_status_mask_ext() function with the two additional parameters and change all callers to

zcrypt_device_status_mask_ext(... , MAX_ZDEV_CARDIDS, MAX_ZDEV_DOMAINS);

or just implement zcrypt_device_status_mask_ext() as a wrapper to zcrypt_device_status_mask_ext2().

void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus)
{
	zcrypt_device_status_ext2(devstatus, MAX_ZDEV_CARDIDS, MAX_ZDEV_DOMAINS);
}
EXPORT_SYMBOL(zcrypt_device_status_mask_ext);

>  int zcrypt_device_status_ext(int card, int queue,
>  			     struct zcrypt_device_status_ext *devstat)
>  {
> diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
> index 06ff697d171c..92027304f0d8 100644
> --- a/drivers/s390/crypto/zcrypt_api.h
> +++ b/drivers/s390/crypto/zcrypt_api.h
> @@ -172,6 +172,8 @@ void zcrypt_api_exit(void);
>  long zcrypt_send_cprb(struct ica_xcRB *xcRB, u32 xflags);
>  long zcrypt_send_ep11_cprb(struct ep11_urb *urb, u32 xflags);
>  void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus);
> +void zcrypt_device_status_mask_ext2(struct zcrypt_device_status_ext *devstatus,
> +				    int maxcard, int maxqueue);
>  int zcrypt_device_status_ext(int card, int queue,
>  			     struct zcrypt_device_status_ext *devstatus);
>  

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

