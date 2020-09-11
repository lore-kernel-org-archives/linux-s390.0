Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35626 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKGVh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Sep 2020 02:21:37 -0400
Date: Fri, 11 Sep 2020 08:21:34 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt
 device driver
Message-ID: <20200911062134.GB21597@lst.de>
References: <20200910102838.28887-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910102838.28887-1-freude@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux390-list@tuxmaker.boeblingen.de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, hch@lst.de, borntraeger@de.ibm.com

On Thu, Sep 10, 2020 at 12:28:38PM +0200, Harald Freudenberger wrote:
> +static inline unsigned long z_copy_from_user(bool userspace,
> +					     void *to, const void __user *from, unsigned long n)

Can you avoid the pointless long lines in the function declaration?

> +{
> +	if (likely(userspace))
> +		return copy_from_user(to, from, n);
> +	memcpy(to, (void __force *) from, n);
> +	return 0;
> +}
> +
> +static inline unsigned long z_copy_to_user(bool userspace,
> +					   void __user *to, const void *from, unsigned long n)
> +{
> +	if (likely(userspace))
> +		return copy_to_user(to, from, n);
> +	memcpy((void __force *) to, from, n);
> +	return 0;

Otherwise this doesn't look great, but also not horrible and gets rid
of the set_fs while reducing the lines of code, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
