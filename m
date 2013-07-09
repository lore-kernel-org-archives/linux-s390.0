From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/4] PF: Provide additional direct page notification
Date: Tue, 09 Jul 2013 18:01:43 +0200
Message-ID: <51DC33E7.1030404@de.ibm.com>
References: <1373378207-10451-1-git-send-email-dingel@linux.vnet.ibm.com> <1373378207-10451-4-git-send-email-dingel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1373378207-10451-4-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Xiantao Zhang <xiantao.zhang@intel.com>, Alexander Graf <agraf@suse.de>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09/07/13 15:56, Dominik Dingel wrote:
> By setting a Kconfig option, the architecture can control when
> guest notifications will be presented by the apf backend.
> So there is the default batch mechanism, working as before, where the vcpu thread
> should pull in this information. On the other hand there is now the direct
> mechanism, this will directly push the information to the guest.
> 
> Still the vcpu thread should call check_completion to cleanup leftovers,
> that leaves most of the common code untouched.
> 
> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com> 
for the "why". We want to use the existing architectured interface.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
