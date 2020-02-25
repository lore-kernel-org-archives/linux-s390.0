Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgBYNaX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 08:30:23 -0500
Date: Tue, 25 Feb 2020 14:30:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 34/36] s390: protvirt: Add sysfs firmware interface
 for Ultravisor information
Message-ID: <20200225143004.4c47f1b8.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-35-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-35-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 24 Feb 2020 06:41:05 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> That information, e.g. the maximum number of guests or installed
> Ultravisor facilities, is interesting for QEMU, Libvirt and
> administrators.
> 
> Let's provide an easily parsable API to get that information.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/uv.c | 86 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
