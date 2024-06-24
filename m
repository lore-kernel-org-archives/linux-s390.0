Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19831182B2;
	Mon, 24 Jun 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252054; cv=none; b=di9/Vfpg1YR5XuzA09uXtmDx9xeBD+W17zG59qG6AS8QnqoADhu/CzSU8kFu1n59NneSgY2tBHaTZi1096a2dOukjbwzFtsTazOgcua/WP1rA6Am16+4SSTbq6d/yBFJUx40OM6Qioj8iHYpEd4uPxQQHuZt3zf/2xLHLX7KY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252054; c=relaxed/simple;
	bh=2+rWco3zjx9eoYZtRJyYjuTVifGdlskumaDhQmygHso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K28iwvkIUetw0Ddjjh41wEp8KOrV4iCjkX8lF1OCpv9LWZClUDwVB4RXRene2H7RskHX6YSwtRcEjsdohaH5G69lsPkp4DjPdP3aqUEMk9t/2CJb3Mw3bPv+TtAlrRe6c7YCS7S67tSUphYwwDsvI36B+PUTYY/1ly0gkVxymhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM8gTWf2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM8gTWf2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7066463c841so1625348b3a.1;
        Mon, 24 Jun 2024 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252052; x=1719856852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sya32zh6rlTi+rX0XJSzUKROEQWEvMEkDKstbuTkhuk=;
        b=iM8gTWf2B6okSNRaLN05K5iMIJujmh++WJfmPfmq4SCUIFx3ET1ICi9TXScm6/tfw9
         UsLXI+nVmXeF7xGpe/2uBQEirDKkOWjnIIJ6N6yxHMJ39WRVMoYAanUaGmz8JYhA1Que
         JJlBe9R5aieMQ2U/PuL8sc8fjFv1uT808Tu0rzk3pjja7Eoj2toqZdoJTn7pjQhufAb8
         9dd/if9WxR7W/nGT1dnKBg8tQ9EB8hU4rvl6U6BSZ3mfR9tEq3GUMEq6z3WXWtf05qCO
         dHSAwVYUUhJMFjmFSotSYqQBdQXDWv/wFBfEUi/2wsbMUqmCgdf7mAW/qPidGTRgwGHU
         mJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252052; x=1719856852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sya32zh6rlTi+rX0XJSzUKROEQWEvMEkDKstbuTkhuk=;
        b=ohdQCAUzcfld5OP2oujuSp0K3Zitcisbh7rmxAD+oeFDSTvKz4s/Pl4LwFeG2zJx51
         G0eiFMKdkNfXqAl22Ao1LbizV15ovfPOxnkVG/FJaxwn7yUonPVzZqNFqQgYeKZSAu6l
         HN+Gcm7FnYddouNc44kDAGyHp6CXTj8U32vTIwIwfASao5i4kF6xIKidOeYaYGxmgDfW
         bCRYALGZfa9NXo9JLKjI0a9005ql3ZEa1L/MvAnRZ92CJswTE/zgk2xW06OfmsXc88bq
         7WvJ1K170AD4Cp29fdDIoo+t7BTki1riaJNVK0Ejk1if2mgR5v+Rncu+XeXOxQJrI74U
         pPWg==
X-Forwarded-Encrypted: i=1; AJvYcCVx96Q7IbiEfz+Fa9kTVlE1PVoyZGk5Z1CN1SAxVXL0YeR4nZTs3b3Ib3GGGsllYbQbB7CGdxrfGWn0gQ4r8Fj9ScOAyX0kUE7JU6xl4X6alcxKHojIRKtlUdRj6Wxamy3JBQ==
X-Gm-Message-State: AOJu0YxTBMBSzqiDf7Hh1rmmXq7DUveFbvhu6w6aVAap7HL5TXnTOic+
	SRu2SUYkvE4bVOHCqrio+jjlJklH3WrJV7U17rK8T82H69VulOOq
X-Google-Smtp-Source: AGHT+IE+K1phdY5GT30UHXgU3WZqrmc5gCxbnU2koonmdTNPFJlh5LHz8q1SXDPLzxEatxjM4VVX2g==
X-Received: by 2002:aa7:908f:0:b0:705:bc32:5357 with SMTP id d2e1a72fcca58-7067459c765mr5040693b3a.1.1719252052132;
        Mon, 24 Jun 2024 11:00:52 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-717e1cdf921sm5241071a12.43.2024.06.24.11.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:00:51 -0700 (PDT)
Message-ID: <880a70f0-89d6-4094-8a71-a9c331bab1ee@gmail.com>
Date: Tue, 25 Jun 2024 03:00:47 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/netiucv: handle memory allocation failure in
 conn_action_start()
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, MichelleJin <shjy180909@gmail.com>
References: <20240623131154.36458-2-yskelg@gmail.com>
 <bb03a384-b2c4-438f-b36b-a4af33a95b60@web.de>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <bb03a384-b2c4-438f-b36b-a4af33a95b60@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Markus,

On 6/23/24 11:27 오후, Markus Elfring wrote:
>> This patch handle potential null pointer dereference in
>> iucv_path_connect(), When iucv_path_alloc() fails to allocate memory
>> for 'rc'.
> 
> 1. Can a wording approach (like the following) be a better change description?
> 
>    A null pointer is stored in the data structure member “path” after a call
>    of the function “iucv_path_alloc” failed. This pointer was passed to
>    a subsequent call of the function “iucv_path_connect” where an undesirable
>    dereference will be performed then.
>    Thus add a corresponding return value check.

Thank you very much for your detailed code review. I will thoughtfully
incorporate your advices into the next patch.

> 2. May the proposed error message be omitted
>    (because a memory allocation failure might have been reported
>    by an other function call already)?

I agree.

> 3. Is there a need to adjust the return type of the function “conn_action_start”?

I had the same thoughts while writing the code. Thank you!

> 4. Would you like to add any tags (like “Fixes”) accordingly?

Yes, I will refer to the mailing list and include the fix tag.

> 5. Under which circumstances will development interests grow for increasing
>    the application of scope-based resource management?
>    https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.h#L8

I am considering the environment in which the micro Virtual Machine
operates and testing the s390 architecture with QEMU on my Mac M2 PC.
I have been reviewing the code under the assumption of using a lot of
memory and having many micro Virtual Machines loaded simultaneously.

> Regards,
> Markus

I really appreciate code review Markus!


Best regards,

Yunseong Kim
