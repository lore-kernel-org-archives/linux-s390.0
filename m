Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728556AbgEKQaz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 May 2020 12:30:55 -0400
Subject: Re: [PATCH v3 3/3] s390/dasd: remove ioctl_by_bdev calls
References: <20200508131455.55407-1-sth@linux.ibm.com>
 <20200508131455.55407-4-sth@linux.ibm.com> <20200508155342.GC4200@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <6cd6788e-ce3d-7869-307a-9a6723f6eb79@linux.ibm.com>
Date: Mon, 11 May 2020 18:30:44 +0200
MIME-Version: 1.0
In-Reply-To: <20200508155342.GC4200@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

Am 08.05.20 um 17:53 schrieb Christoph Hellwig:
> I think this should use symbol_get instead.

Thanks for the Feedback, also for the previous patch.
I will incorporate it, run some test cycles and submit the patches
again when I am ready.
