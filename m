Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35285 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfHBCzj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 22:55:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so55667810oii.2
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 19:55:39 -0700 (PDT)
Subject: Re: [PATCH 0/1] sending DASD patches through linux-block
References: <20190801110630.82432-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c66977ae-7a17-5a54-0519-a69d8f825070@kernel.dk>
Date: Thu, 1 Aug 2019 20:47:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190801110630.82432-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org, hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, gor@linux.ibm.com

On 8/1/19 5:06 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> we would like to get our DASD related patches upstream through your
> linux-block git tree in the future.
> We hope to get a better integration and that we are able to identify
> potential conflicts with generic blocklayer changes earlier.
> 
> I hope this is OK for you. I have attached a first patch that fixes a
> bug in the DASD driver. This patch is based on the master branch of your
> linux-block git tree.

Certainly. No extra hassle for me, and if it makes it easier for you,
then by all means.

> Please let me know if I should change something in my workflow.

Looks fine to me, I generally prefer patches (individual or series)
to git trees, unless it's a huge series.

-- 
Jens Axboe
