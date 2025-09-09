Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D93376AF
	for <linux-s390@vger.kernel.org>; Tue,  9 Sep 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421610; cv=none; b=e/t/HJVGWqyiLtaUFTmd+5w2o+bLzpLhB0huflrTekafWjt9ZVSBDFdgY+OnSnlkU3MbmdCxEvg9rADkwGhXdBNczEbfQPU9izcMWHlxSsHdHaE1KV6ky1BTssCs8m4xoDbjUpHxFh0FoNwPaYmiAdhU9B9kNv1PxaeicQfybgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421610; c=relaxed/simple;
	bh=e2PuQb2l5qTeOFUWgaP2Y3aBrBA1nbxOn5Rl6oGAINY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTCW+APn0gNFX51cHtdcJdfL3x9e2oKsqzeo2nHfotuJ+8oLUge0RYQm8d5ZPkBz2lgj2Wx3rvF77WGSUhjVubW5aGTd+IDFwiyvhpf/a77oMhJsmohVtcR/9VIbDMTFl3/EYlSqJIx9SeosskUH9YMeWc9xky4cLxE96PavVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNLZ09Vh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNLZ09Vh"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso3439316f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 09 Sep 2025 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757421607; x=1758026407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BDedzkBOdVERM0pC4shSEa35qWKaSVEhc1VqRRZMMH8=;
        b=GNLZ09Vhkaz2yuE4c1hmQcTB7M945uhqJkovDdlQs7ITRcUJ9m+uA6fpMxY3LtcQqi
         Fnb/BbGYn7yO8NM/bz33gT+NYAgRCZTgcfOrLR1Fffk5WsRQRjL8GnakypLvVhsLAC5r
         yDl6DPX2Skgb3WXz2M1m03utfHqD3/kseDYKh+OlhQYuh/ktpY8McWz2aBR2gt9ENvZG
         fEHGx71Y4BJQ2TrULeBf3hZmeOmWmSQe5Aj9CAHz1WNcVEGAIVA8Dw9hrcpWlu6U3Ua2
         J7vP+RFrEAiHGeg+O8BihUpfM5uuGFQz17Lp1lOCVpNPwG/P8z+1j4dDrkfIt/1WxFZi
         3VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421607; x=1758026407;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDedzkBOdVERM0pC4shSEa35qWKaSVEhc1VqRRZMMH8=;
        b=m3OZEuzI0ZyH3T3vNsTFxHjXbfSfgT27wCXPFWYC/2derhzPzJeAVka0sBffSduMUv
         NRhNrIHLwxxBoSAzLkGhrVXXG4s8rIM37t0s6Im/kprtrFebDyLO6oNdiSnji155vrKS
         Mm4gsw0PPX7jDQr41E9r7Odhqv0BQPOpgdf5l6QNOtpfWo33C6P+L3wj0E8DsFK4oCQa
         I+cPYRIQ4fJxTmgAakw93bKh+4vm2vAI2NuU6TGCsshj91zvbNJ6iHXWv9i5m23UcSX1
         H9WG1F0ZamQujC8AyfCrWIbZHSfzdMk9p99AJTe+enQ1GCjDZtswO0if/FqyPibAjsLh
         T+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWfl/y0eky/taKJ79HHKULaN/+WcjSZWri310KLtOdSL8PC62pFw3IWkhad3LSImKpNMrhgnFygrFNt@vger.kernel.org
X-Gm-Message-State: AOJu0YyluOqKCTogTaGVBSv3h3FcZtF86cx8rElhhOxfe/J4GkS/9TQw
	kBrUoivd+xbiSzyReGQzFj4EhZPO5buDdywrSXQZ4Ceeof2lFHxGDzWQ6riYc1+Y
