Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:40085 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfJAPpD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Oct 2019 11:45:03 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so49084224iof.7
        for <linux-s390@vger.kernel.org>; Tue, 01 Oct 2019 08:45:03 -0700 (PDT)
Subject: Re: [PATCH 0/2] s390/dasd: fixes for thin provisioning support
References: <20191001153439.62672-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <deaa7dff-5b1a-851f-4f08-74ab369e58b8@kernel.dk>
Date: Tue, 1 Oct 2019 09:45:00 -0600
MIME-Version: 1.0
In-Reply-To: <20191001153439.62672-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 10/1/19 9:34 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following two patches that
> 
> - fix a bug in the thin provisioning base support
> - revert a commit because of possible data corruption

Applied, thanks Stefan.

-- 
Jens Axboe
