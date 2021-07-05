Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C77C07E99
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 09:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F140F61374
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 09:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhGEJ4a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Jul 2021 05:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhGEJ43 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Jul 2021 05:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625478832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEJ5Li45XESMm3lquznvdm6Bm6pYhAxf+/pVPbM0AfY=;
        b=CcOosoZUt9Nle/UNC7QYBWbFdRGe04CO9yl17S9X99fTvOb6/zulE8RhO55WhfdtJRON4K
        E88CpTyGcG1o/4a6JVF+eJ4TxE2Sr5sMHXk4p1fjNP1I0D+Zvn/7DS54j+xl8PfoCQNDOi
        pBqhU3UNCdcw3mBytVVF0PdvcVNgLy8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-exyFbJKkMZmGbijKfemmig-1; Mon, 05 Jul 2021 05:53:51 -0400
X-MC-Unique: exyFbJKkMZmGbijKfemmig-1
Received: by mail-wr1-f69.google.com with SMTP id g4-20020a5d64e40000b029013398ce8904so1358793wri.16
        for <linux-s390@vger.kernel.org>; Mon, 05 Jul 2021 02:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cEJ5Li45XESMm3lquznvdm6Bm6pYhAxf+/pVPbM0AfY=;
        b=BIjWHogiBZ1DRYxLDr9ZMoQFb5bpV+gzfqwDaEisf6jEqVXaUMwXKb9rOnoEgMTxcD
         RSrWoBoM/Lp/BuZ82dj6R2QxL8hIKIvp+zfMGgIez6GxOGghaqiSbwUbCqi/h/idWl5i
         iTw6GegHes0fAcLSXWLNffadNqiHZ4du7e+etE5EViWz6qG/CLa/RWNmPutKan4uyFhS
         +3GZF03lQJGtNX8kwc8y0Q580H1i1wYno2rLn4uVlqS3rhfSH+DgTK0i+/pVbnJ9tmZJ
         kQ9PbMlpFv12Fj25xH+VfpZNfxGnA+NjyZcRUwn5A1XOoFFNkx59/1ZBYBonggygYxtJ
         xQdA==
X-Gm-Message-State: AOAM533ptiO/wy2Sh+cxG40GsbpK+2PPN2vXs38iIPq56s9qK5ECpg6x
        lLTZIRC4L6JRRyYa/ZX733lC7277bMdHZ0IGi44o69LVv64IyX/zTsnd9ObOhhQnnIU9dhDBeh3
        Sct32tYnb9nmn7rgh3tipuA==
X-Received: by 2002:a05:600c:17cf:: with SMTP id y15mr8575670wmo.19.1625478830624;
        Mon, 05 Jul 2021 02:53:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVKvTYCTHnqRPiw054ae5I1sl+RnTYb5mBH2RY7OFB6ReyqeoKEmfARyjwvJSqURU6GZ6Byg==
X-Received: by 2002:a05:600c:17cf:: with SMTP id y15mr8575654wmo.19.1625478830445;
        Mon, 05 Jul 2021 02:53:50 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id j37sm9279000wms.37.2021.07.05.02.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 02:53:50 -0700 (PDT)
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20210701153853.33063-1-borntraeger@de.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH/RFC] KVM: selftests: introduce P44V64 for z196 and EC12
Message-ID: <bc025447-db53-5472-76b0-0cfa2c3ae996@redhat.com>
Date:   Mon, 5 Jul 2021 11:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701153853.33063-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01.07.21 17:38, Christian Borntraeger wrote:
> Older machines likes z196 and zEC12 do only support 44 bits of physical
> addresses. Make this the default and check via IBC if we are on a later
> machine. We then add P47V64 as an additional model.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: 1bc603af73dd ("KVM: selftests: introduce P47V64 for s390x")

[...]

> +#ifdef __s390x__
> +	{
> +		int kvm_fd, vm_fd;
> +		struct kvm_s390_vm_cpu_processor info;
> +
> +		kvm_fd = open_kvm_dev_path_or_exit();
> +		vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, 0);
> +		kvm_device_access(vm_fd, KVM_S390_VM_CPU_MODEL,
> +				  KVM_S390_VM_CPU_PROCESSOR, &info, false);

Can we always assume to run on a kernel where this won't fail?

> +		close(vm_fd);
> +		close(kvm_fd);
> +		/* Starting with z13 we have 47bits of physical address */

This matches the definition in the QEMU cpu models.

> +		if (info.ibc >= 0x30)
> +			guest_mode_append(VM_MODE_P47V64_4K, true, true);
> +	}
> +#endif


In general, LGTM


-- 
Thanks,

David / dhildenb

