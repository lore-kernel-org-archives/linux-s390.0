From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH 0/3] s390/kvm fixes
Date: Wed, 30 Jan 2013 12:36:41 +0200
Message-ID: <20130130103641.GH15004@redhat.com>
References: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Marcelo Tossati <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 25, 2013 at 03:34:14PM +0100, Christian Borntraeger wrote:
> Gleb, Marcelo,
> 
> here are 3 kvm fixes for kvm-next.
> 
> Christian Borntraeger (3):
>   s390/kvm: Fix store status for ACRS/FPRS
>   s390/virtio-ccw: Fix setup_vq error handling.
>   s390/kvm: Fix instruction decoding
> 
>  arch/s390/kvm/kvm-s390.c      |  8 ++++++++
>  arch/s390/kvm/kvm-s390.h      | 25 ++++++++++++++-----------
>  drivers/s390/kvm/virtio_ccw.c | 20 +++++++++++---------
>  3 files changed, 33 insertions(+), 20 deletions(-)
> 
Applied, thanks.

--
			Gleb.
