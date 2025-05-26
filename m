Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3EA21018A
	for <linux-s390@vger.kernel.org>; Mon, 26 May 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748273166; cv=none; b=QVbwSbaBTo8MI562j8Mmkj5Nl5SEeSdqo00UffcuUOJiYxZiiypvLxfKD3rjJ5/UL/xyK60zJT408q1sCvt+54xTUU3rUNxO+bXrGxIGvc2XFealWK7B2W2MCpu+Ic6aLW0afcZIGuZwJkw5KLwU4TQzO13cZ0eyHosqtx5XT2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748273166; c=relaxed/simple;
	bh=Tb/I+3irlz0IFXCuaL3eiC9KQuPMOjAdbPQpRh7RHy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6Zkb6k75sqpeLvc3E0Es4dlvtZT/+cpE7qjpLAbkvlejUYCSqxF/j3ilxSiXgzRJUhddxV749oX2YCvh4JqbAxYCsb9MFjp66V5XD+REAfXxYD1KnnK92+dI7d1aKejMBFoGv3QvA3omt3bXVVOTrJ+/mCyHOH/Y34V5YusSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUIpcBbT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUIpcBbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748273163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FEV/a6K02rdGdlK1WNd9pkOOj7c2ga81h+bqUoYPxys=;
	b=iUIpcBbTEuvb0gRG8tVhTtHukU2Sj4yme5vaLJMQha5VVFdskGMp3x4Ayq9l3j/oJt249g
	7caozXBJDmua9m8DdjVyMMRLGMI7XUhehWvjyFmBxdynsNBlfpHIuE60Rhdpes2k/A5Zvu
	zx4y2/PHI8Ta6obUWTBaxkf51MwgRTQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205--tF0nejGPra3ao_NUmX3cw-1; Mon, 26 May 2025 11:26:01 -0400
X-MC-Unique: -tF0nejGPra3ao_NUmX3cw-1
X-Mimecast-MFC-AGG-ID: -tF0nejGPra3ao_NUmX3cw_1748273161
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4dcfb3bbcso362501f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 26 May 2025 08:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748273160; x=1748877960;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEV/a6K02rdGdlK1WNd9pkOOj7c2ga81h+bqUoYPxys=;
        b=oARectkHSoipSBFd+dau16riAA+BzjO5OI6W/sFG+cC0fOSlCphigU4WOssTLFOX1Q
         l+OjRHux3wBaUhPbIXoo+HRxHR9CV6aArSQGpIk9IfZoyUn8u0dcR8sZ+K2HwWso3P+s
         q22EPVuN7XAN2p1NBwl8+O5jlATJ3MUA2PNCaff89+9Junar2yda0CeJE4y/r+t6fkv4
         8K8RHT/UNX6twbcbVED7Gs+0J3FMY3rEbxpGiVRW6pNPi+jcWL5OANHEldpNvokiSpjP
         B9WteU3Dy40NDgySQhOS0/Ypg3hswKZFTgwNZbLLQe1es4LF41n7dmvLlpA+G0xL2MD3
         jqlg==
X-Gm-Message-State: AOJu0YwOMe7Z56NH6JTMFsELliid1cXjRKwrSy14eliOalmG2DE5Z5jk
	aQtX1Jit+mPV5IWg7ICCGACniJES4aNum7NOZTEvxP8eA6v2orjo56+4xWpkkaB4GLATet5hGUm
	yYT8wJ0HeP0l343DhkDCdpPWDA5ih+FlVfR447DyG1fyqMpfSmLQJ+YjnwQkjHOk=
X-Gm-Gg: ASbGncuL1EdstZE4taVKv4nrvj6TKA8Om8pDrTLO+KMHyI+FmxWtGzrXBTUuFL8xoBc
	PxJ+C/mxUqS+LaZVMcE48uwZ+dFmgK2fc/u0NUkGFapGo+EdJciJdhufrkzmtt4Itc7JSCUnhsP
	FAeCfxhSN34i1hJZQhxDaAJzo2dU6g2Wx7/WxVMkIH0h2RIt/6IBqaCMOfMuIzkgt98MFhk+86V
	PzO+IIgof8TDQiRK/P/HMa097JMRO/94iD66gaBVwMnXGcCtCgaBUFywb/DpagSc3sJnivfAyIa
	aft/YaFkp/s5nRAxM8ykHHVU6FWRoQ02eQUBSYLU/xo=
