Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200504110344.17560-1-eesposit@redhat.com> <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
 <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
In-Reply-To: <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 5 May 2020 09:53:53 -0700
Message-ID: <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: David Rientjes <rientjes@google.com>, Jonathan Adams <jwadams@google.com>, kvm list <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>

On Tue, May 5, 2020 at 2:18 AM Emanuele Giuseppe Esposito
<eesposit@redhat.com> wrote:
>
>
>
> On 5/4/20 11:37 PM, David Rientjes wrote:
> > Since this is becoming a generic API (good!!), maybe we can discuss
> > possible ways to optimize gathering of stats in mass?
>
> Sure, the idea of a binary format was considered from the beginning in
> [1], and it can be done either together with the current filesystem, or
> as a replacement via different mount options.

ASCII stats are not scalable. A binary format is definitely the way to go.
