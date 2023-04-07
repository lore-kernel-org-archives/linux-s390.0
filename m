Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05393C76196
	for <linux-s390@archiver.kernel.org>; Fri,  7 Apr 2023 08:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjDGI5v (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 7 Apr 2023 04:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbjDGI5j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Apr 2023 04:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21999B
        for <linux-s390@vger.kernel.org>; Fri,  7 Apr 2023 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680857809;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zm0x3qIRJGoq5IUNwNsG2TAdBWo5E6P2pw0Wr6/J6xU=;
        b=gygHWpzhklOzFnKD2IAqbEvcPu/wmXcsY6RjNw7KZ6n1TKSbjkVM01qLU5eubMXzPsgrVz
        T1ykgFfAFMeIjuVQ61g0J+68oBB7IiMpdKFOv/e1ylpzYo1pClEuVrTWteiNh1GecCeNhx
        iB1sQqaxoIFOCgxc9Jbh3PaQHwD7cMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-0gAK-iQbPnecvTppqsNn_A-1; Fri, 07 Apr 2023 04:56:47 -0400
X-MC-Unique: 0gAK-iQbPnecvTppqsNn_A-1
Received: by mail-wm1-f71.google.com with SMTP id n11-20020a05600c3b8b00b003f04739b77aso9279379wms.9
        for <linux-s390@vger.kernel.org>; Fri, 07 Apr 2023 01:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zm0x3qIRJGoq5IUNwNsG2TAdBWo5E6P2pw0Wr6/J6xU=;
        b=Vj7IkhMEP/uEgL4BiLyCnjC9Go3CJrvCG1DITVAJnC1feAXYjEeFfvvPTQxEMPNhdm
         vOE0PA+AsJby3mBbi4DV3ZbFQqhlW77+5F+xkj3R9ikTELDghDfXL2NGL9Jw++mXCoLj
         2Mas3k77cxYe3/YZlfl+m5f/PCSbBGJlu+Y4y6DslZ0YzI+x3wtv84mnhLfABHXm3tIs
         xtVKexqf+nCaNRmRmxWiV044nbiXeL8aZgJI8+gOYCZqTX/w+Ujs9G9IfWo2zoMBcwJu
         vvcEKbofd8Xkr0LZkGDk94x7aUxqOqz+tG0n1xOWOhgszi1kJYOy4zNuqeOyGlEzLTZP
         dLvQ==
X-Gm-Message-State: AAQBX9ftA4PJ9PwUX/52oxAmo7KOyUKwHKtproDUK9AGmq4uuLYS0Xs8
        3q8tCRBABoRQOioGCliB+fOk4gH6ltzUhHkarFf0JGE9radNO96qDg/w3wrEbBuzPnnmgdis781
        XNGHixZhRle5PI0bc/u3z1Q==
X-Received: by 2002:a05:600c:4f45:b0:3ee:93d2:c915 with SMTP id m5-20020a05600c4f4500b003ee93d2c915mr915237wmq.6.1680857806783;
        Fri, 07 Apr 2023 01:56:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKstcvpy21T/+Sur+wGdRQ6MZEvGuCCMZJzNceYWbo9B1mTkijQltP94h5JEaS1eDfNwFqwg==
X-Received: by 2002:a05:600c:4f45:b0:3ee:93d2:c915 with SMTP id m5-20020a05600c4f4500b003ee93d2c915mr915208wmq.6.1680857806468;
        Fri, 07 Apr 2023 01:56:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b003ee2a0d49dbsm7785542wmo.25.2023.04.07.01.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 01:56:45 -0700 (PDT)
Message-ID: <5f8d9e23-8a4c-3f97-8f22-01eaa4eddfbb@redhat.com>
Date:   Fri, 7 Apr 2023 10:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v9 06/25] kvm/vfio: Accept vfio device file from userspace
Content-Language: en-US
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>
References: <20230401151833.124749-1-yi.l.liu@intel.com>
 <20230401151833.124749-7-yi.l.liu@intel.com>
 <8fb5a0b3-39c6-e924-847d-6545fcc44c08@redhat.com>
 <DS0PR11MB7529B8DC835A6EADDB815C04C3919@DS0PR11MB7529.namprd11.prod.outlook.com>
 <20230406125730.55bfa666.alex.williamson@redhat.com>
 <DS0PR11MB752903283C1E02708EC13848C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <DS0PR11MB752903283C1E02708EC13848C3969@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Yi,

On 4/7/23 05:42, Liu, Yi L wrote:
>> From: Alex Williamson <alex.williamson@redhat.com>
>> Sent: Friday, April 7, 2023 2:58 AM
>>>> You don't say anything about potential restriction, ie. what if the user calls
>>>> KVM_DEV_VFIO_FILE with device fds while it has been using legacy
>> container/group
>>>> API?
>>> legacy container/group path cannot do it as the below enhancement.
>>> User needs to call KVM_DEV_VFIO_FILE before open devices, so this
>>> should happen before _GET_DEVICE_FD. So the legacy path can never
>>> pass device fds in KVM_DEV_VFIO_FILE.
>>>
>>>
>> https://lore.kernel.org/kvm/20230327102059.333d6976.alex.williamson@redhat.com
>> /#t
>>
>> Wait, are you suggesting that a comment in the documentation suggesting
>> a usage policy somehow provides enforcement of that ordering??  That's
>> not how this works.  Thanks,
> I don't know if there is a good way to enforce this order in the code. The
> vfio_device->kvm pointer is optional. If it is NULL, vfio just ignores it.
> So vfio doesn't have a good way to tell if the order requirement is met or
> not. Perhaps just trigger NULL pointer dereference when kvm pointer is used
> in the device drivers like kvmgt if this order is not met.
>
> So that's why I come up to document it here. The applications uses kvm
> should know this and follow this otherwise it may encounter error.
>
> Do you have other suggestions for it? This order should be a generic
> requirement. is it? group path also needs to follow it to make the mdev
> driver that refers kvm pointer to be workable.

In the same way as kvm_vfio_file_is_valid() called in kvm_vfio_file_add()
can't you have a kernel API that checks the fd consistence?

Thanks

Eric
>
> Thanks,
> Yi Liu
>
>>>>> -The GROUP_ADD operation above should be invoked prior to accessing the
>>>>> +The FILE/GROUP_ADD operation above should be invoked prior to accessing the
>>>>>  device file descriptor via VFIO_GROUP_GET_DEVICE_FD in order to support
>>>>>  drivers which require a kvm pointer to be set in their .open_device()
>>>>> -callback.
>>>>> +callback.  It is the same for device file descriptor via character device
>>>>> +open which gets device access via VFIO_DEVICE_BIND_IOMMUFD.  For such file
>>>>> +descriptors, FILE_ADD should be invoked before
>> VFIO_DEVICE_BIND_IOMMUFD
>>>>> +to support the drivers mentioned in prior sentence as well.
>>> just as here. This means device fds can only be passed with KVM_DEV_VFIO_FILE
>>> in the cdev path.
>>>
>>> Regards,
>>> Yi Liu

