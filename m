Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8CC2B9F4
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 11:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A649760FF0
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 11:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhFQL0F (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232499AbhFQL0F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Jun 2021 07:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623929037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeoOEjtdTbZHikE6qVHZkIHtsqJ8oL1MWdn59al3yJU=;
        b=CuIVKsJuOBZk1oDFBwUwUDX/AaPsvGHmj4f2orBAewlRc07tZ1usRVEBu6/7YCXW48gVA/
        grOo0YspbVYnOaPc8tSp4LJtxvZtFknEGU9b5hUDVN6HyDrcUHUYalSYvHfvNaQEyQ76hY
        /MbMcgUPe1BYRa+8TCWFrmJRTbuh98Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-q5V7AW5PPVirgd5CdhlBng-1; Thu, 17 Jun 2021 07:23:56 -0400
X-MC-Unique: q5V7AW5PPVirgd5CdhlBng-1
Received: by mail-ed1-f72.google.com with SMTP id ch5-20020a0564021bc5b029039389929f28so1290919edb.16
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 04:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QeoOEjtdTbZHikE6qVHZkIHtsqJ8oL1MWdn59al3yJU=;
        b=tmwTIALn0uyldbLdifxhKOJV3hvPOkXU5uhzhWDkZI1s9ZvqMTG7kZTWX5N0ePshO/
         JfltM1qvPVwnCyHFhowqDughXoAnKWLm+IOSdJ3A28uBRiZiWQXMp15ptPpugYn0YWDF
         nH5sM0Zisi/F77VKO0B/j7QNzdvGZ30kfeXBiARM4esL+B+jucE5FQmIK9MaQrooe2Ir
         gy+SP1GTVRvlZxNJXf22MY1PtHmciRjMAMwRTbbZA23dImRG0V+GMoeDnAlPC4jpe0aj
         wOZ7uNmept3mv71C5XQ3tJCRbRt3UoiZ8x0Q86WFojeWzroSmjvX0UoP7v3V5TixiCUe
         xJ5w==
X-Gm-Message-State: AOAM5318UoAgUWHrky933oev2NmiuoMxJ/q1eJn6qI9c28huFLBjpLTl
        LuoKQzinLjcR0CFSH5TQaug2oKq8hLeFfViwMChg0bOQt8pGJSEDP8y0f+B1xjFc8CWZy8i5/nL
        6IRecaK5Vd4ibx6IBuQU3ig==
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr5799071edd.228.1623928793194;
        Thu, 17 Jun 2021 04:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc8lc8kbfFsQbKsVnuEADgPqEmYVAvmC/1IvjtxjrXOO4gKYpFUgt0NPkDolV15GoZuo9rTg==
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr5799027edd.228.1623928793011;
        Thu, 17 Jun 2021 04:19:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e18sm3537900ejh.64.2021.06.17.04.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 04:19:52 -0700 (PDT)
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com>
 <YMrmqOxDWJ2/8sfD@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be506135-5bc3-31bd-1b20-063f01f41df1@redhat.com>
Date:   Thu, 17 Jun 2021 13:19:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMrmqOxDWJ2/8sfD@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/06/21 08:07, Greg KH wrote:
>> The statistics data itself could be read out by userspace telemetry
>> periodically without any extra parsing or setup effort.
> Do you have a pointer to userspace code that can do such a thing that
> others can use?  We do not like adding apis to the kernel without at
> least seeing the user of those apis, especially for complex things like
> this.
> 
> Ideally you would include some library code in the kernel tree itself
> that everyone can use for this for their own programs.  You have
> provided a test which is great, but how do we know it works for "real"
> usages?

I am pretty sure that Google is using this internally, but we are also 
going to work on QEMU and Libvirt support for this.

As for the rest, thanks for the review---I'll let Jing act on it and 
only add my own remarks in a couple places.

Paolo

