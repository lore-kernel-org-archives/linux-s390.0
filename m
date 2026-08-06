Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5B360EDC;
	Thu,  6 Aug 2026 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034101; cv=none; b=FNVQBBKg+NXinfc4zvXV0xoffGKoPpA5lBgYAMsnRPI24mnUzxg6fqKr507HYMo3aMJBWzkTku9MdJlQv5bfx4MyVtkbWXMMA6tBxLPr4AqHPImBKP2XMTO0O6KLhpbzZoRpBz+g0oerM0b9t6ohE4Arx0jWfHlGAdgUMirSR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034101; c=relaxed/simple;
	bh=+t6oBooyxxCt/WhMuEFsfbfpkDraEEFl8aTloOlr54w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omcamjkh6Pzb1r3I8OybtaNFEcap8htC2ijnqtiISZjFRxQSECcaWDwXjiCUY6aB6Dnk72Me1+zLFB/V00d4vHmEbsiQc1rL8Q9byhxcvmrBCVegfnPp+DDCIs9oirpLKM8Jg6t3GUj0uWknQgTyM4ymZ6GtmT1NNOmvh1+Iojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LXIRQYc6; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LXIRQYc6"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hGCYb6WdGzlfwHS;
	Thu,  6 Aug 2026 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786034097; x=1788626098; bh=gRPkFtd381SkTyfYOt+73oBP
	WQJRAc1GCQ7h5u4mo0A=; b=LXIRQYc6FjiG/iDiOeBv64l6bz1HuGYSllZScFO4
	iMJVeWDLQnFW5eVWKhs1ZdOwX6PRP414OfKQo7svdRQXOLOuz+S4PWh8whdmAN1/
	CWTXRB8LxAQS5gWB9y/oFXxJhZPtd5qV/muzzbe6NVHkLYNwGagcmVDKza1XaMp4
	atR6lDHIV8NKTQUuGVNzgEBP1wcAcKHS7TST6g5SmpZ3eC60CsBBtkdLUKSQYNw3
	Vs5QpbtOYZYEgLb3NenWB4T0g7U4Ql4g2qg12gAT3+4LrZuNB5RKKY7RM5MU2tib
	5uBFj+jqj2CgtI98xlZzMhz7xg/YNGvMvdXJB4i0MJa/qg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ubCPup1xK1WE; Thu,  6 Aug 2026 16:34:57 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hGCYX0GMfzlfvqS;
	Thu,  6 Aug 2026 16:34:55 +0000 (UTC)
Message-ID: <7b48d806-0453-429c-aa99-616ce4c5159e@acm.org>
Date: Thu, 6 Aug 2026 09:34:55 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390/block: Enable CONTEXT_ANALYSIS
To: Heiko Carstens <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
 Stefan Haberland <sth@linux.ibm.com>, =?UTF-8?Q?Jan_H=C3=B6ppner?=
 <hoeppner@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
References: <20260806130050.2057443-1-hca@linux.ibm.com>
 <20260806130050.2057443-3-hca@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260806130050.2057443-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 6:00 AM, Heiko Carstens wrote:
> --- a/drivers/s390/block/Makefile
> +++ b/drivers/s390/block/Makefile
> @@ -3,6 +3,8 @@
>   # S/390 block devices
>   #
>   
> +CONTEXT_ANALYSIS := y
> +
>   dasd_eckd_mod-objs := dasd_eckd.o dasd_3990_erp.o dasd_alias.o
>   dasd_fba_mod-objs  := dasd_fba.o
>   dasd_diag_mod-objs := dasd_diag.o

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

