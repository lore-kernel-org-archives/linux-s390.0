Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449C140E5F
	for <linux-s390@vger.kernel.org>; Fri,  8 May 2026 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243740; cv=none; b=n5Ef1/GFUAvwh2pg/+1uAigDEIUfI9tCgDvS6P/Bq8/JmNS7WXPnWf/cX/D0WDDIuv7/jlH0+2lGWENK+OmGruhGEDRbVPNPNJs9g/OkhoOy2KCQMBnd7u60V+7TaNISS0rqOvEKxN7MOQ9DE71BBmHhJoV8A9Y64ndbH6239VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243740; c=relaxed/simple;
	bh=3Zu2cnydmPT5amHK0mlDyIk6+Q04rwpN1ccSaHEZyB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOFhKCPYPxiQXPUe9ifPOwEVuOihv8dE41LApAvpxgakdrUHfdWMoFRYG9034SeNlxCSnG0HNj2KOVeJ0gxYojUn7HWYcN0Lflqbr/Y3UkJLzBQBPQWIDOi9mFyPjFA7tL34HUW5JXfzEGIJemE2G30eyAvSx0f4/4Mi12aDak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnfrPh9y; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnfrPh9y"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso1612186f8f.0
        for <linux-s390@vger.kernel.org>; Fri, 08 May 2026 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778243737; x=1778848537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zu2cnydmPT5amHK0mlDyIk6+Q04rwpN1ccSaHEZyB0=;
        b=TnfrPh9yZubgk1mnXllvHhfkdJLmAsJQeGu2ne9xitVgo8JlonXngG/yoyN/yGfwgj
         9RVVI0adGpz5r3a4DVsrNwAozWlimMo/xZFirZIUIwaTmqLTXSMKgXgg0X041Y4c+VIt
         Fh4bADrYsfYVg9mFHit1neDjMd+AQgP+fDqD9itPZ/9UXRMuLwfVX36Z031PjGYrBGX2
         dfqO8nxyc8DBNFunBT1s7ptRqDImrfnx9Bo24wd9gOfa1DscrXuoqbJdj4IzKp92Q40K
         w2PwZrzokqHhjAI3MKpwYar8b/5W2X99uJllyWLcWl8ccSnA/oP70iZRNZZjNyTbvlJ6
         M/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243737; x=1778848537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zu2cnydmPT5amHK0mlDyIk6+Q04rwpN1ccSaHEZyB0=;
        b=Oaz7oT3srNLjgFUpR1JdZWbidNzyTSR+T1OrvYOj3kda/+EhmkBAPl9n6IV7Ms1sk/
         JU76Ks01+ao0UYucXOCrm4ESTjWjjR8aprmAAAO4kM3o21db1S/m8ljUM0VOt0vsCUUL
         xiQBjubNAMjBSftDYndf/xFHKNWtMqKyJ4md9CJMAzB/SL0I48ZLulfpefm27mdlp0jW
         KjwFEsbNJ4DmKHUJQlHykcC9B8o37Y3djfQbz7fcX1eyq0EGnu8l4EcTJpH+UCyux1+i
         3dWzNu28EJbwtT1WjzApfSMC7YqPa1OX6Jljxx6ds/TVlTCYuUjL0/P+qQ4ESYAD4Fqc
         A2wQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bXG3TrrrSvpOMvd5joedlKqxjIzfb82kZaDSRR6uLXsgcij51A2LddT3qJmVxY0EueSl1ajQ7/HFq@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSWU0plMUNfAmCF6qYBUEzzn5DHIlVMjTbzRMmmjw88yGbDm8
	CzeAdM04amGe/6Vam7G5kNANvh/6MYaMeI2b7KVx6MkM7L51aDwqxoJw
X-Gm-Gg: Acq92OHN6Pp44BvTjyVdf+Ztz25s8aPPS7fyVedvM7HfOEvHLQNSFmyT7Wt9cm2Iq5R
	/RAioXQNDkYWrESgM/evusVBB0sOGZvwBm+/wUK0dFIH7+owmtjehl92HtvojjSnc4JhjG0aI1b
	G9o2Ou4+LNSRSNXumedIPSbSDcTqxs7CCT4PfqLCS3X6mKwxrmbtHCt7ZGbitFrDd/4ucLW/ne5
	8KfyUoCx7PY89EnNmXvIIKneqSdrogyt7vAqwinLtVrSgx9MWuW/iGShVmsPp3G00/LXyDp0MP/
	BSm2LX2gZFQ/TbLzpFe2ufo/yBLX88H5cm96d61Pn0banrveenMoRZDeLpLekBgB+dzGUmBtKwT
	WYVAVdIhTSWtcBRw3wjTfjUhr948HOR7OH6qrEFoGjfguQ1k2qW0PDzd8BRcxt/8fk2AM8hxymK
	ikt0g8HiufqaGlE5qJhVo554qi8GRoJJbthsNY4s/QWuRAgfgrgvxG2YUc3t4=
X-Received: by 2002:a05:6000:2011:b0:43e:a69b:d814 with SMTP id ffacd0b85a97d-4515d008849mr20607094f8f.28.1778243736925;
        Fri, 08 May 2026 05:35:36 -0700 (PDT)
Received: from [10.128.10.158] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491cab9c2sm4454377f8f.31.2026.05.08.05.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 05:35:36 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <27bc3de0-7006-4ced-a53c-9fb0d3e760f9@gmail.com>
Date: Fri, 8 May 2026 13:35:34 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] s390: fix dead defaults for
 S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
 meted@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 akpm@linux-foundation.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260414215651.151228-1-julianbraha@gmail.com>
 <a3adc8e8-ce4c-458c-a0c8-c0e66078589d-agordeev@linux.ibm.com>
 <b3dba59d-22cc-4404-8876-8fd4e22021b5@gmail.com>
 <3ec20142-09d1-436f-a623-21a2440ef7f0-agordeev@linux.ibm.com>
 <cffeec5e-068c-4562-98ef-f65e346dff3c@gmail.com>
 <5bd572e5-78c6-4f6e-ba95-4e79a8ef8341-agordeev@linux.ibm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <5bd572e5-78c6-4f6e-ba95-4e79a8ef8341-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 12:22, Alexander Gordeev wrote:
> I could not recreate it. Could you please provide the exact steps?

Sure, here are the exact commands I ran to reproduce for
S390_UNWIND_SELFTEST. Note that I'm on x86-64 and cross-compiling for
s390:

1. Start from a minimal configuration:
'make ARCH=s390 CROSS_COMPILE=s390x-unknown-linux-gnu- allnoconfig'

2. Enter menuconfig:
'make ARCH=s390 CROSS_COMPILE=s390x-unknown-linux-gnu- menuconfig'

3. Set CONFIG_KUNIT=y

4. Set CONFIG_KUNIT_ALL_TESTS=y

5. Check '.config', and see that S390_UNWIND_SELFTEST is still disabled

The steps to reproduce for S390_MODULES_SANITY_TEST are the same, but
you also need to enable MODULES because of the additional dependency.

> I do appreciate your effort to bring a new tool! But unless it is part
> of
> the toolchain it shold not be referred to in a commit message as far as
> I am concerned. IOW, once it is in the tree, it is fine to mention it:

Thanks :)
Separately, I checked with Greg, and he says that:
1. it is a requirement to acknowledge tool usage, but
2. this patch (and others like it) shouldn't have the Fixes tag.

So I will resubmit this patch without "Fixes", but still acknowledging
the tool, see also:
https://lore.kernel.org/all/2026050728-construct-tingle-0852@gregkh/

- Julian Braha
