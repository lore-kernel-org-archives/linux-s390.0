From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 10/11] KVM: s390: sthyi: remove invalid guest write
 access
Date: Mon, 28 Aug 2017 13:39:47 +0200
Message-ID: <20170828133947.261f607c.cohuck@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
        <1503907651-65296-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-4-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Aug 2017 10:07:30 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> handle_sthyi() always writes to guest memory if the sthyi function
> code is zero in order to fault in the page that later is written to.
> 
> However a function code of zero does not necessarily mean that a write
> to guest memory happens: if the KVM host is running as a second level
> guest under z/VM 6.2 the sthyi instruction is indicated to be
> available to the KVM host, however if the instruction is executed it
> will always return with a return code that indicates "unsupported
> function code".
> 
> In such a case handle_sthyi() must not write to guest memory. This
> means that the prior write access to fault in the guest page may
> result in invalid guest exceptions, and/or invalid data modification.
> 
> In order to be architecture compliant simply remove the write_guest()
> call.
> 
> Given that the guest assumed a write access anyway, this fix does not
> qualify for -stable. This just makes sure the sthyi handler is
> architecture compliant.
> 
> Fixes: 95ca2cb57985 ("KVM: s390: Add sthyi emulation")
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/sthyi.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
