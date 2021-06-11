Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CFFC48BE0
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039276124C
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 17:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhFKRNx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbhFKRNw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Jun 2021 13:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623431514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fN/mVV/PbyF2783Hpa69RufdmQkjHk7SYejj/LdWl0k=;
        b=KTjukm/3z+h54EBcpy0V1ZiSr1hHxv7nAmjTduhQ60X8+ey0AF1FIgNVCzu6F8V+ctLYyW
        OjyLeKLZi5Nr57kO7PSsmlr9Hx4YeDNAvnpGqHOOnVMkLCvh3JzyrXdTgbaTzahFZXyELo
        AU69QYIaKlv4lnEmJxJimP4tJF40SIs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-JYNkw_VpN-quaMpNgMMgeA-1; Fri, 11 Jun 2021 13:11:52 -0400
X-MC-Unique: JYNkw_VpN-quaMpNgMMgeA-1
Received: by mail-wm1-f72.google.com with SMTP id n8-20020a05600c3b88b02901b6e5bcd841so1857449wms.9
        for <linux-s390@vger.kernel.org>; Fri, 11 Jun 2021 10:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fN/mVV/PbyF2783Hpa69RufdmQkjHk7SYejj/LdWl0k=;
        b=WzjxdX1yPXW6ET7YdiLN20sKtwM5rdWR9GTYwUzOYEhjQUJvgummwc4Ys0sW8aGGaD
         1DNylgFBUWul0aU51URoE6/Tm+WbuDQ+2Q88i7hPxWsDLzDOx46XoWUVYWXT7tUZbtQ+
         38h0mzg98Mm0m2PlGvI0BIMJDe06/1ESzSR5C7Cs/5rtgi1kSSG9/ityOnYLTUd82sd9
         RZDMmWPmg7bUR0As0Y60votMVOQH6P9GxTd0qar8f3IthFwV8otzziIELyJ/I8rWNDwV
         FSmdk1RDnXPwQL3KY73eZhQY/+sJyVGzdB/3iEkO3/rb7A1XglqSDqYqx+2ooS3ACaJe
         ZMhA==
X-Gm-Message-State: AOAM5328fx+8sqbfuc7c5yRZGsLNSm92AJQjupJDgC0broCeFWfEmETD
        wsndVN9szEX2a/37iZTwfupD7S1QJLiONyEZtzSC9hNbO/EiGfw+53CBLpCDQLu98sMYtMJXvh2
        C8OTLSl0/eRpTcjFPtwr6Og==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr5215043wri.263.1623431511679;
        Fri, 11 Jun 2021 10:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqAEtDrL+JGgbe7s64y6Qwu724j6kGakolpO9O9iu4bscLtvjosb65kz5vimWchOT3ZRhvXA==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr5215010wri.263.1623431511354;
        Fri, 11 Jun 2021 10:11:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64b6.dip0.t-ipconnect.de. [91.12.100.182])
        by smtp.gmail.com with ESMTPSA id v18sm8416778wrb.10.2021.06.11.10.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:11:51 -0700 (PDT)
Subject: Re: [PATCH 2/3] s390/vfio-ap: introduce two new r/w locks to replace
 wait_queue_head_t
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-3-akrowiak@linux.ibm.com>
 <20210611170526.GU1002214@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7ed059b0-5d58-eeec-167c-280917b47c00@redhat.com>
Date:   Fri, 11 Jun 2021 19:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611170526.GU1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11.06.21 19:05, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 06:46:33PM -0400, Tony Krowiak wrote:
>> This patch introduces two new r/w locks to replace the wait_queue_head_t
>> that was introduced to fix a lockdep splat reported when testing
>> pass-through of AP queues to a Secure Execution guest. This was the
>> abbreviated dependency chain reported by lockdep that was fixed using
>> a wait queue:
>>
>> kvm_arch_crypto_set_masks+0x4a/0x2b8 [kvm]        kvm->lock
>> vfio_ap_mdev_group_notifier+0x154/0x170 [vfio_ap] matrix_dev->lock
>>
>> handle_pqap+0x56/0x1d0 [vfio_ap]    matrix_dev->lock
>> kvm_vcpu_ioctl+0x2cc/0x898 [kvm]    vcpu->mutex
>>
>> kvm_s390_cpus_to_pv+0x4e/0xf8 [kvm]   vcpu->mutex
>> kvm_arch_vm_ioctl+0x3ec/0x550 [kvm]   kvm->lock
> 
> Is the problem larger than kvm_arch_crypto_set_masks()? If not it
> looks easy enough to fix, just pull the kvm->lock out of
> kvm_arch_crypto_set_masks() and obtain it in vfio_ap_mdev_set_kvm()
> before the rwsem. Now your locks are in the right order and all should
> be well?
> 
>> +static int vfio_ap_mdev_matrix_store_lock(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	if (!down_write_trylock(&matrix_mdev->rwsem))
>> +		return -EBUSY;
>> +
>> +	if (matrix_mdev->kvm) {
>> +		up_write(&matrix_mdev->rwsem);
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (!down_write_trylock(&matrix_mdev->matrix.rwsem)) {
>> +		up_write(&matrix_mdev->rwsem);
>> +		return -EBUSY;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> This double locking is quite strange, at least it deserves a detailed
> comment? The comments suggest these locks protect distinct data so..
> 
>> +
>> +	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
>> +	if (ret)
>> +		return ret;
>>   
>>   	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
> 
> here it obtained both locks but only touched matrix.aqm which is only
> protected by the inner lock - what was the point of obtaining the
> outer lock?
> 
> Also, not convinced down_write_trylock() is appropriate from a sysfs
> callback, it should block and wait, surely? Otherwise userspace gets
> random racy failures depending on what the kernel is doing??

It might we worth exploring lock_device_hotplug_sysfs() which does a

"return restart_syscall()" with some delay.


-- 
Thanks,

David / dhildenb

