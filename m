Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
Date: Wed, 16 Jan 2019 10:29:26 +0000
MIME-Version: 1.0
In-Reply-To: <20190115230742.13730-3-mathieu.poirier@linaro.org>
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
To: mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, alexander.shishkin@linux.intel.com, will.deacon@arm.com, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 15/01/2019 23:07, Mathieu Poirier wrote:
> Add a "sinks" directory entry so that users can see all the sinks
> available in the system in a single place.  Individual sink are added
> as they are registered with the coresight bus.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
>   .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
>   drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f21eb28b6782..292bd409a68c 100644
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
>   
> @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
>   	return 0;
>   }
>   
> +static ssize_t etm_perf_sink_name_show(struct device *dev,
> +				       struct device_attribute *dattr,
> +				       char *buf)
> +{
> +	/* See function coresight_sink_by_id() to know where this is used */
> +	u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> +
> +	return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> +}
> +
> +int etm_perf_symlink_sink(struct coresight_device *csdev)
> +{
> +	struct device *pmu_dev = etm_pmu.dev;
> +	struct device *pdev = csdev->dev.parent;
> +	struct device_attribute *dev_attr;
> +
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> +	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> +		return -EINVAL;
> +
> +	if (!etm_perf_up)
> +		return -EPROBE_DEFER;
> +
> +	dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> +	dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> +	dev_attr->attr.mode = 0444;
> +	dev_attr->show = etm_perf_sink_name_show;

I would have  added the attribute to the csdev (say, sink_attr),
and add that to the group, so that it is easier to remove the
attribute when the sink device is removed from the system (when
we get there). It would be good to have something in place to remove the
attribute.

Otherwise, the overall approach looks fine to me.

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
