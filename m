Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35069 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMfE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Dec 2019 07:35:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so2500231plt.2
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 04:35:03 -0800 (PST)
Subject: Re: [PATCH 0/3] s390/dasd patches
References: <20191219084352.75114-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <911ec978-791d-aac3-072b-dab9f3d1bf54@kernel.dk>
Date: Thu, 19 Dec 2019 05:35:00 -0700
MIME-Version: 1.0
In-Reply-To: <20191219084352.75114-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 12/19/19 1:43 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following three patches that
> 
>  - fix a dead code path for DASD
>  - fix a memleak in DASD error case
>  - fix typo in copyright statement

Applied for 5.5, thanks

-- 
Jens Axboe
