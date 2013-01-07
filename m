From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 0/7] s390: Host support for channel I/O.
Date: Mon, 7 Jan 2013 19:54:01 -0200
Message-ID: <20130107215401.GA1139@amt.cnet>
References: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 20, 2012 at 03:32:05PM +0100, Cornelia Huck wrote:
> Hi,
> 
> here's the next iteration of the host patches to support channel
> I/O against kvm/next.
> 
> Changes from v4 are on the style side; mainly using defines instead
> of magic numbers and using helper functions for decoding instructions.
> 
> Patches 1 and 2 are new (and can be applied independently of the
> channel I/O patches); some things Alex pointed out in the patches
> apply to existing code as well.
> 
> Please consider for kvm/next.
> 
> Cornelia Huck (7):
>   KVM: s390: Constify intercept handler tables.
>   KVM: s390: Decoding helper functions.
>   KVM: s390: Support for I/O interrupts.
>   KVM: s390: Add support for machine checks.
>   KVM: s390: In-kernel handling of I/O instructions.
>   KVM: s390: Base infrastructure for enabling capabilities.
>   KVM: s390: Add support for channel I/O instructions.

Applied, thanks.
