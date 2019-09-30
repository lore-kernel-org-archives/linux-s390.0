Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731276AbfI3Pcn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Sep 2019 11:32:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UFOB0I031360
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 11:32:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbm38h41w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 11:32:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 30 Sep 2019 16:32:40 +0100
Date: Mon, 30 Sep 2019 17:32:34 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/cio: fix virtio-ccw DMA without PV
In-Reply-To: <20190930145607.GA18163@lst.de>
References: <20190930135310.26148-1-pasic@linux.ibm.com>
        <20190930145607.GA18163@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190930173234.5251bcb8.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 30 Sep 2019 16:56:07 +0200
Christoph Hellwig <hch@lst.de> wrote:

> The code looks fine, but I still very much disagree with the workaround
> comments.  The different mask for allocations vs streaming mappings is
> exactly how the DMA API is intended to work.

Thanks for having a look! I already changed this but messed up the
amend with git :( I will send out a v2 shortly.

Regards,
Halil
