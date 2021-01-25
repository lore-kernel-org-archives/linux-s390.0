Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbhAYQXY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 11:23:24 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F6C0613D6
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 08:22:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e9so7937900plh.3
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 08:22:43 -0800 (PST)
Subject: Re: [PATCH 0/1] s390/dasd: fix kobject removal
References: <20210118165518.14578-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <74ac02e3-11e3-75a3-520b-47b0f35b711d@kernel.dk>
Date: Mon, 25 Jan 2021 09:22:40 -0700
MIME-Version: 1.0
In-Reply-To: <20210118165518.14578-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 1/18/21 9:55 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes inconsistent kobject removal.

Queued for 5.11, thanks.

-- 
Jens Axboe
