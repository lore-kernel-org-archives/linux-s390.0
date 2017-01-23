From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: KVM: s390: Move two error code assignments in
 kvm_vm_ioctl_get_dirty_log()
Date: Mon, 23 Jan 2017 15:21:18 +0300
Message-ID: <20170123122118.GP4454@mwanda>
References: <70f41e59-d8a4-de42-6064-80ecf6acc065@users.sourceforge.net>
 <35411200-2bd6-1c65-7d7f-21a6353875ea@de.ibm.com>
 <01d581bb-9db6-cba1-e476-49c814c3ebf0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01d581bb-9db6-cba1-e476-49c814c3ebf0@users.sourceforge.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Christian =?iso-8859-1?Q?Borntr=E4ger?= <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 23, 2017 at 12:08:12PM +0100, SF Markus Elfring wrote:
> > but it certainly carries the risk of breaking something
> 
> This is usual in software development, isn't it?
> 

If you break something but you're trying to fix something then normally
you still end up fixing more than you break.  You haven't yet tried to
fix anything, but you've definitely introduced bugs...

We have had this discussion many times.

regards,
dan carpenter
