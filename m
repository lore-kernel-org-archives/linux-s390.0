Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v3 3/7] coresight: Use event attributes for sink selection
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
 <20190131184714.20388-4-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6fa9c1f9-2952-f758-851d-4fe4335d561b@arm.com>
Date: Thu, 31 Jan 2019 18:58:50 +0000
MIME-Version: 1.0
In-Reply-To: <20190131184714.20388-4-mathieu.poirier@linaro.org>
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
> This patch uses the information conveyed by perf_event::attr::config2
> to select a sink to use for the session.  That way a sink can easily be
> selected to be used by more than one source, something that isn't currently
> possible with the sysfs implementation.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
