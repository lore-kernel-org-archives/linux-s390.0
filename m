Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059CEC48BE6
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1BB61289
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 09:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhFNJzb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 05:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232701AbhFNJza (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Jun 2021 05:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623664407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kx9Q3nsVnRINu0vIrWoo9nXjPPqt9AsqYqJM+8URyI=;
        b=DmD/zzSyyUI6UUPShMbzTxNeTo/xOFNgRuLH8zvd5h0q5W3o9M/ziOX1UUGjGGaVMZ9WoP
        mcGiC1AiHS2I1M558nxIrQ4oQGaB9g2+2zTL58I/xRc3avbhZVbBrTqAXkuF9jWouL478/
        QU4KNwQ6Fyz3piVQwMfvIiZkExrV7so=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-HL8hQm6rMSSc6UIS-dygnQ-1; Mon, 14 Jun 2021 05:53:26 -0400
X-MC-Unique: HL8hQm6rMSSc6UIS-dygnQ-1
Received: by mail-ed1-f70.google.com with SMTP id g13-20020a056402090db02903935a4cb74fso14169333edz.1
        for <linux-s390@vger.kernel.org>; Mon, 14 Jun 2021 02:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4kx9Q3nsVnRINu0vIrWoo9nXjPPqt9AsqYqJM+8URyI=;
        b=ajvTHAss1yOxK4Cc2QbqC+Fvo12Igl84obcD6pKPw8WTALPu4th4rWN03a5oHTRrOj
         e1LzChjjaeZfEhWFNHUJKN8nKrK6ZBJA6topkPxh4kKKZWkOaZZ4z+OoanZjajuiSnh8
         4trkwbS7i6z/LZEhABT/rtP8sqWq8gK5e5TqA3HVkKyS8OxQZImjmJOzpctxT78gmAcy
         4A/8Y3YcG/VJmekvmfOBlSI3Pw/0i9zB8bOuKlYPEdl1dG3B36cEtXPgB9d5DpI5/zeh
         8VrguhQTV5k4r4meiJBTr+xeDZbmQk4qUY/LeFFmbJCEiq3VkKOrmGp4ogRp1TJHcXa4
         +W0w==
X-Gm-Message-State: AOAM530VVsMJDoUZKNyIjG0+hO/15MzzfDaUnAUomKZ2FKWv7bcB9CCM
        Lr+zDcrT0ejIvXz5u93qSL91tvHpCONS9W/JLeRbqFH5xFksGtMoj8jsL2QH+Y6wIOUAHVlrWGA
        vJruvtjXRXssyAPr41MDHow==
X-Received: by 2002:aa7:dd1a:: with SMTP id i26mr16204808edv.358.1623664405039;
        Mon, 14 Jun 2021 02:53:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDkQ0JPU1g5M6jhW9DnavBLG6plfx7uGDLrqTbEtcjhKBQcyMeEBajFaPx2nWsm5OdUYvaJg==
X-Received: by 2002:aa7:dd1a:: with SMTP id i26mr16204789edv.358.1623664404859;
        Mon, 14 Jun 2021 02:53:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p10sm8486235edy.86.2021.06.14.02.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 02:53:24 -0700 (PDT)
Subject: Re: [PATCH 0/4] Remove duplicated stats definitions for debugfs
To:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Fuad Tabba <tabba@google.com>
References: <20210614025351.365284-1-jingzhangos@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc48637c-e683-a64a-b744-bd5fe2037f31@redhat.com>
Date:   Mon, 14 Jun 2021 11:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614025351.365284-1-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/06/21 04:53, Jing Zhang wrote:
> This is a follow-up patchset to binary stats interface patchset as below:
> https://lore.kernel.org/kvm/20210611124624.1404010-1-jingzhangos@google.com
> 
> This patchset contains a commit to fix some missing stats and add static
> check to make sure we have the right number of stats descriptors and add an
> 'offset' field in stats descriptor to make sure the or order of stats
> descriptors is not relevant to the order of stats in vm/vcpu stats
> structure. This will totally avoid the possibility of missing stats and
> mismatched stats definitions.
> 
> The binary stats interface defines stats in another array of descriptors,
> while the original stats debugfs interface uses array of kvm_stats_debugfs
> item. To remove the duplicated stats definition, this patchset would
> utilize only the stats descriptors to provide stats information to debugfs
> interface. This patchset adds a 'mode' flag to support the read/write mode
> of stats, which can be used to indicate the file permission of debugfs
> stats files. It removes the usage of kvm_stats_debugfs_item and all the
> debugfs_entries defined in all archs.
> 
> The patch also fixes an issue that read only stats could be cleared in
> global level, though not permitted in VM level in the original debugfs
> code.

Thanks for putting this together quickly.  I think we can drop the mode, 
see the suggestion in patch 2.

It's probably best to fold the v8 for the stats functionality, these 
patches (squashed appropriately) and Fuad's remars in a single posting. 
  But I'm quite confident that it can make it in 5.14.

Paolo

