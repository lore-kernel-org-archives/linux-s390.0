From: Benjamin Block <bblock@linux.ibm.com>
Date: Wed, 10 Apr 2019 12:47:45 +0000
Subject: Re: [PATCH 07/10] zfcp: implicitly refresh port-data diagnostics when reading SysFS
Message-Id: <20190410124745.GA9452@t480-pf1aa2c2>
In-Reply-To: <70ec96aaddd19db44c455607e943cff51e5389f1.1554823974.git.bblock@linux.ibm.com>
References: <70ec96aaddd19db44c455607e943cff51e5389f1.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 09, 2019 at 06:50:50PM +0200, Benjamin Block wrote:
> This patch adds implicit updates to the SysFS entries that read the
> diagnostic data stored in the "caching buffer" for Exchange Port Data.
> 
> An update is triggered once the buffer is older than ZFCP_DIAG_MAX_AGE
> milliseconds (5s). This entails sending an Exchange Port Data command to
> the FCP-Channel, and during its ingress path updating the cached data
> and the timestamp. To prevent multiple concurrent userspace-applications
> from triggering this update in parallel we synchronize all of them using
> a wait-queue (waiting threads are interruptible; the updating thread is
> not).
> 
> Reviewed-by: Steffen Maier <maier@linux.ibm.com>
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>  drivers/s390/scsi/zfcp_diag.c  | 136 +++++++++++++++++++++++++++++++++++++++++
>  drivers/s390/scsi/zfcp_diag.h  |  11 ++++
>  drivers/s390/scsi/zfcp_sysfs.c |   5 ++
>  3 files changed, 152 insertions(+)
> 
> diff --git a/drivers/s390/scsi/zfcp_diag.c b/drivers/s390/scsi/zfcp_diag.c
> index 65475d8fcef1..001ab4978bfa 100644
> --- a/drivers/s390/scsi/zfcp_diag.c
> +++ b/drivers/s390/scsi/zfcp_diag.c
> @@ -22,6 +22,8 @@
>  /* Max age of data in a diagnostics buffer before it needs a refresh (in ms). */
>  #define ZFCP_DIAG_MAX_AGE (5 * 1000)
>  
> +static DECLARE_WAIT_QUEUE_HEAD(__zfcp_diag_publish_wait);
> +
>  /**
>   * zfcp_diag_adapter_setup() - Setup storage for adapter diagnostics.
>   * @adapter: the adapter to setup diagnostics for.
> @@ -143,3 +145,137 @@ void zfcp_diag_update_xdata(struct zfcp_diag_header *const hdr,
>  out:
>  	spin_unlock_irqrestore(&hdr->access_lock, flags);
>  }
> +
> +/**
> + * zfcp_diag_update_port_data_buffer() - Implementation of
> + *                                       &typedef zfcp_diag_update_buffer_func
> + *                                       to collect and update Port Data.
> + * @adapter: Adapter to collect Port Data from.
> + *
> + * This call is SYNCHRONOUS ! It blocks till the respective command has
> + * finished completely, or has failed in some way.
> + *
> + * Return:
> + * * 0		- Successfully retrieved new Diagnostics and Updated the buffer;
> + *                this also includes cases where data was retrieved, but
> + *                incomplete; you'll have to check the flag ``incomplete``
> + *                of &struct zfcp_diag_header.
> + * * -ENOMEM	- In case it is not possible to allocate memory for the qtcb
> + *                bottom.
> + * * see zfcp_fsf_exchange_port_data_sync() for possible error-codes (
> + *   excluding -EAGAIN)
> + */
> +int zfcp_diag_update_port_data_buffer(struct zfcp_adapter *const adapter)
> +{
> +	struct fsf_qtcb_bottom_port *qtcb_bottom;
> +	int rc;
> +
> +	qtcb_bottom = kzalloc(sizeof(*qtcb_bottom), GFP_KERNEL);
> +	if (qtcb_bottom == NULL)
> +		return -ENOMEM;

Never mind, this is stupid. I'll update the series it and resend.

> +
> +	rc = zfcp_fsf_exchange_port_data_sync(adapter->qdio, qtcb_bottom);
> +	if (rc == -EAGAIN)
> +		rc = 0; /* signaling incomplete via struct zfcp_diag_header */
> +
> +	/* buffer-data was updated in zfcp_fsf_exchange_port_data_handler() */
> +
> +	return rc;
> +}
> +
> +static int __zfcp_diag_update_buffer(struct zfcp_adapter *const adapter,
> +				     struct zfcp_diag_header *const hdr,
> +				     zfcp_diag_update_buffer_func buffer_update,
> +				     unsigned long *const flags)
> +	__must_hold(hdr->access_lock)
> +{
> +	int rc;
> +
> +	if (hdr->updating == 1) {
> +		rc = wait_event_interruptible_lock_irq(__zfcp_diag_publish_wait,
> +						       hdr->updating == 0,
> +						       hdr->access_lock);
> +		rc = (rc == 0 ? -EAGAIN : -EINTR);
> +	} else {
> +		hdr->updating = 1;
> +		spin_unlock_irqrestore(&hdr->access_lock, *flags);
> +
> +		/* unlocked, because update function sleeps */
> +		rc = buffer_update(adapter);
> +
> +		spin_lock_irqsave(&hdr->access_lock, *flags);
> +		hdr->updating = 0;
> +
> +		/*
> +		 * every thread waiting here went via an interruptible wait,
> +		 * so its fine to only wake those
> +		 */
> +		wake_up_interruptible_all(&__zfcp_diag_publish_wait);
> +	}
> +
> +	return rc;
> +}
> +
> +static bool
> +__zfcp_diag_test_buffer_age_isfresh(const struct zfcp_diag_header *const hdr)
> +	__must_hold(hdr->access_lock)
> +{
> +	const unsigned long now = jiffies;
> +
> +	/*
> +	 * Should not happen (data is from the future).. if it does, still
> +	 * signal that it needs refresh
> +	 */
> +	if (!time_after_eq(now, hdr->timestamp))
> +		return false;
> +
> +	if (jiffies_to_msecs(now - hdr->timestamp) >= ZFCP_DIAG_MAX_AGE)
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * zfcp_diag_update_buffer_limited() - Collect diagnostics and update a
> + *                                     diagnostics buffer rate limited.
> + * @adapter: Adapter to collect the diagnostics from.
> + * @hdr: buffer-header for which to update with the collected diagnostics.
> + * @buffer_update: Specific implementation for collecting and updating.
> + *
> + * This function will cause an update of the given @hdr by calling the also
> + * given @buffer_update function. If called by multiple sources at the same
> + * time, it will synchornize the update by only allowing one source to call
> + * @buffer_update and the others to wait for that source to complete instead
> + * (the wait is interruptible).
> + *
> + * Additionally this version is rate-limited and will only exit if either the
> + * buffer is fresh enough (within the limit) - it will do nothing if the buffer
> + * is fresh enough to begin with -, or if the source/thread that started this
> + * update is the one that made the update (to prevent endless loops).
> + *
> + * Return:
> + * * 0          - If the update was successfully published and/or the buffer is
> + *                fresh enough
> + * * -EINTR     - If the thread went into the wait-state and was interrupted
> + * * whatever @buffer_update returns
> + */
> +int zfcp_diag_update_buffer_limited(struct zfcp_adapter *const adapter,
> +				    struct zfcp_diag_header *const hdr,
> +				    zfcp_diag_update_buffer_func buffer_update)
> +{
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(&hdr->access_lock, flags);
> +
> +	for (rc = 0; !__zfcp_diag_test_buffer_age_isfresh(hdr); rc = 0) {
> +		rc = __zfcp_diag_update_buffer(adapter, hdr, buffer_update,
> +					       &flags);
> +		if (rc != -EAGAIN)
> +			break;
> +	}
> +
> +	spin_unlock_irqrestore(&hdr->access_lock, flags);
> +
> +	return rc;
> +}
> diff --git a/drivers/s390/scsi/zfcp_diag.h b/drivers/s390/scsi/zfcp_diag.h
> index 7c7e0a726c7e..994ee7e9207c 100644
> --- a/drivers/s390/scsi/zfcp_diag.h
> +++ b/drivers/s390/scsi/zfcp_diag.h
> @@ -71,6 +71,17 @@ void zfcp_diag_sysfs_destroy(struct zfcp_adapter *const adapter);
>  void zfcp_diag_update_xdata(struct zfcp_diag_header *const hdr,
>  			    const void *const data, const bool incomplete);
>  
> +/*
> + * Function-Type used in zfcp_diag_update_buffer_limited() for the function
> + * that does the buffer-implementation dependent work.
> + */
> +typedef int (*zfcp_diag_update_buffer_func)(struct zfcp_adapter *const adapter);
> +
> +int zfcp_diag_update_port_data_buffer(struct zfcp_adapter *const adapter);
> +int zfcp_diag_update_buffer_limited(struct zfcp_adapter *const adapter,
> +				    struct zfcp_diag_header *const hdr,
> +				    zfcp_diag_update_buffer_func buffer_update);
> +
>  /**
>   * zfcp_diag_support_sfp() - Return %true if the @adapter supports reporting
>   *                           SFP Data.
> diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
> index 5323e34d94bb..e20baec37589 100644
> --- a/drivers/s390/scsi/zfcp_sysfs.c
> +++ b/drivers/s390/scsi/zfcp_sysfs.c
> @@ -650,6 +650,11 @@ struct device_attribute *zfcp_sysfs_shost_attrs[] = {
>  									       \
>  		diag_hdr = &adapter->diagnostics->port_data.header;            \
>  									       \
> +		rc = zfcp_diag_update_buffer_limited(                          \
> +			adapter, diag_hdr, zfcp_diag_update_port_data_buffer); \
> +		if (rc != 0)                                                   \
> +			goto out;                                              \
> +									       \
>  		spin_lock_irqsave(&diag_hdr->access_lock, flags);              \
>  		rc = scnprintf(                                                \
>  			buf, (_prtsize) + 2, _prtfmt "\n",                     \
> -- 
> 2.16.4
> 

-- 
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Development
IBM Systems & Technology Group   /  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Matthias Hartmann       /      Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
