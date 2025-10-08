Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101829AAF8
	for <linux-s390@vger.kernel.org>; Wed,  8 Oct 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910745; cv=none; b=m5bvkG+uzM5FIt9SntlN6bOguc2Hwpc6//NF/FNv8RH1HRl96UZdp7o9z85xwIwjaa2q1yFhRX9TtNv/A8FIs2waAFXCXN7PIQh8ADFeeV9Qn17zMfdZoL833+B3nZDBd/u3yerIoQQbaQM5EgHJdEkFdQevDq0RkpteDN4hTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910745; c=relaxed/simple;
	bh=yq/iDEiQ1RPX6RmohINmLnUzpZ9jfovo6KITeqhLMRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uddoQjXpB/FVY1rPTf2HXJphAAOc9opre+Us9dNDXeyu0Tbs45wgpiUWkGMk2Da16K1CU0ac3PpQKzUj+WHKYFaFpTehD1xuvTayy/mzslfSMW79D8NSQtqTyc1yD/1Wa6Sl1Z+GHPSRJcgX0eb14Peo8DduC6nplCNZm+tgT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErINyHjp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErINyHjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759910743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fckckqu8FhSLe+YJGblmZ5Veu3gXLrLCsl3rTsripxs=;
	b=ErINyHjpcPMn/buFcwqkkyl7/ECnVH/DPVQJb6X2mWY3ioFBpzcs7J6wS9FNyZY810vTOG
	bxu6lGSxvspMEOL+VbdUIDcDycRrZXJCdT6MichQdnDYrwL68b+AqtpWezRJzrJ8fnDaj8
	xj9Fq3A83jAaps2N2ODbeZuwnErPpwQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-j_-nZH3ZNLeRuUb4M90GoQ-1; Wed, 08 Oct 2025 04:05:41 -0400
X-MC-Unique: j_-nZH3ZNLeRuUb4M90GoQ-1
X-Mimecast-MFC-AGG-ID: j_-nZH3ZNLeRuUb4M90GoQ_1759910740
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so35648155e9.2
        for <linux-s390@vger.kernel.org>; Wed, 08 Oct 2025 01:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910740; x=1760515540;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fckckqu8FhSLe+YJGblmZ5Veu3gXLrLCsl3rTsripxs=;
        b=c7hJWCQK63A3iwAMGq63yX+/6b9jtrRayXZlsHMSTvD9cb53GIS0UHeWqiTzVcE5Pc
         Ex7sWKV+W4ynQ2idtSTbWOAlUqkZ5nzUnZ+hFHwIT44TluejV9hXL02kt4ZRb6nou3/m
         OCM1N706EnsQIzA/0deyYV/EW2ZLHPsByzJGtzBjQ8G214SJcqR6cO9l9LCBlXesKd+M
         wk0+hJHdcy5AvkOZ6/0YpGVBmxDOEaStFvF7o8z2INL3woKYaaIof6GLjsraKKw/7dMD
         sYuqgXDKXErWS/g8XG6wti8adZRAMXGK3atE9QM0B+qrJsqA9b/H+JO1PHuaQX3iJNlq
         TuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKixF/IZKxr82ebbB4SBHqRWYf3U6ljebvfenJjRChWxccdeN8z9LHNuVVE8Jy4Uj29Pyt0iqSc1Ix@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmkOgEgvP4r/RA9ZiwqO2b4U0+6W0TZIiDn1qX94CplMnBQxT
	6y3QeG7ndsZGcJ3zbGgqRUf92RZ0242/DzDdXy3jJJXs2T1sJDvphLzah/RJkAO3+XYDSxpKDo4
	ka+iYZGP+0JCsnCYU/8HSzUdqBSotmVKrIWSRuAOy5PjoKYBGDALrm62Hf0iAXoU=
