Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BA28EA4A
	for <linux-s390@vger.kernel.org>; Thu, 10 Apr 2025 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310656; cv=none; b=XvDF3hx32XOZdXWESyoCTPFDphpYvtLTMVJorQUEVRUOkXihu5HLM3r/ZObCQLVCcDGqqlVBUTXyrnRo0ZiZXh/NSfr5YpjdO2ZkEaDBRM0JellmMKZI5mjFulkxqUMI6YZtOAw/wGyvszQ5EmAPnTfzJOgstotEr9bNMmCQpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310656; c=relaxed/simple;
	bh=sKywq7H/4Et9741fqSvhin/moVoNQTVDF+h4YhYybJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCGuvN4nsxbZlPp1pvyO5+cIJSJPIwrnSV3D06ixQ/8hTx3k+v25d/XWwbm+AjXbniw4uoDZBiqdm5FLxLpgu66rzXhBdjaLURRDjNuzRTWwQ8XOrFB/9vqM3iJ+fgXoKNlT56zo3fg25+o+T71jMybId1HqjvC6lT8LcZfoeE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8JNKPww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8JNKPww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744310653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jxve4+H/G8iIVYp4eWG2z8bp0IS92tto2aBEElfrg50=;
	b=R8JNKPwwnQFUTb1rsUXWpq1gb7+HZyhlytMY/nN5M3wUu1fSIQq3w8iigvA/EWkcgf7LNn
	4E+lts3nZvjeEhxu7swg1yb4VBNRahDNWy81tDhzmefeccxH/RgB2wkypYdrBwbc3+ohM2
	PPpyAkEy/noG2GAhkzwf9rKdESv+jxg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-1K-JNDXyOr6n9hT_YYHvRA-1; Thu, 10 Apr 2025 14:44:09 -0400
X-MC-Unique: 1K-JNDXyOr6n9hT_YYHvRA-1
X-Mimecast-MFC-AGG-ID: 1K-JNDXyOr6n9hT_YYHvRA_1744310648
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912539665cso1298894f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 10 Apr 2025 11:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744310648; x=1744915448;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jxve4+H/G8iIVYp4eWG2z8bp0IS92tto2aBEElfrg50=;
        b=KeWG+acw382H7s0/hB9Ixu6xRCYNTmvLyGbE1/KONhEDqCBDfo6lbotRhwhjtI/wFh
         uLr+GrOvYQCsjK2F2uPmMOy+jV4osPZDuylz7RVxNbX65gajDN+f/XrjIiHWXpNPZOnJ
         NBukSxh+Sqml2pqlnOmFnvatAIOeUqdDbRGx5d+FhS325J82KcyqJu1P2dHq0HLrP4PO
         RYpU43aSaJQVvOPmcVJVrqOidxpQPDwfHU3EyDAD5chKjfwPiwnqKJsoJs3NZNFSuZTx
         nqVInCapiuHlUwUtXjuu4MbC45JSCBaZky64zw7FsXt81hYO69Lv+XajJfajSMWCieW4
         CHcg==
X-Gm-Message-State: AOJu0YwBKwVOsGTHmEgWt5Oc+wzfwgh2mWgxIu4uo6v8EyuEnM6jIRos
	tXko2x4ST1qs35GQYHC5+2hJ66VdPRWrCzw03UY6/gAJXE42V7pXUw8fOULzy/Vd1tMxV8PzVyO
	IXfU2dzTSlhsML9q1/w1nNkofqzxOhW9Tc8vlA6uT5A6WRyWxp/JNhJ7+7lo=
X-Gm-Gg: ASbGnctI6bu96MyBZrUcyM64mnbXKFWEBQoYegzAt06PaolwCAUnBjDVXBb2xPW6DYD
	2e+r3rFkQ9m7GBq/8UM9ZB1ZQ0mfNoO6In1BbwqlnVw2vHwDSHR3iQMpPo014M6WuZaCU5v/Zmm
	7kg6S30V0rV7t2XleNxIuHjHhLmPiSaxG/MivM1VfyKTkchRA5e7ntnJjpiK89AOEdwfym34AeR
	8IjwUPA//z9pt7WX8sCQd5CKnBef4qXlanqKUw3OygAt2maxdnhJ8fYu12shCN1NkxcEeqBG8NN
	XwHXfJE/+sFOu2amSV07mffi1+7voLCfukADBFfI8igOCMqm22Pc8maPtNIKfZC9MfVvfoimPpN
	h/LocKvpVe+Wm0/QjBwf0smw9811o3eepr+otPrg=
X-Received: by 2002:a05:6000:2910:b0:39c:1efb:eec9 with SMTP id ffacd0b85a97d-39e6e49f471mr38115f8f.13.1744310648185;
        Thu, 10 Apr 2025 11:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEvQUNgBzNubFZ9s+T+LLIrqym+NXcc1LkzcRdHUvQ0wzpouOUTK9qcrtz+IuiYAIXOqtXDw==
