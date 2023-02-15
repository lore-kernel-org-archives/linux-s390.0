Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6B3C636D4
	for <linux-s390@archiver.kernel.org>; Wed, 15 Feb 2023 17:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBORgr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBORgq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Feb 2023 12:36:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4751C7F2
        for <linux-s390@vger.kernel.org>; Wed, 15 Feb 2023 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676482560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WO+XysgspF8DqSG5kDwuRcRoRdFcJUc3Wr5oeGuvwGQ=;
        b=QxHOXVWXLXBogvTYao/VRA4CuV6E5UoPla0A3ba0y7M5WaDbBI+3pr7HNt3ond5FqY5xbJ
        eB9UtuVdsNccwH/JSyyeE7/4cgPY2ZnSXsgEjuLoHmcAe4zpcmFJMNcxUvnRXQnhRiQ8IJ
        SxIPI/2vvwIYyDe4bbxRFytZzrza9QY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-m45DwTwMMI69tCPAM6MT3A-1; Wed, 15 Feb 2023 12:35:59 -0500
X-MC-Unique: m45DwTwMMI69tCPAM6MT3A-1
Received: by mail-vs1-f69.google.com with SMTP id o19-20020a67e153000000b0041221fdc3cfso2695855vsl.21
        for <linux-s390@vger.kernel.org>; Wed, 15 Feb 2023 09:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WO+XysgspF8DqSG5kDwuRcRoRdFcJUc3Wr5oeGuvwGQ=;
        b=Vf9wl3b8vyzJJIZMAAnzlgGb2+SWYFkV01RVeHkialOpAaLVTsqRDmfvUEs38EU2ri
         qQ9Cz8QcBQvmN6FaTISygxHvqeK+75skI5s3wGdjwVtyBnfKPZ75HyFdLiIiA0WRhNq7
         vIBWOuJgiiGOUsjxox1Weovnpd9yEGpGjmd3bz0UNSrmIiB9A15jIAykHnjIEh5b7hHp
         KkEow3LC35/5kK8WjfnqO+HjLd7CpiINzIO/8x+YL/4Ylwf/XMXsmoUnJ30IOSOGwd9I
         3GS/mCyur2yfkYnj6AxfAOhXVnef27lDKe+zlvm13Td6k2SLsEsQ2twVCnsuGpA5kwiK
         gMTw==
X-Gm-Message-State: AO0yUKVrz9WKIDzWEiU/OtNehaPPfxuRrJ0fIDmshkIFM4C83J9dHXqN
        aghsDPT+Lg+9b7vafID4dqWkKfuDmKtVWceSb48F5abg7aPz9EIg9IIsu07aKjXJuWZSqIrqUvs
        T1Gd9RbaLMQP4NYUVDX9IU84NwlGQCTLVqGDGlg==
X-Received: by 2002:a05:6102:5c17:b0:412:c97:4ac8 with SMTP id ds23-20020a0561025c1700b004120c974ac8mr502134vsb.53.1676482556703;
        Wed, 15 Feb 2023 09:35:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8L0sjCkHm2xvfBfZvyQXKAczVR+gQk4t1ZdDhxtXnBjH9xoR9zAR7+Oh0qJAyco9BvrbRFrWse2QE/MMpxhPA=
X-Received: by 2002:a05:6102:5c17:b0:412:c97:4ac8 with SMTP id
 ds23-20020a0561025c1700b004120c974ac8mr502125vsb.53.1676482556440; Wed, 15
 Feb 2023 09:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20230209102300.12254-1-frankja@linux.ibm.com>
In-Reply-To: <20230209102300.12254-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 15 Feb 2023 18:35:45 +0100
Message-ID: <CABgObfbj2GGHxHefb9jdXar3YKMYJxBjJBwzTXhntUQE-xjBNA@mail.gmail.com>
Subject: Re: [GIT PULL 00/18] KVM: s390x: KVM s390x changes for 6.3
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 9, 2023 at 11:25 AM Janosch Frank <frankja@linux.ibm.com> wrote:
>
> Hi Paolo,
>
> the following changes are ready for pulling for 6.3:
> * Two more V!=R patches
> * The last part of the cmpxchg patches
> * A few fixes
>
> This pull includes the s390 cmpxchg_user_key feature branch which is
> the base for the KVM cmpxchg patches by Janis.

Pulled, thanks,

Paolo

> Cheers,
> Janosch
>
> The following changes since commit a2ce98d69fabc7d3758063366fe830f682610cf7:
>
>   Merge remote-tracking branch 'l390-korg/cmpxchg_user_key' into kvm-next (2023-02-07 18:04:23 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-6.3-1
>
> for you to fetch changes up to 5fc5b94a273655128159186c87662105db8afeb5:
>
>   s390/virtio: sort out physical vs virtual pointers usage (2023-02-08 09:59:46 +0100)
>
> ----------------------------------------------------------------
>
> Alexander Gordeev (1):
>   s390/virtio: sort out physical vs virtual pointers usage
>
> Janis Schoetterl-Glausch (14):
>   KVM: s390: selftest: memop: Pass mop_desc via pointer
>   KVM: s390: selftest: memop: Replace macros by functions
>   KVM: s390: selftest: memop: Move testlist into main
>   KVM: s390: selftest: memop: Add bad address test
>   KVM: s390: selftest: memop: Fix typo
>   KVM: s390: selftest: memop: Fix wrong address being used in test
>   KVM: s390: selftest: memop: Fix integer literal
>   KVM: s390: Move common code of mem_op functions into function
>   KVM: s390: Dispatch to implementing function at top level of vm mem_op
>   KVM: s390: Refactor absolute vm mem_op function
>   KVM: s390: Refactor vcpu mem_op function
>   KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
>   Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
>   KVM: s390: selftest: memop: Add cmpxchg tests
>
> Nico Boehr (2):
>   KVM: s390: disable migration mode when dirty tracking is disabled
>   KVM: s390: GISA: sort out physical vs virtual pointers usage
>
> Nina Schoetterl-Glausch (1):
>   KVM: selftests: Compile s390 tests with -march=z10
>
>  Documentation/virt/kvm/api.rst            |  46 +-
>  Documentation/virt/kvm/devices/vm.rst     |   4 +
>  arch/s390/kvm/gaccess.c                   | 109 ++++
>  arch/s390/kvm/gaccess.h                   |   3 +
>  arch/s390/kvm/interrupt.c                 |  11 +-
>  arch/s390/kvm/kvm-s390.c                  | 268 +++++----
>  drivers/s390/virtio/virtio_ccw.c          |  46 +-
>  include/uapi/linux/kvm.h                  |   8 +
>  tools/testing/selftests/kvm/Makefile      |   3 +
>  tools/testing/selftests/kvm/s390x/memop.c | 676 +++++++++++++++++-----
>  10 files changed, 889 insertions(+), 285 deletions(-)
>
> --
> 2.39.1
>