X-Gm-Gg: ASbGncvxEqyV+FMt1tzjmD3464a5wMHzEhVbGguWvkCLiW00++I5l7kyIEZo59VfUMa
	SjfvJMZwEv1RuVXxWsqC4AHpG6tO+jnMCzP2Zc7gdN6aOrGlktvQHei6v1J1RlU9mnA34j4q3lg
	XFGWek3AaBCY070XqvwpW/Y0VnnNjbolC5qKPFo5KDz3RdpAwq5mE+H1egziUa30GPAeAP+01Eq
	Xc41BrciPu0ZGjDdsSi+pzk7awI4S3bRUpCcdXui1r3DNQajUP1eoetAXbP8Bxju2cLbBZuqnK5
	yW5A0bwbl7ZwmVBh4COS04hSkDFTlPU6zjXQIrO0kYO271O/+HazQ9LTR/JxdNI1hpqAbdpH/Qt
	gf2wU7Yi8
X-Received: by 2002:a05:600c:1395:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-46fa9a9efaamr17049985e9.9.1759910740321;
        Wed, 08 Oct 2025 01:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG01JXdA7zG4WT7hRXme96s2VqM9oTOcf5aTlv4lkpg5WkgJHOM8zu4tbyk7O6KwitLxTnxnw==
X-Received: by 2002:a05:600c:1395:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-46fa9a9efaamr17049655e9.9.1759910739866;
        Wed, 08 Oct 2025 01:05:39 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ac750sm29018283f8f.24.2025.10.08.01.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:05:39 -0700 (PDT)
Message-ID: <60066a80-4758-4034-bbd8-25d9c24861b9@redhat.com>
Date: Wed, 8 Oct 2025 10:05:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] s390/sclp: Add support for dynamic (de)configuration
 of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-s390
 <linux-s390@vger.kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <20250926131527.3260733-3-sumanthk@linux.ibm.com>
 <4e832570-32f8-46a5-80d0-40570db862b2@redhat.com>
 <aOYIwEGgrjpNMGKD@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOYIwEGgrjpNMGKD@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Is there any reson this notifier is still needed? I'd assume we can just allow
>> for offlining + re-onlining as we please now.
>>
>> In fact, I'd assume we can get rid of the notifier entirely now?
> 
> I was initially uncertain about contains_standby_increment() use case
> and didnt change it here.  However, after testing by removing the
> contains_standby_increment() checks, I observed that the common memory
> hotplug code already prevents offlining a memory block that contains
> holes. This ensures safety without relying on these checks.
> 
> c5e79ef561b0 ("mm/memory_hotplug.c: don't allow to online/offline memory blocks with holes")

Rings a bell :)

> 
> i.e. #cp define storage 3504M standby 2148M
> This leads to a configuration where memory block 27 contains both
> assigned and standby incr.
> 
> But, offlining it will not succeed:
> chmem -d 0x00000000d8000000-0x00000000dfffffff
> chmem: Memory Block 27 (0x00000000d8000000-0x00000000dfffffff) disable
> failed: Invalid argument
> 
> Hence, I will remove it. Thanks.

Cool!

