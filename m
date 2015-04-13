From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 00/17] s390x cpu model implementation
Date: Mon, 13 Apr 2015 15:56:19 +0200
Message-ID: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch set in combination with its kernel kvm patch set proposes an
implementation of S390 CPU models. The origin of this item is to provide
a means for management interfaces like libvirt to draw decisions if life
guest migration to a target hypervisor is reasonable.

A migration constraint is that a target hypervisor is capable to run a
guest with the same CPU model as the source hypervisor does. To
verify this condition, the administration interface employes the existing
QMP command "query-cpu-definitions" which returns a list of all currently
supported CPU models of a given host system. Together with the extension of
QMP command "query-cpus", the current CPU model of a guest is retrievable
and a conclusion can be drawn if a migration is possible.

A S390 CPU model is defined as a triple of machine type, CPU facility set
and IBC value. Each historic, current and future triple receives a name
composed of the machine type and its general availability counter. This name
forms the CPU model name (e.g.: "2817-ga2".)

With means of the Instruction Blocking Control feature (IBC), the instruction
set available to a given guest is limitable.

Examples:

 {"execute":"query-cpus"}
 {"return":[{"current":true,"CPU":0,"model":"2094-ga3","halted":false,
             "accel":"kvm","thread_id":57423},...]}

 {"execute":"query-cpu-definitions","arguments":{"accel":"kvm",
                                                 "machine":"s390-ccw-virtio"}}
 {"return":[{"order":3345,"name":"2964-ga1","live-migration-safe":true},
            {"name":"zBC12","runnable":true},
            {"name":"2828","runnable":true},
            {"order":3105,"name":"2828-ga1","runnable":true,"live-migration-safe":true},
            {"name":"host","runnable":true},
            {"name":"zEC12","runnable":true},
            {"name":"2827","runnable":true},
            {"order":3090,"name":"2827-ga2","runnable":true,"live-migration-safe":true",
             "is-default":true},
            ...
            {"name":"none","runnable":true}]}

v4-v5:
- common code patches moved to begin of series
- linux header related patch dropped as changes are already upstream
- ibc_range renamed to ibc and fac_list_mask renamed to fac_mask to
  correspond with struct fields in linux header
- test for NULL skipped after strdup_s390_cpu_name()
- strdup_cpu_name() now also handles none cpu model case
- s390_cpu_compare_name() now uses strdup_cpu_name() as well
- omit runnable and is-default field from query-cpu-definitions
  answer when they are false
- global variable cpu_models_used and routine s390_cpu_models_used()
  dropped
- routine query-cpu-definitions has a common code path now
- CPU model none is always runnable and presented in answer of command
  query-cpu-definitions
- live-migration-safe field added to QAPI type CpuDefinitionInfo
- cpu model aliases presented in query-cpu-definitions answer
- CPUState field accel_id added to represent the used accelerator (ACCEL_ID)
  and initialized in cpu_generic_init()
- CPUState field model_name added to represent the used cpu model,
  initialized in arch specific init function s390_cpu_initfn()
- QMP command query-cpus extended to display accelerator and CPU model
  name of all CPUs
- QMP command query-cpu-model dropped in favor to query-cpus
- HMP command info cpus now displays CPU model and accelerator
- optional order field added to query-cpu-definitions

v3-v4:
- qemu probe mode is gone now
- optional parameters 'accel' and 'machine' added to QMP query-cpu-definitions
- z13 related facilities added
- private build directory issue fixed

v2-v3:
- using GTK-Doc style format now for function descriptions
- typo fixed (2/16)
- gen-facilties now used to generate cpu model specific facility lists
  and the qemu side facility mask during build time (5/16)
