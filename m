Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJ2Ji3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Oct 2020 05:38:29 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62F3C0613D5
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2020 02:38:27 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 32so1725419otm.3
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2020 02:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
 <20201029085749.GB25658@infradead.org> <CAKMK7uEV7sQ48w1Dd=WCY1r6LrY+aEq3ASnouOebQoo=Zr=CTQ@mail.gmail.com>
 <20201029092800.GA494@infradead.org>
In-Reply-To: <20201029092800.GA494@infradead.org>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 29 Oct 2020 10:38:16 +0100
Message-ID: <CAKMK7uG=R2372bVTK1Zh+P7uRd2QJSw5EgcJ6JJwVtNyJ7SJtQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] follow_pfn and other iomap races
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>

On Thu, Oct 29, 2020 at 10:28 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Oct 29, 2020 at 10:25:16AM +0100, Daniel Vetter wrote:
> > On Thu, Oct 29, 2020 at 9:57 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > Maybe I'm missing something, but shouldn't follow_pfn be unexported
> > > at the end of the series?
> >
> > kvm is a legit user and modular afaict. But since you can't use this
> > without an mmu_notifier anyway (or digging around in pagetable
> > locking), maybe it should be EXPORT_SYMBOL_GPL now at least?
>
> I think it should then take the notifier as an argument even if it isn't
> diretly used as a safety check, and get a new name describing it.

Hm so Jason and me discussed this, but e.g. the s390 is safe with with
just the pagetable locks. So we'd need two versions.

The more practical problem is that I haven't found a reasonable way to
check that a passed in mmu_notifier is registered against the mm we're
working on, and without that check it feels a bit silly. But if you
see how to do that I think we can do an EXPORT_SYMBOL_GPL follow_pfn
which takes the notifier, and an __follow_pfn for s390 and similar
internal code which isn't exported.

> EXPORT_SYMBOL_GPL is probably ok for now, but I'm drafting a new
> EXPORT_SYMBOL_FOR_MODULE() which will export symbols that can only be
> used by one specific module, with kvm being a prime user due to all
> the odd exports it requires that aren't really the kernel interface by
> any normal means.

Hm yeah that's another one. There's also some virt stuff that's
currently on unsafe_follow_pfn and needs to be switched over, and I
think that would also need an mmu notifier of some sorts to close the
gaps.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
