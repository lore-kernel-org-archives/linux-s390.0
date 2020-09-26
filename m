Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729424AbgIZA4O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Sep 2020 20:56:14 -0400
Date: Sat, 26 Sep 2020 02:56:01 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: fix unregister GISC when KVM is already
 gone results in OOPS
Message-ID: <20200926025601.2ad52b77.pasic@linux.ibm.com>
In-Reply-To: <3795bc75-9d5e-2098-fd18-f1cbaef9c290@linux.ibm.com>
References: <20200918170234.5807-1-akrowiak@linux.ibm.com>
        <20200921174536.49e45e68.pasic@linux.ibm.com>
        <3795bc75-9d5e-2098-fd18-f1cbaef9c290@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pmorel@linux.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, kwankhede@nvidia.com, borntraeger@de.ibm.com

On Fri, 25 Sep 2020 18:29:16 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> 
> 
> On 9/21/20 11:45 AM, Halil Pasic wrote:
> > On Fri, 18 Sep 2020 13:02:34 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >
> >> Attempting to unregister Guest Interruption Subclass (GISC) when the
> >> link between the matrix mdev and KVM has been removed results in the
> >> following:
> >>
> >>     "Kernel panic -not syncing: Fatal exception: panic_on_oops"
> >>
> >> This patch fixes this bug by verifying the matrix mdev and KVM are still
> >> linked prior to unregistering the GISC.
> >
> > I read from your commit message that this happens when the link between
> > the KVM and the matrix mdev was established and then got severed.
> >
> > I assume the interrupts were previously enabled, and were not been
> > disabled or cleaned up because q->saved_isc != VFIO_AP_ISC_INVALID.
> >
> > That means the guest enabled  interrupts and then for whatever
> > reason got destroyed, and this happens on mdev cleanup.
> >
> > Does it happen all the time or is it some sort of a race?
> 
> This is a race condition that happens when a guest is terminated and the 
> mdev is
> removed in rapid succession. I came across it with one of my hades test 
> cases
> on cleanup of the resources after the test case completes. There is a 
> bug in the problem appears
> the vfio_ap_mdev_releasefunction because it tries to reset the APQNs 
> after the bits are
> cleared from the matrix_mdev.matrix, so the resets never happen.
> 

That sounds very strange. I couldn't find the place where we clear the
bits in matrix_mdev.matrix except for unassign. Currently the unassign
is supposed to be enabled only after we have no guest and we have
cleaned up the queues (which should restore VFIO_AP_ISC_INVALID). Does
your test do any unassign operations? (I'm not sure the we always do
like we are supposed to.)

Now if we did not clear the bits from matrix_mdev.matrix then this
could be an use after free scenario (where we interpret already
re-purposed memory as matrix_mdev.matrix).

> Fixing that, however, does not resolve the issue, so I'm in the process 
> of doing a bunch of
> tracing to see the flow of the resets etc. during the lifecycle of the 
> mdev during this
> hades test. I should have a better answer next week.
>

My take away is that we don't understand what exactly is going wrong, and
so this patch is at best a mitigation (not a real fix). Does that sound
about correct?

Regards,
Halil

[..]
