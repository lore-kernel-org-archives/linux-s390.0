Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F414EC77
	for <linux-s390@vger.kernel.org>; Thu,  9 Jan 2025 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736400568; cv=none; b=PMmBFSvi+xSShbxBdZbUSg4VwmdiK9qIH8X62RiymZHH1dUiw9Wr2+AgR55RXwOccvZM5qfoQ65xRSp15DF0U73S1XbZKzYf+f63TEr6nzqqv2dVvo1RlCd0rj06SQvfcp6sI0sZ0ld2EtY+ryK/QSNyx+BLKwqLmPE3AIX3aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736400568; c=relaxed/simple;
	bh=AokpQtg4wT+HaVxGAkUafltUyUpP2VUjq65/op/PFFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKuZETQXYoXcAlh0H6nVto7JRcJLnJtF8XQqf1428zQkGkqGOSZRxjIrcgW72XfPxNhzp2MAWepkf+4AUmAIoJVaL3+KTZAXpyStzfJEmvHsYQU8k4lr73BI+EFCdKU7VYlVhmD4OUPbY26+4s1j26phfXjw9H3J8CrmU2jSiQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=BJ1Y58d3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="BJ1Y58d3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166651f752so9612285ad.3
        for <linux-s390@vger.kernel.org>; Wed, 08 Jan 2025 21:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736400566; x=1737005366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMJt/YhwUnBzvs59wX/sgUOAGddtx1maXOTnOv1QH5s=;
        b=BJ1Y58d3hpgj/XHSiDXIc/mUhau1oC71NOyEyM6o3N16MLBKv45x6ifKvDtPOLSAqQ
         ooiw4B9hkuBC5jxlHPaUcOc5ToRxPgOMoBrsRoUV0dqs5BTlwefA/Sn25J4uZR1Df8Vr
         zhGEf5NDmFsEhmyBGm8EJpDwp36DuD9oDBzNyFL/ilgkcs+QANONLNl7Pw87wwcTPyDq
         Mz6PBsNu7YTdZxJmVmsxeyoHEzncLYIBVJROF4yqracnkLEUj16YTnbRVPzvcz7C1GJM
         gnMyg/0fIztXb5VaNfe0vxZg84Z1WFLz1Yyx94b4aeqA7yjyXZHN3CJ6ISwi5a1657VH
         PGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736400566; x=1737005366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMJt/YhwUnBzvs59wX/sgUOAGddtx1maXOTnOv1QH5s=;
        b=CKfDIuH/ZvWVOsZ1HPxBlcrKhhp6oM+6USHGpWDEX69FHpvUi9dlDb1NCquQrZphiP
         vyr7Re4w09+WZVBXpKDAyvSQbj9HpKRSLUjPLUnyGsm1pLxLpOPoQjEWivRAgRhf20FO
         uZPWpYixWJeZeI73k+8iGT5oG6vQOIMQUU/zxv2abAvmkKJkVdh56zDvNLghDfa+4UB9
         +eUkEm1d8HgsAmRlk6EF6up4v15Lc3s9lgNHB9siH1HQhqG9INipSySvJPSlNGWZd9cv
         T/M4AtBLnfQZ6Pj0lW7IblZRexHrW4d6jOLyewiMOBOrdpQ+af/N8/6wDlQJDLfPrGR6
         aIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtVANyneU+tIsQQDqzzc3fOxTjRkt565hZ/eV5BHcIV7YFTEhGBgSLZdKYqtfGF7PRSmlQMaXKmKdn@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkV+HUjW1tL9CA5BA7kCVmRm3Es8knZe3QTG/7cmHrOtneqtz
	P2EgY/kp96vyVtz1oJYs0VZWjx0C+wEthWafZVgSE/Cm0Resb5eJzot/CLWe60Y=
X-Gm-Gg: ASbGncuXOsJKYxVex0/3hxNgWwfntwkyxgIf+gLL2tGGeQNLsRA4/5SRijkNnHDD9HS
	MjncZyy73xb1yNLDkz6yS5SZDY/gwjqgzoUbmQDQA9O52tX2V3LiPehajf4D05mBBAp4eZuqwsO
	g3ZS0GE92c6R2kiLQtQhOtQsUv0VKhNyYzI46a41QyK8gDBc6S+q1CGVzbC21g4HhE+tcRqEicS
	ZjNLBABjCksjbVKhUyw3YhPc/jEilrSEYT8MH5LjdK21hRvykhHaxSMn4G2j+GwV0c=
X-Google-Smtp-Source: AGHT+IHb0FVyvp1dm7B/1h/x9uzjYQ//zMkoJ4qWj36+ahLI4sk0W30C74Z9uJRWuq6gqr8rh892HA==
X-Received: by 2002:a17:902:f681:b0:215:e98c:c5bc with SMTP id d9443c01a7336-21a840094b7mr86342285ad.48.1736400565988;
        Wed, 08 Jan 2025 21:29:25 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a91744580sm3702405ad.84.2025.01.08.21.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 21:29:25 -0800 (PST)
Message-ID: <2ad7234d-bfc5-49e3-abe6-7a85d992329d@daynix.com>
Date: Thu, 9 Jan 2025 14:29:19 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] s390/crash: Use note name macros
To: Dave Martin <Dave.Martin@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
 <Z31Tp0nMhb/ntUW0@e133380.arm.com>
 <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
 <Z36Cljsz2p0hYsFd@e133380.arm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z36Cljsz2p0hYsFd@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/08 22:50, Dave Martin wrote:
> On Wed, Jan 08, 2025 at 01:53:51PM +0900, Akihiko Odaki wrote:
>> On 2025/01/08 1:17, Dave Martin wrote:
>>> Hi,
>>>
>>> On Tue, Jan 07, 2025 at 09:45:56PM +0900, Akihiko Odaki wrote:
>>>> Use note name macros to match with the userspace's expectation.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
>>>>    1 file changed, 23 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
>>>
>>> [...]
> 
>>>> +#define NT_INIT(buf, type, desc) \
>>>> +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> 
> [...]
> 
>>> (Note also, the outer parentheses and the parentheses around (buf)
>>> appear redundant -- although harmless?)
>>
>> They only make a difference in trivial corner cases and may look needlessly
>> verbose.
> 
> (In case there was a misunderstanding here, I meant that some
> parentheses can be removed without affecting correctness:
> 
> #define NT_INIT(buf, type, desc) \
> 	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> 
> It still doesn't matter though -- and some people do prefer to be
> defensive anyway and err on the side of having too many parentheses
> rather than too few.)

Well, being very pedantic, there are some cases where these parentheses 
have some effect.

If you omit the outer parentheses, the following code will have 
different consequences:
a->NT_INIT(buf, PRSTATUS, desc)

The parentheses around buf will make difference for the following code:
#define COMMA ,
NT_INIT(NULL COMMA buf, PRSTATUS, desc)

But nobody will write such code.

Regards,
Akihiko Odaki
