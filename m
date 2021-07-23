Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD5AC4338F
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB66360EBD
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 08:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhGWIPb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhGWIPb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Jul 2021 04:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627030564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBWhltyKdk3REe+ChbxZxiUkfEHcCzSGpWzpsl0mPA8=;
        b=L6/X+WXANGNPRNidQhAcpmhr1pKjAkKPiOA6YWo/mfQc+v6GJ7EFqwfWCSMgWOn81YzNyR
        QDzK1d5BWYTCM2tWbnkIUaL0zNVSp9/97s4UcdRq6R700ANeYAG2L4+K/sPmrQaq4HrY0T
        I2Uq7jVALaTeh5C9WNZFCxK78pb7Vzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-VRM5GtjaNt68geAKoGaaBA-1; Fri, 23 Jul 2021 04:56:03 -0400
X-MC-Unique: VRM5GtjaNt68geAKoGaaBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF7C8799E0;
        Fri, 23 Jul 2021 08:56:01 +0000 (UTC)
Received: from localhost (unknown [10.39.192.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E77995C1D1;
        Fri, 23 Jul 2021 08:55:57 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v2 2/2] s390:kvm: Topology expose TOPOLOGY facility
In-Reply-To: <7163cf4a-479a-3121-2261-cfb6e4024d0c@de.ibm.com>
Organization: Red Hat GmbH
References: <1626973353-17446-1-git-send-email-pmorel@linux.ibm.com>
 <1626973353-17446-3-git-send-email-pmorel@linux.ibm.com>
 <7163cf4a-479a-3121-2261-cfb6e4024d0c@de.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Fri, 23 Jul 2021 10:55:56 +0200
Message-ID: <87wnph5rz7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 23 2021, Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 22.07.21 19:02, Pierre Morel wrote:
>> We add a KVM extension KVM_CAP_S390_CPU_TOPOLOGY to tell the
>> userland hypervisor it is safe to activate the CPU Topology facility.
>
> I think the old variant of using the CPU model was actually better.
> It was just the patch description that was wrong.

I thought we wanted a cap that userspace can enable to get ptf
intercepts? I'm confused.

>   
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c | 1 +
>>   include/uapi/linux/kvm.h | 1 +
>>   2 files changed, 2 insertions(+)
>> 
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index b655a7d82bf0..8c695ee79612 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -568,6 +568,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   	case KVM_CAP_S390_VCPU_RESETS:
>>   	case KVM_CAP_SET_GUEST_DEBUG:
>>   	case KVM_CAP_S390_DIAG318:
>> +	case KVM_CAP_S390_CPU_TOPOLOGY:
>>   		r = 1;
>>   		break;
>>   	case KVM_CAP_SET_GUEST_DEBUG2:
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index d9e4aabcb31a..081ce0cd44b9 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1112,6 +1112,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_BINARY_STATS_FD 203
>>   #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>>   #define KVM_CAP_ARM_MTE 205
>> +#define KVM_CAP_S390_CPU_TOPOLOGY 206
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
>> 

Regardless of what we end up with: we need documentation for any new cap
:)

