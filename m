Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725915AbgEFN7X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 09:59:23 -0400
Date: Wed, 6 May 2020 15:59:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 0/8] s390x/vfio-ccw: Channel Path Handling [KVM]
Message-ID: <20200506155912.478a2ac5.cohuck@redhat.com>
In-Reply-To: <14c3cf68-c1e5-b46f-d75e-955dbdd63df8@linux.ibm.com>
References: <20200505122745.53208-1-farman@linux.ibm.com>
        <20200505145435.40113d4c.cohuck@redhat.com>
        <14c3cf68-c1e5-b46f-d75e-955dbdd63df8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Tue, 5 May 2020 09:00:20 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/5/20 8:56 AM, Cornelia Huck wrote:
> > On Tue,  5 May 2020 14:27:37 +0200
> > Eric Farman <farman@linux.ibm.com> wrote:

> >>  
> >>> One thing though that keeps coming up: do we need any kind of
> >>> serialization? Can there be any confusion from concurrent reads from
> >>> userspace, or are we sure that we always provide consistent data?    
> >>
> >> I _think_ this is in good shape, though as suggested another set of
> >> eyeballs would be nice. There is still a problem on the main
> >> interrupt/FSM path, which I'm not attempting to address here.  
> > 
> > I'll try to think about it some more.  

I've convinced myself that the patches do not add any new races on top
of what already might be lurking in the existing code.

> 
> Re: interrupt/FSM, I now have two separate patches that each straighten
> things out on their own.  And a handful of debug patches that probably
> only make things worse.  :)  I'll get one/both of those meaningful
> patches sent to the list so we can have that discussion separately from
> this code.

Yes, let's do that on top.

I think that the series looks good now, but I'd still like to see
someone else give it a quick look before I queue it.
