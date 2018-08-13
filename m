From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
Date: Mon, 13 Aug 2018 11:34:27 +0200
Message-ID: <20180813113427.1f074afc.cohuck@redhat.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180809110645.33b20c1f.cohuck@redhat.com>
        <36670270-13f7-f044-7419-57f444317fd9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36670270-13f7-f044-7419-57f444317fd9@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2018 11:24:48 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> Here is now the add-on patch which changes the returncode for the
> ap_instructions_available() function.
> 
> I talked with Heiko Carstens and this patch will go into the next pull
> request for the 4.19 kernel.

I was just about to ask :)

> 
> -----------------------------------------------------------------------------------------
> From 9e050f843f3281da1f65292422e30f2dd1fd6d98 Mon Sep 17 00:00:00 2001
> From: Harald Freudenberger <freude@linux.ibm.com>
> Date: Thu, 9 Aug 2018 11:59:34 +0200
> Subject: [PATCH] s390/zcrypt: fix ap_instructions_available() returncodes
> 
> During review of KVM patches it was complained that the
> ap_instructions_available() function returns 0 if AP
> instructions are available and -ENODEV if not. The function
> acts like a boolean function to check for AP instructions
> available and thus should return 0 on failure and != 0 on
> success. Changed to the suggested behaviour and adapted
> the one and only caller of this function which is the ap
> bus core code.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  arch/s390/include/asm/ap.h   | 10 +++++-----
>  drivers/s390/crypto/ap_bus.c |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)

Looks sane to me.

Acked-by: Cornelia Huck <cohuck@redhat.com>
