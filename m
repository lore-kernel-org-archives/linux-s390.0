Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C2C2B9F4
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 13:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E11C61153
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 13:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhFNNi1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhFNNiY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Jun 2021 09:38:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6122C061767
        for <linux-s390@vger.kernel.org>; Mon, 14 Jun 2021 06:36:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id k8so3306006lja.4
        for <linux-s390@vger.kernel.org>; Mon, 14 Jun 2021 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eDKzbSZu1SwWJ0P86Rh5OM8P2vVwoJZM4q1bflykQ8=;
        b=R0CbDztlv0la7WD/fHY4DFjQzcsop/sh/PmzKnq/2thw9f3PUT2P3wOo+csesCUKls
         LS9qMnbXlXxKgcujagKu/oXpOxYpy2dxS7IHIP6s3wQi+HK7YPP3VHeVgYnLTuvxw2W8
         e9JmgplDrf0dXO+4lR9EtTG+25VcDjXtBgPbHQRB0R7jiHpwm4cLbzR7H4GApyDAID41
         6ySSLIw03/EDfbQ30EEFVf7PeSaHBB2ZEQMx2Bk0fP2scv+TBKF3DLaDOqTLw4lzoHFa
         wNkM22Y6pJCUDfCfDdm2C57VbEIz5RbUdG+Q4N+Wr+1C67rueWN6JzUgBH8Obhx2/D3l
         bWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eDKzbSZu1SwWJ0P86Rh5OM8P2vVwoJZM4q1bflykQ8=;
        b=e8OdiBQ55d0vgB8BXMyWcOPIz+HLhFZzFpIKbxNqCboTaY7I3d5wiEORGGazEKNDE6
         B4+1iD7zXdSYT0AFv0ZQ5SMbTO8cB810uNe0Bgm7yozlxur9qN2pbNxfrW8sieWzVr3H
         /kzeVnDXWlQWsqhOCNeV1k4itG2uF7JhWwtkyhqTu4EUmjO+utJxuvkUo+b7qbxPKjZr
         H4BItGgkMvUDcS7iMv/h0SEOy90SfQMShDXldmpFMPNLuE2SpDqW9jPkiP6NiYIVZBZY
         UAd5GWgdyFyVJhb3+2o0lz/x8xbf+PAFsxeLq7zC+OKee2hXdol3ZX9vAN2Wlf/NK+mT
         JeLQ==
X-Gm-Message-State: AOAM531mYDKN0XY2bmFmfRXpmuNgNNEQs7BnG9Vtm+2nM5rPzbMHuq11
        VMiQH+DCufzUfqPTfZuMqI0RjzRzql3DJAU3qdtG8g==
X-Google-Smtp-Source: ABdhPJyRerJorqPpaASqjE9boZ8l83RWNQm1Z5lsPnNwsXUo1I390oxKiUv+iF3/YpVooNiCx/RtKI8ne6I6YJoWEvk=
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr5867978ljp.216.1623677774828;
 Mon, 14 Jun 2021 06:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210614025351.365284-1-jingzhangos@google.com>
 <20210614025351.365284-3-jingzhangos@google.com> <1b57502b-116a-9be5-fa2f-1e8f5b5fce2d@redhat.com>
In-Reply-To: <1b57502b-116a-9be5-fa2f-1e8f5b5fce2d@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Mon, 14 Jun 2021 08:36:02 -0500
Message-ID: <CAAdAUtiG6Wt52Z3sKchBKR7-7qyeux6CfR1KFEnvi6nNoCRE_Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: stats: Use binary stats descriptors for debugfs interface
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Paolo,

On Mon, Jun 14, 2021 at 4:51 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/06/21 04:53, Jing Zhang wrote:
> > +     STATS_DESC_ICOUNTER_RONLY(VM, lpages),
> > +     STATS_DESC_ICOUNTER_RONLY(VM, nx_lpage_splits),
> >       STATS_DESC_ICOUNTER(VM, max_mmu_page_hash_collisions)
>
> I think we're now adding too many macros.
>
> max_mmu_page_hash_collisions is the only remaining instant counter that
> is not read-only.  In fact, in the statsfs prototype we made all instant
> counters read-only.
>
> You could add a third type in addition to instant and cumulative, let's
> call it "peak".  This essentially corresponds to the "max" aggregation
> function in the statsfs prototype.  Then instant counters would be read
> only, while cumulative and peak would be read-write.
>
> Paolo
>
Thanks for the suggestion. Will do that.
Jing
