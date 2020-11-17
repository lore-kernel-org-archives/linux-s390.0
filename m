Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45424 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgKQSop (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 13:44:45 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIXGGH009364
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:44 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vdn5u7tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:43 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHIXL7f009551
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:43 -0500
Date: Tue, 17 Nov 2020 19:44:37 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 3/3] s390/vmem: make variable and function names
 consistent
Message-ID: <20201117184437.GF4746@osiris>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <f9e09fe0e9c6b7d5ebc5c45c73b917a4ff39a24b.1605000280.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e09fe0e9c6b7d5ebc5c45c73b917a4ff39a24b.1605000280.git.agordeev@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>

On Tue, Nov 10, 2020 at 10:36:23AM +0100, Alexander Gordeev wrote:
> Rename some variable and functions to better clarify
> what they are and what they do.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/vmem.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Applied, thanks.
