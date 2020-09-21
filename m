Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726456AbgIUPCO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Sep 2020 11:02:14 -0400
Date: Mon, 21 Sep 2020 17:01:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/4] s390/pci: stash version in the zpci_dev
Message-ID: <20200921170158.1080d872.cohuck@redhat.com>
In-Reply-To: <1600529318-8996-2-git-send-email-mjrosato@linux.ibm.com>
References: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
        <1600529318-8996-2-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 19 Sep 2020 11:28:35 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> In preparation for passing the info on to vfio-pci devices, stash the
> supported PCI version for the target device in the zpci_dev.

Hm, what kind of version is that? The version of the zPCI interface?

Inquiring minds want to know :)

> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h | 1 +
>  arch/s390/pci/pci_clp.c     | 1 +
>  2 files changed, 2 insertions(+)
