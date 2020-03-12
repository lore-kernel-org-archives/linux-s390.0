Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-il1-f194.google.com ([209.85.166.194]:43354 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNZK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Mar 2020 09:25:10 -0400
Received: by mail-il1-f194.google.com with SMTP id d14so4898129ilq.10
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 06:25:10 -0700 (PDT)
Subject: Re: [PATCH 0/1] s390/dasd: fix data corruption
References: <20200312131715.72621-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cd6a5017-7db4-3d66-c58d-40d8b0fda61c@kernel.dk>
Date: Thu, 12 Mar 2020 07:25:07 -0600
MIME-Version: 1.0
In-Reply-To: <20200312131715.72621-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 3/12/20 7:17 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please find following patch that fixes a likely data corruption when using
> devices with thin provisioning support.
> As this is a severe issue I hope this will make it into RC6. If not, please
> let me know.

Applied for 5.6, thanks.

-- 
Jens Axboe
