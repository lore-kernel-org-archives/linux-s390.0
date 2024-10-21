Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C41F9A90
	for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521973; cv=none; b=tvS4GnEZt9szr8NmuP1JQJDzSbbvE8f/vU78UDU1qD3gYCZuZxnWWIEpqgFTBt5x5YzcVMNeFo3XvHVeKZjCWOUvzZuxdk5Lj8FzFbds1gdTQyeKDx407A8brbom2n2fdY6/TzfPiXHpUY1vku4X74ErN0FHdmDj39ndTCrFUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521973; c=relaxed/simple;
	bh=DmQWkn1T9PFoG0NEwWjY8BdpxvZZCy1ZxEjLTxUCtIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErxSH+S/Vk1XIT9fczBKdvQORQmDdZ5PytL9W2WgXgtTICAXgwx0Lcr87CvRdBcOvnNC2YStrlOel0YujierkztM46H8CUc/BrJA6Z1V3zlnrThCeV0UWbKzLXbZieW3SuizwC8s/wvJEx6Le+TeBC477Of7y3rhI1d/kexVPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4Rr+2yy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4Rr+2yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729521969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pBpP7qLCW9N3cROeVqgUltAMhaWq+ArP+b0NXa5W34=;
	b=N4Rr+2yyYVp5QhwwsG5s90bxFZA8dj/CQWUEXe78q+0OlCVe1CkFUddnk9/9CXuLHSa61a
	XZuml/JcLjNJt7reTyq4lQJ2zzwYDH2INWvS74+fAxnua3XRTk+jcqpFvCnT1XWYL1YwyY
	wR/yG8KjuL6cjn1AxK8JHn093zqpNuU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-2c_du_nPNAy7sT020-xfwQ-1; Mon, 21 Oct 2024 10:46:06 -0400
X-MC-Unique: 2c_du_nPNAy7sT020-xfwQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315544642eso36525885e9.3
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2024 07:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521962; x=1730126762;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pBpP7qLCW9N3cROeVqgUltAMhaWq+ArP+b0NXa5W34=;
        b=M/2QkukwkMlYDpzouvzu/d1ZK9+r57eSCiqTteQNJF/dgp6nhaYTkKBLfRGh3knf7r
         I7gzBaRyKQs253RNmZG+RAkzvVqDjtKNDpo7LwdPv6u4fFl6UdZsuHd5sLgKZiJI/bOB
         48OwTMxY5bnAkbzS+tX10EUwTnwaDF+jKOnVzcuEimldJshCBuqA6/gQTE/a8X5tOBTO
         1BWt5KiO09vOnhzoGzsDSLTa1a6sN6Uax6PjUXszi8kJOVNzwRFj1jMcpIuqzXFOR4JC
         avw73qE8P/CIx/Bjq8veQLDZjhlmXunOGqMNHQU7KB5WncYTFcwyKCcrQhy+soQJRain
         W6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCW3I1sJPVDUQ/Vl/88Jp9plmtyPgg6LVapYCJ0TkmeQNHONsIFEo2qHIx8VmDnPkYsAAH4fZVHZnujz@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7TbvYSCA/XXXeGHQ+KUzpORefnADGzaF0/3X+RN2t7pmDRm6
	1A/nUB7i0EGPPiy8zawxWQms51tWVJ/y/mCunXyDSAfFKIZFV7a/gZYL0XewmMxQpIK0fd/Ifle
	A2vD418tb05zMWltkTc0vhmXfsGS09AMh3PCcqva57YlNA4hHqXk8HiQQCFQ=
X-Received: by 2002:a05:600c:4f15:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-4316168ffb3mr101784395e9.30.1729521961921;
        Mon, 21 Oct 2024 07:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnIcoVRRXbRUhxXReK6GpWNjdl0oiVGYJ9jq/7PmjHByyOKh4qiRtxhiYigJPvogBLyhVgLw==
