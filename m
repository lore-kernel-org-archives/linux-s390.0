Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v2 2/7] coresight: perf: Add "sinks" group to PMU directory
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
 <20190122181144.26645-3-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <aed8011b-5487-a30a-559f-e0daf2867f67@arm.com>
Date: Wed, 30 Jan 2019 17:44:42 +0000
MIME-Version: 1.0
In-Reply-To: <20190122181144.26645-3-mathieu.poirier@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com, ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Mathieu,


On 01/22/2019 06:11 PM, Mathieu Poirier wrote:
> Add a "sinks" directory entry so that users can see all the sinks
> available in the system in a single place.  Individual sink are added
> as they are registered with the coresight bus.

A couple of minor comments.

> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-etm-perf.c  | 76 +++++++++++++++++++
>   .../hwtracing/coresight/coresight-etm-perf.h  |  6 +-
>   drivers/hwtracing/coresight/coresight.c       | 18 +++++
>   include/linux/coresight.h                     |  7 +-
>   4 files changed, 104 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f21eb28b6782..c68a0036532c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -14,6 +14,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/percpu-defs.h>
>   #include <linux/slab.h>
> +#include <linux/stringhash.h>
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
>   
> @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
>   	.attrs  = etm_config_formats_attr,
>   };
>   
> +static struct attribute *etm_config_sinks_attr[] = {
> +	NULL,
> +};
> +
> +static const struct attribute_group etm_pmu_sinks_group = {
> +	.name   = "sinks",
> +	.attrs  = etm_config_sinks_attr,
> +};
> +
>   static const struct attribute_group *etm_pmu_attr_groups[] = {
>   	&etm_pmu_format_group,
> +	&etm_pmu_sinks_group,
>   	NULL,
>   };

I was thinking if this could be the "events" directory for ETM pmu. We
don't have any other event codes. Even if we get in the future, we could
expose them here. But from a quick try it looks like the event names
cannot start with a number (e.g, 2007000.etr wouldn't parse as an event
name). So we could leave this as above and switch when we get generic
naming scheme.

>   
> @@ -479,6 +490,71 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
>   	return 0;
>   }
>   
> +static ssize_t etm_perf_sink_name_show(struct device *dev,
> +				       struct device_attribute *dattr,
> +				       char *buf)
> +{
> +	/* See function coresight_get_sink_by_id() to know where this is used */
> +	u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> +
> +	return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> +}

You may need "0x%x" to avoid confusions interpreting the data.

> +
> +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> +{
> +	int ret;
> +	struct device *pmu_dev = etm_pmu.dev;
> +	struct device *pdev = csdev->dev.parent;
> +	struct device_attribute *dattr;

If we make this a struct dev_ext_attribute(), you get a space to
store the "id" in the "var" field. This can be used for

1) name_show() above

we could do :
	struct dev_ext_attribute *eattr = container_of(attr,
					struct dev_ext_attribute, attr);

	return scnprintf(bu, PAGE_SIZE, "0x%x\n", (u32)eattr->var);

2) Matching the ID of a sink device in lookup by simply doing :
	(u32)csdev->dattr.var == (u32)(void *)data

and can avoid computing the hash all the time.

> +
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> +	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> +		return -EINVAL;
> +
> +	if (csdev->dattr != NULL)
> +		return -EINVAL;
> +
> +	if (!etm_perf_up)
> +		return -EPROBE_DEFER;
> +
> +	dattr = kzalloc(sizeof(*dattr), GFP_KERNEL);

nit: Could we use devm_kzalloc(pdev, ...) ?

> +	dattr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);.


similarly here : devm_kstrdup()

> +	dattr->attr.mode = 0444;
> +	dattr->show = etm_perf_sink_name_show;
> +	csdev->dattr = dattr;
> +
> +	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> +				      &dattr->attr, "sinks");
> +
> +	if (!ret)
> +		return 0;
> +
> +	csdev->dattr = NULL;
> +	kfree(dattr->attr.name);
> +	kfree(dattr);

And we could get rid of these ^

> +
> +	return ret;
> +}
> +
> +void etm_perf_del_symlink_sink(struct coresight_device *csdev)
> +{
> +	struct device *pmu_dev = etm_pmu.dev;
> +	struct device_attribute *dattr = csdev->dattr;
> +
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> +	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> +		return;
> +
> +	if (!dattr)
> +		return;
> +
> +	sysfs_remove_file_from_group(&pmu_dev->kobj,
> +				     &dattr->attr, "sinks");
> +	csdev->dattr = NULL;
> +	kfree(dattr->attr.name);
> +	kfree(dattr);ext

And these ^^

> +}


> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 46c67a764877..a42fac83eac9 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -154,8 +154,9 @@ struct coresight_connection {
>    * @orphan:	true if the component has connections that haven't been linked.
>    * @enable:	'true' if component is currently part of an active path.
>    * @activated:	'true' only if a _sink_ has been activated.  A sink can be
> -		activated but not yet enabled.  Enabling for a _sink_
> -		happens when a source has been selected for that it.
> + *		activated but not yet enabled.  Enabling for a _sink_
> + *		appens when a source has been selected for that it.
> + * @dattr:	Device attribute for sink representation under PMU directory.
>    */
>   struct coresight_device {
>   	struct coresight_connection *conns;
> @@ -168,7 +169,9 @@ struct coresight_device {
>   	atomic_t *refcnt;
>   	bool orphan;
>   	bool enable;	/* true only if configured as part of a path */
> +	/* sink specific fields */
>   	bool activated;	/* true only if a sink is part of a path */
> +	struct device_attribute *dattr;

See my comment above about switching to struct dev_ext_attribute *.

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