X-Received: by 2002:a05:6000:2910:b0:39c:1efb:eec9 with SMTP id ffacd0b85a97d-39e6e49f471mr38093f8f.13.1744310647685;
        Thu, 10 Apr 2025 11:44:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:5900:d106:4706:528a:7cd5? (p200300cbc71a5900d1064706528a7cd5.dip0.t-ipconnect.de. [2003:cb:c71a:5900:d106:4706:528a:7cd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893773b6sm5555224f8f.27.2025.04.10.11.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 11:44:06 -0700 (PDT)
Message-ID: <065d46ba-83c1-473a-9cbe-d5388237d1ea@redhat.com>
Date: Thu, 10 Apr 2025 20:44:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
 Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
References: <20250402203621.940090-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402203621.940090-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 22:36, David Hildenbrand wrote:
> If we finds a vq without a name in our input array in
> virtio_ccw_find_vqs(), we treat it as "non-existing" and set the vq pointer
> to NULL; we will not call virtio_ccw_setup_vq() to allocate/setup a vq.
> 
> Consequently, we create only a queue if it actually exists (name != NULL)
> and assign an incremental queue index to each such existing queue.
> 
> However, in virtio_ccw_register_adapter_ind()->get_airq_indicator() we
> will not ignore these "non-existing queues", but instead assign an airq
> indicator to them.
> 
> Besides never releasing them in virtio_ccw_drop_indicators() (because
> there is no virtqueue), the bigger issue seems to be that there will be a
> disagreement between the device and the Linux guest about the airq
> indicator to be used for notifying a queue, because the indicator bit
> for adapter I/O interrupt is derived from the queue index.
> 
> The virtio spec states under "Setting Up Two-Stage Queue Indicators":
> 
> 	... indicator contains the guest address of an area wherein the
> 	indicators for the devices are contained, starting at bit_nr, one
> 	bit per virtqueue of the device.
> 
> And further in "Notification via Adapter I/O Interrupts":
> 
> 	For notifying the driver of virtqueue buffers, the device sets the
> 	bit in the guest-provided indicator area at the corresponding
> 	offset.
> 
> For example, QEMU uses in virtio_ccw_notify() the queue index (passed as
> "vector") to select the relevant indicator bit. If a queue does not exist,
> it does not have a corresponding indicator bit assigned, because it
> effectively doesn't have a queue index.
> 
> Using a virtio-balloon-ccw device under QEMU with free-page-hinting
> disabled ("free-page-hint=off") but free-page-reporting enabled
> ("free-page-reporting=on") will result in free page reporting
> not working as expected: in the virtio_balloon driver, we'll be stuck
> forever in virtballoon_free_page_report()->wait_event(), because the
> waitqueue will not be woken up as the notification from the device is
> lost: it would use the wrong indicator bit.
> 
> Free page reporting stops working and we get splats (when configured to
> detect hung wqs) like:
> 
>   INFO: task kworker/1:3:463 blocked for more than 61 seconds.
>         Not tainted 6.14.0 #4
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:kworker/1:3 [...]
>   Workqueue: events page_reporting_process
>   Call Trace:
>    [<000002f404e6dfb2>] __schedule+0x402/0x1640
>    [<000002f404e6f22e>] schedule+0x3e/0xe0
>    [<000002f3846a88fa>] virtballoon_free_page_report+0xaa/0x110 [virtio_balloon]
>    [<000002f40435c8a4>] page_reporting_process+0x2e4/0x740
>    [<000002f403fd3ee2>] process_one_work+0x1c2/0x400
>    [<000002f403fd4b96>] worker_thread+0x296/0x420
>    [<000002f403fe10b4>] kthread+0x124/0x290
>    [<000002f403f4e0dc>] __ret_from_fork+0x3c/0x60
>    [<000002f404e77272>] ret_from_fork+0xa/0x38
> 
> There was recently a discussion [1] whether the "holes" should be
> treated differently again, effectively assigning also non-existing
> queues a queue index: that should also fix the issue, but requires other
> workarounds to not break existing setups.
> 
> Let's fix it without affecting existing setups for now by properly ignoring
> the non-existing queues, so the indicator bits will match the queue
> indexes.
> 
> [1] https://lore.kernel.org/all/cover.1720611677.git.mst@redhat.com/
> 
> Fixes: a229989d975e ("virtio: don't allocate vqs when names[i] = NULL")
> Reported-by: Chandra Merla <cmerla@redhat.com>
> Cc: <Stable@vger.kernel.org>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

So, given that

(a) people are actively running into this
(b) we'll have to backport this quite a lot
(c) the spec issue is not a s390x-only issue
(d) it's still unclear how to best deal with the spec issue

I suggest getting this fix here upstream asap. It will neither making 
sorting out the spec issue easier nor harder :)

I can spot it in the s390 fixes tree already.

-- 
Cheers,

David / dhildenb

