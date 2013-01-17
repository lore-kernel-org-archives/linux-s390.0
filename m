From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH] Bugfix for kvm/s390.
Date: Thu, 17 Jan 2013 08:42:25 +0200
Message-ID: <20130117064225.GC11529@redhat.com>
References: <1358245049-37155-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358245049-37155-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 15, 2013 at 11:17:28AM +0100, Cornelia Huck wrote:
> Hi,
> 
> here's another s390 bugfix for kvm-next. Please apply.
> 
Applied, thanks.

> Cong Ding (1):
>   KVM: s390: kvm/sigp.c: fix memory leakage
> 
>  arch/s390/kvm/sigp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> -- 
> 1.7.12.4

--
			Gleb.
