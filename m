Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60094C4332F
	for <linux-s390@archiver.kernel.org>; Tue, 31 Oct 2023 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjJaOLk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Oct 2023 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjJaOLj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 31 Oct 2023 10:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C41F11C
        for <linux-s390@vger.kernel.org>; Tue, 31 Oct 2023 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698761451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+29grXFJZojFwHG1sZMUj8N4tYbCAXJFoBUSIxQKeyY=;
        b=eD6TW17FcLteN7LBHLH1xMpKnoD53DS/htYT0H9fVG8P4rMsDrM3KmW73UhD8KT5ZEDPSG
        TngtDt4u11xuTtXdrFcJWm5+RJSLi1R2y6v/pJYCtSTJEk3deIS2k20ue4HdN6I5+iu2r1
        RVOUpE+UdZCgh+MEmmr29m+FRVoo+kA=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Ql-fGae4N8KlEg7lDsNZyg-1; Tue, 31 Oct 2023 10:10:50 -0400
X-MC-Unique: Ql-fGae4N8KlEg7lDsNZyg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so7494776fac.0
        for <linux-s390@vger.kernel.org>; Tue, 31 Oct 2023 07:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761449; x=1699366249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+29grXFJZojFwHG1sZMUj8N4tYbCAXJFoBUSIxQKeyY=;
        b=AWad49itRntBTcSvLvBvLmcl6eT4WZ+YboaqT4f+vhE9WMRq7Nc7oWdr3GAUezP3xm
         oNoduOgk2APcyHVF5znbf1eVno0fx3yIyM7mj86BZK91gds5ocAqWrIkIEKuRuevoT4w
         2efbWumBKotkOxJDGp8qmQfd+RxxW5XJvF2/0ICq/nrEnRLkBqAeJzr8J2efOdgERopT
         NziE54ktpGECCdLG6WiW9RcPL9YPjnYwW9pFjeR8gSGYP04YQ/3QheWHt7/mxFa9+oxl
         Ltekkxu9rAwxDJyd/tHMhAyXJ+vdQe3KGlXvAgQuc372++a1KfBPbrE4La+ubGM/EhC3
         3xTw==
X-Gm-Message-State: AOJu0Yy76ZgrFMjyI/qoj4N76LsbU4khS2ksUFNVO5te72AWafknOqFJ
        Ap7/t6GxlCeGPMzPhDGbLMUuLJ+6/yr7nhPhJkayH3PY3wBEFt8JSUJCBGP0z93yr7kZLZHTc42
        0n457dIE9Bc4o7f9REQtg0PkYLVMLhdXgdTILHRlHN5Yx3A==
X-Received: by 2002:a05:6871:23c7:b0:1e9:edd1:2176 with SMTP id xy7-20020a05687123c700b001e9edd12176mr12825501oab.33.1698761449245;
        Tue, 31 Oct 2023 07:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkDNkghapOOyIO7MlIs094HOLFT5jnQNcb86xPe9HYK72gpMCPOxpT4qdgb2CzpsWn5KZbftCAGayTULfQu1w=
X-Received: by 2002:a05:6871:23c7:b0:1e9:edd1:2176 with SMTP id
 xy7-20020a05687123c700b001e9edd12176mr12825480oab.33.1698761448978; Tue, 31
 Oct 2023 07:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231030092101.66014-1-frankja@linux.ibm.com>
In-Reply-To: <20231030092101.66014-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 31 Oct 2023 15:10:37 +0100
Message-ID: <CABgObfZtmcbdtWRFmhEuZuKBMf-AgNG_25g9GHZ0o3ZPnthtZA@mail.gmail.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: Changes for 6.7
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org, nrb@linux.ibm.com,
        imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 30, 2023 at 10:22=E2=80=AFAM Janosch Frank <frankja@linux.ibm.c=
om> wrote:
>
> Paolo, please pull these two patches for 6.7.
>
> They introduce counters and a tracepoint into our nested VM page table
> management code. Debuging nested page table management is notoriously
> hard but the added low-overhead debug data will allow us to get a feel
> for the problem before deploying deeper and higher overhead debugging
> means.
>
> I've held back the patches for a bit since we had suspicious CI fails
> but they turned out to be unrelated and have been fixed at the end of
> last week.

Pulled, thanks.

Paolo

>
>
> The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b=
70:
>
>   Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.7-1
>
> for you to fetch changes up to 70fea30195168fd84e7076720c984f0ac1af5b09:
>
>   KVM: s390: add tracepoint in gmap notifier (2023-10-16 14:54:29 +0200)
>
> Nico Boehr (2):
>   KVM: s390: add stat counter for shadow gmap events
>   KVM: s390: add tracepoint in gmap notifier
>
>  arch/s390/include/asm/kvm_host.h |  7 +++++++
>  arch/s390/kvm/gaccess.c          |  7 +++++++
>  arch/s390/kvm/kvm-s390.c         | 11 ++++++++++-
>  arch/s390/kvm/trace-s390.h       | 23 +++++++++++++++++++++++
>  arch/s390/kvm/vsie.c             |  5 ++++-
>  5 files changed, 51 insertions(+), 2 deletions(-)
>
> --
> 2.41.0
>

