Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbgHMHyj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 03:54:39 -0400
Subject: Re: [PATCH v2] PCI: Introduce flag for detached virtual functions
References: <1597260071-2219-1-git-send-email-mjrosato@linux.ibm.com>
 <1597260071-2219-2-git-send-email-mjrosato@linux.ibm.com>
 <20200812143254.2f080c38@x1.home>
 <CAOSf1CFh4ygZeeqpjpbWFWxJJEpDjHD+Q_L4dUaU_3wx7_35pg@mail.gmail.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <19bb6ca8-f6bb-841c-e4dd-cd9e8e6e430f@linux.ibm.com>
Date: Thu, 13 Aug 2020 09:54:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAOSf1CFh4ygZeeqpjpbWFWxJJEpDjHD+Q_L4dUaU_3wx7_35pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Oliver O'Halloran <oohall@gmail.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, pmorel@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, linux-s390@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>



On 8/13/20 3:59 AM, Oliver O'Halloran wrote:
> On Thu, Aug 13, 2020 at 6:33 AM Alex Williamson
> <alex.williamson@redhat.com> wrote:
>>
>> On Wed, 12 Aug 2020 15:21:11 -0400
>> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>
... snip ...
>>
>> Is there too much implicit knowledge in defining a "detached VF"?  For
>> example, why do we know that we can skip the portion of
>> vfio_config_init() that copies the vendor and device IDs from the
>> struct pci_dev into the virtual config space?  It's true on s390x, but
>> I think that's because we know that firmware emulates those registers
>> for us.
>>
>> We also skip the INTx pin register sanity checking.  Do we do
>> that because we haven't installed the broken device into an s390x
>> system?  Because we know firmware manages that for us too?  Or simply
>> because s390x doesn't support INTx anyway, and therefore it's another
>> architecture implicit decision?
> 
> Agreed. Any hacks we put in for normal VFs are going to be needed for
> the passed-though VF case. Only applying the memory space enable
> workaround doesn't make sense to me either.

We did actually have the detached_vf check in that if in
a previous patch version, turning on the INTx and quirk checks.
We decided to send a minimal version for the discussion.
That said I agree that this is currently too specific to our
case.

> 
>> If detached_vf is really equivalent to is_virtfn for all cases that
>> don't care about referencing physfn on the pci_dev, then we should
>> probably have a macro to that effect.

In my opinion it really is, that's why we initially tried to just
set pdev->is_virtfn leaving the physfn pointer NULL for these
detached VFs. 
But as you said that gets uncomfortable because of the union and existing code
assuming that pdev->is_virtfn always means physfn is set.

I think the underlying problem here is, that the current use
of pdev->is_virtfn conflates the two reasons we need to know whether
something is a VF:

1. For dealing with the differences in how a VF presents itself vs a PF
2. For knowing whether the physfn/sriov union is a pointer to the parent PF

If we could untangle this in a sane way I think that would
be the best long term solution.

> 
> A pci_is_virtfn() helper would be better than open coding both checks
> everywhere. That said, it might be solving the wrong problem. The
> union between ->physfn and ->sriov has always seemed like a footgun to
> me so we might be better off switching the users who want a physfn to
> a helper instead. i.e.
> 
> struct pci_dev *pci_get_vf_physfn(struct pci_dev *vf)
> {
>         if (!vf->is_virtfn)
>                 return NULL;
> 
>         return vf->physfn;
> }

Hmm, this is almost exactly  include/linux/pci.h:pci_physfn()
except that returns the argument pdev itself when is_virtfn
is not set.

> 
> ...
> 
> pf = pci_get_vf_physfn(vf)
> if (pf)
>     /* do pf things */
> 
> Then we can just use ->is_virtfn for the normal and detached cases.

I'm asssuming you mean by setting vf->is_virtfn = 1; vf->physfn = NULL
for the detached case? I think that actually also works with the existing
pci_physfn() helper but it requires handling a returned NULL at
all callsites.

> 
> Oliver
> 
