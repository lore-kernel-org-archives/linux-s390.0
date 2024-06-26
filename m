Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C11FBB;
	Wed, 26 Jun 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388565; cv=none; b=BTupIgD2e2foBe+9A+cIiKLIlG8/YSr9fFsuM/guyjdTJxCfo239MKqUzp3wE1MBotsSrVcU/7H8AxD7hkOyozds+LZW/A17Aal/CTse81LV6Wep5sJV5TLRxmfd39rLq5u4TvHmCTHHyS/jhtxEF2Gw63zIof+K4dGade+PPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388565; c=relaxed/simple;
	bh=ku/Jxt8P9jnOA0rNYoyZAmNkMcXikbz5GlUWsxHka0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COJmONDhNe/Bs9ErLmXhPB2wEogUUuEqOXAj/t1VuNWx+E1JOBe28L3rhLmRLQUa1b0RSDJzlT3i2mVWK3GgLdqZuQywaTpELQ/ZN2LEDwZnb19gT/ticWCnKLfldD0AGTWuufnVKeXX34M638x1pgL5UCbi4fxcqnV1/LutEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwWDjv9x; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwWDjv9x"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d55f1e52bcso554152b6e.2;
        Wed, 26 Jun 2024 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719388563; x=1719993363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Usd909YlfhDsHM68RskA4rX3tA2r0uQwKhL9XxkC+6w=;
        b=XwWDjv9xN5EIRCNlk1oH9UOjL1A3w+HWg/ZywouJMgwhls7Bw42VDsBqkSPenLQ/DY
         9f7N2nQOXBIu//Zhoi72J440ZpJ84u4mlSTSlKFPaqAVAt9eoiT5xunnPa1+ZcSmaPsG
         oz3JaveCyrn8X92CjUd4cmaNIdKSC+l/c6CquvT4UaryriuScFaaonoMPGCJh7GBUGBA
         yaNFPLbOdGoT5hoNmhV9JR0RIBkVA9qJPiM0+KZFQZwYCURBm8q1o+5fAhzLGgTUwpsQ
         fgNr9JLOu6TaOj6j5tADncta1qX7uwmfz2sh+3piLF5SlWejQVPIHTUmsTdH7cur7Hqw
         Nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388563; x=1719993363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Usd909YlfhDsHM68RskA4rX3tA2r0uQwKhL9XxkC+6w=;
        b=tSpE5O/sBfglE2WE5aJnO1RIr1i72UQif/Oc8cow/dFFbDzSOwaK5S+FT3OqXN1VlS
         pGoVg4N/eny4lhXa9q19WJa+rcsXwxvMlJAG3xpvysrA/bXMYfWI44RAw9XFF1NFRpHg
         +IMDCiiT0XgQMwVWgvlMHp8h/8l6auJRJ+aiF5SrrOC2df1wsu+bfvdofYZhHx5ctSrl
         ZFlnbMd+Tub8WLAL/oLmBuLKBa2CNkci0Yl2CI4xa6YSqdrB2n3mZZBi1lOhELVcdDaJ
         9uV/nfC6blbso6Zzq4xzhH9s4X8/fjxSHM7SSOaXUD2+vYuMcKBqYzGFEAuTTNmQ6RYW
         xb0g==
X-Forwarded-Encrypted: i=1; AJvYcCUa5zlVWFdEGPuVOuD7J7zTfghw5nOfWQ+sZoB/iyc4bGBBUjpySmH/sSUm3j41wrOoapr2dB9xH4No8zzSrb0V4ti86itsp3RNZM31cKsKMRBccB/Dkr6juZkO/5gnOstjSEwi0TNJXg==
X-Gm-Message-State: AOJu0YwwphAji5uWDaST9ZCNO3nEJoAbTYoxkSOjUSvY2wAjC8btk2Lg
	Z0XZCx238Gxr6OfilEXcv18bVmdyXh96Sg8hF7qfaBfQJv0r0e/o
X-Google-Smtp-Source: AGHT+IFq2k61ZfDssegRsmZLhp8uZvejVWD2+TbgvO4NzEsDGqe2j1e8giYw+Qn/AQvje1WyD+C7NQ==
X-Received: by 2002:a05:6870:219e:b0:25d:ab2:15d1 with SMTP id 586e51a60fabf-25d0ab218a1mr10808170fac.36.1719388562694;
        Wed, 26 Jun 2024 00:56:02 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716baf4acd1sm8208103a12.75.2024.06.26.00.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 00:56:02 -0700 (PDT)
