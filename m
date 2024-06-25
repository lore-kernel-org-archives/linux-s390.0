Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5A146D6A;
	Tue, 25 Jun 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301494; cv=none; b=uYY+dfbF4/T2pL9yLCeZJzPnotJFEo1l0mke8W70/hQbDinj1Gva3dEssz6k9NKNnWh76sXO48Z0BWheyI4vCvcF2ToCajH5FlgRaog80OBOWuNeJv5a/sTRbBFai/e5aLBm1XSBqgsR42D9OZSQjFCSFHYVUNV71LLd+pB+NIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301494; c=relaxed/simple;
	bh=CKj7StaaLWAYcShEgfK6am7EVw0Wcv13Sy9/IIP10GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmVqLbWsPyctQfWSIh/POmxhboJoaQZqX3IIXKheZeMwE7FHpImqGrF2l6QKYBuuNPh3fdjm2htTd9ezUZDdD3l0ylYzvD5jB78ZypLhO4CsWnR5v65ZTmA5Z00UvUgzqjUlxEi6+1jRpPBMOxCZCRHO99Vp4BgZWoDNOQDZWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq5q9jCL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq5q9jCL"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7065a2f4573so2557613b3a.2;
        Tue, 25 Jun 2024 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719301492; x=1719906292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9bNpnMQr1sigVGkEQxdpjCoaEnDXLkw0+fGFzW6LiY=;
        b=Oq5q9jCLXWJWJCDfPQ5esPWWPFBhOrHv9tMh/FYR+1iGuQfz3yP3GTG674yx4a2S2l
         qSe3KRJ6W+gjKBTck5MQrS94G5ukChUE0D6RqfiJvZ79jDRFu0W7g/nGuE/sXHeT1Xj4
         02DAsu1MyVNU401+gzlKo/OPRWYZ+R1cnDDg3JpNdiUAj3IatlX/SjO0LOjW2NZjtAW7
         56nSgD+dMWW2PlJ+1s6zVb5+ym/QIDw/xw38DxcDx219dpHJ+ZZkdhKgBkxJiKMKzrxa
         VqPolGi6tAumAatNrR0bG8dp/b5Xd6gZsqCk9lLzLzxGWyPhcvEH0hLhHTqeBFHs1OND
         t6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301492; x=1719906292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9bNpnMQr1sigVGkEQxdpjCoaEnDXLkw0+fGFzW6LiY=;
        b=l3/99pUHevL0N40hiDWUJumpCgMoYkB8Hbt7McRw7vbkUMFu13E6UqwTYwYJJsHow3
         xwrdVLHnz/Yz2LgUpOz/tYf5B6VSeH2VofcI92a6p8C3wOMi+e/FWa+tYaqR+rxXOXEk
         128KNndHQ66w0JUCifgaxVlwiYF50OWsFQycgGiviH1M1gBF3KTJGsEtOTx/d6DLX2Lb
         fAMk3bZZRxi3a4n/fBkHYWPrjOxh5woIwiVyPl1ZOHed50C7oEgCg+N5PTShCy7DgUje
         lzTqkdNbHfU6C/QHySjwy+koovG1cFaZca/ZEebpV1lnP77Sf42RKKKyTZuK7cghjGT2
         m6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHhTxitu3qzGUL9uB6zAd4MFArZ/zkuWticjw8uBLqokHxc9QAkN1jlo2S6D4HsbP0FLAIKxXemVUUIwsbcofbhzQ/JdA7RqvEtGq25eEj3Me/qU33QTxMPLG9SioPOjvrBkW+DtLEeg==
X-Gm-Message-State: AOJu0YzoalHZtqJtc3IJ8NVx4v6/bS8HMAydMZn6K/Acjyvtrf6k98uJ
	NYmzXcK6MgCp3VpHGklbqQBSEsBZXx8miuwACUDgB3ZyU9WxUmOD
X-Google-Smtp-Source: AGHT+IE3vocBU23Qt4Sm//8nQYn6iEX/8//N53fmeBeJrlpHpfGfA0XguMcQ2Ic/tX661WahnJ9QsQ==
X-Received: by 2002:a05:6a00:3c94:b0:705:9ddb:db6b with SMTP id d2e1a72fcca58-706745aaf1fmr7816795b3a.13.1719301492086;
        Tue, 25 Jun 2024 00:44:52 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70691b08199sm1525805b3a.104.2024.06.25.00.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 00:44:51 -0700 (PDT)
Message-ID: <c88ce35f-eca1-421a-a75b-e56fb6abfa06@gmail.com>
Date: Tue, 25 Jun 2024 16:44:47 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/raw3270: Handle memory allocation failures in
 raw3270_setup_console()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Markus Elfring <Markus.Elfring@web.de>,
 MichelleJin <shjy180909@gmail.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240625013225.17076-2-yskelg@gmail.com>
 <20240625063139.9210-B-hca@linux.ibm.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240625063139.9210-B-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko,

On 6/25/24 3:31 오후, Heiko Carstens wrote:
> On Tue, Jun 25, 2024 at 10:32:26AM +0900, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> A null pointer is stored in a local variable after a call of the function
>> "kzalloc" failed. This pointer was passed to a subsequent call of the
>> function "raw3270_setup_device" where an undesirable dereference will be
>> performed then. Thus add corresponding return value checks.
>> The allocated each memory areas are immediately overwritten by the called
>> function zero-initialisation be omitted by calling the "kmalloc" instead.
>> After "ccw_device_enable_console" succeeds, set the bit raw3270 flag to
>> RAW3270_FLAGS_CONSOLE.
>>
>> Fixes: 33403dcfcdfd ("[S390] 3270 console: convert from bootmem to slab")
>> Cc: linux-s390@vger.kernel.org
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> ---
>>  drivers/s390/char/raw3270.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
> ...
>>  	rc = raw3270_setup_device(cdev, rp, ascebc);
>> -	if (rc)
>> +	if (rc) {
>> +		kfree(ascebc);
>> +		kfree(rp);
>>  		return ERR_PTR(rc);
>> -	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
>> -
>> +	}
>>  	rc = ccw_device_enable_console(cdev);
>>  	if (rc) {
>>  		ccw_device_destroy_console(cdev);
>> +		kfree(ascebc);
>> +		kfree(rp);
>>  		return ERR_PTR(rc);
>>  	}
>> +	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
> 
> Why did you move the set_bit() call?

Thank you for the code review Heiko.

While writing patch version 2, I spent a lot of time thinking about this
part. Previously, even if function "ccw_device_enable_console" failed,
the flag was set to RAW3270_FLAGS_CONSOLE and returned.

I think it would be more appropriate to set the bit after everything
succeeded, so I included and submitted this code in v2 patch.

I’d appreciate hearing your thoughts on this!


Warm regards,

Yunseong Kim
