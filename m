Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729248AbgEERHc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 13:07:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E311C061A10
        for <linux-s390@vger.kernel.org>; Tue,  5 May 2020 10:07:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so1175533pfa.1
        for <linux-s390@vger.kernel.org>; Tue, 05 May 2020 10:07:32 -0700 (PDT)
Date: Tue, 5 May 2020 10:07:29 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
In-Reply-To: <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2005051003380.216575@chino.kir.corp.google.com>
References: <20200504110344.17560-1-eesposit@redhat.com> <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com> <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com> <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
 <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, Emanuele Giuseppe Esposito <eesposit@redhat.com>, Jonathan Adams <jwadams@google.com>, kvm list <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>

On Tue, 5 May 2020, Paolo Bonzini wrote:

> >>> Since this is becoming a generic API (good!!), maybe we can discuss
> >>> possible ways to optimize gathering of stats in mass?
> >> Sure, the idea of a binary format was considered from the beginning in
> >> [1], and it can be done either together with the current filesystem, or
> >> as a replacement via different mount options.
> > 
> > ASCII stats are not scalable. A binary format is definitely the way to go.
> 
> I am totally in favor of having a binary format, but it should be
> introduced as a separate series on top of this one---and preferably by
> someone who has already put some thought into the problem (which
> Emanuele and I have not, beyond ensuring that the statsfs concept and
> API is flexible enough).
> 

The concern is that once this series is merged then /sys/kernel/stats 
could be considered an ABI and there would be a reasonable expectation 
that it will remain stable, in so far as the stats that userspace is 
interested in are stable and not obsoleted.

So is this a suggestion that the binary format becomes complementary to 
statsfs and provide a means for getting all stats from a single subsystem, 
or that this series gets converted to such a format before it is merged?

> ASCII stats are necessary for quick userspace consumption and for
> backwards compatibility with KVM debugfs (which is not an ABI, but it's
> damn useful and should not be dropped without providing something as
> handy), so this is what this series starts from.
> 