X-Received: by 2002:a05:600c:4f15:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-4316168ffb3mr101784205e9.30.1729521961507;
        Mon, 21 Oct 2024 07:46:01 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fc77sm60419925e9.17.2024.10.21.07.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:46:01 -0700 (PDT)
Message-ID: <64db4a88-4f2d-4d1d-8f7c-37c797d15529@redhat.com>
Date: Mon, 21 Oct 2024 16:45:59 +0200
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
 <76f4ed45-5a40-4ac4-af24-a40effe7725c@redhat.com>
 <87sespfwtt.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <87sespfwtt.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 21.10.24 um 14:46 schrieb Alexander Egorenkov:
> Hi David,
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> Makes sense, so it boils down to either
>>
>> bool is_kdump_kernel(void)
>> {
>>            return oldmem_data.start;
>> }
>>
>> Which means is_kdump_kernel() can be "false" even though /proc/vmcore is
>> available or
>>
>> bool is_kdump_kernel(void)
>> {
>>            return dump_available();
>> }
>>
>> Which means is_kdump_kernel() can never be "false" if /proc/vmcore is
>> available. There is the chance of is_kdump_kernel() being "true" if
>> "elfcorehdr_alloc()" fails with -ENODEV.

Thanks for having another look!

> 
> Do you consider is_kdump_kernel() returning "true" in case of zfcpdump or
> nvme/eckd+ldipl dump (also called NGDump) okay ? Because
> dump_available() would return "true" in such cases too.
> If yes then please explain why, i might have missed a previous
> explanation from you.

I consider it okay because this is the current behavior after elfcorehdr_alloc() 
succeeded and set elfcorehdr_addr.

Not sure if it is the right think to do, though :)

Whatever we do, we should achieve on s390 that the result of is_kdump_kernel() 
is consistent throughout the booting stages, just like on all other architectures.

Right now it goes from false->true when /proc/vmcore gets initialized (and only 
if it gets initialized properly).

> 
> I'm afraid everyone will make wrong assumptions while reading the name
> of is_kdump_kernel() and assuming that it only applies to kdump or
> kdump-alike dumps (like stand-alone kdump), and, therefore, introduce
> bugs because the name of the function conveys the wrong idea to code
> readers. I consider dump_available() as a superset of is_kdump_kernel()
> and, therefore, to me they are not equivalent.
 > > I have the feeling you consider is_kdump_kernel() equivalent to
> "/proc/vmcore" being present and not really saying anything about
> whether kdump is active ?

Yes, but primarily because this is the existing handling.

Staring at the powerpc implementation:

/*
  * Return true only when kexec based kernel dump capturing method is used.
  * This ensures all restritions applied for kdump case are not automatically
  * applied for fadump case.
  */
bool is_kdump_kernel(void)
{
	return !is_fadump_active() && elfcorehdr_addr != ELFCORE_ADDR_MAX;
}
EXPORT_SYMBOL_GPL(is_kdump_kernel);


Which was added by

commit b098f1c32365304633077d73e4ae21c72d4241b3
Author: Hari Bathini <hbathini@linux.ibm.com>
Date:   Tue Sep 12 13:59:50 2023 +0530

     powerpc/fadump: make is_kdump_kernel() return false when fadump is active

     Currently, is_kdump_kernel() returns true in crash dump capture kernel
     for both kdump and fadump crash dump capturing methods, as both these
     methods set elfcorehdr_addr. Some restrictions enforced for crash dump
     capture kernel, based on is_kdump_kernel(), are specifically meant for
     kdump case and not desirable for fadump - eg. IO queues restriction in
     device drivers. So, define is_kdump_kernel() to return false when f/w
     assisted dump is active.


For my purpose (virtio-mem), it's sufficient to only support "kexec triggered 
kdump" either way, so I don't care.

So for me it's good enough to have

bool is_kdump_kernel(void)
{
	return oldmem_data.start;
}

And trying to document the situation in a comment like powerpc does :)

-- 
Cheers,

David / dhildenb