> 
>>> -	case MEM_PREPARE_ONLINE:
>>> -		/*
>>> -		 * Access the altmap_start_pfn and altmap_nr_pages fields
>>> -		 * within the struct memory_notify specifically when dealing
>>> -		 * with only MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
>>> -		 *
>>> -		 * When altmap is in use, take the specified memory range
>>> -		 * online, which includes the altmap.
>>> -		 */
>>> -		if (arg->altmap_nr_pages) {
>>> -			start = PFN_PHYS(arg->altmap_start_pfn);
>>> -			size += PFN_PHYS(arg->altmap_nr_pages);
>>> -		}
>>> -		rc = sclp_mem_change_state(start, size, 1);
>>> -		if (rc || !arg->altmap_nr_pages)
>>> -			break;
>>> -		/*
>>> -		 * Set CMMA state to nodat here, since the struct page memory
>>> -		 * at the beginning of the memory block will not go through the
>>> -		 * buddy allocator later.
>>> -		 */
>>> -		__arch_set_page_nodat((void *)__va(start), arg->altmap_nr_pages);
>>> +	default:
>>>    		break;
>>> -	case MEM_FINISH_OFFLINE:
>>> +	}
>>> +	return rc ? NOTIFY_BAD : NOTIFY_OK;
>>> +}
>>> +
>>> +static ssize_t config_mblock_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>>> +{
>>> +	struct mblock *mblock = container_of(kobj, struct mblock, kobj);
>>> +
>>> +	return sysfs_emit(buf, "%u\n", READ_ONCE(mblock->config));
>>> +}
>>> +
>>> +static ssize_t config_mblock_store(struct kobject *kobj, struct kobj_attribute *attr,
>>> +				   const char *buf, size_t count)
>>> +{
>>> +	unsigned long long addr, block_size;
>>
>> "unsigned long" should be sufficient I'm sure :)
> 
> Left over. I will do so.
> 
>>> +	struct memory_block *mem;
>>> +	struct mblock *mblock;
>>> +	unsigned char id;
>>> +	bool value;
>>> +	int rc;
>>> +
>>> +	rc = kstrtobool(buf, &value);
>>> +	if (rc)
>>> +		return rc;
>>> +	mblock = container_of(kobj, struct mblock, kobj);
>>> +	block_size = memory_block_size_bytes();
>>> +	addr = mblock->id * block_size;
>>> +	/*
>>> +	 * Hold device_hotplug_lock when adding/removing memory blocks.
>>> +	 * Additionally, also protect calls to find_memory_block() and
>>> +	 * sclp_attach_storage().
>>> +	 */
>>> +	rc = lock_device_hotplug_sysfs();
>>> +	if (rc)
>>> +		goto out;
>>> +	for_each_clear_bit(id, sclp_storage_ids, sclp_max_storage_id + 1)
>>> +		sclp_attach_storage(id);
>>> +	if (value) {
>>> +		if (mblock->config)
>>> +			goto out_unlock;
>>> +		rc = sclp_mem_change_state(addr, block_size, 1);
>>> +		if (rc)
>>> +			goto out_unlock;
>>>    		/*
>>> -		 * When altmap is in use, take the specified memory range
>>> -		 * offline, which includes the altmap.
>>> +		 * Set entire memory block CMMA state to nodat. Later, when
>>> +		 * page tables pages are allocated via __add_memory(), those
>>> +		 * regions are marked __arch_set_page_dat().
>>>    		 */
>>> -		if (arg->altmap_nr_pages) {
>>> -			start = PFN_PHYS(arg->altmap_start_pfn);
>>> -			size += PFN_PHYS(arg->altmap_nr_pages);
>>> +		__arch_set_page_nodat((void *)__va(addr), block_size >> PAGE_SHIFT);
>>> +		rc = __add_memory(0, addr, block_size,
>>> +				  mblock->memmap_on_memory ?
>>> +				  MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
>>> +		if (rc)
>>> +			goto out_unlock;
>>
>> Do we have to undo the state change?
> 
> Intention was to keep error handling simple. In case of failure in
> add_memory(), we would have state set to 1 (not given back). But,
> subsequent configuration request for that block will not have an impact.

I mean, if we can cleanup easily here by doing another 
sclp_mem_change_state(), I think we should just do that.

I'd assume that sclp_mem_change_state() to 0 will usually not fail (I 
might be wrong :) ).

[...]

>>> -static int __init sclp_detect_standby_memory(void)
>>> +static int __init sclp_setup_memory(void)
>>>    {
>>>    	struct read_storage_sccb *sccb;
>>>    	int i, id, assigned, rc;
>>> +	struct mblock *mblocks;
>>> +	struct kset *kset;
>>>    	/* No standby memory in kdump mode */
>>>    	if (oldmem_data.start)
>>
>> Wouldn't we still want to create the ones for initial memory at least?
> 
> Intention was the following:
> configuration and deconfiguration of memory with optional
> memmap-on-memory is mostly needed for only standby memory.
> 
> If standby memory is absent or sclp is unavailable, we continue using
> the previous behavior (only software offline/online), since the sclp
> memory notifier was not registered in that case before either.

I mean, probably nobody in the kdump kernel cares about it either way, 
agreed.

-- 
Cheers

David / dhildenb

