Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731000AbgDQOFq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 10:05:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E135C061A0C
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 07:05:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o15so592650pgi.1
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 07:05:46 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390/dasd: remove IOSCHED_DEADLINE from DASD Kconfig
References: <20200417094835.60247-1-sth@linux.ibm.com>
 <20200417094835.60247-2-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b748b144-86b8-f0de-e391-f24b50718a2a@kernel.dk>
Date: Fri, 17 Apr 2020 08:05:40 -0600
MIME-Version: 1.0
In-Reply-To: <20200417094835.60247-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 4/17/20 3:48 AM, Stefan Haberland wrote:
> CONFIG_IOSCHED_DEADLINE was removed with
> commit f382fb0bcef4 ("block: remove legacy IO schedulers")
> 
> and setting of the scheduler was removed with
> commit a5fd8ddce2af ("s390/dasd: remove setting of scheduler from driver").
> 
> So get rid of the select.

Applied, thanks.

-- 
Jens Axboe
