Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730926AbgIHPyo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 11:54:44 -0400
Date: Tue, 8 Sep 2020 15:06:55 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v3] s390x: Add 3f program exception handler
Message-ID: <20200908130655.GF14136@osiris>
References: <20200908075337.GA9170@osiris>
 <20200908130504.24641-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908130504.24641-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com, cohuck@redhat.com, thuth@redhat.com

On Tue, Sep 08, 2020 at 09:05:04AM -0400, Janosch Frank wrote:
> Program exception 3f (secure storage violation) can only be detected
> when the CPU is running in SIE with a format 4 state description,
> e.g. running a protected guest. Because of this and because user
> space partly controls the guest memory mapping and can trigger this
> exception, we want to send a SIGSEGV to the process running the guest
> and not panic the kernel.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> CC: <stable@vger.kernel.org> # 5.7+
> Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/entry.h     |  1 +
>  arch/s390/kernel/pgm_check.S |  2 +-
>  arch/s390/mm/fault.c         | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)

I guess this should go upstream via the s390 tree?
Should I pick this up?
