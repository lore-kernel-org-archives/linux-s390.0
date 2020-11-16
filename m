Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgKPP2a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Nov 2020 10:28:30 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64121C0613CF
        for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2020 07:28:30 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n12so17817689ioc.2
        for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2020 07:28:30 -0800 (PST)
Subject: Re: [PATCH 0/1] fix null pointer dereference for ERP requests
References: <20201116152347.61093-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8d6a4ff9-d5dc-131c-3fa7-afe0c843a731@kernel.dk>
Date: Mon, 16 Nov 2020 08:28:27 -0700
MIME-Version: 1.0
In-Reply-To: <20201116152347.61093-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 11/16/20 8:23 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> pleas apply the following patch that fixes a null pointer derefernce in the
> DASD driver.

Applied, thanks.

-- 
Jens Axboe
