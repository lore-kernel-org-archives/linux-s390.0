Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Fri, 1 Feb 2019 17:03:59 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 7/7] perf tools: Remove PMU::set_drv_config API
Message-ID: <20190201160359.GB8839@kernel.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
 <20190131184714.20388-8-mathieu.poirier@linaro.org>
 <695e25a7-d1f0-d764-493e-4c64310ef16b@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <695e25a7-d1f0-d764-493e-4c64310ef16b@arm.com>
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
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, mathieu.poirier@linaro.org, peterz@infradead.org, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com, ast@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Thu, Jan 31, 2019 at 07:03:48PM +0000, Suzuki K Poulose escreveu:
> On 31/01/2019 18:47, Mathieu Poirier wrote:
> > CoreSight was the only client of the PMU's set_drv_config() API.  Now
> > that it is no longer needed by CoreSight remove it from the code base.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I'm processing the patchkit, test building it on a cross arch64 build.

- Arnaldo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
