Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgJFPY5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Oct 2020 11:24:57 -0400
Date: Tue, 6 Oct 2020 17:24:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/5] s390/pci: track whether util_str is valid in the
 zpci_dev
Message-ID: <20201006172444.1c07ee02.cohuck@redhat.com>
In-Reply-To: <1601668844-5798-3-git-send-email-mjrosato@linux.ibm.com>
References: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
        <1601668844-5798-3-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri,  2 Oct 2020 16:00:41 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> We'll need to keep track of whether or not the byte string in util_str is
> valid and thus needs to be passed to a vfio-pci passthrough device.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/pci.h | 3 ++-
>  arch/s390/pci/pci_clp.c     | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

FWIW:

Acked-by: Cornelia Huck <cohuck@redhat.com>
