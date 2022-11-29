Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A36C46467
	for <linux-s390@archiver.kernel.org>; Tue, 29 Nov 2022 15:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiK2PP0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 29 Nov 2022 10:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiK2PPV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Nov 2022 10:15:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC5A2D77D
        for <linux-s390@vger.kernel.org>; Tue, 29 Nov 2022 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669734862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IeJbxQq4oKJJKxEz1iOkWhtpWVLyX6vpshVx4+Idd6k=;
        b=JGE9DcvjwAsdNIc06qB5YmTAAtbeHSNQPqFM3mX9BKVdvdgZSZTScd09mdrbJj8psddbRI
        FJpLTYQE1xzZBJQJEklg6kS6fc3Uzk8iCVXcExyt1tFWE98+pVbHuIcvhVEtzWHFq8YxkH
        TdxLp7SMA2eX9gqe6Trz1i9cUf/dc1A=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-lRBSxpb7PWW9_cwT887EZw-1; Tue, 29 Nov 2022 10:14:21 -0500
X-MC-Unique: lRBSxpb7PWW9_cwT887EZw-1
Received: by mail-vs1-f69.google.com with SMTP id 7-20020a670407000000b003b09b19d078so3008406vse.22
        for <linux-s390@vger.kernel.org>; Tue, 29 Nov 2022 07:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeJbxQq4oKJJKxEz1iOkWhtpWVLyX6vpshVx4+Idd6k=;
        b=fbM9ozBb4LrOOrH4mLpz4TwpgazstLMYSvWPyrEw7qJGyZ9xgxq/N58X25bWm/e7s7
         ImiEMjTRWLyUtYZnBoZlecUx/N7zg5uB3kEBkudzONg44+v8afZ6Yx0aEB1I1AwvjUzn
         cIkhoGrLjgi0T+V/RHOb9CQt7LsKEze8GHFLat8+UhiBR0ZttOMx9Ml5pkcJE+PClpq4
         qKetP5VmwDr/XMs6Ryf5sD7a+IJF978ya3moaj2MpKFoKf1AqLcrTfQaxLW5AZ08AY/D
         6FMUu+HaqLgQrJWDefYJ+p7J1dd3GiKssqD4hCC+SMSezSqsOhvbGUBuylImBwKHxAw2
         0Elw==
X-Gm-Message-State: ANoB5pn72IhD5DpM98uQaZJ6pAbjZYhfa+hkQpEIGYBAf7RDbyPvrQmG
        /3q+TgW5RjP2/1LTjMvVMcDc/4lqSgYSso8Fdho6tyDOL1p5WrsEKf6fkvuzafQiLivem7smZDE
        5Lzen6OfbU1/V7TExcg1KcejJNfLcNtZzBrRqjA==
X-Received: by 2002:a05:6102:3fa1:b0:3a6:aae4:cab6 with SMTP id o33-20020a0561023fa100b003a6aae4cab6mr31965900vsv.27.1669734860673;
        Tue, 29 Nov 2022 07:14:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Eq4ktzAz6wk4yJ1feDHHcUBL7TWADnI4bM+SjL3EJOIZBy0IOhTulfF9sPIFDHQRStgSwqLNwSr+QFsdvzMU=
X-Received: by 2002:a05:6102:3fa1:b0:3a6:aae4:cab6 with SMTP id
 o33-20020a0561023fa100b003a6aae4cab6mr31965877vsv.27.1669734860366; Tue, 29
 Nov 2022 07:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20221125085454.16673-1-frankja@linux.ibm.com>
In-Reply-To: <20221125085454.16673-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 29 Nov 2022 16:14:07 +0100
Message-ID: <CABgObfb5oGOmaN8MOVrgXHeQfa-80dQnY2mCan2RA-ZnGXbrDA@mail.gmail.com>
Subject: Re: [GIT PULL 0/1] s390 fixes for 6.1-rc7/8
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Nov 25, 2022 at 9:55 AM Janosch Frank <frankja@linux.ibm.com> wrote:
>
> Dear Paolo,
>
> please pull Thomas' fix for VSIE.
> We deem it to be low risk and it survived a day in our CI without any errors.
> It's a bit late so let's see if it makes 6.1 or 6.2.
>
>
> The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:
>
>   Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-6.1-2
>
> for you to fetch changes up to 0dd4cdccdab3d74bd86b868768a7dca216bcce7e:
>
>   KVM: s390: vsie: Fix the initialization of the epoch extension (epdx) field (2022-11-24 14:43:17 +0100)

Pulled, thanks.

Paolo

>
> ----------------------------------------------------------------
> VSIE epdx shadowing fix
>
> ----------------------------------------------------------------
> Thomas Huth (1):
>       KVM: s390: vsie: Fix the initialization of the epoch extension (epdx) field
>
>  arch/s390/kvm/vsie.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Thomas Huth (1):
>   KVM: s390: vsie: Fix the initialization of the epoch extension (epdx)
>     field
>
>  arch/s390/kvm/vsie.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --
> 2.38.1
>

