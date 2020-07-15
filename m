Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731174AbgGONcp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jul 2020 09:32:45 -0400
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
 <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
 <20200715064854.GA5409@infradead.org>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <88f32826-4bd2-27c1-c9e0-204aa556b0a6@linux.ibm.com>
Date: Wed, 15 Jul 2020 15:32:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200715064854.GA5409@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Am 15.07.20 um 08:48 schrieb Christoph Hellwig:
> On Tue, Jul 14, 2020 at 02:12:27PM -0600, Jens Axboe wrote:
>> Just curious, any reason this isn't just using bio_alloc()?
> The dasd_diag_bio doesn't seem to have anything to do with the
> block layer struct bio..

exactly, that's a struct dasd_diag_bio.
