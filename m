From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/2] KVM: s390: Bugfixes for virtio-ccw.
Date: Wed, 9 Jan 2013 18:40:43 -0200
Message-ID: <20130109204043.GA29589@amt.cnet>
References: <1357570312-32074-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357570312-32074-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 07, 2013 at 03:51:50PM +0100, Cornelia Huck wrote:
> Hi,
> 
> Christian discovered some problems with regard to serialization
> in the virtio-ccw guest driver. Per-device data structures might
> contain data obtained by channel programs issued later on, leading
> to confusing behaviour. We cannot rely on the common I/O layer
> serialization here.
> 
> Rather than adding extra serialization, we decided to keep it simple
> with per-request allocated data structures and retries on busy.
> These patches have been run in our internal testing without problems
> for a bit now.
> 
> Please apply to kvm-next.

Applied, thanks.
