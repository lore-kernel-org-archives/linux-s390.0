Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729818AbfILHTQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 03:19:16 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8C7IH2J010170
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 03:19:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uyh7yrha4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 03:19:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Thu, 12 Sep 2019 08:19:13 +0100
Subject: Re: [PATCH] s390/qeth: fix spelling mistake "alocpool" -> "allocpool"
References: <20190911153500.30836-1-colin.king@canonical.com>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 12 Sep 2019 09:19:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190911153500.30836-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <de37e3a5-faad-44ae-32b2-d7c6c5d3732d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Colin King <colin.king@canonical.com>, linux-s390@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>



On 9/11/19 5:35 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in QETH_CARD_TEXT text. Fix it.
> 

This spelling mistake is intended, because this qeth trace area is defined for
8 byte length entries. We try to make the entries as speaking as possible - even
at cost of spelling mistakes.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index a7868c8133ee..ab96b22db3fe 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -218,7 +218,7 @@ static int qeth_alloc_buffer_pool(struct qeth_card *card)
>  	void *ptr;
>  	int i, j;
>  
> -	QETH_CARD_TEXT(card, 5, "alocpool");
> +	QETH_CARD_TEXT(card, 5, "allocpool");
>  	for (i = 0; i < card->qdio.init_pool.buf_count; ++i) {
>  		pool_entry = kzalloc(sizeof(*pool_entry), GFP_KERNEL);
>  		if (!pool_entry) {
> 
