Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2246 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232611AbhA0MoA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Jan 2021 07:44:00 -0500
Date: Wed, 27 Jan 2021 13:43:10 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/tape: Fix spelling mistake in function name
 tape_3590_erp_succeded
Message-ID: <your-ad-here.call-01611751390-ext-5985@work.hours>
References: <20210118113222.71708-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210118113222.71708-1-colin.king@canonical.com>
List-ID: <linux-s390.vger.kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:32:22AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Rename tape_3590_erp_succeded to tape_3590_erp_succeeded to fix a
> spelling mistake in the function name.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/s390/char/tape_3590.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
