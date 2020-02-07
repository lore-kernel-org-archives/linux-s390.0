Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726417AbgBGJMd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 04:12:33 -0500
Date: Fri, 7 Feb 2020 10:12:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 0/9] s390x/vfio-ccw: Channel Path Handling
Message-ID: <20200207101220.2d057f18.cohuck@redhat.com>
In-Reply-To: <20200206213825.11444-1-farman@linux.ibm.com>
References: <20200206213825.11444-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Feb 2020 22:38:16 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> Here is a new pass at the channel-path handling code for vfio-ccw.
> This was initially developed by Farhan Ali this past summer, and
> picked up by me.  For my own benefit/sanity, I made a small changelog
> in the commit message for each patch, describing the changes I've
> made to his original code beyond just rebasing to master, rather than
> a giant list appended here.
> 
> I had been encountering a host crash which I think was triggered by
> this code rather than existing within it.  I'd sent a potential fix
> for that separately, but need more diagnosis.  So while that is
> outstanding, I think I've gotten most (but probably not all) comments
> from v1 addressed within.
> 
> With this, and the corresponding QEMU series (to be posted momentarily),
> applied I am able to configure off/on a CHPID (for example, by issuing
> "chchp -c 0/1 xx" on the host), and the guest is able to see both the
> events and reflect the updated path masks in its structures.
> 
> For reasons that are hopefully obvious, issuing chchp within the guest
> only works for the logical vary.  Configuring it off/on does not work,
> which I think is fine.

Before I delve into this: While the basic architecture here (and in the
QEMU part) is still similar, you changed things like handling multiple
CRWs? That's at least the impression I got from a very high-level skim.

> 
> v1: https://lore.kernel.org/kvm/20191115025620.19593-1-farman@linux.ibm.com/
> 
> Eric Farman (4):
>   vfio-ccw: Refactor the unregister of the async regions
>   vfio-ccw: Refactor IRQ handlers
>   vfio-ccw: Add trace for CRW event
>   vfio-ccw: Remove inline get_schid() routine
> 
> Farhan Ali (5):
>   vfio-ccw: Introduce new helper functions to free/destroy regions
>   vfio-ccw: Register a chp_event callback for vfio-ccw
>   vfio-ccw: Introduce a new schib region
>   vfio-ccw: Introduce a new CRW region
>   vfio-ccw: Wire up the CRW irq and CRW region
> 
>  Documentation/s390/vfio-ccw.rst     |  31 ++++-
>  drivers/s390/cio/Makefile           |   2 +-
>  drivers/s390/cio/vfio_ccw_chp.c     | 136 ++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 186 ++++++++++++++++++++++++++--
>  drivers/s390/cio/vfio_ccw_fsm.c     |   8 +-
>  drivers/s390/cio/vfio_ccw_ops.c     |  65 +++++++---
>  drivers/s390/cio/vfio_ccw_private.h |  16 +++
>  drivers/s390/cio/vfio_ccw_trace.c   |   1 +
>  drivers/s390/cio/vfio_ccw_trace.h   |  30 +++++
>  include/uapi/linux/vfio.h           |   3 +
>  include/uapi/linux/vfio_ccw.h       |  19 +++
>  11 files changed, 463 insertions(+), 34 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_chp.c
> 
