From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 1/3] S390: take a full byte as ext_param indicator
Date: Wed, 25 Aug 2010 18:20:20 -0300
Message-ID: <20100825212020.GA2345@amt.cnet>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1282657732-20902-1-git-send-email-agraf@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 24, 2010 at 03:48:50PM +0200, Alexander Graf wrote:
> Currenty the ext_param field only distinguishes between "config change" and
> "vring interrupt". We can do a lot more with it though, so let's enable a
> full byte of possible values and constants to #defines while at it.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> ---
> 
> v1 -> v2:
> 
>   - move defines to virtio_s390.h
> ---
>  arch/s390/include/asm/kvm_virtio.h |    6 ++++++
>  drivers/s390/kvm/kvm_virtio.c      |   19 +++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)

Applied, thanks.
