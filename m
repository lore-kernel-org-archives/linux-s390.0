Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528132F28E3
	for <linux-s390@vger.kernel.org>; Tue,  9 Sep 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420140; cv=none; b=HWil727mMfpgSenzG4z6UjZYdEt5AFdCqfn5lxlLGXU4QUEzFp5olqDjeVokXLuv/OELYlWZ4e+LMzTaoLJk5dqmnrHkYaYlknj/knbeLvy/MRIV7V/QfoMcxRAE6WVy0y1OS3OkYH1AcP3GIzGDbbYN5Pszq4VpRCdtYJrNhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420140; c=relaxed/simple;
	bh=1rXNNakol41mMJcUPR6ynFpy26gIZ8Jta97suT+WGU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tC/rUiJf9VwUFZeTBA4+9oaN+3u9+1ATj3E0kT5akbRyWfv/svaH/FUV3/xcR/IJD/ELOONU0isdyoc8/HrrZwuEZH5IM3gXfo3DzBnLOY+ucY8iLnm+NL+fbg10S3cnwLPi18Tw/Bn+AsjfbdsKs3fHdMX3hX2i61S0B9WLWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/dih80m; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/dih80m"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04679375f6so980478466b.2
        for <linux-s390@vger.kernel.org>; Tue, 09 Sep 2025 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757420138; x=1758024938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8KO5DR7GI5OZLHDasz7lx/tKdixrpxSApe9F1dlD0os=;
        b=M/dih80mdFdNmws2q22KgiM6x7bUIT8N7cufRdqaPv57kYOPUmWGhXjZV3XjZH7+qA
         WXuMpFx29Q1/lGnk0MXu6HfGvRXXckuxZXcZhTU4qJCfxSlGHaGm55CwXql2ZWc24jg5
         yyWxTQyvVi/95Axe25rHsJU0WqpHvZ3Gv0xST54NV5XZur4tHQZGZJygTzJ/J2aviIhU
         sWgkqggUw94ibbf+slMmkTuoZjknfj8poA4T/Bw4C2uR9qec2KZWSe/vWXFXd50PGpc3
         U+j2NnTDxNhCdTXc6dvFDa6ws4Bz+Y7K5DQ9rQcv9JJk06NSBNMhGAOKAz3btixciXXW
         kEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757420138; x=1758024938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KO5DR7GI5OZLHDasz7lx/tKdixrpxSApe9F1dlD0os=;
        b=u8pjuRGiPmJ2n6hIZ859vqxjzg6d03KQxxRbTfXUL7dG3TgPjkA2E6BkyzDkjik1KS
         wE/eyvP5T48/V3SB6IyEQ/nzmPJEcOTE3hBkcJemx3n/u+03JGNycwTiBGkR6MnQimkh
         tVX0aZhpfNlFLQpORZprIN6YMzlsPvumWmFPZGGQ1psxZZahiKS+BrkUOITpE1sIyeF4
         2DbjysgT9WZkkpHRYhlg/dhml66W0rpZHJSxgmnptmbYbiMEbHW01oUhftbq5ultqJ+Q
         UHvX11z330si1dx7LnspRVm8HzbFDpZHhulYy3GScBuGXGRslqDY3+VxIadmxd5rTvCd
         hHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8zLvM9hndNI/ov8/DkdRdv5OJ26cd70YGEc8IFjvtroDgqcWnAJ2xMNRrt5Jb1qTKXlO6wtlUeYxz@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1WlJ04jVzDxyCKXZO6fzaEtDz06kFHk/V8Kx+8NgTE1Jka9P
	hnQpdN7PbAl8mJ32z/LgSSYqSCmg5QMcVJWheLEVPJ3A7FZsfGBZKvvY
X-Gm-Gg: ASbGncuEvoxgfg0s2mXZLQVN0MJX0q/eaO72vQyZGa5NBLQaubxAlvXJjJw1zZRqyIB
	7dgKPn+xTWHpXoy3rS7CZcLgOFtlxaMZorboXYOUAkqfFP5hBiL3W/d9y6O04d05oLFpK8+WHgO
	fJHa75ceoCP5qiUcXyL1qGgBfHAUXsktolq3X9/q2gHGrZLyfsFYVVhE0s+RnS8JKpzJdxW1Dw4
	yMHKOQOgpc1tOhgy97x4gwZcuTB55DNBsU+Aw0nc0IRTsAvFTJV8UyAsq6O3l8Z2i+OUFEt+yKS
	DruLj0XNnXgA1fEksy/dTvZlpDcwqy1uOXM+r842UgySbjFDRVsQqyl2nhv0KPpIFZ8fTYKW+Yh
	erNvQoHF+vaHLP/5yFxruRSuw5obk
X-Google-Smtp-Source: AGHT+IHq0dc7B6Xn8wLE/eSfg8Bg+hX5Iwr2y0yS2I1igzoMmZR/M8HFu/7yzgHQxRVZn0vr9hSWKA==
X-Received: by 2002:a17:907:9612:b0:b04:70f8:d454 with SMTP id a640c23a62f3a-b04b167e38fmr1045807166b.51.1757420137428;
        Tue, 09 Sep 2025 05:15:37 -0700 (PDT)
Received: from [192.168.1.236] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0425ce98f1sm2145216366b.67.2025.09.09.05.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:15:37 -0700 (PDT)
Message-ID: <bd535ddb-b9b0-4404-81ba-4e6f526429d5@gmail.com>
Date: Tue, 9 Sep 2025 14:15:36 +0200
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
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <b01c92bd-e00a-4c8f-803b-20d6a7db2ec3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 1:50 PM, Ingo Franzki wrote:
> On 09.09.2025 13:47, Milan Broz wrote:
>> On 9/9/25 1:18 PM, Ingo Franzki wrote:
>>>> Please, revert my patches and run the same test on a clean 6.17.0-rc5 just
>>>> to verify that the patches do not introduce the bug.
>>>
>>> With your patches reverted the combined mode fails the same way as with your patches.
>>> So they did not introduce the bug.
>>
>> Please report it as cryptsetup issue with a reproducer so we can later check it.
> 
> I don't think its a cryptsetup bug, its rather that dm-crypt is missing something to deal with async HMAC ciphers.
> The point is that PHMAC is a async-only cipher, with no sync variant.

I know, but there is no tracker for dm-crypt and what I like to have some kind of upstream CI testing for PHMAC/PAES
even without mainframe hw (we already talked about a fake cipher module).

It is not an real issue as PHMAC is neither in released kernel nor in cryptsetup yet, but we should have a test
coverage once it is merged.

On the other side, the async thing is a real pain, is there any plan to switch to something better in future
(for dm-crypt and dm-integrity)?

Thanks,
Milan

