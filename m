Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgIOBlQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Sep 2020 21:41:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9DAC06174A
        for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2020 18:41:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f1so484327plo.13
        for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2020 18:41:15 -0700 (PDT)
Subject: Re: [PATCH 0/1] DASD: fix discard for FBA devices
References: <20200914115647.94062-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8c3ae063-8e19-d2ab-f0cb-88014df65e66@kernel.dk>
Date: Mon, 14 Sep 2020 19:41:12 -0600
MIME-Version: 1.0
In-Reply-To: <20200914115647.94062-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 9/14/20 5:56 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following patch that fixes zero writes for DASD FBA devices under certain conditions.
> 
> Do you mind to take this for 5.9?

Applied, thanks.

-- 
Jens Axboe
