From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] s390: improve speculative execution handling
Date: Wed, 17 Jan 2018 14:29:30 +0100
Message-ID: <20180117132930.GA3236@kroah.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 17, 2018 at 10:48:33AM +0100, Martin Schwidefsky wrote:
> @Greg: I have started with the backports for the stable kernel releases,
> but unless the interface for gmp/nospec_ptr/nospec_load is cast in stone
> does it make sense to send them?

No, I can't take anything until it is in Linus's tree.  And as Jiri
pointed out, this isn't the same api as Dan last posted, so any
backports would be really foolish right now...

thanks,

greg k-h
