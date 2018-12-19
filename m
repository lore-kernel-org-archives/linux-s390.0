Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Wed, 19 Dec 2018 09:31:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RESEND PATCH v5 2/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
Message-ID: <20181219083143.GB31670@kroah.com>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-3-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545067306-31687-3-git-send-email-mathieu.poirier@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, acme@kernel.org, ast@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 17, 2018 at 10:21:42AM -0700, Mathieu Poirier wrote:
> This patch adds the mechanic needed for user space to send PMU specific
> configuration to the kernel driver using an ioctl() command.  That way
> events can keep track of options that don't fit in the perf_event_attr
> structure like the selection of a CoreSight sink to use for the session.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  include/linux/perf_event.h | 38 ++++++++++++++++++++++++++
>  kernel/events/core.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f0ca79..8e69b7e309e7 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -114,6 +114,14 @@ struct hw_perf_event_extra {
>  	int		idx;	/* index in shared_regs->regs[] */
>  };
>  
> +/*
> + * PMU driver configuration
> + */
> +struct pmu_drv_config {
> +	void		*config;
> +	raw_spinlock_t	lock;
> +};
> +
>  /**
>   * struct hw_perf_event - performance event hardware details:
>   */
> @@ -178,6 +186,9 @@ struct hw_perf_event {
>  	/* Last sync'ed generation of filters */
>  	unsigned long			addr_filters_gen;
>  
> +	/* PMU driver configuration */
> +	struct pmu_drv_config		drv_config;
> +
>  /*
>   * hw_perf_event::state flags; used to track the PERF_EF_* state.
>   */
> @@ -447,6 +458,17 @@ struct pmu {
>  	 * Filter events for PMU-specific reasons.
>  	 */
>  	int (*filter_match)		(struct perf_event *event); /* optional */
> +
> +	/*
> +	 * Validate complex PMU configuration that don't fit in the
> +	 * perf_event_attr struct.  Returns a PMU specific pointer or an error
> +	 * value < 0.
> +	 *
> +	 * As with addr_filters_validate(), runs in the context of the ioctl()
> +	 * process and is not serialized with the rest of the PMU callbacks.
> +	 */
> +	void *(*drv_config_validate)	(struct perf_event *event,
> +					 u64 value);
>  };
>  
>  enum perf_addr_filter_action_t {
> @@ -1235,6 +1257,11 @@ static inline bool has_addr_filter(struct perf_event *event)
>  	return event->pmu->nr_addr_filters;
>  }
>  
> +static inline bool has_drv_config(struct perf_event *event)
> +{
> +	return event->pmu->drv_config_validate;
> +}
> +
>  /*
>   * An inherited event uses parent's filters
>   */
> @@ -1249,6 +1276,17 @@ perf_event_addr_filters(struct perf_event *event)
>  	return ifh;
>  }
>  
> +static inline struct pmu_drv_config *
> +perf_event_get_drv_config(struct perf_event *event)
> +{
> +	struct pmu_drv_config *cfg = &event->hw.drv_config;
> +
> +	if (event->parent)
> +		cfg = &event->parent->hw.drv_config;
> +
> +	return cfg;
> +}
> +
>  extern void perf_event_addr_filters_sync(struct perf_event *event);
>  
>  extern int perf_output_begin(struct perf_output_handle *handle,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 84530ab358c3..af7a53c97744 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5003,6 +5003,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
>  static int perf_event_set_output(struct perf_event *event,
>  				 struct perf_event *output_event);
>  static int perf_event_set_filter(struct perf_event *event, void __user *arg);
> +static int perf_event_set_drv_config(struct perf_event *event,
> +				     void __user *arg);
>  static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
>  static int perf_copy_attr(struct perf_event_attr __user *uattr,
>  			  struct perf_event_attr *attr);
> @@ -5089,6 +5091,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>  
>  		return perf_event_modify_attr(event,  &new_attr);
>  	}
> +
> +	case PERF_EVENT_IOC_SET_DRV_CONFIG:
> +		return perf_event_set_drv_config(event, (void __user *)arg);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -9128,6 +9134,66 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
>  	return ret;
>  }
>  
> +static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
> +{
> +	unsigned long flags;
> +	struct pmu_drv_config *drv_config = &event->hw.drv_config;
> +
> +	if (!has_drv_config(event))
> +		return;
> +
> +	/* Children take their configuration from their parent */
> +	if (event->parent)
> +		return;
> +
> +	/* Make sure the PMU doesn't get a handle on the data */
> +	raw_spin_lock_irqsave(&drv_config->lock, flags);
> +	drv_config->config = drv_data;
> +	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
> +}
> +
> +static int
> +perf_event_process_drv_config(struct perf_event *event, u64 value)
> +{
> +	int ret = -EINVAL;
> +	void *drv_data;
> +
> +	/* Make sure ctx.mutex is held */
> +	lockdep_assert_held(&event->ctx->mutex);
> +
> +	/* Children take their configuration from their parent */
> +	if (WARN_ON_ONCE(event->parent))
> +		goto out;
> +
> +	drv_data = event->pmu->drv_config_validate(event, value);
> +	if (IS_ERR(drv_data)) {
> +		ret = PTR_ERR(drv_data);
> +		goto out;
> +	}
> +
> +	perf_drv_config_replace(event, drv_data);
> +
> +	ret = 0;
> +out:
> +	return ret;
> +}
> +
> +static int perf_event_set_drv_config(struct perf_event *event, void __user *arg)
> +{
> +	int ret;
> +	u64 value;
> +
> +	if (!has_drv_config(event))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&value, arg, sizeof(value)))
> +		return -EFAULT;

You are just sending in a pointer to a u64?  Why not just pass a u64
directly instead?  Why is a pointer needed here?

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
