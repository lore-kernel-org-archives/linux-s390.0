From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 5/5] KVM: s390: Add support for channel I/O instructions.
Date: Mon, 10 Dec 2012 09:01:13 +0100
Message-ID: <3AEE36A2-EA73-4EF1-8C8C-AE85D1A56172@suse.de>
References: <1354883425-38531-1-git-send-email-cornelia.huck@de.ibm.com> <1354883425-38531-6-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1354883425-38531-6-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 07.12.2012, at 13:30, Cornelia Huck wrote:

> Add a new capability, KVM_CAP_S390_CSS_SUPPORT, which will pass
> intercepts for channel I/O instructions to userspace. Only I/O
> instructions interacting with I/O interrupts need to be handled
> in-kernel:
> 
> - TEST PENDING INTERRUPTION (tpi) dequeues and stores pending
>  interrupts entirely in-kernel.
> - TEST SUBCHANNEL (tsch) dequeues pending interrupts in-kernel
>  and exits via KVM_EXIT_S390_TSCH to userspace for subchannel-
>  related processing.
> 
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
