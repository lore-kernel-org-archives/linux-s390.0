Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61510 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgI0Bjz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Sep 2020 21:39:55 -0400
Date: Sun, 27 Sep 2020 03:39:43 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 12/16] s390/zcrypt: Notify driver on config changed
 and scan complete callbacks
Message-ID: <20200927033943.28943540.pasic@linux.ibm.com>
In-Reply-To: <20200821195616.13554-13-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-13-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:12 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> This patch intruduces an extension to the ap bus to notify drivers
> on crypto config changed and bus scan complete events.
> Two new callbacks are introduced for ap_drivers:
> 
>   void (*on_config_changed)(struct ap_config_info *new_config_info,
>                              struct ap_config_info *old_config_info);
>   void (*on_scan_complete)(struct ap_config_info *new_config_info,
>                              struct ap_config_info *old_config_info);
> 
> Both callbacks are optional. Both callbacks are only triggered
> when QCI information is available (facility bit 12):
> 
> * The on_config_changed callback is invoked at the start of the AP bus scan
>   function when it determines that the host AP configuration information
>   has changed since the previous scan. This is done by storing
>   an old and current QCI info struct and comparing them. If there is any
>   difference, the callback is invoked.
> 
>   Note that when the AP bus scan detects that AP adapters or domains have
>   been removed from the host's AP configuration, it will remove the
>   associated devices from the AP bus subsystem's device model. This
>   callback gives the device driver a chance to respond to the removal
>   of the AP devices in bulk rather than one at a time as its remove
>   callback is invoked. It will also allow the device driver to do any
>   any cleanup prior to giving control back to the bus piecemeal. This is
>   particularly important for the vfio_ap driver because there may be
>   guests using the queues at the time.
> 
> * The on_scan_complete callback is invoked after the ap bus scan is
>   complete if the host AP configuration data has changed.
> 
>   Note that when the AP bus scan detects that adapters or domains have
>   been added to the host's configuration, it will create new devices in
>   the AP bus subsystem's device model. This callback also allows the driver
>   to process all of the new devices in bulk.
> 
> Please note that changes to the apmask and aqmask do not trigger
> these two callbacks since the bus scan function is not invoked by changes
> to those masks.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 85 +++++++++++++++++++++++++++++++++++-
>  drivers/s390/crypto/ap_bus.h | 12 +++++
>  2 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index db27bd931308..cbf4c4d2e573 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -73,8 +73,10 @@ struct ap_perms ap_perms;
>  EXPORT_SYMBOL(ap_perms);
>  DEFINE_MUTEX(ap_perms_mutex);
>  EXPORT_SYMBOL(ap_perms_mutex);
> +DEFINE_MUTEX(ap_config_lock);
>  
>  static struct ap_config_info *ap_qci_info;
> +static struct ap_config_info *ap_qci_info_old;
>  
>  /*
>   * AP bus related debug feature things.
> @@ -1412,6 +1414,52 @@ static int __match_queue_device_with_queue_id(struct device *dev, const void *da
>  		&& AP_QID_QUEUE(to_ap_queue(dev)->qid) == (int)(long) data;
>  }
>  
> +/* Helper function for notify_config_changed */
> +static int __drv_notify_config_changed(struct device_driver *drv, void *data)
> +{
> +	struct ap_driver *ap_drv = to_ap_drv(drv);
> +
> +	if (try_module_get(drv->owner)) {
> +		if (ap_drv->on_config_changed)
> +			ap_drv->on_config_changed(ap_qci_info,
> +						  ap_qci_info_old);
> +		module_put(drv->owner);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Notify all drivers about an qci config change */
> +static inline void notify_config_changed(void)
> +{
> +	bus_for_each_drv(&ap_bus_type, NULL, NULL,
> +			 __drv_notify_config_changed);
> +}
> +
> +/* Helper function for notify_scan_complete */
> +static int __drv_notify_scan_complete(struct device_driver *drv, void *data)
> +{
> +	struct ap_driver *ap_drv = to_ap_drv(drv);
> +
> +	if (try_module_get(drv->owner)) {
> +		if (ap_drv->on_scan_complete)
> +			ap_drv->on_scan_complete(ap_qci_info,
> +						 ap_qci_info_old);
> +		module_put(drv->owner);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Notify all drivers about bus scan complete */
> +static inline void notify_scan_complete(void)
> +{
> +	bus_for_each_drv(&ap_bus_type, NULL, NULL,
> +			 __drv_notify_scan_complete);
> +}
> +
> +
> +

Too many blank lines?

>  /*
>   * Helper function for ap_scan_bus().
>   * Does the scan bus job for the given adapter id.
> @@ -1565,15 +1613,44 @@ static void _ap_scan_bus_adapter(int id)
>  		put_device(&ac->ap_dev.device);
>  }
>  
> +static int ap_config_changed(void)
> +{
> +	int cfg_chg = 0;
> +
> +	if (ap_qci_info) {
> +		if (!ap_qci_info_old) {
> +			ap_qci_info_old = kzalloc(sizeof(*ap_qci_info_old),
> +						  GFP_KERNEL);
> +			if (!ap_qci_info_old)
> +				return 0;
> +		} else {
> +			memcpy(ap_qci_info_old, ap_qci_info,
> +			       sizeof(struct ap_config_info));
> +		}
> +		ap_fetch_qci_info(ap_qci_info);
> +		cfg_chg = memcmp(ap_qci_info,
> +				 ap_qci_info_old,
> +				 sizeof(struct ap_config_info)) != 0;
> +	}
> +
> +	return cfg_chg;
> +}
> +
>  /**
>   * ap_scan_bus(): Scan the AP bus for new devices
>   * Runs periodically, workqueue timer (ap_config_time)
>   */
>  static void ap_scan_bus(struct work_struct *unused)
>  {
> -	int id;
> +	int id, config_changed = 0;
>  
>  	ap_fetch_qci_info(ap_qci_info);

Do we still need this ap_fetch_qci_info()? ...

> +	mutex_lock(&ap_config_lock);

The usage of ap_qci_info does not seem to change substantially, and
ap_qci_info_old is not used unlike. I believe if we need ap_config_lock
now, then we used to need it before. And then adding this lock should
really be a separate patch than clearly advertises its fix nature.


> +
> +	/* config change notify */
> +	config_changed = ap_config_changed();

... I mean ap_config_changed() does a ap_fetch_qci_info()
of it's own.

Otherwise looks OK!

Regards,
Halil

> +	if (config_changed)
> +		notify_config_changed();
>  	ap_select_domain();
>  
>  	AP_DBF(DBF_DEBUG, "%s running\n", __func__);
> @@ -1582,6 +1659,12 @@ static void ap_scan_bus(struct work_struct *unused)
>  	for (id = 0; id < AP_DEVICES; id++)
>  		_ap_scan_bus_adapter(id);
>  
> +	/* scan complete notify */
> +	if (config_changed)
> +		notify_scan_complete();
> +
> +	mutex_unlock(&ap_config_lock);
> +
>  	/* check if there is at least one queue available with default domain */
>  	if (ap_domain_index >= 0) {
>  		struct device *dev =
> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
> index 48c57b3d53a0..3fc743ac549c 100644
> --- a/drivers/s390/crypto/ap_bus.h
> +++ b/drivers/s390/crypto/ap_bus.h
> @@ -137,6 +137,18 @@ struct ap_driver {
>  	int (*probe)(struct ap_device *);
>  	void (*remove)(struct ap_device *);
>  	bool (*in_use)(unsigned long *apm, unsigned long *aqm);
> +	/*
> +	 * Called at the start of the ap bus scan function when
> +	 * the crypto config information (qci) has changed.
> +	 */
> +	void (*on_config_changed)(struct ap_config_info *new_config_info,
> +				  struct ap_config_info *old_config_info);
> +	/*
> +	 * Called at the end of the ap bus scan function when
> +	 * the crypto config information (qci) has changed.
> +	 */
> +	void (*on_scan_complete)(struct ap_config_info *new_config_info,
> +				 struct ap_config_info *old_config_info);
>  };
>  
>  #define to_ap_drv(x) container_of((x), struct ap_driver, driver)
