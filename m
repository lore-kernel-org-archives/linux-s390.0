Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE2209687
	for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093667; cv=none; b=bPpx1LWoyZipl3F+FhtGulyWxpaHmNqFroJtUhop507BWxr+rKg9CBK0KP3bfBLuWcgSw26c+fsItmBKvfCaz+iHGt7G/SfVknZtLH3aBa95qjOK7CzN/Ebp1Vaizx20MVAWj/5AK9cpQ2aBhhqOYtfld03mjMkxNGBfjbdvVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093667; c=relaxed/simple;
	bh=bWT0jZQi2gTGU5Bd8og0Hyl0LagtMrLPaQKxohyIPwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlMfaGWCFaQQLLt2Sst6tC4a4wl0iFG/3vWQo8CSNTXyRHq6J00R6OP/fqk7XTnrFpgraJthPVClMKcxNbMe0Piy4tu52EmFu8iDgfErOBUlQx6y9iowfOjiimES1T1GGDSZ4KHhma3IYoluYRmGKnaMzBbY6ufBbq+Au8S82z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHQ+wqha; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHQ+wqha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729093664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VIzfBQnPXM1p+cHUAfPvEKZFWEw7tRlCE5XfNpemY2E=;
	b=MHQ+wqharG9EKXvpNnBfdKH5Fn4ou5M1g+3t8bG/t77TsKlAGzYfsrBdWrFwLFQI8o+iA4
	solD9CSiFyzNaq8htBIwIGTLIsfOIt2R9n3uOveWB87JAl3vMcGm/tBZVQLOTC3LQ0wP8S
	tffFQJBCccqF15I+GEnLcUoZ2CS+VUY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Z22e8XD6MUqmIIUezzFZiw-1; Wed, 16 Oct 2024 11:47:43 -0400
X-MC-Unique: Z22e8XD6MUqmIIUezzFZiw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43157e3521dso752475e9.1
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2024 08:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093662; x=1729698462;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VIzfBQnPXM1p+cHUAfPvEKZFWEw7tRlCE5XfNpemY2E=;
        b=Ok/Do6fDnFfne0vq7lidJK8D0pJEyLVigYCPN1vm/e8ORXgbehnNCwjzBr0MxfSocH
         rjxBJdXZCyIblj7Akdgd73yVr+hKGmsonZh3B7XdiUYzMF7jx1iLKSdNWBAtfDpL3KZ9
         h9m8MoLtK0VSDFaE1/345npFOK8Mw2INatIpxn8STrpaiq7OPEXsmY7CSK1xY26kl7Ld
         /MiOCLzHPNFZzhnCBGWufKBmyB4d1rbOJLrWPjosHCFdBaERhBkv1CkOn/oQHdVUY25Z
         N8t/IMq6iKxrL+N4EhP4S6fwDms4Omf+cSjRolOYJGwG1P6ngKed6tqxt2a6l5mtF7kp
         8SPA==
X-Forwarded-Encrypted: i=1; AJvYcCUvMtfZyqToBW2VCsyGzA3qVtNi1FG7oj1BAnBfg+qC+YEbbc/zRy3lGofnEaBcNXWYRIjzqOsfpRsm@vger.kernel.org
X-Gm-Message-State: AOJu0YwzeVqbBDTU7jRAYNvbluquS/ArpYv4GBxJ+Q4eXy7xPXillZeO
	OUse9JFJYCFOKplvsf+QadS7hodtRyYiLV09Yu++j6vx/ar6k/sDYf7bMcwOKOh3eE8rlVz1HYh
	7KMm3m62/FmL8TsqC0Q1+NhiL4DMQKqvW7FLMgbIj+r1Xh7srf8eJ3tePE8U=
X-Received: by 2002:a05:600c:4711:b0:430:54a4:5b02 with SMTP id 5b1f17b1804b1-43125619e8fmr121331175e9.34.1729093662300;
        Wed, 16 Oct 2024 08:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/bW0hLobbLXjaDGKyq9Ar43ysgaBvBnKudmwOIGvXULooHv87b61qCzy2T1b+NaF7gXinDw==
