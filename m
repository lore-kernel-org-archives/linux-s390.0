Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgFHO1u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 10:27:50 -0400
Date: Mon, 8 Jun 2020 16:27:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH -next] s390/zcrypt: fix kzalloc-simple.cocci warnings
Message-ID: <20200608142706.GB7478@osiris>
References: <1587472548-105240-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587472548-105240-1-git-send-email-zou_wei@huawei.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Zou Wei <zou_wei@huawei.com>
Cc: freude@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 08:35:48PM +0800, Zou Wei wrote:
> This patch fixes below warning reported by coccicheck
> 
> drivers/s390/crypto/zcrypt_ep11misc.c:198:8-15: WARNING:
> kzalloc should be used for cprb, instead of kmalloc/memset
> 
> Fixes: 7384eb725e2d ("s390/zcrypt: add new low level ep11 functions support file")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, however without Fixes tag, since this was not a bug.
