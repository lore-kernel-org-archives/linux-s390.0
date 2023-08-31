Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C28C83F35
	for <linux-s390@archiver.kernel.org>; Thu, 31 Aug 2023 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbjHaRYC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbjHaRX7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 31 Aug 2023 13:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5BC193
        for <linux-s390@vger.kernel.org>; Thu, 31 Aug 2023 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693502583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEsmay9dgABHBR9HT3CdLYltgWp0I5dORZyQ5/U0Avo=;
        b=ODEdRwbnDeQkaowQou5QxS5Kf/oVetjz3/QE74AtUggXvNQbpHxyYVVN97UD4PPQVyATHw
        oMypt3DrO1VujF1gnLBkIFso7jf2m5W5URvexuP4wkfwuKj9iMxKsUYZYfAya9S6i5/jFX
        3jp3hMh0mOCtnaYHyE9GYqofe8Zt17Y=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-5btWSUKXOvGWMOY5JkGtOw-1; Thu, 31 Aug 2023 13:23:02 -0400
X-MC-Unique: 5btWSUKXOvGWMOY5JkGtOw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-44d62a76b01so442948137.3
        for <linux-s390@vger.kernel.org>; Thu, 31 Aug 2023 10:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502581; x=1694107381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEsmay9dgABHBR9HT3CdLYltgWp0I5dORZyQ5/U0Avo=;
        b=VNusSLaNzYoSuMf4flDq3ot3mQjMKpB8j0OUhO8psobvNGayMsQArM5z82UA6AhjQK
         CFWTu3JZ9mgaBvD8jEvssX8h53VlQ1/r/OHtWXASy9Tq5nRDRb0kjl/X2OqNO1h6gz1s
         s2QYYdvUbVPwddN4LtkHp4nH++9XD7HDZlW5kwsvTtCtSavfDczb2GTziAtl2v8vSE+F
         hnGts+XE6swvCxLGcV9eqXDf2IK03aG0MJVcY043sMfHve6j1kFq/2WXwD+5H6YHjTaU
         0RuuEWOojadPyZNFHA8ldRXMWzfxqZjg9yMZmHn11E+fTBskR3/p9kMqDBR7DVgWrFlT
         +udQ==
X-Gm-Message-State: AOJu0YyRNbqYNhRKTvqcWqXU1BTJO4XieFSZs9RI5NTM0nqe2iUVSlBM
        SVKBJpjVJjf6O3D12zjwEIrfMerb40bLzQdnsveAxA0xsd8Ga/i+6q7CQEdS0DKmx+YSBL2x9WN
        pEIy1S4p2In/nDuR3Mp03OQudN2LuDhLspc/Vf7dNbAZV7w==
X-Received: by 2002:a05:6102:2859:b0:44e:9f69:fa52 with SMTP id az25-20020a056102285900b0044e9f69fa52mr193359vsb.22.1693502581421;
        Thu, 31 Aug 2023 10:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESPNx6zoSzzRswH3gh65uInXbLtYRyP+R9aYRpIgmSsEMGvazhzz0RNlop91a0LsBX6L+kSr90tGcEDFiZvdw=
X-Received: by 2002:a05:6102:2859:b0:44e:9f69:fa52 with SMTP id
 az25-20020a056102285900b0044e9f69fa52mr193336vsb.22.1693502581010; Thu, 31
 Aug 2023 10:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230829120843.66637-1-frankja@linux.ibm.com>
In-Reply-To: <20230829120843.66637-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 31 Aug 2023 19:22:49 +0200
Message-ID: <CABgObfZQjzJkYPiR8Gm80TnMq9=HojvyCkn7znY9-U6iLo5Baw@mail.gmail.com>
Subject: Re: [GIT PULL v2 00/10] KVM: s390: Changes for 6.6
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, mihajlov@linux.ibm.com,
        seiden@linux.ibm.com, akrowiak@linux.ibm.com, seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 29, 2023 at 2:10=E2=80=AFPM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
>
> Dear Paolo,
>
> let's try this again.
> Please pull the following changes for 6.6.
>
> Please note that Heiko and I both merged Heiko's vfio-ap feature
> branch. Linus has pulled Heiko's next branch already (e5b7ca09e9aa).
>
> I've also merged tags/kvm-x86-selftests-immutable-6.6 since we
> introduce a new selftest with the guest debug fixes. I had to fixup
> the selftest commit since a function name changed.

Pulled, thanks!

> In the long run we're considering putting vfio-ap patches into their
> own repository but for 6.6 we didn't find the time to speak with all
> affected maintainers.

If needed you can also use a separate branch that you branch both into
Heiko's s390/next branch and your kvm/next branch

Paolo

> Changes:
> - PV crypto passthrough enablement (Tony, Steffen, Viktor, Janosch)
>   Allows a PV guest to use crypto cards. Card access is governed by
>   the firmware and once a crypto queue is "bound" to a PV VM every
>   other entity (PV or not) looses access until it is not bound
>   anymore. Enablement is done via flags when creating the PV VM.
>
> - Guest debug fixes + test (Ilya)
>
> The following changes since commit ede6d0b2031e045f0a0e4515e4567828d87fd3=
ef:
>
>   Merge tag 'kvm-x86-selftests-immutable-6.6' into next (2023-08-28 09:23=
:36 +0000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.6-1
>
> for you to fetch changes up to 899e2206f46aece42d8194c350bc1de71344dbc7:
>
>   KVM: s390: pv: Allow AP-instructions for pv-guests (2023-08-28 09:27:56=
 +0000)
>
> ----------------------------------------------------------------
> - PV crypto passthrough enablement (Tony, Steffen, Viktor, Janosch)
>   Allows a PV guest to use crypto cards. Card access is governed by
>   the firmware and once a crypto queue is "bound" to a PV VM every
>   other entity (PV or not) looses access until it is not bound
>   anymore. Enablement is done via flags when creating the PV VM.
>
> - Guest debug fixes (Ilya)
> ----------------------------------------------------------------
>
> Ilya Leoshkevich (6):
>   KVM: s390: interrupt: Fix single-stepping into interrupt handlers
>   KVM: s390: interrupt: Fix single-stepping into program interrupt
>     handlers
>   KVM: s390: interrupt: Fix single-stepping kernel-emulated instructions
>   KVM: s390: interrupt: Fix single-stepping userspace-emulated
>     instructions
>   KVM: s390: interrupt: Fix single-stepping keyless mode exits
>   KVM: s390: selftests: Add selftest for single-stepping
>
> Steffen Eiden (3):
>   s390/uv: UV feature check utility
>   KVM: s390: Add UV feature negotiation
>   KVM: s390: pv: Allow AP-instructions for pv-guests
>
> Viktor Mihajlovski (1):
>   KVM: s390: pv: relax WARN_ONCE condition for destroy fast
>
> --
> 2.41.0
>

