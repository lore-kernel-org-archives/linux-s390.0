Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Wed, 19 Dec 2018 09:29:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RESEND PATCH v5 1/6] perf: Introduce ioctl to communicate
 driver configuration to kernel
Message-ID: <20181219082906.GA31670@kroah.com>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-2-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545067306-31687-2-git-send-email-mathieu.poirier@linaro.org>
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

On Mon, Dec 17, 2018 at 10:21:41AM -0700, Mathieu Poirier wrote:
> Adding a new IOCTL command to communicate PMU specific configuration to
> PMU kernel drivers.  This can be anything a PMU might need for
> configuration that doesn't fit in the perf_event_attr structure, such
> as the CoreSight sink to use for a session.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  include/uapi/linux/perf_event.h       | 1 +
>  tools/include/uapi/linux/perf_event.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 9de8780ac8d9..a39d8dc2e7a9 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -462,6 +462,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, __u64 *)
>  
>  enum perf_event_ioc_flags {
>  	PERF_IOC_FLAG_GROUP		= 1U << 0,
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 9de8780ac8d9..a39d8dc2e7a9 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -462,6 +462,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, __u64 *)

A pointer to an unknown structure?  That's just asking for abuse :(


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
