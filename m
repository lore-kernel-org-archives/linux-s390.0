From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM/s390: Fix trivial typo in comments
Date: Fri, 27 Feb 2015 09:26:04 +0100
Message-ID: <54F02A1C.9050703@de.ibm.com>
References: <1424989004-14412-1-git-send-email-yguerrini@tomshardware.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1424989004-14412-1-git-send-email-yguerrini@tomshardware.fr>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Yannick Guerrini <yguerrini@tomshardware.fr>
Cc: cornelia.huck@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, trivial@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am 26.02.2015 um 23:16 schrieb Yannick Guerrini:
> Change 'architecuture' to 'architecture'
> 
> Signed-off-by: Yannick Guerrini <yguerrini@tomshardware.fr>

Thanks, applied. 

> ---
>  arch/s390/kvm/gaccess.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 267523c..633fe9b 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -333,7 +333,7 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
>   * @write: indicates if access is a write access
>   *
>   * Translate a guest virtual address into a guest absolute address by means
> - * of dynamic address translation as specified by the architecuture.
> + * of dynamic address translation as specified by the architecture.
>   * If the resulting absolute address is not available in the configuration
>   * an addressing exception is indicated and @gpa will not be changed.
>   *
> 
