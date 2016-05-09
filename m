From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL 04/10] KVM: s390: enable SRS only if enabled for the
 guest
Date: Mon, 9 May 2016 12:32:20 +0200
Message-ID: <20160509103220.GA4081@osiris>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
 <1462785621-12600-5-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462785621-12600-5-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 09, 2016 at 11:20:15AM +0200, Christian Borntraeger wrote:
> From: David Hildenbrand <dahi@linux.vnet.ibm.com>
> 
> If we don't have SIGP SENSE RUNNING STATUS enabled for the guest, let's
> not enable interpretation so we can correctly report an invalid order.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/sigp.h | 1 +
>  arch/s390/kvm/kvm-s390.c     | 4 +++-
>  arch/s390/kvm/sigp.c         | 6 ++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
> index ec60cf7..35c91da 100644
> --- a/arch/s390/include/asm/sigp.h
> +++ b/arch/s390/include/asm/sigp.h
> @@ -33,6 +33,7 @@
>  #define SIGP_STATUS_INVALID_PARAMETER	0x00000100UL
>  #define SIGP_STATUS_INCORRECT_STATE	0x00000200UL
>  #define SIGP_STATUS_NOT_RUNNING		0x00000400UL
> +#define SIGP_STATUS_INVALID_ORDER	0x00000002UL

This new define should have been added at the top the list to keep the list
sorted. Maybe Paolo or Radim can change this when applying this patch.