X-Received: by 2002:a05:600c:4711:b0:430:54a4:5b02 with SMTP id 5b1f17b1804b1-43125619e8fmr121330835e9.34.1729093661825;
        Wed, 16 Oct 2024 08:47:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4315069032asm25144845e9.0.2024.10.16.08.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 08:47:41 -0700 (PDT)
Message-ID: <76f4ed45-5a40-4ac4-af24-a40effe7725c@redhat.com>
Date: Wed, 16 Oct 2024 17:47:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] s390/kdump: implement is_kdump_kernel()
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: agordeev@linux.ibm.com, akpm@linux-foundation.org,
 borntraeger@linux.ibm.com, cohuck@redhat.com, corbet@lwn.net,
 eperezma@redhat.com, frankja@linux.ibm.com, gor@linux.ibm.com,
 hca@linux.ibm.com, imbrenda@linux.ibm.com, jasowang@redhat.com,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, mcasquer@redhat.com, mst@redhat.com,
 svens@linux.ibm.com, thuth@redhat.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, zaslonko@linux.ibm.com
References: <87ed4g5fwk.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87ed4g5fwk.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> When I wrote that code I was rather convinced that the variant in this patch
>> is the right thing to do.
> 
> A short explanation about what a stand-alone kdump is.
> 
> * First, it's not really a _regular_ kdump activated with kexec-tools and
>    executed by Linux itself but a regular stand-alone dump (SCSI) from the
>    FW's perspective (one has to use HMC or dumpconf to execute it and not
>    with kexec-tools like for the _regular_ kdump).

Ah, that makes sense.

> * One has to reserve crashkernel memory region in the old crashed kernel
>    even if it remains unused until the dump starts.
> * zipl uses regular kdump kernel and initramfs to create stand-alone
>    dumper images and to write them to a dump disk which is used for
>    IPLIng the stand-alone dumper.
> * The zipl bootloader takes care of transferring the old kernel memory
>    saved in HSA by the FW to the crashkernel memory region reserved by the old
>    crashed kernel before it enters the dumper. The HSA memory is released
>    by the zipl bootloader _before_ the dumper image is entered,
>    therefore, we cannot use HSA to read old kernel memory, and instead
>    use memory from crashkernel region, just like the regular kdump.
> * is_ipl_type_dump() will be true for a stand-alone kdump because we IPL
>    the dumper like a regular stand-alone dump (e.g. zfcpdump).
> * Summarized, zipl bootloader prepares an environment which is expected by
>    the regular kdump for a stand-alone kdump dumper before it is entered.

Thanks for the details!

> 
> In my opinion, the correct version of is_kdump_kernel() would be
> 
> bool is_kdump_kernel(void)
> {
>          return oldmem_data.start;
> }
> 
> because Linux kernel doesn't differentiate between both the regular
> and the stand-alone kdump where it matters while performing dumper
> operations (e.g. reading saved old kernel memory from crashkernel memory region).
> 

Right, but if we consider "/proc/vmcore is available", a better version 
would IMHO be:

bool is_kdump_kernel(void)
{
           return dump_available();
}

Because that is mostly (not completely) how is_kdump_kernel() would have 
worked right now *after* we had the elfcorehdr_alloc() during the 
fs_init call.


> Furthermore, if i'm not mistaken then the purpose of is_kdump_kernel()
> is to tell us whether Linux kernel runs in a kdump like environment and not
> whether the current mode is identical to the proper and true kdump,
> right ? And if stand-alone kdump swims like a duck, quacks like one, then it
> is one, regardless how it was started, by kexecing or IPLing
> from a disk.

Same thinking here.

> 
> The stand-alone kdump has a very special use case which most users will
> never encounter. And usually, one just takes zfcpdump instead which is
> more robust and much smaller considering how big kdump initrd can get.
> stand-alone kdump dumper images cannot exceed HSA memory limit on a Z machine.

Makes sense, so it boils down to either

bool is_kdump_kernel(void)
{
          return oldmem_data.start;
}

Which means is_kdump_kernel() can be "false" even though /proc/vmcore is 
available or

bool is_kdump_kernel(void)
{
          return dump_available();
}

Which means is_kdump_kernel() can never be "false" if /proc/vmcore is 
available. There is the chance of is_kdump_kernel() being "true" if 
"elfcorehdr_alloc()" fails with -ENODEV.


You're call :) Thanks!

-- 
Cheers,

David / dhildenb

