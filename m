Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42358 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgDFPcg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 11:32:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id g6so68362pgs.9
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 08:32:34 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390: Cleanup removed IOSCHED_DEADLINE
References: <20200406074118.86849-1-sth@linux.ibm.com>
 <20200406074118.86849-2-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0efad2a5-90f5-8ccf-169e-9715a64a4bb0@kernel.dk>
Date: Mon, 6 Apr 2020 08:32:31 -0700
MIME-Version: 1.0
In-Reply-To: <20200406074118.86849-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 4/6/20 1:41 AM, Stefan Haberland wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
> remove legacy IO schedulers").

Isn't this a leftover thing from when dasd selected deadline
internally? I don't think we need this anymore, just kill the
select completely.

-- 
Jens Axboe
