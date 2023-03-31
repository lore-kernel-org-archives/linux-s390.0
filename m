Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01214C76196
	for <linux-s390@archiver.kernel.org>; Fri, 31 Mar 2023 15:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjCaPQG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjCaPQF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Mar 2023 11:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41C14209
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680275717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jReYaRvaeLpOpGhoWxZkfcictVQRNAgQCVGzZlNYJVk=;
        b=fby76XgF198gf10cGHkjoxSWhFlSUQtvhxwr0WmrDnvbwCE3FVjEq7P9YJkhraOIeEqEfU
        IpDW/NBr+S4PpF9YKo/iE07rqlEIGwl3INfYuiVB01DSEHp61dtdO45ybDfevJcRtK/nPY
        QkVBrlnEAy2HQX9PN+tDbrEH5EVj+20=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-lvbSIeITOh2ETgs2k-yTwA-1; Fri, 31 Mar 2023 11:15:15 -0400
X-MC-Unique: lvbSIeITOh2ETgs2k-yTwA-1
Received: by mail-vs1-f72.google.com with SMTP id p27-20020a05610223fb00b00425b0a40455so7200660vsc.8
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 08:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680275713; x=1682867713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jReYaRvaeLpOpGhoWxZkfcictVQRNAgQCVGzZlNYJVk=;
        b=2hyZSinTY21L8XXaQaA3yopFI6Ff5WGK1HOz77vfmz8U7ZhcogIjV6/laafW25q5x6
         BlH/fNxA9HuBR45BprCzf9u8QiXT337PfTeRJHB/21S2CcJUm7ygN+ZcOc6jhlJO+M7D
         /41CE2rniAQQ7v+7DX1ukS8TnqqXNm4QZ4dk5QOA6/tM4eUmt9VeFuwoQahSCAGP+ELU
         VpppqlvJgn3EI+s+9XmwRsge11ly74ZH/MZ7ApTQMZk24NoCERmVjVCsjUq6Rd+umZML
         Y8OPJ0cY3jJ5u9BWDQ7SEJ4zk5q8zIP8aArA8SDfsHdRJkTGZTgls+kFFmJp6I/PngYv
         NvfQ==
X-Gm-Message-State: AAQBX9fD7XbpQiq/Iy+3uCXv/AlFuxiJ7mLX5WpgU5R86pb6ZlGcMLNw
        iyEQJMftqnqzARUn+caOz5V5d9F/l1ZLTqUw+Ueh8j6cd0KiW6/xIpX2yl+NSNvcZ2f0oLmvgrN
        BCKsCqFoR0y5pUncQFpbJmvkgckMDgK4/wy3OBA==
X-Received: by 2002:a67:cc1b:0:b0:412:4e02:ba9f with SMTP id q27-20020a67cc1b000000b004124e02ba9fmr14336237vsl.1.1680275713562;
        Fri, 31 Mar 2023 08:15:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350bnlCOJmQOLM6/M2bAAW0kF15+DEKJBLkDXCC/WvhP7MCxMgiyX7jFmq4Pg6eh841W2LJ3aSzVsc5nh2XEXVVg=
X-Received: by 2002:a67:cc1b:0:b0:412:4e02:ba9f with SMTP id
 q27-20020a67cc1b000000b004124e02ba9fmr14336228vsl.1.1680275713266; Fri, 31
 Mar 2023 08:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230329135129.77385-1-frankja@linux.ibm.com>
In-Reply-To: <20230329135129.77385-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 31 Mar 2023 17:15:02 +0200
Message-ID: <CABgObfYTkZsHS9xfqO32LMcH9=mZepb6QY2=B_Fn+UwEe-6EWQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/1] kvm/s390: Fixes for 6.3
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Pulled, thanks.

Paolo

On Wed, Mar 29, 2023 at 3:52=E2=80=AFPM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
>
> Dear Paolo,
>
> currently we only have one fix patch to offer which repairs the
> external loop detection code for PV guests.
>
> Please pull,
> Janosch
>
> The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292=
aa:
>
>   Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-6.3-1
>
> for you to fetch changes up to 21f27df854008b86349a203bf97fef79bb11f53e:
>
>   KVM: s390: pv: fix external interruption loop not always detected (2023=
-03-28 07:16:37 +0000)
>
> Nico Boehr (1):
>       KVM: s390: pv: fix external interruption loop not always detected
>
>  arch/s390/kvm/intercept.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> --
> 2.39.2
>

