From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/5] KVM: s390: SIE considerations for AP Queue
 virtualization
Date: Wed, 8 Nov 2017 10:06:47 +0100
Message-ID: <20171108100647.4b2a22b6.cohuck@redhat.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
        <20171108084143.78654-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171108084143.78654-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Nov 2017 09:41:40 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> 
> The Crypto Control Block (CRYCB) is referenced by the SIE state
> description and controls KVM guest access to the Adjunct
> Processor (AP) adapters, usage domains and control domains.
> This patch defines the AP control blocks to be used for
> controlling guest access to the AP adapters and domains.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> Message-Id: <1507916344-3896-2-git-send-email-akrowiak@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

I obviously can't verify (no doc), but I trust that you have done so,
so:

Acked-by: Cornelia Huck <cohuck@redhat.com>
