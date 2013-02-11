From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH] kvm-s390: Bugfix for handling of iscs.
Date: Mon, 11 Feb 2013 10:50:27 +0200
Message-ID: <20130211085027.GU7837@redhat.com>
References: <1360239652-52350-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360239652-52350-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 07, 2013 at 01:20:51PM +0100, Cornelia Huck wrote:
> Hi,
> 
> here's another kvm-s390 bugfix for kvm-next, this time fixing a
> thinko in the I/O interrupt injection.
> 
> Please apply.
> 
Thanks, applied.

> Cornelia Huck (1):
>   KVM: s390: Fix handling of iscs.
> 
>  arch/s390/kvm/interrupt.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> -- 
> 1.7.12.4

--
			Gleb.
