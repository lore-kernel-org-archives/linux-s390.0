Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgJ2KCC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Oct 2020 06:02:02 -0400
Date: Thu, 29 Oct 2020 10:01:57 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 00/15] follow_pfn and other iomap races
Message-ID: <20201029100157.GA10041@infradead.org>
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
 <20201029085749.GB25658@infradead.org>
 <CAKMK7uEV7sQ48w1Dd=WCY1r6LrY+aEq3ASnouOebQoo=Zr=CTQ@mail.gmail.com>
 <20201029092800.GA494@infradead.org>
 <CAKMK7uG=R2372bVTK1Zh+P7uRd2QJSw5EgcJ6JJwVtNyJ7SJtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uG=R2372bVTK1Zh+P7uRd2QJSw5EgcJ6JJwVtNyJ7SJtQ@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Christoph Hellwig <hch@infradead.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>

On Thu, Oct 29, 2020 at 10:38:16AM +0100, Daniel Vetter wrote:
> Hm so Jason and me discussed this, but e.g. the s390 is safe with with
> just the pagetable locks. So we'd need two versions.
> 
> The more practical problem is that I haven't found a reasonable way to
> check that a passed in mmu_notifier is registered against the mm we're
> working on, and without that check it feels a bit silly. But if you
> see how to do that I think we can do an EXPORT_SYMBOL_GPL follow_pfn
> which takes the notifier, and an __follow_pfn for s390 and similar
> internal code which isn't exported.

True, this is a bit of a mess.  So maybe just rename it to __follow_pfn,
proper documentation of the requirements and a switch to
EXPORT_SYMBOL_GPL.
