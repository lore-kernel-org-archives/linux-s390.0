From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH 3/4] PF: Provide additional direct page notification
Date: Wed, 10 Jul 2013 13:42:53 +0300
Message-ID: <20130710104253.GQ24941@redhat.com>
References: <1373378207-10451-1-git-send-email-dingel@linux.vnet.ibm.com>
 <1373378207-10451-4-git-send-email-dingel@linux.vnet.ibm.com>
 <51DC33E7.1030404@de.ibm.com>
 <282EB214-206B-4A04-9830-D97679C9F4EC@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <282EB214-206B-4A04-9830-D97679C9F4EC@suse.de>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Xiantao Zhang <xiantao.zhang@intel.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 10, 2013 at 12:39:01PM +0200, Alexander Graf wrote:
> 
> On 09.07.2013, at 18:01, Christian Borntraeger wrote:
> 
> > On 09/07/13 15:56, Dominik Dingel wrote:
> >> By setting a Kconfig option, the architecture can control when
> >> guest notifications will be presented by the apf backend.
> >> So there is the default batch mechanism, working as before, where the vcpu thread
> >> should pull in this information. On the other hand there is now the direct
> >> mechanism, this will directly push the information to the guest.
> >> 
> >> Still the vcpu thread should call check_completion to cleanup leftovers,
> >> that leaves most of the common code untouched.
> >> 
> >> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> > 
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com> 
> > for the "why". We want to use the existing architectured interface.
> 
> Shouldn't this be a runtime option?
> 
Why? What is the advantage of using sync delivery when HW can do it
async?

--
			Gleb.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
