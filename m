Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v2 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU
 header file
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
 <20190122181144.26645-5-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fe640760-89b8-7ae7-f742-a9f81642d0e4@arm.com>
Date: Wed, 30 Jan 2019 17:50:30 +0000
MIME-Version: 1.0
In-Reply-To: <20190122181144.26645-5-mathieu.poirier@linaro.org>
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

On 01/22/2019 06:11 PM, Mathieu Poirier wrote:
> Moving definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
> used by other files than pmu.c
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   tools/perf/util/pmu.c | 2 --
>   tools/perf/util/pmu.h | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 11a234740632..51d437f55d18 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -29,8 +29,6 @@ struct perf_pmu_format {
>   	struct list_head list;
>   };
>   
> -#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
> -
>   int perf_pmu_parse(struct list_head *list, char *name);
>   extern FILE *perf_pmu_in;
>   
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 76fecec7b3f9..350c54e0bd3d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -16,6 +16,7 @@ enum {
>   };
>   
>   #define PERF_PMU_FORMAT_BITS 64
> +#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>   
>   struct perf_event_attr;
>   
> 

FWIW:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
