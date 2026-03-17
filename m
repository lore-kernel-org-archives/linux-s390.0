Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A1224B12
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773719401; cv=none; b=rSxT4MABUJHM6R3DANPhlL/Clindj9nkSHS0Ik/imQ2ZqJW8QeASWUgos4l9Fm+44Y5BEEVoAc/pgmshaFOqXLRzycQoX/n65WYUgrJjE0C9r+rnLXDPMs6lvaCGOa9nZYIi4gyQZ6qezNkhz+fThXOPJqV1q25SAQsqT0PgJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773719401; c=relaxed/simple;
	bh=bsTHXrdDrCMdw0tDUkatLv8c9nfNpZ/HZf+pMYc7bbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huZ4JxqqThvtcSWdIvY2Gzsf41/CK7RVsXI8llSmH2kDcJjHHUpajBk2oe9drOdT7jlC1UlKOtw7PdQrGmE6A6uC/3cPKweSXw/x8EyJamQFMsLNfVhEPSQVOomk0aiyKBnvFL+i9HJDpPY19OmeMEvOm5YZa+xxNhnxu26l6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CR6uip6z; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CR6uip6z"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4043b27ddeaso3332624fac.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 20:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1773719394; x=1774324194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VINWEtY9aZvz9HaKBZW/WHE45MWpLM833fNP+ydNw4=;
        b=CR6uip6zPXHF8EG78+FENHdmCSIYYRRTnWvPFsXXQD80pAUJCarDaOsrCww/vZ5k98
         9iXN0ZryCz1c5oAgmL4QPw+hKcLwA6fEDswxlhA95s9EOaY6dVsn+FdiqKzdWkCJibit
         nJLuBmcZ0alISlNwx2tFk8bmLe/k2rHRGdWHnzzTvM9E0d1YRE6+NOfexe3ubdkdhSCN
         PxwuTQsaf/nTPJ1W8rilCyWB/f90YeoFZ97NkCpbpXjq90jbXJNjaOOI3BjtUS2QZ3ig
         Bacm0steYrSJxggXILEH0CJMhGAqny3NZDcWOxyfvi5sYdqCKP+4PSwxmOKotsLY9Lmf
         neuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773719394; x=1774324194;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VINWEtY9aZvz9HaKBZW/WHE45MWpLM833fNP+ydNw4=;
        b=pW9gpfSdfS0Isbo1ALPQ1U+XJBwh8uFmI+XYDZgHveLlXw/b90L9BU3klUFcpaSdnX
         yp7wS15Ow785uTXDaTTKwENherCueCuPFEvPgvKfloT4AhLqyuhwWhzY8EiaSdgiq1w/
         Xyr4s1/IPEuCENc7pARSnUgz4SkOOfZCy3VV6STBNUEOzU8Q1Mx+IjgFUn1yd3Q7V4zJ
         Yka5/TU0fpLl2mR8H2benhMl+wZzGjAc+sgszYl960VI3TSu82ufM0EGvbe6IBMYmnkI
         CwGkaGzECWFrB63YmHYuWI5KHayhjcp3FWMEqeWLqHzV8hbE8IupjSad/tjPcQbrJXMj
         3mLg==
X-Forwarded-Encrypted: i=1; AJvYcCXK/ySg22bg6lnZ7Fj7VQ7Q+b2vZxn9kZU/VoC1hh22Ku5W2J3LDxGw9CfqvMDuwxaZTpOR529+DXmC@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKPue0Q3jOS/stv/Baooqi68IaQxC3293sslsknHDHs1HJwpM
	6JMN84VQYNmS+XQ5AQRjzhQmvwP2V2lsKa9BUcpJiNEvSr+KKNLGKaUOCbJ90UzuatE=
X-Gm-Gg: ATEYQzwjADWqKgdb4iM3pYvkKTUPp86L+BLYQ25AI7tjwtaLMKuqIYbcfwYVRnBf3GM
	FZZd7LaZp21FSn7rCMi2ve2JwR9qJ5ZfkQZ8HzDPfemfjEXQs2Bzmm7jZsx7Ul599K70L14NwFU
	x+J2WzWUNwwLCwgbJ5n8/58/chhdUUIMO5GblNbba96XeJDYLtXZdYOwb0i0rwtZ4APJgwhxdGE
	WxLwwmDqDlMaEKfZavugLdKW7Zqg1rFve0VmsFH2dxVvvljY8mAsECatlUMnTs3ST2/etrLYymk
	Rfk57CS3Y0Igeq5iviI/z7ur7H9YSMbxgRigVoMaybN2LZw4TfhquLfUm6Gh/baTM/z+vSD1lVy
	aNsZ8OgY1jGQNh61KX9LbmJ8fJC5f4Sz8NMJnR8jkIXy+PYd+7yjXaNUOJl9D0udAOeaDOvWoqu
	WiAgIL0nG00QOG9hLTDUpk7+ZX