Message-ID: <b9802d33-5af2-42ca-b8cd-e4150bbe8d6d@gmail.com>
Date: Wed, 26 Jun 2024 16:55:57 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/zcrypt: optimizes memory allocation in
 online_show()
To: freude@linux.ibm.com
Cc: Markus Elfring <Markus.Elfring@web.de>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, MichelleJin <shjy180909@gmail.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Holger Dengler <dengler@linux.ibm.com>
References: <20240624222933.81363-2-yskelg@gmail.com>
 <eefcf6fb6c66979c5b4c0a4572d64df6@linux.ibm.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <eefcf6fb6c66979c5b4c0a4572d64df6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Harald,

On 6/25/24 5:27 오후, Harald Freudenberger wrote:
> On 2024-06-25 00:29, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> Make memory allocation more precise (based on maxzqs) by allocating
>> memory only for the queues that are truly affected by the online state
>> changes.
>>
>> Fixes: df6f508c68db ("s390/ap/zcrypt: notify userspace with online,
>> config and mode info")
>> Link:
>> https://lore.kernel.org/linux-s390/your-ad-here.call-01625406648-ext-2488@work.hours/
> 
> What is this Link here? It is pointing to a PR for a 5.14 kernel and has
> no relation to this patch.
> 
>> Cc: linux-s390@vger.kernel.org
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> ---
>>  drivers/s390/crypto/zcrypt_card.c | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/zcrypt_card.c
>> b/drivers/s390/crypto/zcrypt_card.c
>> index 050462d95222..2c80be3f2a00 100644
>> --- a/drivers/s390/crypto/zcrypt_card.c
>> +++ b/drivers/s390/crypto/zcrypt_card.c
>> @@ -88,9 +88,10 @@ static ssize_t online_store(struct device *dev,
>>       * the zqueue objects, we make sure they exist after lock release.
>>       */
>>      list_for_each_entry(zq, &zc->zqueues, list)
>> -        maxzqs++;
>> +        if (!!zq->online != !!online)
> 
> I don't like this line. It is code duplication from the zcrypt_queue.c file
> and uses knowledge about the internals of the zqueue which is not
> appropriate
> here in zcrypt_card.c. Please note also that usually the total number of
> queues attached to a card is in a one digit range. As kcalloc() anyway uses
> the kmalloc pool which is ordered in powers of two it is unlikely to really
> spare some memory by only allocating a pointer space for the online queues.

Thank you Harald for the code review! Oh I see, thanks for the advice.
I was wondering if it was useful when I was coding it too.

>> +            maxzqs++;
>>      if (maxzqs > 0)
>> -        zq_uelist = kcalloc(maxzqs + 1, sizeof(*zq_uelist), GFP_ATOMIC);
>> +        zq_uelist = kcalloc(maxzqs, sizeof(*zq_uelist), GFP_ATOMIC);
> 
> Your improvement about removal of the +1 and use the i value later instead
> of my implementation which uses a NULL as end of list is valid and makes
> sense
> to me.
> 
>>      list_for_each_entry(zq, &zc->zqueues, list)
>>          if (zcrypt_queue_force_online(zq, online))
>>              if (zq_uelist) {
>> @@ -98,14 +99,11 @@ static ssize_t online_store(struct device *dev,
>>                  zq_uelist[i++] = zq;
>>              }
>>      spin_unlock(&zcrypt_list_lock);
>> -    if (zq_uelist) {
>> -        for (i = 0; zq_uelist[i]; i++) {
>> -            zq = zq_uelist[i];
>> -            ap_send_online_uevent(&zq->queue->ap_dev, online);
>> -            zcrypt_queue_put(zq);
>> -        }
>> -        kfree(zq_uelist);
>> +    while (i--) {
>> +        ap_send_online_uevent(&zq->queue->ap_dev, online);
>> +        zcrypt_queue_put(zq_uelist[i]);
> 
> The content of this while loop is NOT covering the old code. zq is not
> set any more and thus the ap_sen_online_uevent() uses a random zq which
> is a left over from the list_for_each() loop.

Oh this is where I wrote the code without understanding it properly,
thanks for the guidance!

>>      }
>> +    kfree(zq_uelist);
>>
>>      return count;
>>  }
> 
> You sent another patch for the online_store() function with exactly the
> same code changes. I would see these changes as one patch and don't want
> to have more or less equal changes spread over two patches.
> 
> I am sorry, I will not pick this and the online_store() patch.

I'm so sorry Harald, This was missing judgment, I should have checked it
one last time before sending v2 patch mail.

> regards Harald Freudenberger


I truly appreciate Harald for the detailed code review of my patch.,
even though it may be less understanding in many part.

Thank you very much again!


Warm regards,

Yunseong Kim
