Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgJLTdd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Oct 2020 15:33:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D0C0613D0
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2020 12:33:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n6so18777299ioc.12
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2020 12:33:31 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
Date: Mon, 12 Oct 2020 13:33:29 -0600
MIME-Version: 1.0
In-Reply-To: <20201012183550.GA12341@imap.linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 10/12/20 1:06 PM, Stefan Haberland wrote:
> Hi Jens,
> 
> quick ping. Are you going to apply this for 5.10?

I actually wasn't planning on it - it arrived a bit late, and
it seemed like one of those things that needed a bit more review
talk before being able to be applied.

-- 
Jens Axboe
