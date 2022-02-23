Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1739AC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 11:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiBWLbJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Feb 2022 06:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbiBWLbI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Feb 2022 06:31:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B7A290266
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645615840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gE7c+TJZwdJ+gVzSVPXnxEm5PYurvMoN/2kz7QXDHUQ=;
        b=PJ3L2ZFl6cYyRqfmfQFcuH7AlEGndm2dCKPcIcipp+DLqTIppouT3CuwYutp8t4AVZxG46
        M2le/z5HYOI8dxREYvSg8Dcj45HjOtT2o8D5fbjV8En2yagOTcCL32nkG1yjkuOqdp2CfT
        QAj0Vh1BYAvp1QUkmUW/iFoflfANeyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-YfTqakG4O4SHrXdrP1elkA-1; Wed, 23 Feb 2022 06:30:39 -0500
X-MC-Unique: YfTqakG4O4SHrXdrP1elkA-1
Received: by mail-wr1-f72.google.com with SMTP id o9-20020adfca09000000b001ea79f7edf8so2900242wrh.16
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 03:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gE7c+TJZwdJ+gVzSVPXnxEm5PYurvMoN/2kz7QXDHUQ=;
        b=FWZf1iQ+aDZuPiWk1mEJRONmiekBF2xz611LRNKpCiX3HtMquPJMEsQdtnllqrfx5E
         kXD0Xs/VfjY3kbhmcK3ikG8vxLALvvyq5IvRDqq2YOEGZ0r2D9uuvFx6hkxbsgDim2jH
         5utzb/cBqfgDW3qZidxT9oNSGOj39xqbhjS19jvOdFlyCQPhFTknIaQCMDqqSmpGCnpD
         9LNXe8WQKUHf5elGhhwPHI/THnBR3W5kgb23OMTbyoRor8BU8s/hlZ7BBnGu0CYxYB9M
         w03Knknxopqzqiu7pxjDu7jWQ+/W9HMf9ntuCDvC9Irq72gqOvNRkXDpyTIJQxhu+riS
         S+NQ==
X-Gm-Message-State: AOAM533scPdD8rLf7BttNCK2FmvM1PQMig2dRx6Y8FnudFReDJ5f5JI2
        z+gW16fVQhiaDc+qK6ky2cunGWbnBTCr90shIDcRLNd6Dha8Chl7/QonfN3nTiqCtRtZtN0z3cq
        wALZIPquUUqzbO35x6QoAYw==
X-Received: by 2002:a05:6000:1d99:b0:1ed:bc55:34ad with SMTP id bk25-20020a0560001d9900b001edbc5534admr920991wrb.427.1645615837923;
        Wed, 23 Feb 2022 03:30:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyszBOWYlHNQwLxhXHNusl4BU8vLtOvldGHIca7YPyki7EvMfBkXxUePbm2YmXVo7pCzEFZHg==
X-Received: by 2002:a05:6000:1d99:b0:1ed:bc55:34ad with SMTP id bk25-20020a0560001d9900b001edbc5534admr920975wrb.427.1645615837592;
        Wed, 23 Feb 2022 03:30:37 -0800 (PST)
Received: from [10.33.192.232] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id t1sm67945067wre.45.2022.02.23.03.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:30:37 -0800 (PST)
Message-ID: <b2fd362a-eefa-8fa7-1016-55bedd3fa6ee@redhat.com>
Date:   Wed, 23 Feb 2022 12:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/9] KVM: s390: pv: Add query interface
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, borntraeger@linux.ibm.com
References: <20220223092007.3163-1-frankja@linux.ibm.com>
 <20220223092007.3163-4-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220223092007.3163-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23/02/2022 10.20, Janosch Frank wrote:
> Some of the query information is already available via sysfs but
> having a IOCTL makes the information easier to retrieve.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 47 ++++++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/kvm.h | 23 ++++++++++++++++++++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index faa85397b6fb..837f898ad2ff 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2217,6 +2217,34 @@ static int kvm_s390_cpus_to_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
>   	return r;
>   }
>   
> +static int kvm_s390_handle_pv_info(struct kvm_s390_pv_info *info)
> +{
> +	u32 len;
> +
> +	switch (info->header.id) {
> +	case KVM_PV_INFO_VM: {
> +		len =  sizeof(info->header) + sizeof(info->vm);
> +
> +		if (info->header.len < len)
> +			return -EINVAL;
> +
> +		memcpy(info->vm.inst_calls_list,
> +		       uv_info.inst_calls_list,
> +		       sizeof(uv_info.inst_calls_list));
> +
> +		/* It's max cpuidm not max cpus so it's off by one */
> +		info->vm.max_cpus = uv_info.max_guest_cpu_id + 1;
> +		info->vm.max_guests = uv_info.max_num_sec_conf;
> +		info->vm.max_guest_addr = uv_info.max_sec_stor_addr;
> +		info->vm.feature_indication = uv_info.uv_feature_indications;
> +
> +		return 0;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>   {
>   	int r = 0;
> @@ -2353,6 +2381,25 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>   			     cmd->rc, cmd->rrc);
>   		break;
>   	}
> +	case KVM_PV_INFO: {
> +		struct kvm_s390_pv_info info = {};
> +
> +		if (copy_from_user(&info, argp, sizeof(info.header)))
> +			return -EFAULT;
> +
> +		if (info.header.len < sizeof(info.header))
> +			return -EINVAL;
> +
> +		r = kvm_s390_handle_pv_info(&info);
> +		if (r)
> +			return r;
> +
> +		r = copy_to_user(argp, &info, sizeof(info));

sizeof(info) is currently OK ... but this might break if somebody later 
extends the kvm_s390_pv_info struct, I guess? ==> Maybe also better use 
sizeof(info->header) + sizeof(info->vm) here, too? Or let 
kvm_s390_handle_pv_info() return the amount of bytes that should be copied here?

  Thomas


> +		if (r)
> +			return -EFAULT;
> +		return 0;
> +	}
>   	default:
>   		r = -ENOTTY;
>   	}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index dbc550bbd9fa..96fceb204a92 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1642,6 +1642,28 @@ struct kvm_s390_pv_unp {
>   	__u64 tweak;
>   };
>   
> +enum pv_cmd_info_id {
> +	KVM_PV_INFO_VM,
> +};
> +
> +struct kvm_s390_pv_info_vm {
> +	__u64 inst_calls_list[4];
> +	__u64 max_cpus;
> +	__u64 max_guests;
> +	__u64 max_guest_addr;
> +	__u64 feature_indication;
> +};
> +
> +struct kvm_s390_pv_info_header {
> +	__u32 id;
> +	__u32 len;
> +};
> +
> +struct kvm_s390_pv_info {
> +	struct kvm_s390_pv_info_header header;
> +	struct kvm_s390_pv_info_vm vm;
> +};
> +
>   enum pv_cmd_id {
>   	KVM_PV_ENABLE,
>   	KVM_PV_DISABLE,
> @@ -1650,6 +1672,7 @@ enum pv_cmd_id {
>   	KVM_PV_VERIFY,
>   	KVM_PV_PREP_RESET,
>   	KVM_PV_UNSHARE_ALL,
> +	KVM_PV_INFO,
>   };
>   
>   struct kvm_pv_cmd {

