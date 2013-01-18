From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 03/12] s390: Add mapping helper functions.
Date: Fri, 18 Jan 2013 18:07:01 +0100
Message-ID: <4B8BCAC8-86F5-4157-BC21-04DEE1D8B149@suse.de>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com> <1358432637-42512-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-4-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 17.01.2013, at 15:23, Cornelia Huck wrote:

> Add s390_cpu_physical_memory_{map,unmap} with special handling
> for the lowcore.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> target-s390x/cpu.h    |  4 ++++
> target-s390x/helper.c | 26 ++++++++++++++++++++++++++
> 2 files changed, 30 insertions(+)
> 
> diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
> index 6700fe9..cd729d3 100644
> --- a/target-s390x/cpu.h
> +++ b/target-s390x/cpu.h
> @@ -299,6 +299,10 @@ int cpu_s390x_handle_mmu_fault (CPUS390XState *env, target_ulong address, int rw
> 
> 
> #ifndef CONFIG_USER_ONLY
> +void *s390_cpu_physical_memory_map(CPUS390XState *env, hwaddr addr, hwaddr len,
> +                                   int is_write);
> +void s390_cpu_physical_memory_unmap(CPUS390XState *env, void *addr, hwaddr len,
> +                                    int is_write);
> void s390x_tod_timer(void *opaque);
> void s390x_cpu_timer(void *opaque);
> 
> diff --git a/target-s390x/helper.c b/target-s390x/helper.c
> index bf2b4d3..d350f28 100644
> --- a/target-s390x/helper.c
> +++ b/target-s390x/helper.c
> @@ -490,6 +490,32 @@ static void cpu_unmap_lowcore(LowCore *lowcore, hwaddr len)
>     cpu_physical_memory_unmap(lowcore, len, 1, len);
> }
> 
> +void *s390_cpu_physical_memory_map(CPUS390XState *env, hwaddr addr, hwaddr len,

Please stick to the same semantics as cpu_physical_memory_map and pass hwaddr *len here. Otherwise the caller can't do sanity checks.

> +                                   int is_write)
> +{
> +    hwaddr start = addr;
> +
> +    /* Mind the prefix area. */
> +    if (addr < 8192) {
> +        start += env->psa;
> +    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
> +        start -= env->psa;
> +    }
> +
> +    if ((addr + len <= env->psa) || (addr >= env->psa + 8192)) {
> +        return cpu_physical_memory_map(start, &len, is_write);
> +    }
> +
> +    DPRINTF("mapping across lowcore boundaries not yet supported\n");

I only understand half of what this function does :). You basically want

  if (addr < 8192) {
    start += env->psa;
    len = min(8192 - addr, len);
}

We can easily support mapping of the lowcode higher up in memory, right? So we only have to take the case into account where [addr..addr+len] is within the first 8192 bytes.

And if you pass len as pointer, we can also indicate to the caller that the mapping isn't for all of the memory he requested, but only part of it.


Alex

> +    return NULL;
> +}
> +
> +void s390_cpu_physical_memory_unmap(CPUS390XState *env, void *addr, hwaddr len,
> +                                    int is_write)
> +{
> +    cpu_physical_memory_unmap(addr, len, is_write, len);
> +}
> +
> static void do_svc_interrupt(CPUS390XState *env)
> {
>     uint64_t mask, addr;
> -- 
> 1.7.12.4
> 
