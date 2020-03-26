Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56695 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbgCZGtF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Mar 2020 02:49:05 -0400
Date: Thu, 26 Mar 2020 07:47:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 2/9] vfio-ccw: Register a chp_event callback for
 vfio-ccw
Message-ID: <20200326074759.5808c945.cohuck@redhat.com>
In-Reply-To: <302a0650-99b0-22ef-b95d-cecdeb0f9f04@linux.ibm.com>
References: <20200206213825.11444-1-farman@linux.ibm.com>
        <20200206213825.11444-3-farman@linux.ibm.com>
        <20200214131147.0a98dd7d.cohuck@redhat.com>
        <459a60d1-699d-2f16-bb59-23f11b817b81@linux.ibm.com>
        <20200324165854.3d862d5b.cohuck@redhat.com>
        <302a0650-99b0-22ef-b95d-cecdeb0f9f04@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 25 Mar 2020 22:09:40 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 3/24/20 11:58 AM, Cornelia Huck wrote:
> > On Fri, 14 Feb 2020 11:35:21 -0500
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> On 2/14/20 7:11 AM, Cornelia Huck wrote:  
> >>> On Thu,  6 Feb 2020 22:38:18 +0100
> >>> Eric Farman <farman@linux.ibm.com> wrote:  

> >>>> +	case CHP_ONLINE:
> >>>> +		/* Path became available */
> >>>> +		sch->lpm |= mask & sch->opm;    
> >>>
> >>> If I'm not mistaken, this patch introduces the first usage of sch->opm
> >>> in the vfio-ccw code.     
> >>
> >> Correct.
> >>  
> >>> Are we missing something?    
> >>
> >> Maybe?  :)
> >>  
> >>> Or am I missing
> >>> something? :)
> >>>     
> >>
> >> Since it's only used in this code, for acting as a step between
> >> vary/config off/on, maybe this only needs to be dealing with the lpm
> >> field itself?  
> > 
> > Ok, I went over this again and also looked at what the standard I/O
> > subchannel driver does, and I think this is fine, as the lpm basically
> > factors in the opm already. (Will need to keep this in mind for the
> > following patches.)  
> 
> Just to make sure I don't misunderstand, when you say "I think this is
> fine" ... Do you mean keeping the opm field within vfio-ccw, as this
> patch does?  Or removing it, and only adjusting the lpm within vfio-ccw,
> as I suggested in my response just above?

I meant the code change done in this patch: We update the lpm whenever
the opm is changed, and use the lpm. I'd like to keep the opm separate,
just so that we are clear where each value comes from.
