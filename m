From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/2] KVM: s390: sthyi: fix sthyi inline assembly
Date: Mon, 21 Aug 2017 14:44:57 +0200
Message-ID: <ae54fd75-8460-1e63-f479-9072867a0418@redhat.com>
References: <1503318465-19013-1-git-send-email-borntraeger@de.ibm.com>
 <1503318465-19013-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503318465-19013-2-git-send-email-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 21.08.2017 14:27, Christian Borntraeger wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> The sthyi inline assembly misses register r3 within the clobber
> list. The sthyi instruction will always write a return code to
> register "R2+1", which in this case would be r3. Due to that we may
> have register corruption and see host crashes or data corruption
> depending on how gcc decided to allocate and use registers during
> compile time.
> 
> Fixes: 95ca2cb57985 ("KVM: s390: Add sthyi emulation")
> Cc: <stable@vger.kernel.org> # 4.8+
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/sthyi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
> index 926b524..2773a2f 100644
> --- a/arch/s390/kvm/sthyi.c
> +++ b/arch/s390/kvm/sthyi.c
> @@ -394,7 +394,7 @@ static int sthyi(u64 vaddr)
>  		"srl     %[cc],28\n"
>  		: [cc] "=d" (cc)
>  		: [code] "d" (code), [addr] "a" (addr)
> -		: "memory", "cc");
> +		: "3", "memory", "cc");
>  	return cc;
>  }
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
