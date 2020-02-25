Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729142AbgBYNoY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 08:44:24 -0500
Date: Tue, 25 Feb 2020 14:44:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 28/36] KVM: s390: protvirt: Report CPU state to
 Ultravisor
Message-ID: <20200225144412.52250925.cohuck@redhat.com>
In-Reply-To: <20200225132106.637817-1-borntraeger@de.ibm.com>
References: <20200225140151.5e639df1.cohuck@redhat.com>
        <20200225132106.637817-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ulrich.Weigand@de.ibm.com, david@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

On Tue, 25 Feb 2020 08:21:06 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> VCPU states have to be reported to the ultravisor for SIGP
> interpretation, kdump, kexec and reboot.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 15 +++++++++++++
>  arch/s390/kvm/diag.c       |  6 +++++-
>  arch/s390/kvm/intercept.c  |  4 ++++
>  arch/s390/kvm/kvm-s390.c   | 44 +++++++++++++++++++++++++++++---------
>  arch/s390/kvm/kvm-s390.h   |  5 +++--
>  arch/s390/kvm/pv.c         | 18 ++++++++++++++++
>  6 files changed, 79 insertions(+), 13 deletions(-)

Looks good.
