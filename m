Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727847AbgIGWh2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 18:37:28 -0400
Date: Tue, 8 Sep 2020 00:37:14 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200908003714.6233107d.pasic@linux.ibm.com>
In-Reply-To: <1599471547-28631-3-git-send-email-pmorel@linux.ibm.com>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
        <1599471547-28631-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Mon,  7 Sep 2020 11:39:07 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> If protected virtualization is active on s390, VIRTIO has only retricted
> access to the guest memory.
> Define CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS and export
> arch_has_restricted_virtio_memory_access to advertize VIRTIO if that's
> the case, preventing a host error on access attempt.

The description is a little inaccurate, but I don't care hence the r-b.

The function arch_has_restricted_virtio_memory_access() returning true
can not prevent the host from attempting to access memory if it decides
to do so. And as far as I know there was no host error on access attempt.
The page gets exported, and the host will operate on the encrypted
page. But in the end we do run into trouble, which is usually fatal for
the guest (not the host).

What we actually do here is the following. If we detect
an ill configured device we fail it (device status field), because
attempting to drive it is a recipe for disaster.

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
