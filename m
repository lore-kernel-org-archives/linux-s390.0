From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v4 00/15] s390x cpu model implementation
Date: Mon, 30 Mar 2015 16:28:13 +0200
Message-ID: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch set in combination with its kernel kvm patch set proposes an
implementation of S390 cpu models. The origin of this item is to provide
a means for management interfaces like libvirt to draw decisions if life
guest migration to a target hypervisor is reasonable.

A migration constraint is that a target hypervisor is capable to run a
guest with the same S390 cpu model as the source hypervisor does. To
verify this condition, the administration interface employes the existing
QMP command "query-cpu-definitions" which returns a list of all currently
supported S390 cpu models of a given host system. Together with the newly
defined QMP command "query-cpu-model", which returns the current active
S390 cpu model of a guest, a conclusion can be drawn if a migration is
possible.

A S390 cpu model is defined as a triple of machine type, cpu facility set
and IBC value. Each historic, current and future triple receives a name
composed of the machine type and its general availability counter. This name
forms the cpu model name (e.g.: "2817-ga2".)

With means of the Instruction Blocking Control feature (IBC), the instruction
set available to a given guest is limitable.

Details:
- The QMP command query-cpu-model returns the active cpu model and the
  accellerator name it is using:

  {"name":"2066-ga1","accel":"kvm"}

Or just the empty model in case an accelerator does not take care of cpu models:

  {}

- A management instance like libvirt may probe by means of the QMP command
  query-cpu-definitions which models are defined and usable for specific
  accelerators and machine types. To implement this the cpu definition info
  type gets two optional fields named 'runnable' and 'is-default' representing
  the runnable cpu model for the given accelertor and machine type as well as
  the host cpu model.

  { "execute": "query-cpu-definitions",
    "arguments": { "accel": "kvm", "machine": "s390-ccw-virtio" } }

  { "return": [ {"name": "2964-ga1","runnable": false, "is-default": false},
                {"name": "2828-ga1","runnable": true,  "is-default": false},
                {"name": "2827-ga2","runnable": true,  "is-default": true},
                ...
                {"name": "2064-ga1","runnable": true,  "is-default": false} ] }
		
Or just host in case an accelerator does not take care of the cpu models:

  { "return": [ {"name": "host"} ] }

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

Michael Mueller (15):
  Introduce stub routine cpu_desc_avail
  target-s390x: Introduce cpu facilities
  target-s390x: Generate facility defines per cpu model
  target-s390x: Introduce cpu models
  target-s390x: Define cpu model specific facility lists
  target-s390x: Add cpu model alias definition routines
  target-s390x: Update linux-headers/asm-s390/kvm.h
  target-s390x: Add KVM VM attribute interface for cpu models
  target-s390x: Add cpu class initialization routines
  target-s390x: Prepare accelerator during cpu object realization
  target-s390x: New QMP command query-cpu-model
  Add optional parameters to QMP command query-cpu-definitions
  target-s390x: Extend QMP command query-cpu-definitions
  target-s390x: Introduce facility test routine
  target-s390x: Enable cpu model usage

 Makefile.target               |   2 +-
 hw/s390x/s390-virtio.c        |  12 +-
 include/qemu-common.h         |   2 +
 include/sysemu/arch_init.h    |   7 +-
 linux-headers/asm-s390/kvm.h  |  18 +-
 qapi-schema.json              |  49 ++-
 qmp-commands.hx               |   8 +-
 qmp.c                         |  14 +-
 rules.mak                     |   1 +
 stubs/Makefile.objs           |   2 +
 stubs/arch-query-cpu-def.c    |   6 +-
 stubs/arch-query-cpu-mod.c    |   9 +
 stubs/cpu-desc-avail.c        |   6 +
 target-arm/helper.c           |   6 +-
 target-i386/cpu.c             |   6 +-
 target-ppc/translate_init.c   |   6 +-
 target-s390x/Makefile.objs    |  21 ++
 target-s390x/cpu-facilities.h |  86 +++++
 target-s390x/cpu-models.c     | 767 ++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu-models.h     | 169 ++++++++++
 target-s390x/cpu-qom.h        |  36 ++
 target-s390x/cpu.c            | 163 ++++++++-
 target-s390x/gen-facilities.c | 417 +++++++++++++++++++++++
 target-s390x/helper.c         |   9 +-
 target-s390x/kvm.c            | 129 +++++++
 trace-events                  |   3 +
 vl.c                          |   2 +-
 27 files changed, 1921 insertions(+), 35 deletions(-)
 create mode 100644 stubs/arch-query-cpu-mod.c
 create mode 100644 stubs/cpu-desc-avail.c
 create mode 100644 target-s390x/cpu-facilities.h
 create mode 100644 target-s390x/cpu-models.c
 create mode 100644 target-s390x/cpu-models.h
 create mode 100644 target-s390x/gen-facilities.c

-- 
1.8.3.1
