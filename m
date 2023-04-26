Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54704C7618E
	for <linux-s390@archiver.kernel.org>; Wed, 26 Apr 2023 19:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjDZTo5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZTo4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Apr 2023 15:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75261FD3
        for <linux-s390@vger.kernel.org>; Wed, 26 Apr 2023 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682538248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CU69wKejwOMDppClKDYq19yj03ls8og4z5qIG2uSb9U=;
        b=fetVXsnYx3Rxy9se00coikCqncEmBoegzHgQxAFaRadDB2On0gv2BGDbHIODrtNMFIzhpn
        VZXR8O3p724z+AEs2aefCzTh2FW4FMFmbyP6YDjQ4PyL6VEpbkDxgSYjA0TYsKLvuU7XzW
        7OxbuODTHExfrUY08dyAujn2KOnPWO4=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-TiC0p8COMvSLZnWlhSZIkA-1; Wed, 26 Apr 2023 15:44:06 -0400
X-MC-Unique: TiC0p8COMvSLZnWlhSZIkA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-42e5b08ec92so1667310137.3
        for <linux-s390@vger.kernel.org>; Wed, 26 Apr 2023 12:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682538246; x=1685130246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CU69wKejwOMDppClKDYq19yj03ls8og4z5qIG2uSb9U=;
        b=ktalGZgJ/kMu6Js6zo2A/uxMPYaDI/BMer4ZJZznTEu8dfSdMO+4rSkglL9ErmEGk2
         WxyzwyG58/hj+h3M1FznYxHGu5MUAdtU4lDvtG2TNpEXZTldSIN7yCUK1R+ID0yZF6Cs
         xBJUN1IQY6xyNjgIqLVvvBmkmtDUXeR8re5Da4+Bx+IdJavT39y26aKzMboTJASJVF7+
         +fTPhzpqbtU7plyLrue0YbyipMA8JOg+I66g2mSjraWTwNY8rgbRfkOHCA3uy/rItz07
         9SYRiuNKGvnywPiiRPriz4658VT3x86SWxnfB39i+govwKr5xv0iQP73MQRYm1/L/M57
         V6hA==
X-Gm-Message-State: AAQBX9cqXodY3wkuDymdMuaEdAuAsz1BqRRc0THIuaxfGSDyxMPLFnyq
        id6ZjtjtnWMJH5zijmorl7yIKbU88ytTFBRp4Upttg974wKWE/ho5yZIMPMn1+cldydymy4b1tS
        bL6EsMOQeGplO/uDuM1c4KRU6GN9RtoF/xk9UsQ==
X-Received: by 2002:a67:be05:0:b0:42c:7f68:3da7 with SMTP id x5-20020a67be05000000b0042c7f683da7mr9325914vsq.29.1682538245821;
        Wed, 26 Apr 2023 12:44:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ae1/wLvvTOZSRM+56KhIlSssMem8ehV3S5SNvr/HasjBRhzN4Pe2L1ULwRDoVgD8Q5vL+j9uS4oWY2eP5C2gQ=
X-Received: by 2002:a67:be05:0:b0:42c:7f68:3da7 with SMTP id
 x5-20020a67be05000000b0042c7f683da7mr9325908vsq.29.1682538245428; Wed, 26 Apr
 2023 12:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230426125119.11472-1-frankja@linux.ibm.com>
In-Reply-To: <20230426125119.11472-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 26 Apr 2023 21:43:54 +0200
Message-ID: <CABgObfaD4hGe0atddjW5s5A0ejB7ujHu1V9sJdEC3dt3=T+-8Q@mail.gmail.com>
Subject: Re: [GIT PULL 0/3] KVM: s390: Changes for 6.4
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Apr 26, 2023 at 2:52=E2=80=AFPM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
>
> Hi Paolo,
>
> nothing major for today, two patches that continue our phys_to_virt()
> conversion efforts and a patch that increases readability.
>
> Please pull,
> Janosch

Queued, thanks.

Paolo

> The following changes since commit eeac8ede17557680855031c6f305ece2378af3=
26:
>
>   Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.4-1
>
> for you to fetch changes up to 8a46df7cd135fe576c18efa418cd1549e51f2732:
>
>   KVM: s390: pci: fix virtual-physical confusion on module unload/load (2=
023-04-20 16:30:35 +0200)
>
> ----------------------------------------------------------------
> Minor cleanup:
>  - phys_to_virt conversion
>  - Improvement of VSIE AP management
>
> ----------------------------------------------------------------
> Nico Boehr (2):
>       KVM: s390: interrupt: fix virtual-physical confusion for next alert=
 GISA
>       KVM: s390: pci: fix virtual-physical confusion on module unload/loa=
d
>
> Pierre Morel (1):
>       KVM: s390: vsie: clarifications on setting the APCB
>
>  arch/s390/kvm/interrupt.c |  4 ++--
>  arch/s390/kvm/pci.c       |  2 +-
>  arch/s390/kvm/vsie.c      | 50 +++++++++++++++++++++++++++--------------=
------
>  3 files changed, 32 insertions(+), 24 deletions(-)
>
>
> Nico Boehr (2):
>   KVM: s390: interrupt: fix virtual-physical confusion for next alert
>     GISA
>   KVM: s390: pci: fix virtual-physical confusion on module unload/load
>
> Pierre Morel (1):
>   KVM: s390: vsie: clarifications on setting the APCB
>
>  arch/s390/kvm/interrupt.c |  4 ++--
>  arch/s390/kvm/pci.c       |  2 +-
>  arch/s390/kvm/vsie.c      | 50 +++++++++++++++++++++++----------------
>  3 files changed, 32 insertions(+), 24 deletions(-)
>
> --
> 2.40.0
>

