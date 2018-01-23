From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 4/5] s390: define ISOLATE_BP to run tasks with modified
 branch prediction
Date: Tue, 23 Jan 2018 21:32:24 +0100
Message-ID: <20180123203223.GA648@flask>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
 <1516712825-2917-5-git-send-email-schwidefsky@de.ibm.com>
 <ac891f07-cd8d-83a6-0a16-cb99b69080e0@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ac891f07-cd8d-83a6-0a16-cb99b69080e0@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

2018-01-23 15:21+0100, Christian Borntraeger:
> Paolo, Radim,
> 
> this patch not only allows to isolate a userspace process, it also allows us
> to add a new interface for KVM that would allow us to isolate a KVM guest CPU
> to no longer being able to inject branches in any host or other  guests. (while
> at the same time QEMU and host kernel can run with full power). 
> We just have to set the TIF bit TIF_ISOLATE_BP_GUEST for the thread that runs a
> given CPU. This would certainly be an addon patch on top of this patch at a later
> point in time.

I think that the default should be secure, so userspace will be
breaking the isolation instead of setting it up and having just one
place to screw up would be better -- the prctl could decide which
isolation mode to pick.

Maybe we can change the conditions and break logical connection between
TIF_ISOLATE_BP and TIF_ISOLATE_BP_GUEST, to make a separate KVM
interface useful.

> Do you think something similar would be useful for other architectures as well?

It goes against my idea of virtualization, but there probably are users
that don't care about isolation and still use virtual machines ...
I expect most architectures to have a fairly similar resolution of
branch prediction leaks, so the idea should be easily abstractable on
all levels.  (At least x86 is.)

> In that case we should try to come up with a cross-architecture interface to enable
> that.

Makes me think of a generic VM control "prefer performance over
security", which would also take care of future problems and let arches
decide what is worth the code.

A main drawback is that this will introduce dynamic branches to the
code, which are going to slow down the common case to speed up a niche.
