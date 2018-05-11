From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH RFC 1/2] s390/cio: export hsch to modules
Date: Fri, 11 May 2018 11:36:10 +0200
Message-ID: <f93c7d39-0924-c3e6-d954-987d82252cb6@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-2-cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509154822.23510-2-cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On 09/05/2018 17:48, Cornelia Huck wrote:
> The vfio-ccw code will need this, and it matches treatment of ssch
> and csch.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/ioasm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
> index 14d328338ce2..08eb10283b18 100644
> --- a/drivers/s390/cio/ioasm.c
> +++ b/drivers/s390/cio/ioasm.c
> @@ -233,6 +233,7 @@ int hsch(struct subchannel_id schid)
>   
>   	return ccode;
>   }
> +EXPORT_SYMBOL(hsch);
>   
>   static inline int __xsch(struct subchannel_id schid)
>   {

hsch already defined in ioasm.h so, all OK

Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
