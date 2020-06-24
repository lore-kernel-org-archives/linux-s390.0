Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33302 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404531AbgFXQJ4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Jun 2020 12:09:56 -0400
Date: Wed, 24 Jun 2020 16:09:53 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
Message-ID: <20200624160953.GH4332@42.do-not-panic.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624144311.GA5839@infradead.org>
 <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>

On Wed, Jun 24, 2020 at 05:54:46PM +0200, Christian Borntraeger wrote:
> 
> 
> On 24.06.20 16:43, Christoph Hellwig wrote:
> > On Wed, Jun 24, 2020 at 01:11:54PM +0200, Christian Borntraeger wrote:
> >> Does anyone have an idea why "umh: fix processed error when UMH_WAIT_PROC is used" breaks the
> >> linux-bridge on s390?
> > 
> > Are we even sure this is s390 specific and doesn't happen on other
> > architectures with the same bridge setup?
> 
> Fair point. AFAIK nobody has tested this yet on x86.

Regardless, can you enable dynamic debug prints, to see if the kernel
reveals anything on the bridge code which may be relevant:

echo "file net/bridge/* +p" > /sys/kernel/debug/dynamic_debug/control

  Luis
