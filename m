Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232DCC6FD1D
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 15:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjDDPUC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDDPUB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 11:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548AC1991
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680621555;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9h0qe2de4wpUWOB28748KnL4bo+TUsPB4FwOqLcCkxY=;
        b=c3Xe4fqhHGSkOVm9o/+83nlTAUhXr6hp2KHTa7mHVh6Q+wOUt0WerNd4BoWU0lkQ9G6AaR
        YASNxBjd6thKXsuuGIaFM02TrK/aZCV0n9vnFE1ml+D4lD0WwzgTHPM1RRrJL0nPBVw5xT
        /MfierSw0uen6ewyPynhwu13bO74oCg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-OMC8ZfrdOZOUkuzAhYVJAw-1; Tue, 04 Apr 2023 11:19:01 -0400
X-MC-Unique: OMC8ZfrdOZOUkuzAhYVJAw-1
Received: by mail-qv1-f69.google.com with SMTP id q1-20020ad44341000000b005a676b725a2so14734952qvs.18
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 08:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680621540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9h0qe2de4wpUWOB28748KnL4bo+TUsPB4FwOqLcCkxY=;
        b=vb5ffxVGu+MbEFamE7mQHLuYCyWU+8L2Qa1bxvbcWvQcrUyzGI6b8m2yhb7nRnhW7Q
         1CPJeHbvb0w61ymUGmJhCDhVL22kv7oCqaaitbq8HlqGi/lKugDoelp98Dv5amTLSrGA
         FbIuDF1i4m5cdBWvZrIh1WGQ5JJ983vw3jigParmSVl1kkQ/cewSi2/9dYOBYnnamRN3
         wUZMsXpDXK83FvBEvcrfdBJSHDiPl7WHzD6mz/lovRn4teJGNVwqz/+Rx8ZGa+uzMtxw
         bGCwkBXI+CTwRhwC0QyjJu4Iemt1VrMos542vZJTJVDhteuCScMwbGqzlfFo2L3e5Hea
         fSNw==
X-Gm-Message-State: AAQBX9f3zV8/HYTN45KtiOBsua1d0GXsfRX2MdsT5v09isCpS9padZsG
        CR8wiQFPkXzknkGAwXArXXc+E9zlrGkdYwXOHP21P9tJ51Vr0rsnRKAhQBQZ5g6L/OhnTmcBJq5
        rVHQWkXx1ULfPmOc6QouN8A==
X-Received: by 2002:a05:6214:c6b:b0:5d5:11b4:ad6 with SMTP id t11-20020a0562140c6b00b005d511b40ad6mr4092522qvj.5.1680621539818;
        Tue, 04 Apr 2023 08:18:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350b/pUGHnnzAa/Is2PTZjxccUTN1xIqWGh6dFWoPmFhMxxL0nmFn4Q7QHgQ+QfiC+fi7gOde3g==
X-Received: by 2002:a05:6214:c6b:b0:5d5:11b4:ad6 with SMTP id t11-20020a0562140c6b00b005d511b40ad6mr4092477qvj.5.1680621539415;
        Tue, 04 Apr 2023 08:18:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ea7-20020ad458a7000000b005dd8b9345a7sm3427407qvb.63.2023.04.04.08.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 08:18:57 -0700 (PDT)
Message-ID: <fc87191d-2e79-83c3-b5ba-7f8b1083988a@redhat.com>
Date:   Tue, 4 Apr 2023 17:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 02/12] vfio/pci: Only check ownership of opened devices
 in hot reset
Content-Language: en-US
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
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
References: <20230401144429.88673-1-yi.l.liu@intel.com>
 <20230401144429.88673-3-yi.l.liu@intel.com>
 <844faa5c-2968-2a4f-8a70-900f359be1a0@redhat.com>
 <DS0PR11MB75290339DD0FD467146D4655C3939@DS0PR11MB7529.namprd11.prod.outlook.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <DS0PR11MB75290339DD0FD467146D4655C3939@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Yi,

On 4/4/23 16:37, Liu, Yi L wrote:
> Hi Eric,
>
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Tuesday, April 4, 2023 10:00 PM
>>
>> Hi YI,
>>
>> On 4/1/23 16:44, Yi Liu wrote:
>>> If the affected device is not opened by any user, it's safe to reset it
>>> given it's not in use.
>>>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> ---
>>>  drivers/vfio/pci/vfio_pci_core.c | 14 +++++++++++---
>>>  include/uapi/linux/vfio.h        |  8 ++++++++
>>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>>> index 65bbef562268..5d745c9abf05 100644
>>> --- a/drivers/vfio/pci/vfio_pci_core.c
>>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>>> @@ -2429,10 +2429,18 @@ static int vfio_pci_dev_set_hot_reset(struct
>> vfio_device_set *dev_set,
>>>  	list_for_each_entry(cur_vma, &dev_set->device_list, vdev.dev_set_list) {
>>>  		/*
>>> -		 * Test whether all the affected devices are contained by the
>>> -		 * set of groups provided by the user.
>>> +		 * Test whether all the affected devices can be reset by the
>>> +		 * user.
>>> +		 *
>>> +		 * Resetting an unused device (not opened) is safe, because
>>> +		 * dev_set->lock is held in hot reset path so this device
>>> +		 * cannot race being opened by another user simultaneously.
>>> +		 *
>>> +		 * Otherwise all opened devices in the dev_set must be
>>> +		 * contained by the set of groups provided by the user.
>>>  		 */
>>> -		if (!vfio_dev_in_groups(cur_vma, groups)) {
>>> +		if (cur_vma->vdev.open_count &&
>>> +		    !vfio_dev_in_groups(cur_vma, groups)) {
>>>  			ret = -EINVAL;
>>>  			goto err_undo;
>>>  		}
>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>> index 0552e8dcf0cb..f96e5689cffc 100644
>>> --- a/include/uapi/linux/vfio.h
>>> +++ b/include/uapi/linux/vfio.h
>>> @@ -673,6 +673,14 @@ struct vfio_pci_hot_reset_info {
>>>   * VFIO_DEVICE_PCI_HOT_RESET - _IOW(VFIO_TYPE, VFIO_BASE + 13,
>>>   *				    struct vfio_pci_hot_reset)
>>>   *
>>> + * Userspace requests hot reset for the devices it uses.  Due to the
>>> + * underlying topology, multiple devices can be affected in the reset
>> by the reset
>>> + * while some might be opened by another user.  To avoid interference
>> s/interference/hot reset failure?
> I don’t think user can really avoid hot reset failure since there may
> be new devices plugged into the affected slot. Even user has opened
I don't know the legacy wrt that issue but this sounds a serious issue,
meaning the reset of an assigned device could impact another device
belonging to another group not not owned by the user?
> all the groups/devices reported by VFIO_DEVICE_GET_PCI_HOT_RESET_INFO,
> the hot reset can fail if new device is plugged in and has not been
> bound to vfio or opened by another user during the window of
> _INFO and HOT_RESET.
with respect to the latter isn't the dev_set lock held during the hot
reset and sufficient to prevent any new opening to occur?
>
> maybe the whole statement should be as below:
>
> To avoid interference, the hot reset can only be conducted when all
> the affected devices are either opened by the calling user or not
> opened yet at the moment of the hot reset attempt.

OK

Eric
>
>>> + * the calling user must ensure all affected devices, if opened, are
>>> + * owned by itself.
>>> + *
>>> + * The ownership is proved by an array of group fds.
>>> + *
>>>   * Return: 0 on success, -errno on failure.
>>>   */
>>>  struct vfio_pci_hot_reset {
> Regards,
> Yi Liu

