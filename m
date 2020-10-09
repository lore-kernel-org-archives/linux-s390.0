Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733101AbgJIJiS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 05:38:18 -0400
Date: Fri, 9 Oct 2020 11:38:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 3/5] vfio: Introduce capability definitions for
 VFIO_DEVICE_GET_INFO
Message-ID: <20201009113804.6ccc9738.cohuck@redhat.com>
In-Reply-To: <1602096984-13703-4-git-send-email-mjrosato@linux.ibm.com>
References: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
        <1602096984-13703-4-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed,  7 Oct 2020 14:56:22 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Allow the VFIO_DEVICE_GET_INFO ioctl to include a capability chain.
> Add a flag indicating capability chain support, and introduce the
> definitions for the first set of capabilities which are specified to
> s390 zPCI devices.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  include/uapi/linux/vfio.h      | 11 ++++++
>  include/uapi/linux/vfio_zdev.h | 78 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>  create mode 100644 include/uapi/linux/vfio_zdev.h

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
