Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727410AbfH2RmH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 13:42:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7THWDIq093040
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2019 13:42:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upj1rk1em-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2019 13:42:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 29 Aug 2019 18:42:03 +0100
Date: Thu, 29 Aug 2019 19:41:58 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH RFC UNTESTED] vfio-ccw: indirect access to translated
 cps
In-Reply-To: <20190828143947.1c6b88e4.cohuck@redhat.com>
References: <20190726100617.19718-1-cohuck@redhat.com>
        <20190730174910.47930494.pasic@linux.ibm.com>
        <20190807132311.5238bc24.cohuck@redhat.com>
        <20190807160136.178e69de.pasic@linux.ibm.com>
        <20190808104306.2450bdcf.cohuck@redhat.com>
        <20190816003402.2a52b863.pasic@linux.ibm.com>
        <20190828143947.1c6b88e4.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190829194158.094879b8.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 28 Aug 2019 14:39:47 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> > > 
> > > So we do have three states here, right? (I hope we're not talking past
> > > each other again...)    
> > 
> > Right, AFAIR  and without any consideration to fine details the three
> > states and two state transitions do make sense.  
> 
> If we translate the three states to today's states in the fsm, we get:
> - "idle" -> VFIO_CCW_STATE_IDLE
> - "doing translation" -> VFIO_CCW_STATE_CP_PROCESSING
> - "submitted" -> VFIO_CCW_STATE_CP_PENDING
> and the transitions between the three already look fine to me (modulo
> locking). We also seem to handle async requests correctly (-EAGAIN if
> _PROCESSING, else just go ahead).
> 
> So we can probably forget about the approach in this patch, and
> concentrate on eliminating races in state transitions.

I agree.

> 
> Not sure what the best approach is for tackling these: intermediate
> transit state, a mutex or another lock, running locked and running
> stuff that cannot be done locked on workqueues (and wait for all work
> to finish while disallowing new work while doing the transition)?
> 
> Clever ideas wanted :)

AFAIR Eric has this problem on his TODO list. I think we can resume the
in depth discussion over his code :)

Regards,
Halil
