Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQQgx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Dec 2020 11:36:53 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8BDC061794
        for <linux-s390@vger.kernel.org>; Thu, 17 Dec 2020 08:36:13 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o6so14978875iob.10
        for <linux-s390@vger.kernel.org>; Thu, 17 Dec 2020 08:36:13 -0800 (PST)
Subject: Re: [PATCH 0/4] Fix DASD control unit updates
References: <20201217155907.36436-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <da474562-ece9-4630-15c7-d93634e3b2f3@kernel.dk>
Date: Thu, 17 Dec 2020 09:36:11 -0700
MIME-Version: 1.0
In-Reply-To: <20201217155907.36436-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 12/17/20 8:59 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patches that address problems during DASD
> control unit updates.

Applied, thanks.

-- 
Jens Axboe
