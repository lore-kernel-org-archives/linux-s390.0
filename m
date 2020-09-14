Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbgINHz4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 03:55:56 -0400
Date: Mon, 14 Sep 2020 09:55:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt device
 driver
Message-ID: <20200914075546.GA11573@osiris>
References: <20200910102838.28887-1-freude@linux.ibm.com>
 <20200911062134.GB21597@lst.de>
 <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, borntraeger@de.ibm.com

On Mon, Sep 14, 2020 at 09:36:07AM +0200, Harald Freudenberger wrote:
> Otherwise how to we provide this fix then ? My recommendation would
> be to go the 'usual' way: Commit this s390 internal and then let
> this go out with the next kernel merge window when next time Linus
> is pulling patches from the s390 subsystem for the 5.10 kernel
> development cycle.

I will create a "set_fs" topic branch on kernel.org based on
vfs.git/base.set_fs and add your patch there and also the rest of
s390 set_fs related patches on top of that as soon as things are
ready.
