Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52E442C
	for <linux-s390@vger.kernel.org>; Tue, 27 May 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748334106; cv=none; b=ceRW67/naNy75XNV1K7C6b4FrxN6q1/olhE0/kNMYrWZHr4/CE2il8JNgivOsjV08DkufA8IRSH4BfZT+7hg1xzTX/fLQQ9MPk6sO3XYMJ2c7Fs1b9gbLJD+kKiG6d/YJ6/0B1yKk0yWVPgHc4jJ9pGHe43gYsDn1/whgXH0TsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748334106; c=relaxed/simple;
	bh=TnzPbsJoi9ue8RBbB7ADmKdd5uaBz/8uYKBaGq30x7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYcs4C6acYGh3s0Oe0ZZGBzRTHJCBn4uTfx4fh6uC+kkb2eETF8on4ZdGB4pddaTapYOpwoY7fkp5p2U6e7zzmZ9EYKM1UIvMVSgVdkVcI/RzhDfXWTtfnMVZgXy9t8yyNycogLPZmwl4t8dji+YOiGjVgjBqxRJ3yITN02AcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTGBgmar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTGBgmar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748334103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x96GvMGdcLU8L02+ttSOX81nqKdS67Hr84XuYvwPnyQ=;
	b=BTGBgmarQFbdnqwclcjgLx71Iqi2Wx29LMwa9y3KirVIgzm/eFsyDv57/dpVDNUo1AgcW+
	fyALIWtUqyC9slmxPvk0Nu3MSc7WLw0/SHRZNTfcHKZJB5WemEy9jR5T9mmt7CIcQOcg1z
	CSND4xtzxHKhsFjsBqMFaIemHB+2rUs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-5hmpD25yNJeQGy20q96Vbg-1; Tue, 27 May 2025 04:21:41 -0400
X-MC-Unique: 5hmpD25yNJeQGy20q96Vbg-1
X-Mimecast-MFC-AGG-ID: 5hmpD25yNJeQGy20q96Vbg_1748334100
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a3683aa00eso1416829f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 27 May 2025 01:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748334100; x=1748938900;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x96GvMGdcLU8L02+ttSOX81nqKdS67Hr84XuYvwPnyQ=;
        b=Mpr/qaxZIuBMfLnnTMior6a96BwIJSbyfiOqL3aUx6xwo6I6fvRqYwyhAjzmZ/J/fk
         3LnlKt+TE8yU2URegtawOzOoDHv0nNqXkukGVko5Auddp/+6J9mU9nsdDsY8+F6hOzpQ
         Tm/pO3aW8ws1g5nDghf6uokM0bHXVj79GISj0w9VT16We6Aok3HRhpl0N9PTgmVnI0u5
         4cgyGt7SCI5vgwxOWyU01v7Yc+z2sL6jCXqMpc/r/+4bBtDa3m/8D4XmEFiPPB0Jkn7O
         HoApodcLpSpQ4siGovLpI3w2BaYV47MUH+ZjTKIU7uqDGvO/KJuHWHI9UC8Uyv85UjA8
         2H0w==
X-Forwarded-Encrypted: i=1; AJvYcCW4x4QiQrjCz0ReOWwEqb1Q3C4wCWcMBaCt3whaVki2TdMP3KIOY/2l11b+ZA38TW9n0kuSK5BFTJX4@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsocGwQkdPFJrRqn4xy3YDG1nBQnAa4w+V7+W372l03hA/iN8
	TTXWedeLKR6EZehRHK+/Ob9FPQUhrjPkOOlxFrBrXkfd+POATPhAKIUXE/V9iinl6RHIVvnTHJd
	JqnItYIYLlZJPNW8SiEQIraiZ6eDuFCjAU0bJcNuP2X6WrRYpyI8Sz6Vj4VfQm1c=
X-Gm-Gg: ASbGnctqp1nd/KOKXkWZGSrgpHwR6dJ0HWR8+mPBaiDA6fkVMS7gxH/2R5cu67etBOY
	hzZ7joyIseopfaerCRc0dKhfa0YfkgVe4yXAHf6fSPiEYxWC7f0v2SVGHHU7ct71ubWkmQQQgGN
	J00gCPJGmXpPiavdNKae+Oro1vl7hwbUZKcV0qpSIscpOjEp0lAWQc4qhKXWYL9kWxOAiai9B3t
	DHOFdbDSBG8gLna/702ZPIBUpLk/wELwv+vFQxbT5l4A4ufNcukFe6RCuafo30cY5rj76wbXdx7
	elV5BEGxlEvwqzGhm8M0YnIxdfvpr7xlS8DiEQuQ
X-Received: by 2002:a5d:4b8d:0:b0:3a4:d038:cb9b with SMTP id ffacd0b85a97d-3a4d03934c5mr7058869f8f.7.1748334099820;
        Tue, 27 May 2025 01:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ygYqA7kSuJJZqhl/70ykBU9DVEzJ3IhPzwyQTk7TYbVU4pkiKryBDcz2EX1CV/oKLxvsFA==
