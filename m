Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42152 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730347AbgGOJUa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jul 2020 05:20:30 -0400
Date: Wed, 15 Jul 2020 11:20:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v7 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200715112014.7a196261.cohuck@redhat.com>
In-Reply-To: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Wed, 15 Jul 2020 10:31:07 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Hi all,
> 
> The goal of the series is to give a chance to the architecture
> to validate VIRTIO device features.
> 
> in this respin:
> 
> 1) I kept removed the ack from Jason as I reworked the patch
>    @Jason, the nature and goal of the patch did not really changed
>            please can I get back your acked-by with these changes?
> 
> 2) Rewording for warning messages
> 
> Regards,
> Pierre
> 
> Pierre Morel (2):
>   virtio: let arch validate VIRTIO features
>   s390: virtio: PV needs VIRTIO I/O device protection
> 
>  arch/s390/mm/init.c           | 28 ++++++++++++++++++++++++++++
>  drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>  include/linux/virtio_config.h |  1 +
>  3 files changed, 48 insertions(+)
> 

LGTM.

I assume that this will go either via the virtio tree or via the s390
arch tree, i.e. not through virtio-ccw, right?
