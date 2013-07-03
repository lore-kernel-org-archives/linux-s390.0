From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: kvm-io: support cookies
Date: Wed, 03 Jul 2013 11:05:50 +0200
Message-ID: <51D3E96E.5080405@redhat.com>
References: <1372841780-29645-1-git-send-email-cornelia.huck@de.ibm.com> <1372841780-29645-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1372841780-29645-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 03/07/2013 10:56, Cornelia Huck ha scritto:
> Add a new function kvm_io_bus_write_cookie() that allows users of the
> kvm io infrastructure to use a cookie value to speed up lookup of a
> device on an io bus.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  include/linux/kvm_host.h |  2 ++
>  virt/kvm/kvm_main.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e3aae6d..2d298fc 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -159,6 +159,8 @@ enum kvm_bus {
>  
>  int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  		     int len, const void *val);
> +int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +			    int len, const void *val, long *cookie);
>  int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr, int len,
>  		    void *val);
>  int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1580dd4..222475a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2891,6 +2891,50 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  	return -EOPNOTSUPP;
>  }
>  
> +/* kvm_io_bus_write_cookie - called under kvm->slots_lock */
> +int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +			    int len, const void *val, long *cookie)
> +{
> +	int idx, ret = -EOPNOTSUPP;
> +	struct kvm_io_bus *bus;
> +	struct kvm_io_range range;
> +
> +	range = (struct kvm_io_range) {
> +		.addr = addr,
> +		.len = len,
> +	};
> +
> +	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> +
> +	/* First try the device referenced by *cookie. */
> +	if ((*cookie >= 0) && (*cookie < bus->dev_count) &&
> +	    (kvm_io_bus_sort_cmp(&range, &bus->range[*cookie]) == 0))
> +		if (!kvm_iodevice_write(bus->range[*cookie].dev, addr, len,
> +					val))
> +			return 0;

Nice idea, though I don't really like the duplication between
kvm_io_bus_write and kvm_io_bus_write_cookie.

Can you make kvm_io_bus_write, and perhaps kvm_io_bus_read too, return
the cookie, and return -EINVAL here if the cookie is garbage?
(Unfortunately, most callers of kvm_io_bus_read/write expect them to
never return a value that is >= 0, but there aren't many so it's easily
solved).

Paolo

> +
> +	/*
> +	 * *cookie contained garbage; fall back to search and return the
> +	 * correct value in *cookie.
> +	 */
> +	idx = kvm_io_bus_get_first_dev(bus, addr, len);
> +	if (idx < 0)
> +		goto out;
> +
> +	while (idx < bus->dev_count &&
> +		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
> +		if (!kvm_iodevice_write(bus->range[idx].dev, addr, len, val)) {
> +			ret = 0;
> +			goto out;
> +		}
> +		idx++;
> +	}
> +	idx = -ENOENT;
> +out:
> +	*cookie = idx;
> +	return ret;
> +}
> +
>  /* kvm_io_bus_read - called under kvm->slots_lock */
>  int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  		    int len, void *val)
> 
