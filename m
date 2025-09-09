Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099629BD90
	for <linux-s390@vger.kernel.org>; Tue,  9 Sep 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427167; cv=none; b=AeZY4SmVL5vT1X78GVueLAP0xDfQxI6nABohwNe6jcnStWyJX6lOn63AK53Auy0/C8hotdpSdwpwjK73HVXqH5nOT2yI1t7quf8vPR6ktvia6vNV2EqMeZEalG95g2wIt7MtMFD29ji3fAYCy1frF+0oY2VwvH/FnHrM4x6hO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427167; c=relaxed/simple;
	bh=FUGUHbmTlUk8TQfWfWrdMH175CzOHUSDBWw86JAA1Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVbRpCVrp7CLMV15QI/9LzYV1VAKIBwU1jsXgA+ApzO2fhewV0e/fBzkpvSZQ/YSCBN6sNUoAgvJ8YNIYYUrriRtRpWkE4sHASOdIBx9z38Y1nmc4hRQthYbmgNvxfN3ztbWID7KoNHQ6YBGHnIoILv8eqrq32Ir3PIpfX+SUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0+ETrUA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0+ETrUA"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso6875676a12.2
        for <linux-s390@vger.kernel.org>; Tue, 09 Sep 2025 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757427164; x=1758031964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3ctfjE+pKRwd5zF4FXaQW3t/vZs+ySfwFN+6YFF61/s=;
        b=m0+ETrUAsiIjW/n4gbi7VaoDjrTg+WtUGHyiRpN7QWqxrH0gOYcutJpsrDSNhNTAxu
         a0zzFjuWFHMkQrY5FULwU5BBUWzi9AgNoKgYaZKe8U8DH+TQqKYJcCT0yIln6wBrEhlV
         W0PfThWGUyJ7SfspfYMm0KHZayFS5r7s3W2lf4uwanIrJqWTKDWsd2u4Z6xm9ACoEFSc
         0/a034AaZsQEOY+wyxRboTbs/j4qe3viX5ci+rdsb/w4k0RUnAph4zNOsFMSqgtZiZAG
         DqpCyKA1rrbj9QWs8+/yh2FeGNk/ghd88mOfwTy9H3KvyUb3E7HMvPGLAggHaVj8nwm4
         Mc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427164; x=1758031964;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ctfjE+pKRwd5zF4FXaQW3t/vZs+ySfwFN+6YFF61/s=;
        b=WYTbrMW3pZhBCIbJDMonYVAzQNcjmjqN43PdPVg6hZ3I/thxRU1hpot2TOAPJs3Yvp
         LtGApkTtXyAvof/WjV6YOxQ5XOLEnPthSjH0VkYCc2FApLUvfWA2nfd4NhPvzBupBduk
         A4Y6J5wmhj8Xu8DUWjfgDE0Vcy47yLOTBFhes8CVf2LDT+S+PVu9kpJ6PfeymHQxMNnr
         BtgHSK+aMMJ65/whpWVZDSr08VxZpx9IaYOXXvaNBmFVd3gJ8fFLiKSvsQGHogx2RnqN
         nf7eOJ/cltILofIcq70yuLU2TEmh+Nwcs4AC80HgVxJw6FIFZyIxscwZK1C5L75AxEsH
         3tlA==
X-Forwarded-Encrypted: i=1; AJvYcCXDNS8Xws1itaUOPOdLyMMlIoYPF8EpG91ObpcCPRkoBCBAOYFNi3lENkT51+cjbLC2LqZMgkUzWV8J@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJHzybg1sKm8HAo4+yGAdW1/BqCYaiIHFPpkMct5z9hqCWFOc
	1cIDToCgYBwJ1z0m7hCdUmp+a6AXfasj0BXPL90IWwi1g+MgV1OPozww
X-Gm-Gg: ASbGncvHesz5Pb2DKb2M2bDVfOF8+PSgxAda3lhsYzNn2+lVcvnYP1i4BPMNIgwh1IQ
	AAaL67EgpEBnPNmkkDjwaYqmdAp1ZuXyNdRpD98kKq+OqCK4LKw463mhnij7u9RIMRFW1rk+cD7
	CyxCazOpS5TWcPeEz2XacawBBLCtA/B5JvImBtexvpMVoYutgkOgN/Eo6qcAwqfShEPqzB71W2D
	pDeH/q3l4JukkFsVaSTFa02TDAo6haCml5Krz9ro8VyH4Ok6oDlZwHW1fdho/ixmPFfspyN16o5
	dKlUeQjix1Eor8+yDMeE8qUILYj6NIUjr+Qb26v4NAlKVdd5FVhm4VqzGneFNv4DBqY/0z0mV1P
	qu8bu/T4Hd90i6vp7hR7ln0+x4JN3um8zDAc4j5Q1bNJHRWsg
X-Google-Smtp-Source: AGHT+IFo0uq6VNSOptACqaP1uIiI4hzg0CWa7RBqBAinrZ7LRh6LwZhjeHLCNofDQz5RJV+0GvfH/Q==
X-Received: by 2002:a05:6402:34d3:b0:628:62d0:fdab with SMTP id 4fb4d7f45d1cf-62862d10569mr6682485a12.11.1757427164100;
        Tue, 09 Sep 2025 07:12:44 -0700 (PDT)
Received: from [192.168.2.22] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfef6752esm1329347a12.12.2025.09.09.07.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:12:43 -0700 (PDT)
Message-ID: <446ea303-0da0-40a1-8cc7-6faab9f9d22c@gmail.com>
Date: Tue, 9 Sep 2025 16:12:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] dm-integrity: asynchronous hash support
To: freude@linux.ibm.com
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
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
 <76c330493c036317755838d2dfce2de0@linux.ibm.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <76c330493c036317755838d2dfce2de0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 3:51 PM, Harald Freudenberger wrote:
> On 2025-09-09 14:15, Milan Broz wrote:
>> On 9/9/25 1:50 PM, Ingo Franzki wrote:
>>> On 09.09.2025 13:47, Milan Broz wrote:
>>>> On 9/9/25 1:18 PM, Ingo Franzki wrote:
>>>>>> Please, revert my patches and run the same test on a clean
>>>>>> 6.17.0-rc5 just
>>>>>> to verify that the patches do not introduce the bug.
>>>>>
>>>>> With your patches reverted the combined mode fails the same way as
>>>>> with your patches.
>>>>> So they did not introduce the bug.
>>>>
>>>> Please report it as cryptsetup issue with a reproducer so we can
>>>> later check it.
>>>
>>> I don't think its a cryptsetup bug, its rather that dm-crypt is
>>> missing something to deal with async HMAC ciphers.
>>> The point is that PHMAC is a async-only cipher, with no sync variant.
>>
>> I know, but there is no tracker for dm-crypt and what I like to have
>> some kind of upstream CI testing for PHMAC/PAES
>> even without mainframe hw (we already talked about a fake cipher
>> module).
> 
> Let me think about this a bit... You are suggesting a test kernel module
> for
> e.g. x64 which acts like the phmac/paes implementation in a asynchronous
> way.
> I'll discuss this with Ingo.

Just for the context - we do not need a real implementation, only something
that pretends the alg with that name exists so we can check all options.

In reality we just cloned SHA ans AES modules and renamed them - we do not
care that keys is not wrapped, we use it directly here. This allows us
to prepare a test script that can run in our CI without mainframe HW.
(These modules are compiled on the CI builder and loaded to the kernel.)

If cryptd() can be used here, we can trivially add async path testing.
It will not be perfect, but still better than nothing.

That's all, no real magic :)

Milan

