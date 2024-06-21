Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5FDDC4
	for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989168; cv=none; b=iAfp3CJQOZ3HfDdJQP2V5t/qeAnLg+X7AoKy63uYECyOeNFZeZkIk9ZXBHP5OdSPYZ8KEoNkDiUQDt0m1qkEhvmPy6No1x48Cpmgb8Jp/NCk9t8jEf+pVYs92bMLWtDYo+Ms57ePkcyFKz3ME/G+8zO8UAoV5RGHdMFXapsI8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989168; c=relaxed/simple;
	bh=1oDR7k2gFW09En6OAZZAYDxx0OjcZbjUa9RBKFgsr7I=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:References:Subject:
	 In-Reply-To:Content-Type; b=Id83p84wyD2FDwlbzFPwu3DxKypM/m1kRWVYsaUAOqp3WuZOSitcCWe5vxkKfDyMKRl5u8ZaiRqeQO+zktUAFyy6/1/di7jH+hhdHvZkAx816ecdxeXJh9zwsTknO1KZ8a4DBM/HbAPu1/U3+44BULKYJkhGB4zniv2fH5/+D+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOKmrgRE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOKmrgRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718989165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JhyZB49NT62g9nY7mTsG6YKeRp/i2azht6jhc/Szlw=;
	b=jOKmrgREhzhe+zMH4Ihj4fTmW5clU5ysN0GZgI8mZe6WWpmzE42OfAiQ+gC2o0AZRzVUSE
	sje36EDoKQKpiINfQSuDmsbaje8qQx+2k09beE1xFqqKn4Bpi/JOUIEovEmtxJfqu+WzKR
	s4ARCbUcKwIhI919u5FFlee+UzTgpVo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-45yXuiDaN3Gg-cSYTS6rlA-1; Fri, 21 Jun 2024 12:59:23 -0400
X-MC-Unique: 45yXuiDaN3Gg-cSYTS6rlA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-63bca8ce79eso40436977b3.1
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 09:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718989163; x=1719593963;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JhyZB49NT62g9nY7mTsG6YKeRp/i2azht6jhc/Szlw=;
        b=wove3qk399oLjyqV2HkN3XdxDjaazNWBzUkgqkz5PC16l68qQU/H6S9i6kqrU0DVFU
         MUpfYpYlTZlv7EuY6fJAB3oqBwA0ahXD/UaA3N7Vmj4k1wrb9nMMMtTSaCYUJueTlmlN
         2vtPQtu/K1eB1V9rg+oOWaKAD7B2MfnOMvg4qWXQCorfN8AtImWVrt+knFWNW15fQJhm
         OvSOnm0Ubk+09lZmxleS7HJFjzpblwAxOvaIZ9e7b6K2aqFPZZWMunnkLb06mowOARTa
         yu4SUYOkWMCVDWrRHthMZH04yd/YEEs82C3PYTi4qWxvIg+INUDIW4AUfz2+YHAQV2cZ
         JATg==
X-Gm-Message-State: AOJu0Yw5aWxHjUOcbttgrQMPOpGeT2HTgHbV66VcGJq9TeWBb6jkCD0o
	F/mAlcwkdZqS3DGQoiVmDLnS/RfVNZ0Vduqgx8UV8s/poo0pFUZ23NJq5Rr77cCp8g6DC/oZqja
	XMBOO7eLo+4QLRRYHaubB3b//0Xf5fRZ8qByJw1WavePUeVS99WOk5dvNfcI=
X-Received: by 2002:a05:690c:fcf:b0:63b:e711:934c with SMTP id 00721157ae682-63be71194ddmr81046407b3.28.1718989163432;
        Fri, 21 Jun 2024 09:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA5wGIEPANZeBuBOaJWE6czSuTCvbWtFb0jnVxghM/uBsSXPMCO5blmXU3E4AAhacTogqKNQ==
X-Received: by 2002:a05:690c:fcf:b0:63b:e711:934c with SMTP id 00721157ae682-63be71194ddmr81046127b3.28.1718989163059;
        Fri, 21 Jun 2024 09:59:23 -0700 (PDT)
Received: from [192.168.1.24] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef5ef88sm10292786d6.122.2024.06.21.09.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 09:59:22 -0700 (PDT)
Message-ID: <157b32d5-7e68-a77f-6f72-356433e4a942@redhat.com>
Date: Fri, 21 Jun 2024 12:59:21 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
 gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
 <ZnHv/HmiYHoQRkUU@redhat.com>
 <ZnMO4DOBZ2qz4Twg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <4610b08d-46a4-b6fc-2ec5-a88abba7022c@redhat.com>
Subject: Re: [PATCH v2 0/4] s390: compile relocatable kernel with/without fPIE
In-Reply-To: <4610b08d-46a4-b6fc-2ec5-a88abba7022c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 14:23, Joe Lawrence wrote:
> On 6/19/24 13:01, Sumanth Korikkar wrote:
>> Other Note:
>> The latest kernel is built with -fPIC and linked with -no-pie (reference
>> commit: ca888b17da9b ("s390: Compile kernel with -fPIC and link with
>> -no-pie")) which also avoids generation of dynamic symbols and helps
>> kpatch usecases (when num of sections >=64k sections).  Also the build
>> options would be similar (-fPIC in kernel and -fPIC in kpatch-build)
>>
>> For latest kernel, there is no need to add explicit -fPIC again
>> in kpatch tool.
>>
>> But for the intermediate commits, yes, makes sense to add
>> it in kpatch-build tools and will create one PR.
>>
> 
> Interesting!  With 00cda11d3b2e ("s390: Compile kernel with -fPIC and
> link with -no-pie") it sounds like the original vmlinux would be built
> with -fPIC as well, so the optimization decisions re: __mmput() would
> likely be the same.  I can retry the tests with v6.10-rcX to verify.
> 

To follow up, all of the kpatch-build integration tests work with
v6.10.0-rc4 :) as the kernel is built with -fPIC and so are the kpatch
reference and patched builds.  For pre-v6.10 kernels, I think there may
be some instances where a patch author may need to account for slight
build differences to appease kpatch-build expectations as I noticed here.

-- 
Joe

