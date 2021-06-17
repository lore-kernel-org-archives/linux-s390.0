Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4BCC2B9F4
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 11:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ADE6613F1
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhFQLgd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232361AbhFQLgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Jun 2021 07:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623929664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFNQaz+UBr3+VeZ6q7OSgOqHodPl71Dh+9dEuoGcM+Q=;
        b=bIl12vf123u21HU9jyGn6RKDK3k1C4XqoMV0cmazh7VDTpNkcNutgg+bHH87SDOXy4AxLK
        6bMTE9pvv+xFEaxUN+pAVWjoLxBSkVmTPn640yxhbP4ypSnrcGr+JKg4dLjLql3LfaEfsT
        69YcM8CIzJ4F9aWhNId7kZVI0r59BD4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-AmpOwvHaMwydG8YWEmHqSQ-1; Thu, 17 Jun 2021 07:34:23 -0400
X-MC-Unique: AmpOwvHaMwydG8YWEmHqSQ-1
Received: by mail-ed1-f70.google.com with SMTP id g13-20020a056402090db02903935a4cb74fso1341202edz.1
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 04:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFNQaz+UBr3+VeZ6q7OSgOqHodPl71Dh+9dEuoGcM+Q=;
        b=U6dj63f3yi1hLP8ZjsVntPnMu/QV59FB38enNDy+tkzP44ryKrwhmReu9zkdeZIybe
         qBu9XLBtdUqUPSbsiZ4dPHjgHGQVKXL+khWyZC5UyCkYC7EWkfW8s/N2zUD1GRMVkhCY
         OSFOVfVXrIqM+BHlIc2y417Tc5PXo7VEEk02+3MZT4sz6E3f5i4NA+3hmqwJBNK54yDn
         7tHt57hjHgk2UwRZh9ulb2CQ/Z3xaIu84vCxasx6M9szyqkYU3inQFBOmcanTwu19eis
         7A8t0jUfcYEVFuaLHPRsBocCwon3YBBDoyWl2ldDBFAhFfaWpgAdQ7vCabHKfc17+s+x
         jXKw==
X-Gm-Message-State: AOAM5315Tp9K9Qefk+9vW5NkiIiqNEeyzV+s2JlAg0tse07c+K49SOct
        n4ugvwZDrKnkmFB/gSKG3h7MHkmRrgxvnBCQQWUFLreWrn5IuDpDFwntE3bk4FnDhh8kNnSyg5O
        dNo+R7WWCIkPLCknlOMInng==
X-Received: by 2002:a17:906:ca4a:: with SMTP id jx10mr4731025ejb.200.1623929246047;
        Thu, 17 Jun 2021 04:27:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw32CbI/7oXViDiR3/KwQ1e7FS2cEfJU4e5y3PkNkTiAFxV1nv9UNltBlc/li58ogeNN1nAkA==
X-Received: by 2002:a17:906:ca4a:: with SMTP id jx10mr4730994ejb.200.1623929245836;
        Thu, 17 Jun 2021 04:27:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s5sm4131010edi.93.2021.06.17.04.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 04:27:25 -0700 (PDT)
Subject: Re: [PATCH v10 2/5] KVM: stats: Add fd-based API to read binary stats
 data
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
 <20210617044146.2667540-3-jingzhangos@google.com>
 <YMr4rArKvj3obDEM@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9cc4df4-a502-31ec-0f5d-32a53c372f06@redhat.com>
Date:   Thu, 17 Jun 2021 13:27:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMr4rArKvj3obDEM@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/06/21 09:24, Greg KH wrote:
>> Provides a file descriptor per VM to read VM stats info/data.
>> Provides a file descriptor per vCPU to read vCPU stats info/data.
> Shouldn't this be two separate patches, one for each thing as these are
> two different features being added?

They share a lot of code.  We could have three patches though:

- add common code for binary statistics file descriptor

- add VM ioctl to retrieve a statistics file descriptor [including the 
definition of VM stats descriptors]

- add VCPU ioctl to retrieve a statistics file descriptor [again 
including the definitions of VCPU stats].

Paolo

