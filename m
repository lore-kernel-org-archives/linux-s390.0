Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 0/7] perf: Communicate sink via event::attr:config2 
Date: Tue, 15 Jan 2019 16:07:35 -0700
Message-Id: <20190115230742.13730-1-mathieu.poirier@linaro.org>
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
To: acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com, will.deacon@arm.com, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: "Mathieu Poirier]" <mathieu.poirier@linaro.org>

This set is a refurbished version of this one [1].  I dropped the version
count and changed the name because a new approach is taken.

The end result is the same though, that is to allow multiple sources to
select the same sink for a session which is a prerequisite for the CoreSight
support of CPU-wide trace scenarios.

Here the sink ID is communicated to the kernel by way of the event's
configuration attribure (event::attr::config2).  The ID itself is an
hash of the sink's name, something that is readily available and doesn't
require the addition of a new information field in the coresight_device
structure.

With this new strategy the mechanic used to communicate sink selection to the
kernel via sysfs is no longer needed and removed from the code base.

Everthing has been applied and tested on 5.0-rc2.

Regards,
Mathieu

PS: Greg, I'm drawing your attention to patch 02 where I seem to be the first
to use function sysfs_add_file_to_group() in this way.

[1]. https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1818488.html

Mathieu Poirier (6):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection
  perf tools: Use event attributes to send sink information to kernel
  perf tools: Removing CoreSight set_drv_config() API
  perf tools: Remove PMU::set_drv_config API

linaro (1):
  perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file

 arch/s390/kernel/perf_cpum_sf.c               |  6 +-
 arch/x86/events/intel/bts.c                   |  4 +-
 arch/x86/events/intel/pt.c                    |  5 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 65 ++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 drivers/hwtracing/coresight/coresight.c       | 56 +++++++++++
 drivers/perf/arm_spe_pmu.c                    |  6 +-
 include/linux/perf_event.h                    |  2 +-
 kernel/events/ring_buffer.c                   |  2 +-
 tools/perf/arch/arm/util/cs-etm.c             | 94 ++++++++-----------
 tools/perf/arch/arm/util/cs-etm.h             |  3 -
 tools/perf/arch/arm/util/pmu.c                |  2 -
 tools/perf/builtin-record.c                   | 10 --
 tools/perf/builtin-stat.c                     |  9 --
 tools/perf/builtin-top.c                      | 13 ---
 tools/perf/util/Build                         |  1 -
 tools/perf/util/drv_configs.c                 | 78 ---------------
 tools/perf/util/drv_configs.h                 | 26 -----
 tools/perf/util/pmu.c                         |  2 -
 tools/perf/util/pmu.h                         |  2 +-
 21 files changed, 163 insertions(+), 225 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
