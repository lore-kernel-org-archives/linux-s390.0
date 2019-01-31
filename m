Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v3 7/7] perf tools: Remove PMU::set_drv_config API
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
 <20190131184714.20388-8-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <695e25a7-d1f0-d764-493e-4c64310ef16b@arm.com>
Date: Thu, 31 Jan 2019 19:03:48 +0000
MIME-Version: 1.0
In-Reply-To: <20190131184714.20388-8-mathieu.poirier@linaro.org>
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



On 31/01/2019 18:47, Mathieu Poirier wrote:
> CoreSight was the only client of the PMU's set_drv_config() API.  Now
> that it is no longer needed by CoreSight remove it from the code base.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   tools/perf/builtin-record.c   | 10 -----
>   tools/perf/builtin-stat.c     |  9 ----
>   tools/perf/builtin-top.c      | 13 ------
>   tools/perf/util/Build         |  1 -
>   tools/perf/util/drv_configs.c | 78 -----------------------------------
>   tools/perf/util/drv_configs.h | 26 ------------
>   tools/perf/util/pmu.h         |  1 -
>   7 files changed, 138 deletions(-)
>   delete mode 100644 tools/perf/util/drv_configs.c
>   delete mode 100644 tools/perf/util/drv_configs.h

Nice !

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