X-Received: by 2002:a05:6870:d406:b0:409:74c7:1cbb with SMTP id 586e51a60fabf-417b906d206mr9213737fac.7.1773719394528;
        Mon, 16 Mar 2026 20:49:54 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.103.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm19148337fac.16.2026.03.16.20.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 20:49:54 -0700 (PDT)
Message-ID: <da8c8b57-6d5e-461a-83b3-9339a712aca4@sifive.com>
Date: Mon, 16 Mar 2026 22:49:52 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] mm/kasan: add document into
 kernel-parameters.txt
To: Baoquan He <bhe@redhat.com>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, andreyknvl@gmail.com,
 ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
 linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-15-bhe@redhat.com>
 <f7054184-dca2-4c7c-9e2e-4a5e3e1c81da@sifive.com> <abjMP58VdUu_eElh@fedora>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <abjMP58VdUu_eElh@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-03-16 10:36 PM, Baoquan He wrote:
> On 03/12/26 at 07:53am, Samuel Holland wrote:
>> Hi Baoquan,
>>
>> On 2026-02-25 2:14 AM, Baoquan He wrote:
>>> And also remove the relevant description in dev-tools/kasan.rst
>>> which is hw_tags specificially.
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>>>  Documentation/dev-tools/kasan.rst               | 2 --
>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index cb850e5290c2..e0115fad9e60 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2899,6 +2899,10 @@ Kernel parameters
>>>  	js=		[HW,JOY] Analog joystick
>>>  			See Documentation/input/joydev/joystick.rst.
>>>  
>>> +	kasan=		[KNL] controls whether KASAN is enabled.
>>> +			Format: off | on
>>> +			default: on
>>> +
>>>  	kasan_multi_shot
>>>  			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
>>>  			report on every invalid memory access. Without this
>>> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
>>> index a034700da7c4..eaae83fcb5e4 100644
>>> --- a/Documentation/dev-tools/kasan.rst
>>> +++ b/Documentation/dev-tools/kasan.rst
>>> @@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
>>>  mitigation. Therefore, it supports additional boot parameters that allow
>>>  disabling KASAN altogether or controlling its features:
>>
>> The sentence above is now incorrect as well. I would recommend documenting the
>> parameter earlier in the "Boot parameters" section instead of removing it from
>> this document entirely.
> 
> Good catch and the suggestion is good to me. Thanks.
> 
> Is below change OK to you?
> 
> 
> From 317be48b9c1bf9d33b8d8fff5e401e3155531d81 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Tue, 17 Mar 2026 11:28:39 +0800
> Subject: [PATCH] mm/kasan: adjust documentation

I'd suggest something a bit more specific, maybe like "mm/kasan: document kasan=
for all modes".

> Content-type: text/plain
> 
> To reflect the change of kasan=on|off.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/dev-tools/kasan.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a034700da7c4..8e65bc04dbcd 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -103,6 +103,9 @@ Boot parameters
>  KASAN is affected by the generic ``panic_on_warn`` command line parameter.
>  When it is enabled, KASAN panics the kernel after printing a bug report.
>  
> +The generic ``kasan=off`` or ``=on`` command line parameter controls
> +whether KASAN is enabled (default: ``on``).
> +

This is in the middle of paragraphs describing the fault reporting options. I'd
suggest to move it to the beginning of the section.

With those fixes, you can add

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

>  By default, KASAN prints a bug report only for the first invalid memory access.
>  With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
>  effectively disables ``panic_on_warn`` for KASAN reports.
> @@ -127,9 +130,7 @@ modes below) support altering stack trace collection behavior:
>  
>  Hardware Tag-Based KASAN mode is intended for use in production as a security
>  mitigation. Therefore, it supports additional boot parameters that allow
> -disabling KASAN altogether or controlling its features:
> -
> -- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
> +controlling its features:
>  
>  - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
>    is configured in synchronous, asynchronous or asymmetric mode of

