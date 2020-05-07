Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgEGPWi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 11:22:38 -0400
References: <20200430111754.98508-1-sth@linux.ibm.com>
 <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de>
 <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com>
 <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com>
 <20200505124423.GA26313@lst.de>
 <a6c99eba-44f2-2944-a135-50ed75ef2c55@linux.ibm.com>
 <20200506045258.GB9846@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <10918cd1-a4a9-7872-9672-efcd28ef0751@linux.ibm.com>
Date: Thu, 7 May 2020 17:22:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200506045258.GB9846@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>

Am 06.05.20 um 06:52 schrieb Christoph Hellwig:
>
> No, I mean the series that I actually sent out:
>
> https://lkml.org/lkml/2020/4/21/66
> https://lkml.org/lkml/2020/4/21/68
> https://lkml.org/lkml/2020/4/21/69

OK, just thought again about your suggestion and also that
you have already been talking about a symbol lookup I just
have written a prototype that took your first two patches
as base, exports the symbol of dasd_biodasdinfo and in
ibm.c I do a kallsyms_lookup_name("dasd_biodasdinfo").

So I would not have to define a structure twice or rely on
MAJORs. Also we would not have to define an own file
operation only for DASD devices.

What do you think about this? If you agree I will polish
the patches, test them and send them for review.
