Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9203C48BD1
	for <linux-s390@archiver.kernel.org>; Thu, 10 Jun 2021 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDC8613F1
	for <linux-s390@archiver.kernel.org>; Thu, 10 Jun 2021 16:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhFJQoz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231881AbhFJQoJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Jun 2021 12:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623343331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTYsk+3ZrtMDgibB9knYQRxYmGEpuIUf1VdElxSCW6k=;
        b=TrMQDsKp+FKHxX4nb0ERe0QpfAZo046yyVth6XhXZarsIKikOxe2S4GuwEE4mHX8KJm5Dl
        R0b7PJQ5LXGxbyXL+DLdbs65laG56d1Sq+pM+SZEBBBKmUnoyC72EXFFILSHrXk6rwnVxm
        HAsklXT37ERwhPDBTzggcxIgBGi4SWc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-pJSu-FYJOW2tjdn9IXxOUg-1; Thu, 10 Jun 2021 12:42:10 -0400
X-MC-Unique: pJSu-FYJOW2tjdn9IXxOUg-1
Received: by mail-wr1-f70.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so1230090wrb.3
        for <linux-s390@vger.kernel.org>; Thu, 10 Jun 2021 09:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FTYsk+3ZrtMDgibB9knYQRxYmGEpuIUf1VdElxSCW6k=;
        b=kL3cHgMAZz1xqZVEJTijnbpA0xw7y8Fd9fhMgWur6wM5zJMvPsrYeSMFhvJI1nn6Tv
         EnzW+5KQJ85c4rLpY8z/x0UJrUCy57gB6Xq59i6AE2oNQrsr0wxg0dLb17RpcoZz86aY
         9VEn6yP8vTzyLCMxeQsKckgwo0qlliVEM7X1H0GNQhuT0SOW56+r1GbrkttsjFu+2QQ3
         ngkL2IzJj0gXXO45qUUTYr55SKaXD84QTCNySLfmBeMq/zUAYVc48GQ3svKmNDkPA6xW
         EJaBFWRmd182+yAXyJbYx5HMBTaTqP/X4glCIQxpaQfjwmeBKGAj3YZkP8vF+ikRTDif
         QMdg==
X-Gm-Message-State: AOAM533Y040eQ5Xt7L3sr2k0nyvi6Nro6xeHc7Nk6zBMnzzB/qOqxNsP
        DrR9yfIxFPSkdDaDZqFO3YFDcCv7nUmdFW8lSu6CpOXghK4GD5xC/af/60/yO6CP9EpYJQbH+v3
        xOeA9xRmTSE6KDtJp6dpEYQ==
X-Received: by 2002:adf:ab49:: with SMTP id r9mr6556032wrc.237.1623343329061;
        Thu, 10 Jun 2021 09:42:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT8GKTcc6CtIM2Omfzfm3HSpY3IDEVA0VZ0HkqF8YvTQlmVrTL+SEqxKoSDnFCTA+GbV+zog==
X-Received: by 2002:adf:ab49:: with SMTP id r9mr6556002wrc.237.1623343328880;
        Thu, 10 Jun 2021 09:42:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id f13sm4050941wrt.86.2021.06.10.09.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 09:42:08 -0700 (PDT)
To:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-3-jingzhangos@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 2/4] KVM: stats: Add fd-based API to read binary stats
 data
Message-ID: <345170fd-636c-f1be-7dc3-69467e51d872@redhat.com>
Date:   Thu, 10 Jun 2021 18:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603211426.790093-3-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 03/06/21 23:14, Jing Zhang wrote:
> +struct _kvm_stats_header {
> +	__u32 name_size;
> +	__u32 count;
> +	__u32 desc_offset;
> +	__u32 data_offset;
> +};
> +

Keeping this struct in sync with kvm_stats_header is a bit messy.  If 
you move the id at the end of the header, however, you can use the same 
trick with the zero-sized array that you used for _kvm_stats_desc.

> +struct kvm_vm_stats_data {
> +	unsigned long value[0];
> +};
> +

I posted the patch to switch the VM statistics to 64-bit; you can rebase 
on top of it.

> +#define KVM_GET_STATS_FD  _IOR(KVMIO,  0xcc, struct kvm_stats_header)

This should be _IO(KVMIO, 0xcc) since it does not have an argument.

> +#define STATS_DESC(stat, type, unit, scale, exp)			       \
> +	{								       \
> +		{							       \
> +			.flags = type | unit | scale,			       \
> +			.exponent = exp,				       \
> +			.size = 1					       \
> +		},							       \
> +		.name = stat,						       \

Here you can use

	type | BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |
	unit | BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |
	scale | BUILD_BUG_ON_ZERO(scale & ~KVM_STATS_SCALE_MASK) |

to get a little bit of type checking.

Paolo