- gen-facilities added to make magic (5/16)
- element of struct S390CPUMachineProps now statically in cpu class (6/16)
- element of struct S390CPUProcessorProps now statically in cpu class (6/16)
- facility list also static now (6/16)
- typo fixed (7/16)
- zBC12-ga1 model now active on zEC12-ga2 host (11/16)
- operations on facility lists use QEMU bitmap API now (11/16)
- routine s390_cpu_model_init() introduced, called during cpu object
  realization to prepare the current accelarator (12/16) if a cpu
  model was selected
- missing comment added in description of CpuModelInfo type (13/16)
- accelerator field now mandatory for "query-cpu-model" (13/16)
- sorted list related comment to "query-cpu-definitions" dropped in
  commit message (13/16)
- comment for AccelCpuInfo type updated (13/16)
- routine s390_facility_test() factored out (15/16)

v1-v2:
- QEMU-side facility list mask introduced: this allows to enable guest
  facilities that are handled by instruction interception handlers
  implemented on qemu side. Similar to the facilities enabled by means
  of the KVM side facility list mask which are handled by kvm/kernel.
- Concept of soft facilities has been dropped
- Result type of QMP command query-cpu-definitions extended to hold
  additional information beside the cpu model name including which
  cpu model is runnable in current accelerator and machine context.

Michael Mueller (17):
  Introduce stub routine cpu_desc_avail
  Add accelerator id and model name to CPUState
  Extend QMP command query-cpus to return accelerator id and model name
  Extend HMP command info cpus to display accelerator id and model name
  Add optional parameters to QMP command query-cpu-definitions
  target-s390x: Introduce S390 CPU facilities
  target-s390x: Generate facility defines per S390 CPU model
  target-s390x: Introduce S390 CPU models
  target-s390x: Define S390 CPU model specific facility lists
  target-s390x: Add S390 CPU model alias definition routines
  target-s390x: Add KVM VM attribute interface for S390 CPU models
  target-s390x: Add S390 CPU class initialization routines
  target-s390x: Prepare accelerator during S390 CPU object realization
  target-s390x: Initialize S390 CPU model name in CPUState
  target-s390x: Extend arch specific QMP command query-cpu-definitions
  target-s390x: Introduce S390 CPU facility test routine
  target-s390x: Enable S390 CPU model usage

 Makefile.target               |   2 +-
 cpus.c                        |   4 +
 hmp.c                         |   7 +
 hw/s390x/s390-virtio.c        |  12 +-
 include/qemu-common.h         |   2 +
 include/qom/cpu.h             |   5 +
 include/sysemu/arch_init.h    |   7 +-
 qapi-schema.json              |  44 ++-
 qmp-commands.hx               |   2 +-
 qmp.c                         |  11 +-
 qom/cpu.c                     |  14 +
 rules.mak                     |   1 +
 stubs/Makefile.objs           |   1 +
 stubs/arch-query-cpu-def.c    |   6 +-
 stubs/cpu-desc-avail.c        |   6 +
 target-arm/helper.c           |   6 +-
 target-i386/cpu.c             |   6 +-
 target-ppc/translate_init.c   |   6 +-
 target-s390x/Makefile.objs    |  21 ++
 target-s390x/cpu-facilities.h |  86 +++++
 target-s390x/cpu-models.c     | 746 ++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h     | 168 ++++++++++
 target-s390x/cpu-qom.h        |  49 +++
 target-s390x/cpu.c            | 149 ++++++++-
 target-s390x/gen-facilities.c | 417 +++++++++++++++++++++++
 target-s390x/helper.c         |   9 +-
 target-s390x/kvm.c            | 129 ++++++++
 trace-events                  |   3 +
 vl.c                          |   2 +-
 29 files changed, 1891 insertions(+), 30 deletions(-)
 create mode 100644 stubs/cpu-desc-avail.c
 create mode 100644 target-s390x/cpu-facilities.h
 create mode 100644 target-s390x/cpu-models.c
 create mode 100644 target-s390x/cpu-models.h
 create mode 100644 target-s390x/gen-facilities.c

-- 
1.8.3.1
