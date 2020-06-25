Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39429 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403801AbgFYQLh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 12:11:37 -0400
Date: Thu, 25 Jun 2020 18:11:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/2] docs: kvm: add documentation for
 KVM_CAP_S390_DIAG318
Message-ID: <20200625181124.478ddd9f.cohuck@redhat.com>
In-Reply-To: <20200625150724.10021-2-walling@linux.ibm.com>
References: <20200625150724.10021-1-walling@linux.ibm.com>
        <20200625150724.10021-2-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On Thu, 25 Jun 2020 11:07:23 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> Documentation for the s390 DIAGNOSE 0x318 instruction handling.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/virt/kvm/api.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Still looks good to me.
