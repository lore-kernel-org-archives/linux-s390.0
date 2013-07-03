From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH v4 1/2] KVM: kvm-io: support cookies
Date: Wed, 3 Jul 2013 18:05:09 +0300
Message-ID: <20130703150509.GF32123@redhat.com>
References: <1372861854-23043-1-git-send-email-cornelia.huck@de.ibm.com>
 <1372861854-23043-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372861854-23043-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 03, 2013 at 04:30:53PM +0200, Cornelia Huck wrote:
> Add new functions kvm_io_bus_{read,write}_cookie() that allows users of
> the kvm io infrastructure to use a cookie value to speed up lookup of a
> device on an io bus.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Looks good to me now.

> ---
>  include/linux/kvm_host.h |   4 ++
>  virt/kvm/kvm_main.c      | 106 ++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 95 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e3aae6d..60e261c9 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -159,8 +159,12 @@ enum kvm_bus {
>  
>  int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  		     int len, const void *val);
> +int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +			    int len, const void *val, long cookie);
>  int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr, int len,
>  		    void *val);
> +int kvm_io_bus_read_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +			   int len, void *val, long cookie);
>  int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  			    int len, struct kvm_io_device *dev);
>  int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1580dd4..c7f5355 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2863,11 +2863,48 @@ static int kvm_io_bus_get_first_dev(struct kvm_io_bus *bus,
>  	return off;
>  }
>  
> +static int __kvm_io_bus_write(struct kvm_io_bus *bus,
> +			      struct kvm_io_range *range, const void *val)
> +{
> +	int idx;
> +
> +	idx = kvm_io_bus_get_first_dev(bus, range->addr, range->len);
> +	if (idx < 0)
> +		return -EOPNOTSUPP;
> +
> +	while (idx < bus->dev_count &&
> +		kvm_io_bus_sort_cmp(range, &bus->range[idx]) == 0) {
> +		if (!kvm_iodevice_write(bus->range[idx].dev, range->addr,
> +					range->len, val))
> +			return idx;
> +		idx++;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  /* kvm_io_bus_write - called under kvm->slots_lock */
>  int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  		     int len, const void *val)
>  {
> -	int idx;
> +	struct kvm_io_bus *bus;
> +	struct kvm_io_range range;
> +	int r;
> +
> +	range = (struct kvm_io_range) {
> +		.addr = addr,
> +		.len = len,
> +	};
> +
> +	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> +	r = __kvm_io_bus_write(bus, &range, val);
> +	return r < 0 ? r : 0;
> +}
> +
> +/* kvm_io_bus_write_cookie - called under kvm->slots_lock */
> +int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +			    int len, const void *val, long cookie)
> +{
>  	struct kvm_io_bus *bus;
>  	struct kvm_io_range range;
>  
> @@ -2877,14 +2914,35 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  	};
>  
>  	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> -	idx = kvm_io_bus_get_first_dev(bus, addr, len);
> +
> +	/* First try the device referenced by cookie. */
> +	if ((cookie >= 0) && (cookie < bus->dev_count) &&
> +	    (kvm_io_bus_sort_cmp(&range, &bus->range[cookie]) == 0))
> +		if (!kvm_iodevice_write(bus->range[cookie].dev, addr, len,
> +					val))
> +			return cookie;
> +
> +	/*
> +	 * cookie contained garbage; fall back to search and return the
> +	 * correct cookie value.
> +	 */
> +	return __kvm_io_bus_write(bus, &range, val);
> +}
> +
> +static int __kvm_io_bus_read(struct kvm_io_bus *bus, struct kvm_io_range *range,
> +			     void *val)
> +{
> +	int idx;
> +
> +	idx = kvm_io_bus_get_first_dev(bus, range->addr, range->len);
>  	if (idx < 0)
>  		return -EOPNOTSUPP;
>  
>  	while (idx < bus->dev_count &&
>  		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
> -		if (!kvm_iodevice_write(bus->range[idx].dev, addr, len, val))
> -			return 0;
> +		if (!kvm_iodevice_read(bus->range[idx].dev, range->addr,
> +				       range->len, val))
> +			return idx;
>  		idx++;
>  	}
>  
> @@ -2895,9 +2953,9 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  		    int len, void *val)
>  {
> -	int idx;
>  	struct kvm_io_bus *bus;
>  	struct kvm_io_range range;
> +	int r;
>  
>  	range = (struct kvm_io_range) {
>  		.addr = addr,
> @@ -2905,18 +2963,36 @@ int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  	};
>  
>  	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> -	idx = kvm_io_bus_get_first_dev(bus, addr, len);
> -	if (idx < 0)
> -		return -EOPNOTSUPP;
> +	r = __kvm_io_bus_read(bus, &range, val);
> +	return r < 0 ? r : 0;
> +}
>  
> -	while (idx < bus->dev_count &&
> -		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
> -		if (!kvm_iodevice_read(bus->range[idx].dev, addr, len, val))
> -			return 0;
> -		idx++;
> -	}
> +/* kvm_io_bus_read_cookie - called under kvm->slots_lock */
> +int kvm_io_bus_read_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> +			   int len, void *val, long cookie)
> +{
> +	struct kvm_io_bus *bus;
> +	struct kvm_io_range range;
>  
> -	return -EOPNOTSUPP;
> +	range = (struct kvm_io_range) {
> +		.addr = addr,
> +		.len = len,
> +	};
> +
> +	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> +
> +	/* First try the device referenced by cookie. */
> +	if ((cookie >= 0) && (cookie < bus->dev_count) &&
> +	    (kvm_io_bus_sort_cmp(&range, &bus->range[cookie]) == 0))
> +		if (!kvm_iodevice_read(bus->range[cookie].dev, addr, len,
> +				       val))
> +			return cookie;
> +
> +	/*
> +	 * cookie contained garbage; fall back to search and return the
> +	 * correct cookie value.
> +	 */
> +	return __kvm_io_bus_read(bus, &range, val);
>  }
>  
>  /* Caller must hold slots_lock. */
> -- 
> 1.8.2.2

--
			Gleb.
