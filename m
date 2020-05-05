Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730608AbgEERCn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 13:02:43 -0400
Received: by mail-wr1-f72.google.com with SMTP id g7so1515123wrw.18
        for <linux-s390@vger.kernel.org>; Tue, 05 May 2020 10:02:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
References: <20200504110344.17560-1-eesposit@redhat.com>
 <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
 <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
 <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
Date: Tue, 5 May 2020 19:02:34 +0200
MIME-Version: 1.0
In-Reply-To: <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jim Mattson <jmattson@google.com>, Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: David Rientjes <rientjes@google.com>, Jonathan Adams <jwadams@google.com>, kvm list <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>

On 05/05/20 18:53, Jim Mattson wrote:
>>> Since this is becoming a generic API (good!!), maybe we can discuss
>>> possible ways to optimize gathering of stats in mass?
>> Sure, the idea of a binary format was considered from the beginning in
>> [1], and it can be done either together with the current filesystem, or
>> as a replacement via different mount options.
> 
> ASCII stats are not scalable. A binary format is definitely the way to go.

I am totally in favor of having a binary format, but it should be
introduced as a separate series on top of this one---and preferably by
someone who has already put some thought into the problem (which
Emanuele and I have not, beyond ensuring that the statsfs concept and
API is flexible enough).

ASCII stats are necessary for quick userspace consumption and for
backwards compatibility with KVM debugfs (which is not an ABI, but it's
damn useful and should not be dropped without providing something as
handy), so this is what this series starts from.

Paolo
