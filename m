Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48526 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391022AbgE1OWw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 May 2020 10:22:52 -0400
Date: Thu, 28 May 2020 16:22:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 00/10] vfio-ccw patches for 5.8
Message-ID: <20200528162243.7ee3a352.cohuck@redhat.com>
In-Reply-To: <your-ad-here.call-01590669751-ext-3257@work.hours>
References: <20200525094115.222299-1-cohuck@redhat.com>
        <your-ad-here.call-01590669751-ext-3257@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 28 May 2020 14:42:31 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Mon, May 25, 2020 at 11:41:05AM +0200, Cornelia Huck wrote:
> > The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:
> > 
> >   Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw tags/vfio-ccw-20200525  
> 
> Hello Conny,
> 
> s390/features is based on v5.7-rc2 rather than on v5.7-rc3 as your
> tags/vfio-ccw-20200525. Are there any pre-requisites in between for
> vfio-ccw changes? It does cleanly rebase onto v5.7-rc2.

There shouldn't be anything.

> 
> Could you please rebase onto v5.7-rc2 or s390/features if that's possible?

Ugh. Isn't there any way to avoid doing that?