X-Gm-Gg: ASbGncuujPNfbwSuCPsFn4ExovDY5MpiBoqnlLIhQzXLfTjnlgb/MwwswBYrnS5WBmb
	Ipe1b1NVchOwZSz8pt7x7vqDPyZgSp0EfdQVQ960ngqwowp5mY/YXKHZriYz95kImHgYK2rw0nz
	zfmoFUZmO/HyqdPOHG0oRMy5Pt8CEjo9pKs1K0nLtLaIuEJ9PUlBd98BZnhJWwAUH6lG8HbfAbU
	jPET3O4XfbXbeVJ++VnKNGA1Jg4qPphBU87e/w0xfoBA9yecDMg+bzOtMdk49uf8McecwT+sVgJ
	omMDjwBaFj0GjggoBvNwvYlmanPtiK8K2UmwZzQ2xPWOEKzuRd4XuIj+kAlrvFZd/XSMceaq+A4
	uMQAUQa+sFvG7cl7LC80E15OipL1SStaxbwG7SYA=
X-Google-Smtp-Source: AGHT+IFQo4PfJmUvDW++nyL92dtnzZBbYw0FXDblCHbuU4QK+dLtUZ0E/CoCZNIDZHrMSw9xH/KvPA==
X-Received: by 2002:a05:6000:2007:b0:3cf:74e0:55b9 with SMTP id ffacd0b85a97d-3e643eff35emr8910417f8f.63.1757421606691;
        Tue, 09 Sep 2025 05:40:06 -0700 (PDT)
Received: from [192.168.1.236] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm283426345e9.13.2025.09.09.05.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:40:06 -0700 (PDT)
Message-ID: <9152baa6-9974-4b33-a979-c63657f55dbf@gmail.com>
Date: Tue, 9 Sep 2025 14:40:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] dm-integrity: asynchronous hash support
To: Ingo Franzki <ifranzki@linux.ibm.com>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@kernel.org>,
 dengler@linux.ibm.com, linux-s390@vger.kernel.org, dm-devel@lists.linux.dev,
 agk@redhat.com, snitzer@kernel.org
References: <20250908131642.385445532@debian4.vm>
 <3a6b6f8f-5205-459c-810a-2425aae92fc8@linux.ibm.com>
 <e1e420d5-dc00-14d0-fdef-635d6ef70811@redhat.com>
 <bb68f9d6-8180-4291-9e6b-33bbdcef780f@linux.ibm.com>
 <3184e0b1-571f-4cf7-94ef-acca41c12b02@gmail.com>
 <b01c92bd-e00a-4c8f-803b-20d6a7db2ec3@linux.ibm.com>
 <bd535ddb-b9b0-4404-81ba-4e6f526429d5@gmail.com>
 <3b506db5-1e6d-4ef8-a6a3-1b0db334d4b3@linux.ibm.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <3b506db5-1e6d-4ef8-a6a3-1b0db334d4b3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 2:23 PM, Ingo Franzki wrote:
> On 09.09.2025 14:15, Milan Broz wrote:
>> On 9/9/25 1:50 PM, Ingo Franzki wrote:
>>> On 09.09.2025 13:47, Milan Broz wrote:
>>>> On 9/9/25 1:18 PM, Ingo Franzki wrote:
>>>>>> Please, revert my patches and run the same test on a clean 6.17.0-rc5 just
>>>>>> to verify that the patches do not introduce the bug.
>>>>>
>>>>> With your patches reverted the combined mode fails the same way as with your patches.
>>>>> So they did not introduce the bug.
>>>>
>>>> Please report it as cryptsetup issue with a reproducer so we can later check it.
>>>
>>> I don't think its a cryptsetup bug, its rather that dm-crypt is missing something to deal with async HMAC ciphers.
>>> The point is that PHMAC is a async-only cipher, with no sync variant.
>>
>> I know, but there is no tracker for dm-crypt and what I like to have some kind of upstream CI testing for PHMAC/PAES
>> even without mainframe hw (we already talked about a fake cipher module).
>>
>> It is not an real issue as PHMAC is neither in released kernel nor in cryptsetup yet, but we should have a test
>> coverage once it is merged.
> 
> The fake-PHMAC cipher you use for cryptsetup's CI is not async-only, so you won't see this error with it.

Years ago I tested async path by replacing algorithm (in kernel) with cryptd(%s-generic) - would this work in principle for PHMAC?

Milan

