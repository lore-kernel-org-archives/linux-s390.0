Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ2J2D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Oct 2020 05:28:03 -0400
Date: Thu, 29 Oct 2020 09:28:00 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 00/15] follow_pfn and other iomap races
Message-ID: <20201029092800.GA494@infradead.org>
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
 <20201029085749.GB25658@infradead.org>
 <CAKMK7uEV7sQ48w1Dd=WCY1r6LrY+aEq3ASnouOebQoo=Zr=CTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEV7sQ48w1Dd=WCY1r6LrY+aEq3ASnouOebQoo=Zr=CTQ@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Christoph Hellwig <hch@infradead.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>

On Thu, Oct 29, 2020 at 10:25:16AM +0100, Daniel Vetter wrote:
> On Thu, Oct 29, 2020 at 9:57 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Maybe I'm missing something, but shouldn't follow_pfn be unexported
> > at the end of the series?
> 
> kvm is a legit user and modular afaict. But since you can't use this
> without an mmu_notifier anyway (or digging around in pagetable
> locking), maybe it should be EXPORT_SYMBOL_GPL now at least?

I think it should then take the notifier as an argument even if it isn't
diretly used as a safety check, and get a new name describing it.

EXPORT_SYMBOL_GPL is probably ok for now, but I'm drafting a new
EXPORT_SYMBOL_FOR_MODULE() which will export symbols that can only be
used by one specific module, with kvm being a prime user due to all
the odd exports it requires that aren't really the kernel interface by
any normal means.
