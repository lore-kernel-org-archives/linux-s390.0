Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D8FECAAD2
	for <linux-s390@archiver.kernel.org>; Thu,  1 Sep 2022 22:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiIAWrM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiIAWrL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Sep 2022 18:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FFA6F547
        for <linux-s390@vger.kernel.org>; Thu,  1 Sep 2022 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662072430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zAeTJy5ubeDHnWShRqQvqVpSgwyCAkD2ph2sh9lD1WE=;
        b=GUfS1ue2IKtshQk8PfPjFGdlcV9Rr8aIE3LlHssh5iSpyY2mXiTKU+Bdoda5BjssH9FlBv
        LdDKDfqWN80xccBQSynAcO/tmUBij+tF9ItkMUbKzvFziGMjtSQRs2zlASYbTTAFqoICE0
        Gzrwkqoeo/HPVd3A6rPcywR3BCO3Afw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-BQIVtpqXM3yw82pFd63i_g-1; Thu, 01 Sep 2022 18:47:09 -0400
X-MC-Unique: BQIVtpqXM3yw82pFd63i_g-1
Received: by mail-ed1-f69.google.com with SMTP id m18-20020a056402511200b0044862412596so268416edd.3
        for <linux-s390@vger.kernel.org>; Thu, 01 Sep 2022 15:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zAeTJy5ubeDHnWShRqQvqVpSgwyCAkD2ph2sh9lD1WE=;
        b=EgI4eCnbtUmaDzjdb3fbfUhJeUt9XUEpIahu3EHa4CIt+ueLVPGMfX24YzhpT9uigq
         zkoUNBGRDYQCEBdA8ajOPTIL473oerolf9TPAd5VBEvDaV0M3P83fH4XKb0PN4QMn04f
         u8CUGsjSf4x0U48hOE5isbDA8ZJ/lc4C4AVVQaRIz6VWIky2F4130XXELc1Wp26ZtQ92
         Xz0uWg+0hlt3z8QtQrnOczVKja09KD9qnkW/1rIGu/X6HQQe4wkuJ7KRopz/fTI6kfn/
         GVLwptYGzqJDbA2Tcy32SRMJB+ZAtna7yFJW0seQVoDjjneAHIIleAJJvFMwEko0Le2u
         Tqag==
X-Gm-Message-State: ACgBeo2D/kmiu+Yj+EBnt4sTAkZ447FsUU6NZPECuzwvESJPrsBdG0Ee
        uqDv7XFGmL0Y8ZMIkM+OmB8jF0FwUZm5cRbFHoDTIUX/VFS06mofTQo3WTZ1wfRUqSkiKAkiQiv
        DH1MpiKcGy/N1cpfcHwiCzw==
X-Received: by 2002:a17:907:7252:b0:73f:c3e9:4197 with SMTP id ds18-20020a170907725200b0073fc3e94197mr21919940ejc.173.1662072427553;
        Thu, 01 Sep 2022 15:47:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Az1+wY7j+OKvmai1ferq1yhW9uB3SEtzY5xblvhoKYlAjraIcuSn27cPH+tLNPonVYS5MFA==
X-Received: by 2002:a17:907:7252:b0:73f:c3e9:4197 with SMTP id ds18-20020a170907725200b0073fc3e94197mr21919929ejc.173.1662072427347;
        Thu, 01 Sep 2022 15:47:07 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id t1-20020a1709066bc100b007303fe58eb2sm249653ejs.154.2022.09.01.15.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 15:47:06 -0700 (PDT)
Message-ID: <5084cacf-c84d-65fe-45c5-efe73c38f314@redhat.com>
Date:   Fri, 2 Sep 2022 00:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [GIT PULL 0/1] KVM: s390: VFIO PCI build fix
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, pmorel@linux.ibm.com
References: <20220830083250.25720-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220830083250.25720-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 8/30/22 10:32, Janosch Frank wrote:
> Paolo,
> 
> here's a lone fix for a KVM/VFIO build problem.
> 
> A few PV fixes are currently still in development but fixing those
> issues will be harder.
> 
> The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:
> 
>    Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-6.0-1

Pulled, thanks.

Paolo

> for you to fetch changes up to ca922fecda6caa5162409406dc3b663062d75089:
> 
>    KVM: s390: pci: Hook to access KVM lowlevel from VFIO (2022-08-29 13:29:28 +0200)
> 
> ----------------------------------------------------------------
> PCI interpretation compile fixes
> 
> ----------------------------------------------------------------
> 
> Pierre Morel (1):
>    KVM: s390: pci: Hook to access KVM lowlevel from VFIO
> 
>   arch/s390/include/asm/kvm_host.h | 17 ++++++-----------
>   arch/s390/kvm/pci.c              | 12 ++++++++----
>   arch/s390/pci/Makefile           |  2 +-
>   arch/s390/pci/pci_kvm_hook.c     | 11 +++++++++++
>   drivers/vfio/pci/vfio_pci_zdev.c |  8 ++++++--
>   5 files changed, 32 insertions(+), 18 deletions(-)
>   create mode 100644 arch/s390/pci/pci_kvm_hook.c
> 

