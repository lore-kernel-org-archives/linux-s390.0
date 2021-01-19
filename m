Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729404AbhASQU6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 11:20:58 -0500
Date: Tue, 19 Jan 2021 17:19:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] s390: uv: Fix sysfs max number of VCPUs reporting
Message-ID: <20210119171913.29cc4a0d.cohuck@redhat.com>
In-Reply-To: <20210119100402.84734-2-frankja@linux.ibm.com>
References: <20210119100402.84734-1-frankja@linux.ibm.com>
        <20210119100402.84734-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com

On Tue, 19 Jan 2021 05:04:01 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> The number reported by the query is N-1 and I think people reading the
> sysfs file would expect N instead. For users creating VMs there's no
> actual difference because KVM's limit is currently below the UV's
> limit.
> 
> The naming of the field is a bit misleading. Number in this context is
> used like ID and starts at 0. The query field denotes the maximum
> number that can be put into the VCPU number field in the "create
> secure CPU" UV call.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: a0f60f8431999 ("s390/protvirt: Add sysfs firmware interface for Ultravisor information")
> Cc: stable@vger.kernel.org
> ---
>  arch/s390/boot/uv.c        | 2 +-
>  arch/s390/include/asm/uv.h | 4 ++--
>  arch/s390/kernel/uv.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
