Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59671 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbgKYQgT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 11:36:19 -0500
Date: Wed, 25 Nov 2020 17:36:16 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20201125163616.GA1975@lst.de>
References: <20200915154340.4215-1-hca@linux.ibm.com> <20200915154340.4215-5-hca@linux.ibm.com> <20200915160243.GB22056@lst.de> <20200915193755.GA8528@osiris> <20200916123603.GC7076@osiris> <20201125083808.GB31753@lst.de> <72753cc5-e9a9-05c5-c465-6dff9fcf679d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72753cc5-e9a9-05c5-c465-6dff9fcf679d@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

On Wed, Nov 25, 2020 at 09:51:47AM +0100, Christian Borntraeger wrote:
> > Did you manage to get back to the s390 set_fs removal?
> > 
> 
> Heiko has queued the following:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=87d5986345219a7e4f204726d9085ea87f3e22d0

Ah, nice!
