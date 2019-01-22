Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v2 0/7] perf: Communicate sink via event::attr:config2
Date: Tue, 22 Jan 2019 11:11:37 -0700
Message-Id: <20190122181144.26645-1-mathieu.poirier@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: acme@kernel.org, peterz@infradead.org
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com, ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is the second revision of a patchset allowing multiple sources to select
the same sink for a session which is a prerequisite for the support of CoreSight
CPU-wide trace scenarios.

The sink ID is communicated to the kernel by way of the event's configuration
attribute (event::attr:config2).  The ID itself is an hash of the sink's name,
something that is readily available and doesn't require the addition of a new
information field in the coresight_device structure.

With this set the mechanic to communicate sink selection to the kernel via
sysfs is no longer needed and removed.

Applies cleanly and tested on 5.0-rc3.

Thanks,
Mathieu

Changes for V2:
* Addressed memory leak in etm_perf_add_symlink_sink()
* Keep track of device attribute for future removal.
* Added PMU attribure for config2.
* Fixed email address signature.

Mathieu Poirier (7):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection
  perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file
  perf tools: Use event attributes to send sink information to kernel
  perf tools: Removing CoreSight set_drv_config() API
  perf tools: Remove PMU::set_drv_config API

 arch/s390/kernel/perf_cpum_sf.c               |   6 +-
 arch/x86/events/intel/bts.c                   |   4 +-
 arch/x86/events/intel/pt.c                    |   5 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 106 +++++++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |   6 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight.c       |  57 ++++++++++
 drivers/perf/arm_spe_pmu.c                    |   6 +-
 include/linux/coresight.h                     |   7 +-
 include/linux/perf_event.h                    |   2 +-
 kernel/events/ring_buffer.c                   |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  94 +++++++---------
 tools/perf/arch/arm/util/cs-etm.h             |   3 -
 tools/perf/arch/arm/util/pmu.c                |   2 -
 tools/perf/builtin-record.c                   |  10 --
 tools/perf/builtin-stat.c                     |   9 --
 tools/perf/builtin-top.c                      |  13 ---
 tools/perf/util/Build                         |   1 -
 tools/perf/util/drv_configs.c                 |  78 -------------
 tools/perf/util/drv_configs.h                 |  26 -----
 tools/perf/util/pmu.c                         |   2 -
 tools/perf/util/pmu.h                         |   2 +-
 22 files changed, 214 insertions(+), 228 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
