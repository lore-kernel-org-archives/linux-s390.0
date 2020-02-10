Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730469AbgBJMni (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:43:38 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ACeF2s017960
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:43:37 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u8050nf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:43:37 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 10 Feb 2020 12:43:35 -0000
Date: Mon, 10 Feb 2020 13:43:30 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PULL 0/1] one vfio-ccw patch for 5.6
References: <20200206170331.1032-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206170331.1032-1-cohuck@redhat.com>
Message-Id: <your-ad-here.call-01581338610-ext-6781@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, Feb 06, 2020 at 06:03:30PM +0100, Cornelia Huck wrote:
> The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:
> 
>   Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20200206
> 
> for you to fetch changes up to dbaf10027ae92a66f0dfad33e1e3453daa16373f:
> 
>   vfio-ccw: Use the correct style for SPDX License Identifier (2020-01-07 10:37:34 +0100)
> 
> ----------------------------------------------------------------
> fix style of SPDX License Identifier
> 
> ----------------------------------------------------------------
> 
> Nishad Kamdar (1):
>   vfio-ccw: Use the correct style for SPDX License Identifier
> 
>  drivers/s390/cio/vfio_ccw_trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.21.1
> 
Pulled into fixes, thanks!