X-Received: by 2002:a05:6000:40e0:b0:3a0:b53a:bc06 with SMTP id ffacd0b85a97d-3a4cb408801mr7746561f8f.1.1748273160546;
        Mon, 26 May 2025 08:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtzlsbiKZTfBjU3+dvwvlcE5t/olyvLFWBx1BaQc9baD3mP9abZAHBZ/Eiq96KSQtg+SJdsg==
X-Received: by 2002:a05:6000:40e0:b0:3a0:b53a:bc06 with SMTP id ffacd0b85a97d-3a4cb408801mr7746539f8f.1.1748273160095;
        Mon, 26 May 2025 08:26:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de. [109.42.49.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44804e89c42sm248790445e9.21.2025.05.26.08.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 08:25:59 -0700 (PDT)
Message-ID: <f958f869-8da3-48d9-a118-f3cf9a9ea75c@redhat.com>
Date: Mon, 26 May 2025 17:25:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] s390/crypto: Rework protected key AES for true
 asynch support
To: Harald Freudenberger <freude@linux.ibm.com>, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, dengler@linux.ibm.com
References: <20250514090955.72370-1-freude@linux.ibm.com>
 <20250514090955.72370-3-freude@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250514090955.72370-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/05/2025 11.09, Harald Freudenberger wrote:
> This is a complete rework of the protected key AES (PAES) implementation.
> The goal of this rework is to implement the 4 modes (ecb, cbc, ctr, xts)
> in a real asynchronous fashion:
> - init(), exit() and setkey() are synchronous and don't allocate any
>    memory.
> - the encrypt/decrypt functions first try to do the job in a synchronous
>    manner. If this fails, for example the protected key got invalid caused
>    by a guest suspend/resume or guest migration action, the encrypt/decrypt
>    is transferred to an instance of the crypto engine (see below) for
>    asynchronous processing.
>    These postponed requests are then handled by the crypto engine by
>    invoking the do_one_request() callback but may of course again run into
>    a still not converted key or the key is getting invalid. If the key is
>    still not converted, the first thread does the conversion and updates
>    the key status in the transformation context. The conversion is
>    invoked via pkey API with a new flag PKEY_XFLAG_NOMEMALLOC.
>    Note that once there is an active requests enqueued to get async
>    processed via crypto engine, further requests also need to go via
>    crypto engine to keep the request sequence.
> 
> This patch together with the pkey/zcrypt/AP extensions to support
> the new PKEY_XFLAG_NOMEMMALOC should toughen the paes crypto algorithms
> to truly meet the requirements for in-kernel skcipher implementations
> and the usage patterns for the dm-crypt and dm-integrity layers.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>   arch/s390/crypto/paes_s390.c | 1812 ++++++++++++++++++++++++----------
>   1 file changed, 1270 insertions(+), 542 deletions(-)

  Hi Harald,

I'm currently facing these errors when building linux-next:

ERROR: modpost: "crypto_engine_stop" [arch/s390/crypto/paes_s390.ko] undefined!
ERROR: modpost: "crypto_engine_exit" [arch/s390/crypto/paes_s390.ko] undefined!
ERROR: modpost: "crypto_engine_unregister_skcipher" 
[arch/s390/crypto/paes_s390.ko] undefined!
ERROR: modpost: "crypto_engine_alloc_init_and_set" 
[arch/s390/crypto/paes_s390.ko] undefined!
ERROR: modpost: "crypto_engine_start" [arch/s390/crypto/paes_s390.ko] undefined!
ERROR: modpost: "crypto_engine_register_skcipher" 
[arch/s390/crypto/paes_s390.ko] undefined!
ERROR: modpost: "crypto_finalize_skcipher_request" 
[arch/s390/crypto/paes_s390.ko] undefined!
ERROR: modpost: "crypto_transfer_skcipher_request_to_engine" 
[arch/s390/crypto/paes_s390.ko] undefined!

I think the Kconfig is missing a "select CRYPTO_ENGINE" somewhere?

  Thomas

