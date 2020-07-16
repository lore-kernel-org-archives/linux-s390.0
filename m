Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgGPL0n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 07:26:43 -0400
Date: Thu, 16 Jul 2020 13:26:30 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH -next] s390/mm: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200716112630.GB8484@osiris>
References: <20200716090703.14315-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716090703.14315-1-miaoqinglang@huawei.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>

On Thu, Jul 16, 2020 at 05:07:03PM +0800, Qinglang Miao wrote:
> From: Chen Huang <chenhuang5@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
> ---
>  arch/s390/mm/dump_pagetables.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Thanks for the patch, however we are going to convert the s390 page
table dumper to generic code, so I'm not going to apply any cleanup
patches for this code anymore.