X-Received: by 2002:a5d:4b8d:0:b0:3a4:d038:cb9b with SMTP id ffacd0b85a97d-3a4d03934c5mr7058850f8f.7.1748334099298;
        Tue, 27 May 2025 01:21:39 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-26.web.vodafone.de. [109.42.50.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d58a59fcsm6588116f8f.76.2025.05.27.01.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 01:21:38 -0700 (PDT)
Message-ID: <8b96836d-4337-4acc-8db2-b1e276d019df@redhat.com>
Date: Tue, 27 May 2025 10:21:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] s390/crypto: Rework protected key AES for true
 asynch support
To: freude@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com
References: <20250514090955.72370-1-freude@linux.ibm.com>
 <20250514090955.72370-3-freude@linux.ibm.com>
 <f958f869-8da3-48d9-a118-f3cf9a9ea75c@redhat.com>
 <9939f4a9dcabae4c739b73b3f9e6cdb1@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9939f4a9dcabae4c739b73b3f9e6cdb1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/05/2025 09.31, Harald Freudenberger wrote:
> On 2025-05-26 17:25, Thomas Huth wrote:
>> On 14/05/2025 11.09, Harald Freudenberger wrote:
>>> This is a complete rework of the protected key AES (PAES) implementation.
>>> The goal of this rework is to implement the 4 modes (ecb, cbc, ctr, xts)
>>> in a real asynchronous fashion:
>>> - init(), exit() and setkey() are synchronous and don't allocate any
>>>    memory.
>>> - the encrypt/decrypt functions first try to do the job in a synchronous
>>>    manner. If this fails, for example the protected key got invalid caused
>>>    by a guest suspend/resume or guest migration action, the encrypt/decrypt
>>>    is transferred to an instance of the crypto engine (see below) for
>>>    asynchronous processing.
>>>    These postponed requests are then handled by the crypto engine by
>>>    invoking the do_one_request() callback but may of course again run into
>>>    a still not converted key or the key is getting invalid. If the key is
>>>    still not converted, the first thread does the conversion and updates
>>>    the key status in the transformation context. The conversion is
>>>    invoked via pkey API with a new flag PKEY_XFLAG_NOMEMALLOC.
>>>    Note that once there is an active requests enqueued to get async
>>>    processed via crypto engine, further requests also need to go via
>>>    crypto engine to keep the request sequence.
>>>
>>> This patch together with the pkey/zcrypt/AP extensions to support
>>> the new PKEY_XFLAG_NOMEMMALOC should toughen the paes crypto algorithms
>>> to truly meet the requirements for in-kernel skcipher implementations
>>> and the usage patterns for the dm-crypt and dm-integrity layers.
>>>
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
>>> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>>> ---
>>>   arch/s390/crypto/paes_s390.c | 1812 ++++++++++++++++++++++++----------
>>>   1 file changed, 1270 insertions(+), 542 deletions(-)
>>
>>  Hi Harald,
>>
>> I'm currently facing these errors when building linux-next:
>>
>> ERROR: modpost: "crypto_engine_stop" [arch/s390/crypto/paes_s390.ko] 
>> undefined!
>> ERROR: modpost: "crypto_engine_exit" [arch/s390/crypto/paes_s390.ko] 
>> undefined!
>> ERROR: modpost: "crypto_engine_unregister_skcipher"
>> [arch/s390/crypto/paes_s390.ko] undefined!
>> ERROR: modpost: "crypto_engine_alloc_init_and_set"
>> [arch/s390/crypto/paes_s390.ko] undefined!
>> ERROR: modpost: "crypto_engine_start" [arch/s390/crypto/paes_s390.ko] 
>> undefined!
>> ERROR: modpost: "crypto_engine_register_skcipher"
>> [arch/s390/crypto/paes_s390.ko] undefined!
>> ERROR: modpost: "crypto_finalize_skcipher_request"
>> [arch/s390/crypto/paes_s390.ko] undefined!
>> ERROR: modpost: "crypto_transfer_skcipher_request_to_engine"
>> [arch/s390/crypto/paes_s390.ko] undefined!
>>
>> I think the Kconfig is missing a "select CRYPTO_ENGINE" somewhere?
>>
>>  Thomas
> 
> Well, with the rework the paes_s390 module has a dependency to the
> crypto engine which is the kernel module "crypto_engine". There is
> a kernel config CONFIG_CRYPTO_ENGINE but this is not defined in our
> defconfig and debug_defconfig. However, when I build a defconfig
> kernel I automatically get CONFIG_CRYPTO_ENGINE=m in my .config.

I guess it's working for you since you have the "CONFIG_CRYPTO_DEV_VIRTIO=m" 
from the defconfig, and CRYPTO_DEV_VIRTIO selects CRYPTO_ENGINE.

I'm using a config without CONFIG_CRYPTO_DEV_VIRTIO, so maybe try to disable 
that in your .config, too, to see what happens...

  Thomas

