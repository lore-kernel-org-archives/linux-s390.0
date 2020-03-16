Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6640 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730634AbgCPMKS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Mar 2020 08:10:18 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GC3YJi004832
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2020 08:10:17 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yrt33vemk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2020 08:10:17 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 16 Mar 2020 12:10:15 -0000
Date: Mon, 16 Mar 2020 13:10:09 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: mark sie block as 512 byte aligned
In-Reply-To: <20200311083304.3725276-1-borntraeger@de.ibm.com>
References: <20200311083304.3725276-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200316131009.381a8692@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

On Wed, 11 Mar 2020 09:33:04 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The sie block must be aligned to 512 bytes. Mark it as such.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h
> b/arch/s390/include/asm/kvm_host.h index 0ea82152d2f7..2d50f6c432e2
> 100644 --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -344,7 +344,7 @@ struct kvm_s390_sie_block {
>  	__u64	itdba;			/* 0x01e8 */
>  	__u64   riccbd;			/* 0x01f0 */
>  	__u64	gvrd;			/* 0x01f8 */
> -} __attribute__((packed));
> +} __packed __aligned(512);
>  
>  struct kvm_s390_itdb {
>  	__u8	data[256];

I agree with the addition of aligned, but did you really have to remove
packed? it makes me a little uncomfortable.

do we have any compile-time assertions that the size of the block will
be the one we expect?
