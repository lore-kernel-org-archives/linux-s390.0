From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 4/7] vfio: ap: register IOMMU VFIO notifier
Date: Thu, 28 Feb 2019 17:55:13 +0100
Message-ID: <20190228175513.06504ae6@oc2783563651>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-5-git-send-email-pmorel@linux.ibm.com>
        <d90f4746-887f-2d9c-df37-c834f22e85fd@de.ibm.com>
        <f13769d5-26a4-c1fa-0858-e4a1acef7bb9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f13769d5-26a4-c1fa-0858-e4a1acef7bb9@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 28 Feb 2019 09:48:39 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 28/02/2019 09:23, Christian Borntraeger wrote:
> > On 22.02.2019 16:29, Pierre Morel wrote:
> >> To be able to use the VFIO interface to facilitate the
> >> mediated device memory pining/unpining we need to register
> >> a notifier for IOMMU.
> > 
> > You might want to add that while we start to pin one guest page for the
> > interrupt indicator byte in the next patch, this is still ok with ballooning
> > as this page will never be used by the guest virtio-balloon driver. So the
> > pinned page will never be freed. And even a broken guest does so, that would
> > not impact the host as the original page is still in control by vfio.
> > 
> 
> Thanks, I ll do.
> 

I recall a comment in qemu that says vfio-ap does not pin any pages.
That one needs to be fixed up as well.

Regards,
Halil

[..]
