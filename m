Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52184 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725790AbgEKJhJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 May 2020 05:37:09 -0400
Received: by mail-wm1-f69.google.com with SMTP id h6so8052845wmi.7
        for <linux-s390@vger.kernel.org>; Mon, 11 May 2020 02:37:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
References: <20200504110344.17560-1-eesposit@redhat.com>
 <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
 <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <20c45f7b-3daa-c300-a8e7-0fd26664080b@redhat.com>
Date: Mon, 11 May 2020 11:37:01 +0200
MIME-Version: 1.0
In-Reply-To: <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Adams <jwadams@google.com>
Cc: kvm list <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, David Rientjes <rientjes@google.com>


On 5/8/20 11:44 AM, Paolo Bonzini wrote:
> So in general I'd say the sources/values model holds up.  We certainly
> want to:
> 
> - switch immediately to callbacks instead of the type constants (so that
> core statsfs code only does signed/unsigned)
> 
> - add a field to distinguish cumulative and floating properties (and use
> it to determine the default file mode)
> 
> - add a new argument to statsfs_create_source and statsfs_create_values
> that makes it not create directories and files respectively
> 
> - add a new API to look for a statsfs_value recursively in all the
> subordinate sources, and pass the source/value pair to a callback
> function; and reimplement recursive aggregation and clear in terms of
> this function.

Ok I will apply this, thank you for all the suggestions. 
I will post the v3 patchset in the next few weeks. 

In the meanwhile, I wrote the documentation you asked (even though it's 
going to change in v3), you can find it here:

https://github.com/esposem/linux/commit/dfa92f270f1aed73d5f3b7f12640b2a1635c711f

Thank you,
Emanuele
