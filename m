Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48275 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgIOPwr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 11:52:47 -0400
Date: Tue, 15 Sep 2020 17:52:17 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] s390/dis: get rid of set_fs() usage
Message-ID: <20200915155217.GA22056@lst.de>
References: <20200915154340.4215-1-hca@linux.ibm.com> <20200915154340.4215-3-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915154340.4215-3-hca@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 05:43:38PM +0200, Heiko Carstens wrote:
> +		if (user_mode(regs)) {
> +			if (__copy_from_user(code + start - 2, (char __user *)addr, 2))
> +				break;
> +		} else {
> +			if (copy_from_kernel_nofault(code + start - 2, (char *)addr, 2))
> +				break;
> +		}

>  	for (end = 32; end < 64; end += 2) {
>  		addr = regs->psw.addr + end - 32;
> +		if (user_mode(regs)) {
> +			if (__copy_from_user(code + end, (char __user *)addr, 2))
> +				break;
> +		} else {
> +			if (copy_from_kernel_nofault(code + end, (char *)addr, 2))
> +				break;
> +		}

Maybe add a little copy_from_regs helper?  That would also get rid
of the awfully long lines here.

Also any good reason for the __copy_from_user instead of the normal
copy_from_user here?
