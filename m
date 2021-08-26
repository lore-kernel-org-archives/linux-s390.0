Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A3BC432BE
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 22:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F97E608FE
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 22:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbhHZWVs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243745AbhHZWVs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Aug 2021 18:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630016460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zroasAaaMl84Lp8cGgnsSX6CLhufn7UDcF8dOmcgMyE=;
        b=YdRLh6guW6G6sWIq2r8GthCqfIHBiX+odev1aQ3iY9+0+WMF+GCd7GTZMKk2+j9kn0rLM6
        ui3+hkCu56q5aM/nVbSL/ZJ+Ww6l+5Z1zfJXZeSjOtWEEP7qitxXFjRCZw38bK/E5IMBjW
        zV0aignqsRSIuueChZXXeFbSS69+Aes=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183--UkMc3WQOlOg2RaJBs07sw-1; Thu, 26 Aug 2021 18:20:58 -0400
X-MC-Unique: -UkMc3WQOlOg2RaJBs07sw-1
Received: by mail-oi1-f198.google.com with SMTP id 20-20020aca2814000000b002690d9b60aaso2327644oix.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Aug 2021 15:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zroasAaaMl84Lp8cGgnsSX6CLhufn7UDcF8dOmcgMyE=;
        b=Q7xsEqwyQQ80sfoWCWDvBZybQVavorUQQqMr3SsnYse4cbr6xbY8KFfS/M2td7Pei9
         68cVfuxuLS7wslrMuyTIUPmEAHCk/fih6qBZzKLM6O54wYtrhxEc6nGZWwKOHrSGdk2x
         HsAotQbVMvd508uyGU0ux1dV2nuf4nUJ0JspMcxFCeAyQwYjDQwJiqDDenN1p/felUe1
         WtqnKfoQeQUPLjG4uXkms7Opm7sAc7kMeDcLUKnIEQBo6ieouRMHl0PnKw0fMfCvkvrg
         XBExxRbv9MjYrvKpvz5gKv18+VgMwQb4/vYo56ElVi6Tt2Ez91E05jXTtobVef0FTWz0
         K0oA==
X-Gm-Message-State: AOAM5336uwu6cDLeyfHCl61OZ6nKY0yoAkLbLYRjVDdxZ0J5hP0K8WW6
        YAlZRsItUKAW6YPSi5WBZ98o0HvfgCiZX5Q3Dok0aZXn2w8WreoFbNuxemsw8pjkeSrJPnv6+x8
        JI6937wsiLqYIs792yVD7qw==
X-Received: by 2002:a05:6830:441f:: with SMTP id q31mr5265945otv.204.1630016457895;
        Thu, 26 Aug 2021 15:20:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8TozJtnLI8oHWvST2FybzAHXy1mHRyzcLBuZjcgJQTjoQcaruPsL3DLvGDsW5daknmMQbwg==
X-Received: by 2002:a05:6830:441f:: with SMTP id q31mr5265931otv.204.1630016457733;
        Thu, 26 Aug 2021 15:20:57 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u15sm862114oor.34.2021.08.26.15.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:20:57 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:20:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        kwankhede@nvidia.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2 0/2] s390/vfio-ap: do not open code locks for
Message-ID: <20210826162056.304eb7ca.alex.williamson@redhat.com>
In-Reply-To: <20210823212047.1476436-1-akrowiak@linux.ibm.com>
References: <20210823212047.1476436-1-akrowiak@linux.ibm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 23 Aug 2021 17:20:45 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The subject line does not necessarily encompass both patches of this
> two-patch series, but I left it as versions 1 and 2 used this subject
> line and I didn't want to confuse those who reviewed those patches.
> 
> Change log v1->v2:
> -----------------
> * Both of these patches were rebased on Alex's linux-vfio-next tree taken
>   from https://github.com/awilliam/linux-vfio.git.
>   
> * Replaced kvm_s390_module_hook structure with a function pointer to the
>   interception handler for the PQAP(AQIC) instruction.
> 
> Tony Krowiak (2):
>   s390/vfio-ap: r/w lock for PQAP interception handler function pointer
>   s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM
>     notification
> 
>  arch/s390/include/asm/kvm_host.h      |   8 +-
>  arch/s390/kvm/kvm-s390.c              |  32 ++++++-
>  arch/s390/kvm/priv.c                  |  15 +--
>  drivers/s390/crypto/vfio_ap_ops.c     | 127 +++++++++-----------------
>  drivers/s390/crypto/vfio_ap_private.h |   4 +-
>  5 files changed, 84 insertions(+), 102 deletions(-)

Applied to vfio next branch for v5.15.  Thanks,

Alex

