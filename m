From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] vfio-ccw: update documentation
Date: Tue, 16 Jan 2018 17:28:18 +0100
Message-ID: <20180116172818.6f35a1c0.cohuck@redhat.com>
References: <20180115104353.27413-1-cohuck@redhat.com>
        <20180115104353.27413-2-cohuck@redhat.com>
        <5a99b7e2-3cce-c92d-f1d8-1469a334ff6d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5a99b7e2-3cce-c92d-f1d8-1469a334ff6d@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Jan 2018 17:17:08 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 01/15/2018 11:43 AM, Cornelia Huck wrote:
> > The vfio-ccw documentation comes from the cover letter of the
> > original patch submission, which shows in some parts. Give it some
> > love; in particular:
> > 
> > - Remove/rework statements that make sense in a cover letter, but not
> >   in regular documentation.
> > - Fix some typos.
> > - Describe the current limitations in more detail.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> The changes look sane and definitively improve on what we have
> right now. Acked by me if you like.

Can you please give your explicit A-b on v2?

> 
> When we are at the limitations, the prefetch story seems to be
> still missing. IMHO it's the most important limitation.

Yeah, that's just a start. I'm happy to take further patches :)
