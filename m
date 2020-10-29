Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgJ2JZ2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Oct 2020 05:25:28 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9DEC0613D4
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2020 02:25:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n15so1664167otl.8
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2020 02:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch> <20201029085749.GB25658@infradead.org>
In-Reply-To: <20201029085749.GB25658@infradead.org>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 29 Oct 2020 10:25:16 +0100
Message-ID: <CAKMK7uEV7sQ48w1Dd=WCY1r6LrY+aEq3ASnouOebQoo=Zr=CTQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] follow_pfn and other iomap races
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>

On Thu, Oct 29, 2020 at 9:57 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Maybe I'm missing something, but shouldn't follow_pfn be unexported
> at the end of the series?

kvm is a legit user and modular afaict. But since you can't use this
without an mmu_notifier anyway (or digging around in pagetable
locking), maybe it should be EXPORT_SYMBOL_GPL now at least?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
