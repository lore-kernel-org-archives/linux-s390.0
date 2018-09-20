From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 20 Sep 2018 09:18:44 +0000
Subject: Re: [RFC PATCH 0/3] Use DIAG318 to set Control Program Name & Version Codes
Message-Id: <20180920111844.53cbaa65.cohuck@redhat.com>
In-Reply-To: <82ae7fbf-8b05-7da2-b294-64b945a47172@de.ibm.com>
References: <82ae7fbf-8b05-7da2-b294-64b945a47172@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 19 Sep 2018 13:09:34 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 09/19/2018 05:30 AM, Cornelia Huck wrote:
> > On Fri, 31 Aug 2018 12:51:16 -0400
> > Collin Walling <walling@linux.ibm.com> wrote:

> >> The CPC and HPID are used for problem diagnosis and allows IBM to identify 
> >> control program information by answering the following questions:
> >>
> >>     "What environment is this guest running in?" (CPNC)
> >>     "What distribution is this guest running?" (CPVC)
> >>     "What underlying host environment is this guest running on?" (HPID)  
> > 
> > Is there also a way for people-who-are-not-IBM to find out what these
> > values have been set to? :) (IOW, is that write-only from a Linux
> > perspective?)
> > 
> > I see that for the emulated instruction the values are logged into the
> > debug feature, which seems useful.
> >   
> 
> Maybe it would help to include a toString-esque macro for these values. Then
> when the HPID and CPNC get logged we will have something us humans can read? :)
> 
> The distro_id will have to be deciphered via the registry file. Thoughts?

It's probably fine if this has to be decoded outside of the kernel.

One thing that came to my mind: Would it be useful to be able to
introspect a live guest from the hypervisor? For example, being able to
get the CPNC/CPVC from a QEMU monitor command? (The debug feature may
wrap around so that the info can get lost, I guess?)
