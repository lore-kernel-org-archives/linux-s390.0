Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daYa+lAq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131847A88
	for <linux-s390@vger.kernel.org>; Mon, 27 Nov 2023 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701104338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XMg0UCw7ncShwMtFI9YG6sbkvvyS81hZIPOGyu2PItU=;
	b=daYa+lAqT2Uh00H5NVSLi6otpWGQE+TdjdoYFTyimqNptW1fncRZIJR1L8RC6W9kaOwNdE
	ow7mtd9/7eqZlbCH3OjvStSqUGwqF0uJLHzEBJznRhgvW8teTss6k+BvYg3ZHm/jyMK7vz
	RNsjRheXiCzwjA1PiSsMoR1heC9SEAg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-Z6IpPwYtPh294b3uKx1HJw-1; Mon, 27 Nov 2023 11:58:55 -0500
X-MC-Unique: Z6IpPwYtPh294b3uKx1HJw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332e2f70092so3144751f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Nov 2023 08:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104334; x=1701709134;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMg0UCw7ncShwMtFI9YG6sbkvvyS81hZIPOGyu2PItU=;
        b=VEYVClfUR82eycaRLGc7sbnYlxh9C6daJ5mGGiyEZfzq8oDB5+1jj+ghFkDWA3hHN8
         NvVPlo09Hn2GKFGmMS+BB6AbDUuiFnFVqnA40KDULuVR6V1HfUBmp5Ja/kSNcqs0RQbP
         JO2ELS677jrfeMtHvx+u6iBZL3IaDeTAHTfVJKQI+WrsFRugYpyuJLjdlc8RjPlT1tp5
         51brNw9+/jYR1Enr4CULUPkQMnnv6SbSnMw2iA+ZXyvGKXPx/d1a7aZZ9uNDlnrL3S57
         R56tWoGiF9j1hHWU4IFzf8yAhNKnQ91+KxeR3+cJIctmJZl2mZy0IY7nrk7TY9vlhsr3
         vtPA==
X-Gm-Message-State: AOJu0Yz0VEkNA0i4jvYUhmeI1k1QFb+zWJ3BR4X9QbTV639UerXVi9OZ
	UisYxgl/3D4q5MqVud0ZwSDOfr6QeLQfvUESe1uqqReARNHdxNum8D4B/tnWLzv9GZB2pAEY3vz
	SSCc7zEsDoY2qax1DIAyOzg==
X-Received: by 2002:a5d:5273:0:b0:331:6ad3:857 with SMTP id l19-20020a5d5273000000b003316ad30857mr8810748wrc.16.1701104334507;
        Mon, 27 Nov 2023 08:58:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkb1qMBwdaK5OKbqHyvO8vII4UsazWfZXMxlnMnXEG1jHUb4fu4JABuF77+v1aRM34CscZJg==
X-Received: by 2002:a5d:5273:0:b0:331:6ad3:857 with SMTP id l19-20020a5d5273000000b003316ad30857mr8810701wrc.16.1701104333179;
        Mon, 27 Nov 2023 08:58:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b003316b38c625sm12583163wro.99.2023.11.27.08.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 08:58:52 -0800 (PST)
Message-ID: <18d06a3d-b75f-4ac9-8791-8391a3f60575@redhat.com>
Date: Mon, 27 Nov 2023 17:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] s390/mm: implement
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Content-Language: en-US
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
 <20231127082023.2079810-5-sumanthk@linux.ibm.com>
 <abbe4d53-e944-46cc-90fc-a0a65e50b2fe@redhat.com>
 <ZWS/5ZzhGzt6ykfq@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWS/5ZzhGzt6ykfq@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.11.23 17:12, Sumanth Korikkar wrote:
> On Mon, Nov 27, 2023 at 04:11:05PM +0100, David Hildenbrand wrote:
>>> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
>>> index 355e63e44e95..30b829e4c052 100644
>>> --- a/drivers/s390/char/sclp_cmd.c
>>> +++ b/drivers/s390/char/sclp_cmd.c
>>> @@ -18,6 +18,7 @@
>>>    #include <linux/mm.h>
>>>    #include <linux/mmzone.h>
>>>    #include <linux/memory.h>
>>> +#include <linux/memory_hotplug.h>
>>>    #include <linux/module.h>
>>>    #include <asm/ctlreg.h>
>>>    #include <asm/chpid.h>
>>> @@ -26,6 +27,7 @@
>>>    #include <asm/sclp.h>
>>>    #include <asm/numa.h>
>>>    #include <asm/facility.h>
>>> +#include <asm/page-states.h>
>>>    #include "sclp.h"
>>> @@ -319,6 +321,7 @@ static bool contains_standby_increment(unsigned long start, unsigned long end)
>>>    static int sclp_mem_notifier(struct notifier_block *nb,
>>>    			     unsigned long action, void *data)
>>>    {
>>> +	struct memory_block *memory_block;
>>>    	unsigned long start, size;
>>>    	struct memory_notify *arg;
>>>    	unsigned char id;
>>> @@ -340,18 +343,29 @@ static int sclp_mem_notifier(struct notifier_block *nb,
>>>    		if (contains_standby_increment(start, start + size))
>>>    			rc = -EPERM;
>>>    		break;
>>> -	case MEM_GOING_ONLINE:
>>> +	case MEM_PREPARE_ONLINE:
>>> +		memory_block = find_memory_block(pfn_to_section_nr(arg->start_pfn));
>>> +		if (!memory_block) {
>>> +			rc = -EINVAL;
>>> +			goto out;
>>> +		}
>>>    		rc = sclp_mem_change_state(start, size, 1);
>>> +		if (rc || !memory_block->altmap)
>>> +			goto out;
>>> +		/*
>>> +		 * Set CMMA state to nodat here, since the struct page memory
>>> +		 * at the beginning of the memory block will not go through the
>>> +		 * buddy allocator later.
>>> +		 */
>>> +		__arch_set_page_nodat((void *)__va(start), memory_block->altmap->free);
>>
>> Looking up the memory block and grabbing the altmap from there is a bit
>> unfortunate.
>>
>> Why can't we do that when adding the altmap? Will the hypervisor scream at
>> us?
>>
> calling __arch_set_page_nodat() before making memory block accessible
> will lead to crash. Hence, we think this is the only safe location to
> place it.
> 
>> ... would we want to communicate any altmap start+size via the memory
>> notifier instead?
> 
> Passing start, size  of memory range via memory notifier looks correct
> approach to me, as we try to make the specified range accessible.
> 
> If we want to pass altmap size (nr_vmemmap_pages), then we might need a
> new field in struct memory_notify, which would prevent access of
> memory_block->altmap->free in the notifier.
> 
> Do you want to take this approach instead?
> 
> If yes, Then I could add a new field nr_vmemmap_pages in struct
> memory_notify and place it in PATCH : introduce
> MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.

Yes, see my other mail. That's probably cleanest!

-- 
Cheers,

David / dhildenb

