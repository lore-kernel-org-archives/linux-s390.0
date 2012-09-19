From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2 7/7] s390/kvm: In-kernel channel subsystem support.
Date: Wed, 19 Sep 2012 16:47:34 +0200
Message-ID: <48430489-B96F-4717-AA1E-B04445F55717@suse.de>
References: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com> <1346771610-52423-8-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1346771610-52423-8-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 04.09.2012, at 17:13, Cornelia Huck wrote:

> Handle most support for channel I/O instructions in the kernel itself.
> 
> Only asynchronous functions (such as the start function) need to be
> handled by userspace.

Phew. This is a lot of code for something that is usually handled in user space in the kvm world. The x86 equivalent would be an in-kernel PCI bus, right? Have you measured major performance penalties when running this from user space?

Avi, what do you think?


Alex

> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> 
> Changes v1->v2:
> - reorganize channel subsystem vs. channel subsystem images
> - new ioctl KVM_S390_ADD_CSS
> 
> ---
> Documentation/virtual/kvm/api.txt | 153 ++++++
> arch/s390/include/asm/kvm_host.h  |  53 ++
> arch/s390/kvm/Makefile            |   2 +-
> arch/s390/kvm/css.c               | 989 ++++++++++++++++++++++++++++++++++++++
> arch/s390/kvm/intercept.c         |   1 +
> arch/s390/kvm/interrupt.c         | 147 ++++--
> arch/s390/kvm/ioinst.c            | 797 ++++++++++++++++++++++++++++++
> arch/s390/kvm/kvm-s390.c          |  44 ++
> arch/s390/kvm/kvm-s390.h          |  39 ++
> arch/s390/kvm/priv.c              |   7 +-
> arch/s390/kvm/trace-s390.h        |  67 +++
> arch/s390/kvm/trace.h             |  22 +
> include/linux/kvm.h               |  60 +++
> include/trace/events/kvm.h        |   2 +-
> virt/kvm/kvm_main.c               |   3 +-
> 15 files changed, 2339 insertions(+), 47 deletions(-)
> create mode 100644 arch/s390/kvm/css.c
> create mode 100644 arch/s390/kvm/ioinst.c
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 9c71aaa..61d5199 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1984,6 +1984,127 @@ return the hash table order in the parameter.  (If the guest is using
> the virtualized real-mode area (VRMA) facility, the kernel will
> re-create the VMRA HPTEs on the next KVM_RUN of any vcpu.)
> 
> +4.77 KVM_S390_CSS_NOTIFY
> +
> +Capability: KVM_CAP_S390_CSS_SUPPORT
> +Architectures: s390
> +Type: vcpu ioctl
> +Parameters: struct kvm_css_notify (in)
> +Returns: 0 on success, negative value on failure
> +
> +This ioctl may be used by userspace to notify the kernel that the control
> +blocks for a virtual subchannel should be updated and an I/O interrupt
> +injected.
> +
> +It uses the following parameter block:
> +
> +/* for KVM_S390_CSS_NOTIFY */
> +struct kvm_css_notify {
> +	__u8 cssid;
> +	__u8 ssid;
> +	__u16 schid;
> +	__u32 scsw[3];
> +	__u32 pmcw[7];
> +	__u8 sense_data[32];
> +	__u8 unsolicited;
> +	__u8 func;
> +};
> +
> +cssid, ssid and schid specify the subchannel; scsw, pmcw and sense_data
> +are the control blocks to be updated. If the notification is specified
> +to be unsolicited, no new interrupt is generated if an interrupt is already
> +pending for the subchannel; else an unsolicited interrupt is generated.
> +
> +The func parameter specifies the asynchronous function that is notified
> +for (solicited interrupts only).
> +
> +This ioctl (like the other interrupt injection ioctls) is executed
> +asynchronously to normal vcpu execution.
> +
> +4.78 KVM_S390_CCW_HOTPLUG
> +
> +Capability: KVM_CAP_S390_CSS_SUPPORT
> +Architectures: s390
> +Type: vm ioctl
> +Parameters: struct kvm_s390_sch_info (in)
> +Returns: 0 on success, negative value on failure
> +
> +This ioctl allows userspace to notify the kernel about addition or removal
> +of subchannels.
> +
> +It uses the following data structure:
> +
> +/* for KVM_S390_CCW_HOTPLUG */
> +struct kvm_s390_sch_info {
> +	__u8 cssid;
> +	__u8 ssid;
> +	__u16 schid;
> +	__u16 devno;
> +	__u32 schib[12];
> +	int hotplugged;
> +	int add;
> +	int virtual;
> +};
> +
> +cssid, ssid, schid and devno describe the subchannel. If the subchannel is
> +being added, schib contains the initial subchannel information block for it.
> +hotplugged (can only be 0 if add is !0) specifies whether the subchannel has
> +been dynamically added or removed (as opposed to the initial machine setup,
> +when no channel report words will be created). add specifies whether the
> +subchannel is coming or going. virtual signifies whether this is a real or
> +a purely virtual subchannel.
> +
> +4.79 KVM_S390_CHP_HOTPLUG
> +
> +Capability: KVM_CAP_S390_CSS_SUPPORT
> +Architectures: s390
> +Type: vm ioctl
> +Parameters: struct kvm_s390_chp_info (in)
> +Returns: 0 on success, negative value on failure
> +
> +This ioctl allows userspace to notify the kernel about addition or removal
> +of a channel path.
> +
> +It uses the following structure:
> +
> +/* for KVM_S390_CHP_HOTPLUG */
> +struct kvm_s390_chp_info {
> +	__u8 cssid;
> +	__u8 chpid;
> +	__u8 type;
> +	int add;
> +	int virtual;
> +};
> +
> +cssid and chpid specify the channel path, type the channel path type. add
> +determines whether the path is coming or going, and virtual signifies
> +whether this is a purely virtual or a real channel path.
> +
> +4.80 KVM_S390_ADD_CSS
> +
> +Capability: KVM_CAP_S390_CSS_SUPPORT
> +Architectures: s390
> +Type: vm ioctl
> +Parameters: struct kvm_s390_css_info (in)
> +Returns: 0 on success, negative value on failure
> +
> +This ioctl allows userspace to add a new channel subsystem image for use
> +by the channel subsystem and specifying whether it should be used as the
> +default channel subsystem image when mcss-e is not active. Adding a
> +channel subsystem image is prerequisite to adding subchannels and channel
> +paths to it.
> +
> +It uses the following structure:
> +
> +/* for KVM_S390_ADD_CSS */
> +struct kvm_s390_css_info {
> +	__u8 cssid;
> +	__u8 default_image;
> +};
> +
> +cssid is the id of the channel subsystem image being added, and default_image
> +specifies whether it should be considered the default channel subsystem image.
> +
> 
> 5. The kvm_run structure
> ------------------------
> @@ -2199,6 +2320,24 @@ The possible hypercalls are defined in the Power Architecture Platform
> Requirements (PAPR) document available from www.power.org (free
> developer registration required to access it).
> 
> +		/* KVM_EXIT_S390_SCH_IO */
> +		struct {
> +			__u32 sch_id;
> +#define SCH_DO_CSCH 0
> +#define SCH_DO_HSCH 1
> +#define SCH_DO_SSCH 2
> +#define SCH_DO_RSCH 3
> +#define SCH_DO_XSCH 4
> +			__u8 func;
> +			__u8 pad;
> +			__u64 orb;
> +			__u32 scsw[3];
> +			__u32 pmcw[7];
> +		} s390_sch_io;
> +
> +s390 specific. Used for userspace processing of asynchronous subchannel
> +functions.
> +
> 		/* Fix the size of the union. */
> 		char padding[256];
> 	};
> @@ -2320,3 +2459,17 @@ For mmu types KVM_MMU_FSL_BOOKE_NOHV and KVM_MMU_FSL_BOOKE_HV:
>    where "num_sets" is the tlb_sizes[] value divided by the tlb_ways[] value.
>  - The tsize field of mas1 shall be set to 4K on TLB0, even though the
>    hardware ignores this value for TLB0.
> +
> +6.4 KVM_CAP_S390_CSS_SUPPORT
> +
> +Architectures: s390
> +Parameters: none
> +Returns: 0 on success; -1 on error
> +
> +This capability enables in-kernel support for handling of channel I/O
> +instructions like STORE SUBCHANNEL or CHANNEL SUBSYSTEM CALL.
> +
> +When this capability is enabled, KVM_EXIT_S390_SCH_IO can occur.
> +
> +When this capability is provided, the KVM_S390_CCW_HOTPLUG,
> +KVM_S390_CHP_HOTPLUG and KVM_S390_CSS_NOTIFY ioctls are provided.
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 556774d..dc7dd18 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -17,13 +17,18 @@
> #include <linux/interrupt.h>
> #include <linux/kvm_host.h>
> #include <asm/debug.h>
> +#include <asm/cio.h>
> #include <asm/cpu.h>
> +#include <asm/crw.h>
> 
> #define KVM_MAX_VCPUS 64
> #define KVM_MEMORY_SLOTS 32
> /* memory slots that does not exposed to userspace */
> #define KVM_PRIVATE_MEM_SLOTS 4
> 
> +#define VIRTUAL_CSSID 0xfe
> +#define KVM_MAX_CSSID 0xfe /* 0xff is reserved */
> +
> struct sca_entry {
> 	atomic_t scn;
> 	__u32	reserved;
> @@ -174,6 +179,7 @@ struct kvm_s390_ext_info {
> #define PGM_ADDRESSING           0x05
> #define PGM_SPECIFICATION        0x06
> #define PGM_DATA                 0x07
> +#define PGM_OPERAND              0x15
> 
> struct kvm_s390_pgm_info {
> 	__u16 code;
> @@ -208,6 +214,7 @@ struct kvm_s390_interrupt_info {
> 		struct kvm_s390_prefix_info prefix;
> 		struct kvm_s390_mchk_info mchk;
> 	};
> +	int nondyn;
> };
> 
> /* for local_interrupt.action_flags */
> @@ -259,11 +266,57 @@ struct kvm_vm_stat {
> struct kvm_arch_memory_slot {
> };
> 
> +struct crw_container {
> +	struct crw crw;
> +	struct list_head sibling;
> +};
> +
> +struct chp_info {
> +	u8 in_use;
> +	u8 type;
> +};
> +
> +struct kvm_subch {
> +	struct mutex lock;
> +	u8 cssid;
> +	u8 ssid;
> +	u16 schid;
> +	u16 devno;
> +	u8 sense_data[32];
> +	struct schib *curr_status;
> +	struct kvm_s390_interrupt_info inti;
> +};
> +
> +struct schid_info {
> +	struct kvm_subch *schs[__MAX_SUBCHANNEL + 1];
> +	unsigned long bm[0];
> +};
> +
> +struct css_image {
> +	struct schid_info *schids[__MAX_SSID + 1];
> +	struct chp_info chpids[__MAX_CHPID + 1];
> +};
> +
> +struct kvm_s390_css_data {
> +	int max_cssid;
> +	int max_ssid;
> +	int default_cssid;
> +	struct list_head pending_crws;
> +	struct kvm_s390_interrupt_info crw_inti;
> +	int do_crw_mchk;
> +	int crws_lost;
> +	atomic_t chnmon_active;
> +	u64 chnmon_area;
> +	struct css_image *css[KVM_MAX_CSSID + 1];
> +};
> +
> struct kvm_arch{
> 	struct sca_block *sca;
> 	debug_info_t *dbf;
> 	struct kvm_s390_float_interrupt float_int;
> 	struct gmap *gmap;
> +	int css_support;
> +	struct kvm_s390_css_data *css;
> };
> 
> extern int sie64a(struct kvm_s390_sie_block *, u64 *);
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 3975722..afcf71e 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -10,5 +10,5 @@ common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o)
> 
> ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
> 
> -kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o diag.o
> +kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o diag.o ioinst.o css.o
> obj-$(CONFIG_KVM) += kvm.o
> diff --git a/arch/s390/kvm/css.c b/arch/s390/kvm/css.c
> new file mode 100644
> index 0000000..ee8f559
> --- /dev/null
> +++ b/arch/s390/kvm/css.c
> @@ -0,0 +1,989 @@
> +/*
> + * Virtual channel subsystem support for kvm
> + *
> + * Copyright IBM Corp. 2012
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License (version 2 only)
> + * as published by the Free Software Foundation.
> + *
> + *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> + */
> +
> +#include <linux/kvm.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/vmalloc.h>
> +#include <asm/cio.h>
> +#include <asm/crw.h>
> +#include <asm/schib.h>
> +#include <asm/schid.h>
> +#include <asm/scsw.h>
> +#include "gaccess.h"
> +#include "kvm-s390.h"
> +#include "trace-s390.h"
> +
> +static void css_update_chnmon(struct kvm_vcpu *vcpu, struct kvm_subch *sch)
> +{
> +	if (!sch->curr_status->pmcw.mme)
> +		/* Not active. */
> +		return;
> +
> +	/*
> +	 * The only field we want to update (ssch_rsch_count) is conveniently
> +	 * located at the beginning of the measurement block.
> +	 * For format 0, it is a 16 bit value; for format 1, a 32 bit value.
> +	 */
> +	if (sch->curr_status->pmcw.mbfc) {
> +		/* Format 1, per-subchannel area. */
> +		u32 uninitialized_var(count);
> +
> +		if (get_guest_u32(vcpu, sch->curr_status->mba, &count))
> +			return;
> +		count++;
> +		put_guest_u32(vcpu, sch->curr_status->mba, count);
> +	} else {
> +		/* Format 0, global area. */
> +		u64 target;
> +		u16 uninitialized_var(count);
> +
> +		target = vcpu->kvm->arch.css->chnmon_area +
> +			(sch->curr_status->pmcw.mbi << 5);
> +		if (get_guest_u16(vcpu, target, &count))
> +			return;
> +		count++;
> +		put_guest_u16(vcpu, target, count);
> +	}
> +}
> +
> +static int highest_schid(struct kvm *kvm, u8 cssid, u8 ssid)
> +{
> +	struct css_image *css = kvm->arch.css->css[cssid];
> +
> +	if (!css || !css->schids[ssid])
> +		return 0;
> +	return find_last_bit(css->schids[ssid]->bm,
> +			     (__MAX_SUBCHANNEL + 1) / sizeof(unsigned long));
> +}
> +
> +int css_schid_final(struct kvm *kvm, u8 cssid, u8 ssid, u16 schid)
> +{
> +	return (cssid > KVM_MAX_CSSID ||
> +		ssid > __MAX_SSID ||
> +		schid > highest_schid(kvm, cssid, ssid)) ? 1 : 0;
> +}
> +
> +static int css_add_virtual_chpid(struct kvm *kvm, u8 cssid, u8 chpid, u8 type)
> +{
> +	struct css_image *css;
> +
> +	if (cssid > KVM_MAX_CSSID)
> +		return -EINVAL;
> +
> +	css = kvm->arch.css->css[cssid];
> +
> +	if (!css)
> +		return -EINVAL;
> +
> +	if (css->chpids[chpid].in_use)
> +		return -EEXIST;
> +
> +	css->chpids[chpid].in_use = 1;
> +	css->chpids[chpid].type = type;
> +	return 0;
> +}
> +
> +static int css_remove_virtual_chpid(struct kvm *kvm, u8 cssid, u8 chpid)
> +{
> +	struct css_image *css;
> +
> +	if (cssid > KVM_MAX_CSSID)
> +		return -EINVAL;
> +
> +	css = kvm->arch.css->css[cssid];
> +
> +	if (!css)
> +		return -EINVAL;
> +
> +	if (!css->chpids[chpid].in_use)
> +		return -EINVAL;
> +
> +	css->chpids[chpid].in_use = 0;
> +	return 0;
> +}
> +
> +int css_chpid_in_use(struct kvm *kvm, u8 cssid, u8 chpid)
> +{
> +	struct css_image *css;
> +
> +	if ((cssid > KVM_MAX_CSSID) || (chpid > __MAX_CHPID))
> +		return 0;
> +	css = kvm->arch.css->css[cssid];
> +	return css ? css->chpids[chpid].in_use : 0;
> +}
> +
> +static int css_chpid_type(struct kvm *kvm, u8 cssid, u8 chpid)
> +{
> +	struct css_image *css;
> +
> +	if ((cssid > KVM_MAX_CSSID) || (chpid > __MAX_CHPID))
> +		return 0;
> +	css = kvm->arch.css->css[cssid];
> +	return css ? css->chpids[chpid].type : 0;
> +}
> +
> +int css_collect_chp_desc(struct kvm *kvm, u8 cssid, u8 f_chpid, u8 l_chpid,
> +			 int rfmt, void *buf)
> +{
> +	int i, desc_size;
> +	u32 words[8];
> +
> +	desc_size = 0;
> +	for (i = f_chpid; i <= l_chpid; i++) {
> +		if (!css_chpid_in_use(kvm, cssid, i))
> +			continue;
> +		if (rfmt == 0) {
> +			words[0] = 0x80000000 |
> +				(css_chpid_type(kvm, cssid, i) << 8) | i;
> +			words[1] = 0;
> +			memcpy(buf + desc_size, words, 8);
> +			desc_size += 8;
> +		} else if (rfmt == 1) {
> +			words[0] = 0x80000000 |
> +				(css_chpid_type(kvm, cssid, i) << 8) | i;
> +			words[1] = 0;
> +			words[2] = 0;
> +			words[3] = 0;
> +			words[4] = 0;
> +			words[5] = 0;
> +			words[6] = 0;
> +			words[7] = 0;
> +			memcpy(buf + desc_size, words, 32);
> +			desc_size += 32;
> +		}
> +	}
> +	return desc_size;
> +}
> +
> +struct kvm_subch *css_find_subch(struct kvm *kvm, u8 m, u8 cssid, u8 ssid,
> +				 u16 schid)
> +{
> +	struct css_image *css;
> +	u8 real_cssid;
> +
> +	if (!m) {
> +		if (cssid)
> +			return NULL;
> +		real_cssid = kvm->arch.css->default_cssid;
> +	} else
> +		real_cssid = cssid;
> +	css = kvm->arch.css->css[real_cssid];
> +	/* Don't bother for out of range values. */
> +	if (!css)
> +		return NULL;
> +	if (css_schid_final(kvm, real_cssid, ssid, schid))
> +		return NULL;
> +	if (!css->schids[ssid])
> +		return NULL;
> +	if (!test_bit(schid, css->schids[ssid]->bm))
> +		return NULL;
> +	return css->schids[ssid]->schs[schid];
> +}
> +
> +void css_queue_crw(struct kvm *kvm, u8 rsc, u8 erc, int chain, u16 rsid)
> +{
> +	struct crw_container *crw_cont;
> +	struct kvm_s390_css_data *css = kvm->arch.css;
> +	int ret;
> +
> +	/* TODO: Maybe use a static crw pool? */
> +	crw_cont = kzalloc(sizeof(struct crw_container), GFP_KERNEL);
> +
> +	mutex_lock(&kvm->lock);
> +
> +	if (!crw_cont) {
> +		css->crws_lost = 1;
> +		goto out;
> +	}
> +	crw_cont->crw.rsc = rsc;
> +	crw_cont->crw.erc = erc;
> +	crw_cont->crw.chn = chain;
> +	crw_cont->crw.rsid = rsid;
> +	crw_cont->crw.oflw = css->crws_lost;
> +	css->crws_lost = 0;
> +
> +	list_add_tail(&crw_cont->sibling, &css->pending_crws);
> +
> +	if (css->do_crw_mchk) {
> +		css->do_crw_mchk = 0;
> +		ret = kvm_s390_inject_internal(kvm, &css->crw_inti);
> +		if (ret)
> +			css->do_crw_mchk = 1;
> +	}
> +out:
> +	mutex_unlock(&kvm->lock);
> +}
> +
> +int css_do_stcrw(struct kvm_vcpu *vcpu, u32 cda)
> +{
> +	struct crw_container *crw_cont;
> +	struct kvm_s390_css_data *css = vcpu->kvm->arch.css;
> +	int ret;
> +
> +	mutex_lock(&vcpu->kvm->lock);
> +	if (list_empty(&css->pending_crws)) {
> +		u32 zeroes = 0;
> +		/* List was empty, turn crw machine checks on again. */
> +		if (copy_to_guest(vcpu, cda, &zeroes, sizeof(struct crw))) {
> +			kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +			ret = -EIO;
> +			goto out;
> +		}
> +		css->do_crw_mchk = 1;
> +		ret = 1;
> +		goto out;
> +	}
> +
> +	crw_cont = container_of(css->pending_crws.next, struct crw_container,
> +				sibling);
> +	if (copy_to_guest(vcpu, cda, &crw_cont->crw, sizeof(struct crw))) {
> +		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +		ret = -EIO;
> +		goto out;
> +	}
> +	list_del(&crw_cont->sibling);
> +	kfree(crw_cont);
> +	ret = 0;
> +out:
> +	mutex_unlock(&vcpu->kvm->lock);
> +	return ret;
> +}
> +
> +void css_do_schm(struct kvm_vcpu *vcpu, u8 mbk, int update, int dct, u64 mbo)
> +{
> +	struct kvm_s390_css_data *css = vcpu->kvm->arch.css;
> +
> +	/* dct is currently ignored (not really meaningful for our devices) */
> +	/* TODO: Don't ignore mbk. */
> +	if (update && !atomic_cmpxchg(&css->chnmon_active, 0, 1))
> +		/* Enable measuring. */
> +		css->chnmon_area = mbo;
> +
> +	if (!update && !atomic_cmpxchg(&css->chnmon_active, 1, 0))
> +		/* Disable measuring. */
> +		css->chnmon_area = 0;
> +}
> +
> +int css_enable_mcsse(struct kvm *kvm)
> +{
> +	kvm->arch.css->max_cssid = KVM_MAX_CSSID;
> +	return 0;
> +}
> +
> +int css_enable_mss(struct kvm *kvm)
> +{
> +	kvm->arch.css->max_ssid = __MAX_SSID;
> +	return 0;
> +}
> +
> +int css_do_tpi(struct kvm_vcpu *vcpu, u32 addr, int lowcore)
> +{
> +	struct kvm_s390_interrupt_info *inti;
> +
> +	inti = kvm_s390_get_io_int(vcpu->kvm, vcpu->run->s.regs.crs[6]);
> +	if (inti) {
> +		if (!lowcore) {
> +			put_guest_u16(vcpu, addr, inti->io.subchannel_id);
> +			put_guest_u16(vcpu, addr + 2, inti->io.subchannel_nr);
> +			put_guest_u32(vcpu, addr + 4, inti->io.io_int_parm);
> +		} else {
> +			put_guest_u16(vcpu, addr + 184, inti->io.subchannel_id);
> +			put_guest_u16(vcpu, addr + 186, inti->io.subchannel_nr);
> +			put_guest_u32(vcpu, addr + 188, inti->io.io_int_parm);
> +			put_guest_u32(vcpu, addr + 192, inti->io.io_int_word);
> +		}
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +int css_do_msch(struct kvm_vcpu *vcpu, struct kvm_subch *sch,
> +		struct schib *schib)
> +{
> +	union scsw *s = &sch->curr_status->scsw;
> +	struct pmcw *p = &sch->curr_status->pmcw;
> +	int ret;
> +
> +	mutex_lock(&sch->lock);
> +
> +	if (!sch->curr_status->pmcw.dnv) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	if (scsw_stctl(s) & SCSW_STCTL_STATUS_PEND) {
> +		ret = -EINPROGRESS;
> +		goto out;
> +	}
> +
> +	if (scsw_fctl(s) & (SCSW_FCTL_START_FUNC | SCSW_FCTL_HALT_FUNC |
> +			    SCSW_FCTL_CLEAR_FUNC)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/* Only update the program-modifiable fields. */
> +	p->ena = schib->pmcw.ena;
> +	p->intparm = schib->pmcw.intparm;
> +	p->isc = schib->pmcw.isc;
> +	p->mp = schib->pmcw.mp;
> +	p->lpm = schib->pmcw.lpm;
> +	p->pom = schib->pmcw.pom;
> +	p->lm = schib->pmcw.lm;
> +	p->csense = schib->pmcw.csense;
> +
> +	p->mme = schib->pmcw.mme;
> +	p->mbi = schib->pmcw.mbi;
> +	p->mbfc = schib->pmcw.mbfc;
> +	sch->curr_status->mba = schib->mba;
> +
> +	/*
> +	 * No need to exit to userspace since it will get the current state
> +	 * with the next exit.
> +	 */
> +	ret = 0;
> +
> +out:
> +	mutex_unlock(&sch->lock);
> +	return ret;
> +}
> +
> +int css_do_xsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch)
> +{
> +	union scsw *s = &sch->curr_status->scsw;
> +	struct pmcw *p = &sch->curr_status->pmcw;
> +	int ret;
> +
> +	mutex_lock(&sch->lock);
> +
> +	if (!p->dnv || !p->ena) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (!scsw_fctl(s) || (scsw_fctl(s) != SCSW_FCTL_START_FUNC) ||
> +	    (!(scsw_actl(s) & (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND |
> +			       SCSW_ACTL_SUSPENDED))) ||
> +	    (scsw_actl(s) & SCSW_ACTL_SCHACT)) {
> +		ret = -EINPROGRESS;
> +		goto out;
> +	}
> +
> +	if (scsw_stctl(s) != 0) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/* Cancel the current operation. */
> +	s->cmd.fctl &= ~SCSW_FCTL_START_FUNC;
> +	s->cmd.actl &= ~(SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND |
> +			 SCSW_ACTL_SUSPENDED);
> +	s->cmd.dstat = 0;
> +	s->cmd.cstat = 0;
> +	/*
> +	 * Let userspace update its state.
> +	 * No hardware related structures need to be updated, since userspace
> +	 * will get the current state with the next exit.
> +	 */
> +	vcpu->run->exit_reason = KVM_EXIT_S390_SCH_IO;
> +	vcpu->run->s390_sch_io.func = SCH_DO_XSCH;
> +	vcpu->run->s390_sch_io.sch_id = (sch->cssid << 24) | (1 << 19) |
> +		(sch->ssid << 17) | 1 << 16 | sch->schid;
> +	ret = -EREMOTE;
> +
> +out:
> +	mutex_unlock(&sch->lock);
> +	return ret;
> +}
> +
> +int css_do_csch(struct kvm_vcpu *vcpu, struct kvm_subch *sch)
> +{
> +	union scsw *s = &sch->curr_status->scsw;
> +	struct pmcw *p = &sch->curr_status->pmcw;
> +	int ret;
> +
> +	mutex_lock(&sch->lock);
> +
> +	if (!p->dnv || !p->ena) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	/* Trigger the clear function. */
> +	s->cmd.fctl = SCSW_FCTL_CLEAR_FUNC;
> +	s->cmd.actl = SCSW_ACTL_CLEAR_PEND;
> +
> +	/* Let userspace handle the clear function. */
> +	vcpu->run->exit_reason = KVM_EXIT_S390_SCH_IO;
> +	vcpu->run->s390_sch_io.func = SCH_DO_CSCH;
> +	vcpu->run->s390_sch_io.sch_id = (sch->cssid << 24) | (1 << 19) |
> +		(sch->ssid << 17) | 1 << 16 | sch->schid;
> +	memcpy(&vcpu->run->s390_sch_io.scsw, s, sizeof(*s));
> +	memcpy(&vcpu->run->s390_sch_io.pmcw, p, sizeof(*p));
> +	ret = -EREMOTE;
> +
> +out:
> +	mutex_unlock(&sch->lock);
> +	return ret;
> +}
> +
> +int css_do_hsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch)
> +{
> +	union scsw *s = &sch->curr_status->scsw;
> +	struct pmcw *p = &sch->curr_status->pmcw;
> +	int ret;
> +
> +	mutex_lock(&sch->lock);
> +
> +	if (!p->dnv || !p->ena) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if ((scsw_stctl(s) == SCSW_STCTL_STATUS_PEND) ||
> +	    (scsw_stctl(s) & (SCSW_STCTL_PRIM_STATUS |
> +			      SCSW_STCTL_SEC_STATUS |
> +			      SCSW_STCTL_ALERT_STATUS))) {
> +		ret = -EINPROGRESS;
> +		goto out;
> +	}
> +
> +	if (scsw_fctl(s) & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/* Trigger the halt function. */
> +	s->cmd.fctl |= SCSW_FCTL_HALT_FUNC;
> +	s->cmd.fctl &= ~SCSW_FCTL_START_FUNC;
> +	if ((scsw_actl(s) == (SCSW_ACTL_SCHACT | SCSW_ACTL_DEVACT)) &&
> +	    (scsw_stctl(s) == SCSW_STCTL_INTER_STATUS)) {
> +		s->cmd.stctl &= ~SCSW_STCTL_STATUS_PEND;
> +	}
> +	s->cmd.actl |= SCSW_ACTL_HALT_PEND;
> +
> +	/* Let userspace handle the halt function. */
> +	vcpu->run->exit_reason = KVM_EXIT_S390_SCH_IO;
> +	vcpu->run->s390_sch_io.func = SCH_DO_HSCH;
> +	vcpu->run->s390_sch_io.sch_id = (sch->cssid << 24) | (1 << 19) |
> +		(sch->ssid << 17) | 1 << 16 | sch->schid;
> +	memcpy(&vcpu->run->s390_sch_io.scsw, s, sizeof(*s));
> +	memcpy(&vcpu->run->s390_sch_io.pmcw, p, sizeof(*p));
> +	ret = -EREMOTE;
> +
> +out:
> +	mutex_unlock(&sch->lock);
> +	return ret;
> +}
> +
> +int css_do_ssch(struct kvm_vcpu *vcpu, struct kvm_subch *sch, u64 orb)
> +{
> +	union scsw *s = &sch->curr_status->scsw;
> +	struct pmcw *p = &sch->curr_status->pmcw;
> +	int ret;
> +
> +	mutex_lock(&sch->lock);
> +
> +	if (!p->dnv || !p->ena) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (scsw_stctl(s) & SCSW_STCTL_STATUS_PEND) {
> +		ret = -EINPROGRESS;
> +		goto out;
> +	}
> +
> +	if (scsw_fctl(s) & (SCSW_FCTL_START_FUNC |
> +			    SCSW_FCTL_HALT_FUNC |
> +			    SCSW_FCTL_CLEAR_FUNC)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/* If monitoring is active, update counter. */
> +	if (atomic_read(&vcpu->kvm->arch.css->chnmon_active))
> +		css_update_chnmon(vcpu, sch);
> +
> +	/* Trigger the start function. */
> +	s->cmd.fctl |= SCSW_FCTL_START_FUNC;
> +	s->cmd.actl |= SCSW_ACTL_START_PEND;
> +	s->cmd.pno = 0;
> +
> +	/* Let userspace handle the start function. */
> +	vcpu->run->exit_reason = KVM_EXIT_S390_SCH_IO;
> +	vcpu->run->s390_sch_io.func = SCH_DO_SSCH;
> +	vcpu->run->s390_sch_io.sch_id = (sch->cssid << 24) | (1 << 19) |
> +		(sch->ssid << 17) | 1 << 16 | sch->schid;
> +	memcpy(&vcpu->run->s390_sch_io.scsw, s, sizeof(*s));
> +	memcpy(&vcpu->run->s390_sch_io.pmcw, p, sizeof(*p));
> +	vcpu->run->s390_sch_io.orb = orb;
> +	ret = -EREMOTE;
> +
> +out:
> +	mutex_unlock(&sch->lock);
> +	return ret;
> +}
> +
> +int css_do_tsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch, uint32_t addr)
> +{
> +	union scsw *s = &sch->curr_status->scsw;
> +	struct pmcw *p = &sch->curr_status->pmcw;
> +	u8 stctl;
> +	u8 fctl;
> +	u8 actl;
> +	struct irb irb;
> +	int ret;
> +	u32 *esw;
> +
> +
> +	mutex_lock(&sch->lock);
> +
> +	if (!p->dnv || !p->ena) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	stctl = scsw_stctl(s);
> +	fctl = scsw_fctl(s);
> +	actl = scsw_actl(s);
> +
> +	memset(&irb, 0, sizeof(struct irb));
> +
> +	/* Copy scsw. */
> +	memcpy(&irb.scsw, s, sizeof(union scsw));
> +	esw = (u32 *)&irb.esw;
> +	if (stctl & SCSW_STCTL_STATUS_PEND) {
> +		if (scsw_cstat(s) & (SCHN_STAT_CHN_DATA_CHK |
> +				     SCHN_STAT_CHN_CTRL_CHK |
> +				     SCHN_STAT_INTF_CTRL_CHK)) {
> +			irb.scsw.cmd.eswf = 1;
> +			esw[0] = 0x04804000;
> +		} else
> +			esw[0] = 0x00800000;
> +
> +		/* If a unit check is pending, copy sense data. */
> +		if ((scsw_dstat(s) & DEV_STAT_UNIT_CHECK) && p->csense) {
> +			irb.scsw.cmd.eswf = 1;
> +			irb.scsw.cmd.ectl = 1;
> +			memcpy(irb.ecw, sch->sense_data,
> +			       sizeof(sch->sense_data));
> +			esw[1] = 0x02000000 | (sizeof(sch->sense_data) << 8);
> +		}
> +	}
> +	if (copy_to_guest(vcpu, addr, &irb, sizeof(struct irb))) {
> +		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	/* Clear conditions on subchannel, if applicable. */
> +	if (stctl & SCSW_STCTL_STATUS_PEND) {
> +		s->cmd.stctl = 0;
> +		if ((stctl != (SCSW_STCTL_INTER_STATUS |
> +			       SCSW_STCTL_STATUS_PEND)) ||
> +		    ((fctl & SCSW_FCTL_HALT_FUNC) &&
> +		     (actl & SCSW_ACTL_SUSPENDED)))
> +			s->cmd.fctl = 0;
> +
> +		if (stctl != (SCSW_STCTL_INTER_STATUS |
> +			      SCSW_STCTL_STATUS_PEND)) {
> +			s->cmd.pno = 0;
> +			s->cmd.actl &= ~(SCSW_ACTL_RESUME_PEND |
> +					 SCSW_ACTL_START_PEND |
> +					 SCSW_ACTL_HALT_PEND |
> +					 SCSW_ACTL_CLEAR_PEND |
> +					 SCSW_ACTL_SUSPENDED);
> +		} else {
> +			if ((actl & SCSW_ACTL_SUSPENDED) &&
> +			    (fctl & SCSW_FCTL_START_FUNC)) {
> +				s->cmd.pno = 0;
> +				if (fctl & SCSW_FCTL_HALT_FUNC)
> +					s->cmd.actl &= ~(SCSW_ACTL_RESUME_PEND |
> +							 SCSW_ACTL_START_PEND |
> +							 SCSW_ACTL_HALT_PEND |
> +							 SCSW_ACTL_CLEAR_PEND |
> +							 SCSW_ACTL_SUSPENDED);
> +				else
> +					s->cmd.actl &= ~SCSW_ACTL_RESUME_PEND;
> +			}
> +			/* Clear a possible pending I/O interrupt. */
> +			if (!list_empty(&sch->inti.list))
> +				kvm_s390_dequeue_internal(vcpu->kvm, &sch->inti);
> +		}
> +		/* Clear pending sense data. */
> +		if (p->csense)
> +			memset(sch->sense_data, 0 , sizeof(sch->sense_data));
> +	}
> +
> +	/*
> +	 * No need to exit to userspace since it will get the current state
> +	 * with the next exit.
> +	 */
> +	ret = (stctl & SCSW_STCTL_STATUS_PEND) ? -EBUSY : 0;
> +
> +out:
> +	mutex_unlock(&sch->lock);
> +	return ret;
> +}
> +
> +int css_do_rsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch)
> +{
> +	union scsw *s = &sch->curr_status->scsw;
> +	struct pmcw *p = &sch->curr_status->pmcw;
> +	int ret;
> +
> +	mutex_lock(&sch->lock);
> +
> +	if (!p->dnv || !p->ena) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (scsw_stctl(s) & SCSW_STCTL_STATUS_PEND) {
> +		ret = -EINPROGRESS;
> +		goto out;
> +	}
> +
> +	if ((scsw_fctl(s) != SCSW_FCTL_START_FUNC) ||
> +	    (scsw_actl(s) & SCSW_ACTL_RESUME_PEND) ||
> +	    (!(scsw_actl(s) & SCSW_ACTL_SUSPENDED))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* If monitoring is active, update counter. */
> +	if (atomic_read(&vcpu->kvm->arch.css->chnmon_active))
> +		css_update_chnmon(vcpu, sch);
> +
> +	s->cmd.actl |= SCSW_ACTL_RESUME_PEND;
> +	/* Let userspace handle the start function. */
> +	vcpu->run->exit_reason = KVM_EXIT_S390_SCH_IO;
> +	vcpu->run->s390_sch_io.func = SCH_DO_RSCH;
> +	vcpu->run->s390_sch_io.sch_id = (sch->cssid << 24) | (1 << 19) |
> +		(sch->ssid << 17) | 1 << 16 | sch->schid;
> +	memcpy(&vcpu->run->s390_sch_io.scsw, s, sizeof(*s));
> +	memcpy(&vcpu->run->s390_sch_io.pmcw, p, sizeof(*p));
> +	ret = -EREMOTE;
> +
> +out:
> +	mutex_unlock(&sch->lock);
> +	return ret;
> +}
> +
> +int kvm_arch_vcpu_ioctl_css_notify(struct kvm_vcpu *vcpu,
> +				   struct kvm_css_notify *notify)
> +{
> +	struct kvm_subch *sch;
> +	int ret;
> +
> +	trace_kvm_s390_css_notify(notify->cssid, notify->ssid, notify->schid);
> +	/* Userspace always gives us the real cssid. */
> +	sch = css_find_subch(vcpu->kvm, 1, notify->cssid, notify->ssid,
> +			     notify->schid);
> +	if (!sch)
> +		return -ENODEV;
> +	mutex_lock(&sch->lock);
> +	if (notify->unsolicited) {
> +		/*
> +		 * Userspace wants us to inject an unsolicited interrupt
> +		 * iff the subchannel is not status pending.
> +		 */
> +		if (scsw_stctl(&sch->curr_status->scsw) &
> +		    SCSW_STCTL_STATUS_PEND) {
> +			ret = 0;
> +			goto out;
> +		}
> +		sch->curr_status->scsw.cmd.stctl =
> +			SCSW_STCTL_ALERT_STATUS | SCSW_STCTL_STATUS_PEND;
> +	} else {
> +		/*
> +		 * First, check whether any I/O instructions have been
> +		 * issued in the mean time which would preclude normal
> +		 * signalling as requested by the control block. This
> +		 * might happen e.g. if the kernel accepted a csch while
> +		 * the start function was in progress in user space.
> +		 */
> +		if (((notify->func == SCH_DO_SSCH) ||
> +		     (notify->func == SCH_DO_RSCH)) &&
> +		    (scsw_fctl(&sch->curr_status->scsw) !=
> +		     SCSW_FCTL_START_FUNC)) {
> +			/*
> +			 * xsch, hsch, or csch happened.
> +			 * For the xsch case, no interrupt will be generated.
> +			 * For the hsch/csch case, another notification will
> +			 * happen.
> +			 */
> +			ret = 0;
> +			goto out;
> +		}
> +		if ((notify->func == SCH_DO_HSCH) &&
> +		    (scsw_fctl(&sch->curr_status->scsw) &
> +		     SCSW_FCTL_CLEAR_FUNC)) {
> +			/*
> +			 * csch happened, and another notification will come
> +			 * in later.
> +			 */
> +			ret = 0;
> +			goto out;
> +		}
> +		/* Update internal status. */
> +		memcpy(&sch->curr_status->scsw, &notify->scsw,
> +		       sizeof(notify->scsw));
> +		memcpy(&sch->curr_status->pmcw, &notify->pmcw,
> +		       sizeof(notify->pmcw));
> +		memcpy(sch->sense_data, notify->sense_data,
> +		       sizeof(notify->sense_data));
> +	}
> +
> +	/* Inject interrupt. */
> +	sch->inti.type = (sch->cssid << 24) | (sch->ssid << 22) |
> +		(sch->schid << 16);
> +	sch->inti.io.subchannel_id = vcpu->kvm->arch.css->max_cssid > 0 ?
> +		(sch->cssid << 8) | (1 << 3) | (sch->ssid << 1) | 1 :
> +		(sch->ssid << 1) | 1;
> +	sch->inti.io.subchannel_nr = sch->schid;
> +	sch->inti.io.io_int_parm = sch->curr_status->pmcw.intparm;
> +	sch->inti.io.io_int_word = (0x80 >> sch->curr_status->pmcw.isc) << 24;
> +	BUG_ON(!list_empty(&sch->inti.list));
> +	mutex_lock(&vcpu->kvm->lock);
> +	ret = kvm_s390_inject_internal(vcpu->kvm, &sch->inti);
> +	mutex_unlock(&vcpu->kvm->lock);
> +out:
> +	mutex_unlock(&sch->lock);
> +	return ret;
> +}
> +
> +static int css_add_to_store(struct kvm *kvm, struct kvm_subch *sch)
> +{
> +	struct css_image *css = kvm->arch.css->css[sch->cssid];
> +	struct schid_info *info;
> +	size_t schid_size;
> +
> +	if (!css)
> +		return -EINVAL;
> +	if (!css->schids[sch->ssid]) {
> +		schid_size = sizeof(struct schid_info) +
> +			__BITOPS_WORDS(__MAX_SUBCHANNEL + 1) *
> +			sizeof(unsigned long);
> +		css->schids[sch->ssid] = vmalloc(schid_size);
> +		if (!css->schids[sch->ssid])
> +			return -ENOMEM;
> +		memset(css->schids[sch->ssid], 0, schid_size);
> +	}
> +	info = css->schids[sch->ssid];
> +	info->schs[sch->schid] = sch;
> +	set_bit(sch->schid, info->bm);
> +
> +	return 0;
> +}
> +
> +static int css_remove_from_store(struct kvm *kvm, struct kvm_subch *sch)
> +{
> +	struct css_image *css = kvm->arch.css->css[sch->cssid];
> +	struct schid_info *info;
> +
> +	if (!css)
> +		return -EINVAL;
> +	info = css->schids[sch->ssid];
> +	if (!info)
> +		return -EINVAL;
> +	info->schs[sch->schid] = NULL;
> +	clear_bit(sch->schid, info->bm);
> +
> +	return 0;
> +}
> +
> +static int css_add_subchannel(struct kvm *kvm,
> +			      struct kvm_s390_sch_info *sch_info)
> +{
> +	struct kvm_subch *sch;
> +	struct kvm_s390_css_data *css = kvm->arch.css;
> +	u8 guest_cssid;
> +	bool no_crw;
> +
> +	/* Generate subchannel structure. */
> +	sch = kzalloc(sizeof(*sch), GFP_KERNEL);
> +	if (!sch)
> +		return -ENOMEM;
> +	sch->curr_status = kzalloc(sizeof(*sch->curr_status), GFP_KERNEL);
> +	if (!sch->curr_status) {
> +		kfree(sch);
> +		return -ENOMEM;
> +	}
> +	mutex_init(&sch->lock);
> +	sch->cssid = sch_info->cssid;
> +	sch->ssid = sch_info->ssid;
> +	sch->schid = sch_info->schid;
> +	sch->devno = sch_info->devno;
> +	memcpy(sch->curr_status, &sch_info->schib, sizeof(*sch->curr_status));
> +	INIT_LIST_HEAD(&sch->inti.list);
> +	sch->inti.nondyn = 1;
> +	/* Add subchannel to store. */
> +	css_add_to_store(kvm, sch);
> +	if (!sch_info->hotplugged)
> +		goto out;
> +	/*
> +	 * Generate add ccw.
> +	 *
> +	 * Only notify for higher subchannel sets/channel subsystems if the
> +	 * guest has enabled it.
> +	 */
> +	guest_cssid = ((css->max_cssid == 0) &&
> +		       (sch->cssid == css->default_cssid)) ?
> +		0 : sch->cssid;
> +	no_crw = (sch->ssid > css->max_ssid) ||
> +		(guest_cssid > css->max_cssid) ||
> +		((css->max_cssid == 0) && (sch->cssid != css->default_cssid));
> +	if (!no_crw) {
> +		css_queue_crw(kvm, CRW_RSC_SCH, CRW_ERC_IPARM,
> +			      ((css->max_ssid > 0) || (css->max_cssid > 0)) ?
> +			      1 : 0, sch->schid);
> +		if ((css->max_ssid > 0) || (css->max_cssid > 0))
> +			css_queue_crw(kvm, CRW_RSC_SCH, CRW_ERC_IPARM, 0,
> +				      (guest_cssid << 8) | (sch->ssid << 4));
> +	}
> +out:
> +	return 0;
> +}
> +
> +static int css_remove_subchannel(struct kvm *kvm, struct kvm_subch *sch)
> +{
> +	struct kvm_s390_css_data *css = kvm->arch.css;
> +	u8 guest_cssid;
> +	bool no_crw;
> +
> +	/* Make subchannel inaccessible. */
> +	mutex_lock(&sch->lock);
> +	/* Clear a possible pending I/O interrupt. */
> +	if (!list_empty(&sch->inti.list))
> +		kvm_s390_dequeue_internal(kvm, &sch->inti);
> +	css_remove_from_store(kvm, sch);
> +	mutex_unlock(&sch->lock);
> +	/*
> +	 * Generate removal ccw.
> +	 *
> +	 * Only notify for higher subchannel sets/channel subsystems if the
> +	 * guest has enabled it.
> +	 */
> +	guest_cssid = ((css->max_cssid == 0) &&
> +		       (sch->cssid == css->default_cssid)) ?
> +		0 : sch->cssid;
> +	no_crw = (sch->ssid > css->max_ssid) ||
> +		(guest_cssid > css->max_cssid) ||
> +		((css->max_cssid == 0) && (sch->cssid != css->default_cssid));
> +	if (!no_crw) {
> +		css_queue_crw(kvm, CRW_RSC_SCH, CRW_ERC_IPARM,
> +			      ((css->max_ssid > 0) || (css->max_cssid > 0)) ?
> +			      1 : 0, sch->schid);
> +		if ((css->max_ssid > 0) || (css->max_cssid > 0))
> +			css_queue_crw(kvm, CRW_RSC_SCH, CRW_ERC_IPARM, 0,
> +				      (guest_cssid << 8) | (sch->ssid << 4));
> +	}
> +	kfree(sch);
> +	return 0;
> +}
> +
> +int kvm_s390_process_ccw_hotplug(struct kvm *kvm,
> +				 struct kvm_s390_sch_info *sch_info)
> +{
> +	struct kvm_subch *sch;
> +
> +	trace_kvm_s390_ccw_hotplug(sch_info->cssid, sch_info->ssid,
> +				   sch_info->schid, sch_info->add);
> +	/* We currently support only virtual subchannels. */
> +	if (!sch_info->virtual)
> +		return -EINVAL;
> +
> +	/* Virtual subchannels must be in the virtual css. */
> +	if (sch_info->virtual && (sch_info->cssid != VIRTUAL_CSSID))
> +		return -EINVAL;
> +	/* Userspace always notifies with the real cssid. */
> +	sch = css_find_subch(kvm, 1, sch_info->cssid, sch_info->ssid,
> +			     sch_info->schid);
> +	if (sch_info->add) {
> +		/* New device. */
> +		if (sch)
> +			return -EINVAL;
> +		return css_add_subchannel(kvm, sch_info);
> +	} else {
> +		/* Device gone. */
> +		if (!sch)
> +			return -EINVAL;
> +		return css_remove_subchannel(kvm, sch);
> +	}
> +}
> +
> +int kvm_s390_process_chp_hotplug(struct kvm *kvm,
> +				 struct kvm_s390_chp_info *chp_info)
> +{
> +	if (!chp_info->virtual)
> +		/* Not supported for now. */
> +		return -EINVAL;
> +
> +	/* Virtual channel paths must be in the virtual css. */
> +	if (chp_info->virtual && (chp_info->cssid != VIRTUAL_CSSID))
> +		return -EINVAL;
> +	if (chp_info->add)
> +		return css_add_virtual_chpid(kvm, chp_info->cssid,
> +					     chp_info->chpid, chp_info->type);
> +	else
> +		return css_remove_virtual_chpid(kvm, chp_info->cssid,
> +						chp_info->chpid);
> +}
> +
> +int kvm_s390_enable_css(struct kvm *kvm)
> +{
> +	if (kvm->arch.css_support)
> +		return 0;
> +
> +	kvm->arch.css = kzalloc(sizeof(*kvm->arch.css), GFP_KERNEL);
> +	if (!kvm->arch.css)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&kvm->arch.css->pending_crws);
> +	INIT_LIST_HEAD(&kvm->arch.css->crw_inti.list);
> +	kvm->arch.css->crw_inti.type = KVM_S390_MCHK;
> +	kvm->arch.css->crw_inti.mchk.mcic = 0x00400f1d40330000;
> +	kvm->arch.css->crw_inti.mchk.cr14 = 1 << 28;
> +	kvm->arch.css->crw_inti.nondyn = 1;
> +	kvm->arch.css->do_crw_mchk = 1;
> +	atomic_set(&kvm->arch.css->chnmon_active, 0);
> +	kvm->arch.css_support = 1;
> +	trace_kvm_s390_enable_kernel_css(kvm);
> +	return 0;
> +}
> +
> +int kvm_s390_new_css(struct kvm *kvm, struct kvm_s390_css_info *css_info)
> +{
> +	struct kvm_s390_css_data *css;
> +
> +	if (!kvm->arch.css_support)
> +		return -EINVAL;
> +
> +	css = kvm->arch.css;
> +
> +	if (!css->css[css_info->cssid])
> +		css->css[css_info->cssid] = kzalloc(sizeof(struct css_image),
> +						    GFP_KERNEL);
> +	if (!css->css[css_info->cssid])
> +		return -ENOMEM;
> +
> +	if (css_info->default_image)
> +		css->default_cssid = css_info->cssid;
> +
> +	return 0;
> +}
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 754dc9e..9ab2efd 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -273,6 +273,7 @@ static const intercept_handler_t intercept_funcs[] = {
> 	[0x0C >> 2] = handle_instruction_and_prog,
> 	[0x10 >> 2] = handle_noop,
> 	[0x14 >> 2] = handle_noop,
> +	[0x18 >> 2] = handle_noop,
> 	[0x1C >> 2] = kvm_s390_handle_wait,
> 	[0x20 >> 2] = handle_validity,
> 	[0x28 >> 2] = handle_stop,
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index edc065f..072828b 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -370,6 +370,7 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
> 		
> 		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
> 				     __LC_MCK_NEW_PSW, sizeof(psw_t));
> +
> 		if (rc == -EFAULT)
> 			exception = 1;
> 		break;
> @@ -596,7 +597,7 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
> 			spin_lock_bh(&li->lock);
> 			list_for_each_entry_safe(inti, n, &li->list, list) {
> 				if (__interrupt_is_deliverable(vcpu, inti)) {
> -					list_del(&inti->list);
> +					list_del_init(&inti->list);
> 					deliver = 1;
> 					break;
> 				}
> @@ -607,7 +608,8 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
> 			spin_unlock_bh(&li->lock);
> 			if (deliver) {
> 				__do_deliver_interrupt(vcpu, inti);
> -				kfree(inti);
> +				if (!inti->nondyn)
> +					kfree(inti);
> 			}
> 		} while (deliver);
> 	}
> @@ -622,7 +624,7 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
> 			spin_lock(&fi->lock);
> 			list_for_each_entry_safe(inti, n, &fi->list, list) {
> 				if (__interrupt_is_deliverable(vcpu, inti)) {
> -					list_del(&inti->list);
> +					list_del_init(&inti->list);
> 					deliver = 1;
> 					break;
> 				}
> @@ -633,7 +635,8 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
> 			spin_unlock(&fi->lock);
> 			if (deliver) {
> 				__do_deliver_interrupt(vcpu, inti);
> -				kfree(inti);
> +				if (!inti->nondyn)
> +					kfree(inti);
> 			}
> 		} while (deliver);
> 	}
> @@ -654,7 +657,7 @@ void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
> 			list_for_each_entry_safe(inti, n, &li->list, list) {
> 				if ((inti->type == KVM_S390_MCHK) &&
> 				    __interrupt_is_deliverable(vcpu, inti)) {
> -					list_del(&inti->list);
> +					list_del_init(&inti->list);
> 					deliver = 1;
> 					break;
> 				}
> @@ -665,7 +668,8 @@ void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
> 			spin_unlock_bh(&li->lock);
> 			if (deliver) {
> 				__do_deliver_interrupt(vcpu, inti);
> -				kfree(inti);
> +				if (!inti->nondyn)
> +					kfree(inti);
> 			}
> 		} while (deliver);
> 	}
> @@ -677,7 +681,7 @@ void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
> 			list_for_each_entry_safe(inti, n, &fi->list, list) {
> 				if ((inti->type == KVM_S390_MCHK) &&
> 				    __interrupt_is_deliverable(vcpu, inti)) {
> -					list_del(&inti->list);
> +					list_del_init(&inti->list);
> 					deliver = 1;
> 					break;
> 				}
> @@ -688,7 +692,8 @@ void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
> 			spin_unlock(&fi->lock);
> 			if (deliver) {
> 				__do_deliver_interrupt(vcpu, inti);
> -				kfree(inti);
> +				if (!inti->nondyn)
> +					kfree(inti);
> 			}
> 		} while (deliver);
> 	}
> @@ -716,14 +721,100 @@ int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
> 	return 0;
> }
> 
> -int kvm_s390_inject_vm(struct kvm *kvm,
> -		       struct kvm_s390_interrupt *s390int)
> +int kvm_s390_inject_internal(struct kvm *kvm,
> +			     struct kvm_s390_interrupt_info *inti)
> {
> 	struct kvm_s390_local_interrupt *li;
> 	struct kvm_s390_float_interrupt *fi;
> -	struct kvm_s390_interrupt_info *inti, *iter;
> +	struct kvm_s390_interrupt_info *iter;
> 	int sigcpu;
> 
> +	fi = &kvm->arch.float_int;
> +	spin_lock(&fi->lock);
> +	if (!is_ioint(inti->type))
> +		list_add_tail(&inti->list, &fi->list);
> +	else {
> +		/* Keep I/O interrupts sorted in isc order. */
> +		list_for_each_entry(iter, &fi->list, list) {
> +			if (!is_ioint(iter->type))
> +				continue;
> +			if (iter->io.io_int_word <= inti->io.io_int_word)
> +				continue;
> +			break;
> +		}
> +		list_add_tail(&inti->list, &iter->list);
> +	}
> +	atomic_set(&fi->active, 1);
> +	sigcpu = find_first_bit(fi->idle_mask, KVM_MAX_VCPUS);
> +	if (sigcpu == KVM_MAX_VCPUS) {
> +		do {
> +			sigcpu = fi->next_rr_cpu++;
> +			if (sigcpu == KVM_MAX_VCPUS)
> +				sigcpu = fi->next_rr_cpu = 0;
> +		} while (fi->local_int[sigcpu] == NULL);
> +	}
> +	li = fi->local_int[sigcpu];
> +	spin_lock_bh(&li->lock);
> +	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
> +	if (waitqueue_active(&li->wq))
> +		wake_up_interruptible(&li->wq);
> +	spin_unlock_bh(&li->lock);
> +	spin_unlock(&fi->lock);
> +	return 0;
> +}
> +
> +int kvm_s390_dequeue_internal(struct kvm *kvm,
> +			      struct kvm_s390_interrupt_info *inti)
> +{
> +	struct kvm_s390_float_interrupt *fi;
> +
> +	if (!inti)
> +		return -EINVAL;
> +
> +	mutex_lock(&kvm->lock);
> +	fi = &kvm->arch.float_int;
> +	spin_lock(&fi->lock);
> +	list_del_init(&inti->list);
> +	if (list_empty(&fi->list))
> +		atomic_set(&fi->active, 0);
> +	spin_unlock(&fi->lock);
> +	mutex_unlock(&kvm->lock);
> +	return 0;
> +}
> +
> +struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm, u64 cr6)
> +{
> +	struct kvm_s390_float_interrupt *fi;
> +	struct kvm_s390_interrupt_info *inti, *iter;
> +
> +	mutex_lock(&kvm->lock);
> +	fi = &kvm->arch.float_int;
> +	spin_lock(&fi->lock);
> +	inti = NULL;
> +	list_for_each_entry(iter, &fi->list, list) {
> +		if (!is_ioint(iter->type))
> +			continue;
> +		if ((cr6 & iter->io.io_int_word) == 0)
> +			continue;
> +		inti = iter;
> +		break;
> +	}
> +	if (inti)
> +		list_del_init(&inti->list);
> +	if (list_empty(&fi->list))
> +		atomic_set(&fi->active, 0);
> +	spin_unlock(&fi->lock);
> +	mutex_unlock(&kvm->lock);
> +	return inti;
> +}
> +
> +
> +int kvm_s390_inject_vm(struct kvm *kvm,
> +		       struct kvm_s390_interrupt *s390int)
> +{
> +	struct kvm_s390_interrupt_info *inti;
> +	int rc;
> +
> 	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
> 	if (!inti)
> 		return -ENOMEM;
> @@ -776,39 +867,9 @@ int kvm_s390_inject_vm(struct kvm *kvm,
> 				 2);
> 
> 	mutex_lock(&kvm->lock);
> -	fi = &kvm->arch.float_int;
> -	spin_lock(&fi->lock);
> -	if (!is_ioint(inti->type))
> -		list_add_tail(&inti->list, &fi->list);
> -	else {
> -		/* Keep I/O interrupts sorted in isc order. */
> -		list_for_each_entry(iter, &fi->list, list) {
> -			if (!is_ioint(iter->type))
> -				continue;
> -			if (iter->io.io_int_word <= inti->io.io_int_word)
> -				continue;
> -			break;
> -		}
> -		list_add_tail(&inti->list, &iter->list);
> -	}
> -	atomic_set(&fi->active, 1);
> -	sigcpu = find_first_bit(fi->idle_mask, KVM_MAX_VCPUS);
> -	if (sigcpu == KVM_MAX_VCPUS) {
> -		do {
> -			sigcpu = fi->next_rr_cpu++;
> -			if (sigcpu == KVM_MAX_VCPUS)
> -				sigcpu = fi->next_rr_cpu = 0;
> -		} while (fi->local_int[sigcpu] == NULL);
> -	}
> -	li = fi->local_int[sigcpu];
> -	spin_lock_bh(&li->lock);
> -	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
> -	if (waitqueue_active(&li->wq))
> -		wake_up_interruptible(&li->wq);
> -	spin_unlock_bh(&li->lock);
> -	spin_unlock(&fi->lock);
> +	rc = kvm_s390_inject_internal(kvm, inti);
> 	mutex_unlock(&kvm->lock);
> -	return 0;
> +	return rc;
> }
> 
> int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
> diff --git a/arch/s390/kvm/ioinst.c b/arch/s390/kvm/ioinst.c
> new file mode 100644
> index 0000000..29c4629
> --- /dev/null
> +++ b/arch/s390/kvm/ioinst.c
> @@ -0,0 +1,797 @@
> +/*
> + * Handling of channel I/O instructions for kvm
> + *
> + * Copyright IBM Corp. 2012
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License (version 2 only)
> + * as published by the Free Software Foundation.
> + *
> + *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> + */
> +
> +#include <linux/kvm.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/types.h>
> +#include <asm/cio.h>
> +#include <asm/crw.h>
> +#include <asm/orb.h>
> +#include <asm/schib.h>
> +#include <asm/schid.h>
> +#include <asm/scsw.h>
> +#include "kvm-s390.h"
> +#include "gaccess.h"
> +#include "trace.h"
> +
> +#define PRIV_CSCH                       0x30
> +#define PRIV_HSCH                       0x31
> +#define PRIV_MSCH                       0x32
> +#define PRIV_SSCH                       0x33
> +#define PRIV_STSCH                      0x34
> +#define PRIV_TSCH                       0x35
> +#define PRIV_TPI                        0x36
> +#define PRIV_SAL                        0x37
> +#define PRIV_RSCH                       0x38
> +#define PRIV_STCRW                      0x39
> +#define PRIV_STCPS                      0x3a
> +#define PRIV_RCHP                       0x3b
> +#define PRIV_SCHM                       0x3c
> +#define PRIV_CHSC                       0x5f
> +#define PRIV_XSCH                       0x76
> +
> +static int ioinst_disassemble_sch_ident(u32 value, int *m, int *cssid, int *ssid,
> +					int *schid)
> +{
> +	if (!(value & 0x00010000))
> +		return -EINVAL;
> +
> +	if (!(value & 0x00080000)) {
> +		if (value & 0xff000000)
> +			return -EINVAL;
> +		*m = 0;
> +		*cssid = 0;
> +	} else {
> +		*m = 1;
> +		*cssid = (value & 0xff000000) >> 24;
> +	}
> +	*ssid = (value & 0x00060000) >> 17;
> +	*schid = value & 0x0000ffff;
> +	return 0;
> +}
> +
> +static int ioinst_handle_xsch(struct kvm_vcpu *vcpu, int *cc, u64 reg1)
> +{
> +	int m, cssid, ssid, schid;
> +	struct kvm_subch *sch;
> +	int ret = -ENODEV;
> +
> +	if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	trace_kvm_s390_handle_ioinst("xsch", cssid, ssid, schid);
> +	sch = css_find_subch(vcpu->kvm, m, cssid, ssid, schid);
> +	if (sch)
> +		ret = css_do_xsch(vcpu, sch);
> +
> +	switch (ret) {
> +	case -ENODEV:
> +		*cc = 3;
> +		break;
> +	case -EBUSY:
> +		*cc = 2;
> +		break;
> +	case -EREMOTE:
> +		*cc = 0;
> +		break;
> +	default:
> +		*cc = 1;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ioinst_handle_csch(struct kvm_vcpu *vcpu, int *cc, u64 reg1)
> +{
> +	int m, cssid, ssid, schid;
> +	struct kvm_subch *sch;
> +	int ret = -ENODEV;
> +
> +	if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	trace_kvm_s390_handle_ioinst("csch", cssid, ssid, schid);
> +	sch = css_find_subch(vcpu->kvm, m, cssid, ssid, schid);
> +	if (sch)
> +		ret = css_do_csch(vcpu, sch);
> +
> +	if (ret == -ENODEV) {
> +		*cc = 3;
> +	} else {
> +		*cc = 0;
> +	}
> +	return ret;
> +}
> +
> +static int ioinst_handle_hsch(struct kvm_vcpu *vcpu, int *cc, u64 reg1)
> +{
> +	int m, cssid, ssid, schid;
> +	struct kvm_subch *sch;
> +	int ret = -ENODEV;
> +
> +	if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	trace_kvm_s390_handle_ioinst("hsch", cssid, ssid, schid);
> +	sch = css_find_subch(vcpu->kvm, m, cssid, ssid, schid);
> +	if (sch)
> +		ret = css_do_hsch(vcpu, sch);
> +
> +	switch (ret) {
> +	case -ENODEV:
> +		*cc = 3;
> +		break;
> +	case -EBUSY:
> +		*cc = 2;
> +		break;
> +	case -EREMOTE:
> +		*cc = 0;
> +		break;
> +	default:
> +		*cc = 1;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ioinst_schib_valid(struct schib *schib)
> +{
> +	if (schib->pmcw.res5 != 0)
> +		return 0;
> +
> +	if ((schib->pmcw.unused1 != 0) || (schib->pmcw.unused2 != 0))
> +		return 0;
> +
> +	/* Disallow extended measurements for now. */
> +	if (schib->pmcw.xmwme)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int ioinst_handle_msch(struct kvm_vcpu *vcpu, int *cc, u64 reg1, u32 ipb)
> +{
> +	int m, cssid, ssid, schid;
> +	struct kvm_subch *sch;
> +	struct schib schib;
> +	u32 addr;
> +	int ret = -ENODEV;
> +
> +	if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	addr = ipb >> 28;
> +	if (addr > 0)
> +		addr = vcpu->run->s.regs.gprs[addr];
> +
> +	addr += (ipb & 0xfff0000) >> 16;
> +	if (copy_from_guest(vcpu, &schib, addr, sizeof(struct schib))) {
> +		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +		return -EIO;
> +	}
> +	if (!ioinst_schib_valid(&schib)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	trace_kvm_s390_handle_ioinst("msch", cssid, ssid, schid);
> +	sch = css_find_subch(vcpu->kvm, m, cssid, ssid, schid);
> +	if (sch)
> +		ret = css_do_msch(vcpu, sch, &schib);
> +
> +	switch (ret) {
> +	case -ENODEV:
> +		*cc = 3;
> +		break;
> +	case -EBUSY:
> +		*cc = 2;
> +		break;
> +	case 0:
> +		*cc = 0;
> +		break;
> +	default:
> +		*cc = 1;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ioinst_orb_valid(union orb *orb)
> +{
> +	if (orb->cmd.res2 != 0)
> +		return 0;
> +
> +	if (orb->cmd.zero != 0)
> +		return 0;
> +
> +	if ((orb->cmd.cpa & 0x80000000) != 0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int ioinst_handle_ssch(struct kvm_vcpu *vcpu, int *cc, u64 reg1, u32 ipb)
> +{
> +	int m, cssid, ssid, schid;
> +	struct kvm_subch *sch;
> +	union orb orb;
> +	u32 addr;
> +	int ret = -ENODEV;
> +
> +	if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	addr = ipb >> 28;
> +	if (addr > 0)
> +		addr = vcpu->run->s.regs.gprs[addr];
> +
> +	addr += (ipb & 0xfff0000) >> 16;
> +	if (copy_from_guest(vcpu, &orb, addr, sizeof(union orb))) {
> +		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +		return -EIO;
> +	}
> +	if (!ioinst_orb_valid(&orb)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	trace_kvm_s390_handle_ioinst("ssch", cssid, ssid, schid);
> +	sch = css_find_subch(vcpu->kvm, m, cssid, ssid, schid);
> +	if (sch)
> +		ret = css_do_ssch(vcpu, sch, addr);
> +
> +	switch (ret) {
> +	case -ENODEV:
> +		*cc = 3;
> +		break;
> +	case -EBUSY:
> +		*cc = 2;
> +		break;
> +	case -EREMOTE:
> +		*cc = 0;
> +		break;
> +	default:
> +		*cc = 1;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ioinst_handle_stcrw(struct kvm_vcpu *vcpu, int *cc, u32 ipb)
> +{
> +	int ret;
> +	u32 addr;
> +
> +	addr = ipb >> 28;
> +	if (addr > 0)
> +		addr = vcpu->run->s.regs.gprs[addr];
> +
> +	addr += (ipb & 0xfff0000) >> 16;
> +	ret = css_do_stcrw(vcpu, addr);
> +	/* 0 - crw stored, 1 - zeroes stored */
> +	if (ret >= 0) {
> +		*cc = ret;
> +		ret = 0;
> +	}
> +	return 0;
> +}
> +
> +static int ioinst_handle_stsch(struct kvm_vcpu *vcpu, int *cc, u64 reg1, u32 ipb)
> +{
> +	int m, cssid, ssid, schid;
> +	struct kvm_subch *sch;
> +	u32 addr;
> +	int ret;
> +
> +	if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	addr = ipb >> 28;
> +	if (addr > 0)
> +		addr = vcpu->run->s.regs.gprs[addr];
> +
> +	addr += (ipb & 0xfff0000) >> 16;
> +	if (addr & 3) {
> +		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +		return -EIO;
> +	}
> +	trace_kvm_s390_handle_ioinst("stsch", cssid, ssid, schid);
> +	sch = css_find_subch(vcpu->kvm, m, cssid, ssid, schid);
> +	if (sch) {
> +		ret = copy_to_guest(vcpu, addr, sch->curr_status,
> +				    sizeof(*sch->curr_status));
> +		if (ret < 0)
> +			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +		else
> +			*cc = 0;
> +	} else {
> +		if (css_schid_final(vcpu->kvm, m ? cssid :
> +				    (cssid ? cssid : VIRTUAL_CSSID),
> +				    ssid, schid)) {
> +			*cc = 3; /* No more subchannels in this css/ss */
> +			ret = 0;
> +		} else {
> +			struct schib schib;
> +
> +			/* Store an empty schib. */
> +			memset(&schib, 0, sizeof(struct schib));
> +			ret = copy_to_guest(vcpu, addr, &schib, sizeof(schib));
> +			if (ret < 0)
> +				kvm_s390_inject_program_int(vcpu,
> +							    PGM_ADDRESSING);
> +			else
> +				*cc = 0;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int ioinst_handle_tsch(struct kvm_vcpu *vcpu, int *cc, u64 reg1, u32 ipb)
> +{
> +	int m, cssid, ssid, schid;
> +	struct kvm_subch *sch;
> +	u32 addr;
> +	int ret = -ENODEV;
> +
> +	if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	addr = ipb >> 28;
> +	if (addr > 0)
> +		addr = vcpu->run->s.regs.gprs[addr];
> +
> +	addr += (ipb & 0xfff0000) >> 16;
> +	trace_kvm_s390_handle_ioinst("tsch", cssid, ssid, schid);
> +	sch = css_find_subch(vcpu->kvm, m, cssid, ssid, schid);
> +	if (sch)
> +		ret = css_do_tsch(vcpu, sch, addr);
> +	/* 0 - status pending, 1 - not status pending */
> +	switch (ret) {
> +	case -EBUSY:
> +		*cc = 0;
> +		break;
> +	case 0:
> +		*cc = 1;
> +		break;
> +	case -ENODEV:
> +		*cc = 3;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +struct chsc_req {
> +	u16 len;
> +	u16 command;
> +	u32 param0;
> +	u32 param1;
> +	u32 param2;
> +} __attribute__((packed));
> +
> +struct chsc_resp {
> +	u16 len;
> +	u16 code;
> +	u32 param;
> +	char data[0];
> +} __attribute__((packed));
> +
> +#define CHSC_SCPD 0x0002
> +#define CHSC_SCSC 0x0010
> +#define CHSC_SDA  0x0031
> +
> +static void ioinst_handle_chsc_scpd(struct kvm *kvm, struct chsc_req *req,
> +				    struct chsc_resp *res)
> +{
> +	u16 resp_code;
> +	int rfmt;
> +	u16 cssid;
> +	u8 f_chpid, l_chpid;
> +	int desc_size;
> +
> +	rfmt = (req->param0 & 0x00000f00) >> 8;
> +	if ((rfmt == 0) ||  (rfmt == 1))
> +		rfmt = (req->param0 & 0x10000000) >> 28;
> +
> +	if ((req->len != 0x0010) || (req->param0 & 0xc000f000) ||
> +	    (req->param1 & 0xffffff00) || req->param2) {
> +		resp_code = 0x0003;
> +		goto out_err;
> +	}
> +	if (req->param0 & 0x0f000000) {
> +		resp_code = 0x0007;
> +		goto out_err;
> +	}
> +	cssid = (req->param0 & 0x00ff0000) >> 16;
> +	if (cssid != 0)
> +		if (!(req->param0 & 0x20000000) || (cssid != VIRTUAL_CSSID)) {
> +			resp_code = 0x0008;
> +			goto out_err;
> +		}
> +
> +	if ((cssid == 0) && (!(req->param0 & 0x20000000)))
> +		cssid = VIRTUAL_CSSID;
> +
> +	f_chpid = req->param0 & 0x000000ff;
> +	l_chpid = req->param1 & 0x000000ff;
> +	if (l_chpid < f_chpid) {
> +		resp_code = 0x0003;
> +		goto out_err;
> +	}
> +	desc_size = css_collect_chp_desc(kvm, cssid, f_chpid, l_chpid, rfmt,
> +					 &res->data);
> +	res->code = 0x0001;
> +	res->len = 8 + desc_size;
> +	res->param = rfmt;
> +	return;
> +
> +out_err:
> +	res->code = resp_code;
> +	res->len = 8;
> +	res->param = rfmt;
> +}
> +
> +/* For now, always the same characteristics. */
> +static u32 general_chars[510] = { 0x03000000, 0x00059000, 0, };
> +static u32 chsc_chars[508] = { 0x40000000, 0x00040000, 0, };
> +
> +static void ioinst_handle_chsc_scsc(struct kvm *kvm, struct chsc_req *req,
> +				    struct chsc_resp *res)
> +{
> +	u8 cssid;
> +	u16 resp_code;
> +
> +	if (req->param0 & 0x000f0000) {
> +		resp_code = 0x0007;
> +		goto out_err;
> +	}
> +	cssid = (req->param0 & 0x0000ff00) >> 8;
> +	if (cssid != 0)
> +		if (!(req->param0 & 0x20000000) || (cssid != VIRTUAL_CSSID)) {
> +			resp_code = 0x0008;
> +			goto out_err;
> +		}
> +
> +	if ((req->param0 & 0xdff000ff) || req->param1 || req->param2) {
> +		resp_code = 0x0003;
> +		goto out_err;
> +	}
> +	res->code = 0x0001;
> +	res->len = 4080;
> +	res->param = 0;
> +
> +	memcpy(res->data, general_chars, sizeof(general_chars));
> +	memcpy(res->data + sizeof(general_chars), chsc_chars,
> +	       sizeof(chsc_chars));
> +	return;
> +
> +out_err:
> +	res->code = resp_code;
> +	res->len = 8;
> +	res->param = 0;
> +}
> +
> +#define CHSC_SDA_SC_MCSSE 0x0
> +#define CHSC_SDA_SC_MSS 0x2
> +
> +static void ioinst_handle_chsc_sda(struct kvm *kvm, struct chsc_req *req,
> +				   struct chsc_resp *res)
> +{
> +	u16 resp_code = 0x0001;
> +	u16 oc;
> +	int ret;
> +
> +	if ((req->len != 0x0400) || (req->param0 & 0xf0ff0000)) {
> +		resp_code = 0x0003;
> +		goto out;
> +	}
> +
> +	if (req->param0 & 0x0f000000) {
> +		resp_code = 0x0007;
> +		goto out;
> +	}
> +
> +	oc = req->param0 & 0x0000ffff;
> +	switch (oc) {
> +	case CHSC_SDA_SC_MCSSE:
> +		ret = css_enable_mcsse(kvm);
> +		if (ret == -EINVAL) {
> +			resp_code = 0x0101;
> +			goto out;
> +		}
> +		break;
> +	case CHSC_SDA_SC_MSS:
> +		ret = css_enable_mss(kvm);
> +		if (ret == -EINVAL) {
> +			resp_code = 0x0101;
> +			goto out;
> +		}
> +		break;
> +	default:
> +		resp_code = 0x0003;
> +		goto out;
> +	}
> +
> +out:
> +	res->code = resp_code;
> +	res->len = 8;
> +	res->param = 0;
> +}
> +
> +static void ioinst_handle_chsc_unimplemented(struct chsc_resp *res)
> +{
> +	res->len = 8;
> +	res->code = 0x0004;
> +	res->param = 0;
> +}
> +
> +static int ioinst_handle_chsc(struct kvm_vcpu *vcpu, int *cc, u32 ipb)
> +{
> +	struct chsc_req *req;
> +	struct chsc_resp *res;
> +	u64 addr;
> +	int reg;
> +	int ret;
> +
> +	reg = (ipb >> 20) & 0x00f;
> +	addr = vcpu->run->s.regs.gprs[reg];
> +	if (addr & 0x0000000000000fff) {
> +		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +		return -EIO;
> +	}
> +	req = (struct chsc_req *)get_zeroed_page(GFP_KERNEL);
> +	if (!req)
> +		return -EFAULT;
> +	if (copy_from_guest(vcpu, req, addr, sizeof(*req))) {
> +		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +		return -EFAULT;
> +	}
> +	if ((req->len & 3) || (req->len < 16) || (req->len > 4088)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	res = (struct chsc_resp *)((unsigned long)req + req->len);
> +	switch (req->command) {
> +	case CHSC_SCSC:
> +		ioinst_handle_chsc_scsc(vcpu->kvm, req, res);
> +		break;
> +	case CHSC_SCPD:
> +		ioinst_handle_chsc_scpd(vcpu->kvm, req, res);
> +		break;
> +	case CHSC_SDA:
> +		ioinst_handle_chsc_sda(vcpu->kvm, req, res);
> +		break;
> +	default:
> +		ioinst_handle_chsc_unimplemented(res);
> +		break;
> +	}
> +	ret = copy_to_guest(vcpu, addr + req->len, res, res->len);
> +	if (ret < 0)
> +		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +	else
> +		*cc = 0;
> +	free_page((unsigned long)req);
> +	return ret;
> +}
> +
> +static int ioinst_handle_tpi(struct kvm_vcpu *vcpu, int *cc, u32 ipb)
> +{
> +	u32 addr;
> +	int lowcore;
> +
> +	addr = ipb >> 28;
> +	if (addr > 0)
> +		addr = vcpu->run->s.regs.gprs[addr];
> +
> +	addr += (ipb & 0xfff0000) >> 16;
> +	lowcore = addr ? 0 : 1;
> +	*cc = css_do_tpi(vcpu, addr, lowcore);
> +	return 0;
> +}
> +
> +static int ioinst_handle_schm(struct kvm_vcpu *vcpu, u64 reg1, u64 reg2,
> +			      u32 ipb)
> +{
> +	u8 mbk;
> +	int update;
> +	int dct;
> +
> +	if (reg1 & 0x000000000ffffffc) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +
> +	mbk = (reg1 & 0x00000000f0000000) >> 28;
> +	update = (reg1 & 0x0000000000000002) >> 1;
> +	dct = reg1 & 0x0000000000000001;
> +
> +	if (update && (reg2 & 0x0000000000000fff)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +
> +	css_do_schm(vcpu, mbk, update, dct, update ? reg2 : 0);
> +
> +	return 0;
> +}
> +
> +static int ioinst_handle_rsch(struct kvm_vcpu *vcpu, int *cc, u64 reg1)
> +{
> +	int m, cssid, ssid, schid;
> +	struct kvm_subch *sch;
> +	int ret = -ENODEV;
> +
> +	if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	trace_kvm_s390_handle_ioinst("rsch", cssid, ssid, schid);
> +	sch = css_find_subch(vcpu->kvm, m, cssid, ssid, schid);
> +	if (sch)
> +		ret = css_do_rsch(vcpu, sch);
> +
> +	switch (ret) {
> +	case -ENODEV:
> +		*cc = 3;
> +		break;
> +	case -EINVAL:
> +		*cc = 2;
> +		break;
> +	case -EREMOTE:
> +		*cc = 0;
> +		break;
> +	default:
> +		*cc = 1;
> +		break;
> +	}
> +
> +	return ret;
> +
> +}
> +
> +static int ioinst_handle_rchp(struct kvm_vcpu *vcpu, int *cc, u64 reg1)
> +{
> +	u8 cssid;
> +	u8 chpid;
> +	int ret;
> +	struct kvm_s390_css_data *css = vcpu->kvm->arch.css;
> +
> +	if (reg1 & 0xff00ff00) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +
> +	cssid = (reg1 >> 16) & 0xff;
> +	chpid = reg1 & 0xff;
> +
> +	if (cssid > css->max_cssid) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		ret = -EIO;
> +	} else if (!css_chpid_in_use(vcpu->kvm, cssid, chpid)) {
> +		ret = 0;
> +		*cc = 3;
> +	} else {
> +		/*
> +		 * Since we only support virtual (i.e. not real) channel paths,
> +		 * there's nothing left for us to do save signaling success.
> +		 */
> +		css_queue_crw(vcpu->kvm, CRW_RSC_CPATH, CRW_ERC_INIT,
> +			      css->max_cssid > 0 ? 1 : 0, chpid);
> +		if (css->max_cssid > 0)
> +			css_queue_crw(vcpu->kvm, CRW_RSC_CPATH, CRW_ERC_INIT, 0,
> +				      cssid << 8);
> +		ret = 0;
> +		*cc = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ioinst_handle_sal(struct kvm_vcpu *vcpu, u64 reg1)
> +{
> +	/* We do not provide address limit checking, so let's suppress it. */
> +	if (reg1 & 0x000000008000ffff) {
> +		kvm_s390_inject_program_int(vcpu, PGM_OPERAND);
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +int kvm_css_instruction(struct kvm_vcpu *vcpu)
> +{
> +	int ret;
> +	int cc;
> +	int no_cc = 0;
> +
> +	if ((vcpu->arch.sie_block->ipa & 0xff00) != 0xb200)
> +		/* Not handled for now. */
> +		return -EOPNOTSUPP;
> +
> +	switch (vcpu->arch.sie_block->ipa & 0x00ff) {
> +	case PRIV_XSCH:
> +		ret = ioinst_handle_xsch(vcpu, &cc, vcpu->run->s.regs.gprs[1]);
> +		break;
> +	case PRIV_CSCH:
> +		ret = ioinst_handle_csch(vcpu, &cc, vcpu->run->s.regs.gprs[1]);
> +		break;
> +	case PRIV_HSCH:
> +		ret = ioinst_handle_hsch(vcpu, &cc, vcpu->run->s.regs.gprs[1]);
> +		break;
> +	case PRIV_MSCH:
> +		ret = ioinst_handle_msch(vcpu, &cc, vcpu->run->s.regs.gprs[1],
> +					 vcpu->arch.sie_block->ipb);
> +		break;
> +	case PRIV_SSCH:
> +		ret = ioinst_handle_ssch(vcpu, &cc, vcpu->run->s.regs.gprs[1],
> +					 vcpu->arch.sie_block->ipb);
> +		break;
> +	case PRIV_STCRW:
> +		ret = ioinst_handle_stcrw(vcpu, &cc, vcpu->arch.sie_block->ipb);
> +		break;
> +	case PRIV_STSCH:
> +		ret = ioinst_handle_stsch(vcpu, &cc, vcpu->run->s.regs.gprs[1],
> +					  vcpu->arch.sie_block->ipb);
> +		break;
> +	case PRIV_TSCH:
> +		ret = ioinst_handle_tsch(vcpu, &cc, vcpu->run->s.regs.gprs[1],
> +					 vcpu->arch.sie_block->ipb);
> +		break;
> +	case PRIV_CHSC:
> +		ret = ioinst_handle_chsc(vcpu, &cc, vcpu->arch.sie_block->ipb);
> +		break;
> +	case PRIV_TPI:
> +		ret = ioinst_handle_tpi(vcpu, &cc, vcpu->arch.sie_block->ipb);
> +		break;
> +	case PRIV_SCHM:
> +		no_cc = 1;
> +		ret = ioinst_handle_schm(vcpu, vcpu->run->s.regs.gprs[1],
> +					 vcpu->run->s.regs.gprs[2],
> +					 vcpu->arch.sie_block->ipb);
> +		break;
> +	case PRIV_RSCH:
> +		ret = ioinst_handle_rsch(vcpu, &cc, vcpu->run->s.regs.gprs[1]);
> +		break;
> +	case PRIV_RCHP:
> +		ret = ioinst_handle_rchp(vcpu, &cc, vcpu->run->s.regs.gprs[1]);
> +		break;
> +	case PRIV_STCPS:
> +		/* We do not provide this instruction, it is suppressed. */
> +		no_cc = 1;
> +		ret = 0;
> +		break;
> +	case PRIV_SAL:
> +		no_cc = 1;
> +		ret = ioinst_handle_sal(vcpu, vcpu->run->s.regs.gprs[1]);
> +		break;
> +	default:
> +		/* Give user space a go at this. */
> +		return -EOPNOTSUPP;
> +	}
> +	if ((ret != -EFAULT) && (ret != -EIO) && (ret != -EREMOTE))
> +		ret = 0;
> +
> +	if ((!ret || (ret == -EREMOTE)) && !no_cc) {
> +		vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
> +		vcpu->arch.sie_block->gpsw.mask |= (cc & 3ul) << 44;
> +	}
> +
> +	return (ret == -EREMOTE) ? ret : 0;
> +}
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4b0681c..a2ba7e1 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -141,6 +141,7 @@ int kvm_dev_ioctl_check_extension(long ext)
> 	case KVM_CAP_SYNC_REGS:
> 	case KVM_CAP_ONE_REG:
> 	case KVM_CAP_ENABLE_CAP:
> +	case KVM_CAP_S390_CSS_SUPPORT:
> 		r = 1;
> 		break;
> 	case KVM_CAP_NR_VCPUS:
> @@ -183,6 +184,33 @@ long kvm_arch_vm_ioctl(struct file *filp,
> 		r = kvm_s390_inject_vm(kvm, &s390int);
> 		break;
> 	}
> +	case KVM_S390_CCW_HOTPLUG: {
> +		struct kvm_s390_sch_info sch_info;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&sch_info, argp, sizeof(sch_info)))
> +			break;
> +		r = kvm_s390_process_ccw_hotplug(kvm, &sch_info);
> +		break;
> +	}
> +	case KVM_S390_CHP_HOTPLUG: {
> +		struct kvm_s390_chp_info chp_info;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&chp_info, argp, sizeof(chp_info)))
> +			break;
> +		r = kvm_s390_process_chp_hotplug(kvm, &chp_info);
> +		break;
> +	}
> +	case KVM_S390_ADD_CSS: {
> +		struct kvm_s390_css_info css_info;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&css_info, argp, sizeof(css_info)))
> +			break;
> +		r = kvm_s390_new_css(kvm, &css_info);
> +		break;
> +	}
> 	default:
> 		r = -ENOTTY;
> 	}
> @@ -235,6 +263,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> 		if (!kvm->arch.gmap)
> 			goto out_nogmap;
> 	}
> +
> +	kvm->arch.css_support = 0;
> +
> 	return 0;
> out_nogmap:
> 	debug_unregister(kvm->arch.dbf);
> @@ -657,6 +688,7 @@ rerun_vcpu:
> 	case KVM_EXIT_INTR:
> 	case KVM_EXIT_S390_RESET:
> 	case KVM_EXIT_S390_UCONTROL:
> +	case KVM_EXIT_S390_SCH_IO:
> 		break;
> 	default:
> 		BUG();
> @@ -817,6 +849,9 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
> 		return -EINVAL;
> 
> 	switch (cap->cap) {
> +	case KVM_CAP_S390_CSS_SUPPORT:
> +		r = kvm_s390_enable_css(vcpu->kvm);
> +		break;
> 	default:
> 		r = -EINVAL;
> 		break;
> @@ -919,6 +954,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
> 		break;
> 	}
> +	case KVM_S390_CSS_NOTIFY:
> +	{
> +		struct kvm_css_notify notify;
> +		r = -EFAULT;
> +		if (copy_from_user(&notify, argp, sizeof(notify)))
> +			break;
> +		r = kvm_arch_vcpu_ioctl_css_notify(vcpu, &notify);
> +		break;
> +	}
> 	default:
> 		r = -ENOTTY;
> 	}
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 7f50229..8c8b59d 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -76,6 +76,11 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
> 		struct kvm_s390_interrupt *s390int);
> int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
> int kvm_s390_inject_sigp_stop(struct kvm_vcpu *vcpu, int action);
> +int kvm_s390_inject_internal(struct kvm *kvm,
> +			     struct kvm_s390_interrupt_info *inti);
> +int kvm_s390_dequeue_internal(struct kvm *kvm,
> +			      struct kvm_s390_interrupt_info *inti);
> +struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm, u64 cr6);
> 
> /* implemented in priv.c */
> int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
> @@ -94,4 +99,38 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu,
> /* implemented in diag.c */
> int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
> 
> +/* implemented in ioinst.c */
> +int kvm_css_instruction(struct kvm_vcpu *vcpu);
> +
> +/* implemented in css.c */
> +struct schib;
> +int kvm_arch_vcpu_ioctl_css_notify(struct kvm_vcpu *vcpu,
> +				   struct kvm_css_notify *notify);
> +int kvm_s390_process_ccw_hotplug(struct kvm *kvm,
> +				 struct kvm_s390_sch_info *sch_info);
> +int kvm_s390_process_chp_hotplug(struct kvm *kvm,
> +				 struct kvm_s390_chp_info *chp_info);
> +int kvm_s390_enable_css(struct kvm *kvm);
> +int kvm_s390_new_css(struct kvm *kvm, struct kvm_s390_css_info *css_info);
> +struct kvm_subch *css_find_subch(struct kvm *kvm, u8 m, u8 cssid, u8 ssid,
> +				 u16 schid);
> +int css_do_stsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch, u32 addr);
> +int css_schid_final(struct kvm *kvm, u8 cssid, u8 ssid, u16 schid);
> +int css_do_msch(struct kvm_vcpu *vcpu, struct kvm_subch *sch, struct schib *schib);
> +int css_do_xsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch);
> +int css_do_csch(struct kvm_vcpu *vcpu, struct kvm_subch *sch);
> +int css_do_hsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch);
> +int css_do_ssch(struct kvm_vcpu *vcpu, struct kvm_subch *sch, u64 orb);
> +int css_do_tsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch, u32 addr);
> +int css_do_stcrw(struct kvm_vcpu *vcpu, u32 addr);
> +int css_do_tpi(struct kvm_vcpu *vcpu, u32 addr, int lowcore);
> +int css_collect_chp_desc(struct kvm *kvm, u8 cssid, u8 f_chpid, u8 l_chpid,
> +                         int rfmt, void *buf);
> +void css_do_schm(struct kvm_vcpu *vcpu, u8 mbk, int update, int dct, uint64_t mbo);
> +int css_enable_mcsse(struct kvm *kvm);
> +int css_enable_mss(struct kvm *kvm);
> +int css_do_rsch(struct kvm_vcpu *vcpu, struct kvm_subch *sch);
> +int css_do_rchp(struct kvm_vcpu *vcpu, u8 cssid, u8 chpid);
> +int css_chpid_in_use(struct kvm *kvm, u8 cssid, u8 chpid);
> +void css_queue_crw(struct kvm *kvm, u8 rsc, u8 erc, int chain, u16 rsid);
> #endif
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 8b79a94..8b128e4 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -138,7 +138,12 @@ static int handle_skey(struct kvm_vcpu *vcpu)
> static int handle_io_inst(struct kvm_vcpu *vcpu)
> {
> 	VCPU_EVENT(vcpu, 4, "%s", "I/O instruction");
> -	/* condition code 3 */
> +
> +	if (vcpu->kvm->arch.css_support)
> +		/* Use in-kernel css support. */
> +		return kvm_css_instruction(vcpu);
> +
> +	/* Set cc 3 to stop guest issueing I/O instructions. */
> 	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
> 	vcpu->arch.sie_block->gpsw.mask |= (3 & 3ul) << 44;
> 	return 0;
> diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
> index 95fbc1a..6d2059e 100644
> --- a/arch/s390/kvm/trace-s390.h
> +++ b/arch/s390/kvm/trace-s390.h
> @@ -203,6 +203,73 @@ TRACE_EVENT(kvm_s390_stop_request,
> 		      __entry->action_bits)
> 	);
> 
> +/*
> + * Trace point for enabling in-kernel channel subsystem support.
> + */
> +TRACE_EVENT(kvm_s390_enable_kernel_css,
> +	    TP_PROTO(void *kvm),
> +	    TP_ARGS(kvm),
> +
> +	    TP_STRUCT__entry(
> +		    __field(void *, kvm)
> +		),
> +
> +	    TP_fast_assign(
> +		    __entry->kvm = kvm;
> +		),
> +
> +	    TP_printk("enabling in-kernel css support (kvm @ %p)\n",
> +		    __entry->kvm)
> +    );
> +
> +/*
> + * Trace point for user space subchannel I/O notification.
> + */
> +TRACE_EVENT(kvm_s390_css_notify,
> +	    TP_PROTO(u8 cssid, u8 ssid, u16 schid),
> +	    TP_ARGS(cssid, ssid, schid),
> +
> +	    TP_STRUCT__entry(
> +		    __field(u8, cssid)
> +		    __field(u8, ssid)
> +		    __field(u16, schid)
> +		),
> +
> +	    TP_fast_assign(
> +		    __entry->cssid = cssid;
> +		    __entry->ssid = ssid;
> +		    __entry->schid = schid;
> +		),
> +
> +	    TP_printk("css notification for subchannel %x.%x.%04x\n",
> +		      __entry->cssid, __entry->ssid, __entry->schid)
> +    );
> +
> +/*
> + * Trace point for user space subchannel hotplug notification.
> + */
> +TRACE_EVENT(kvm_s390_ccw_hotplug,
> +	    TP_PROTO(u8 cssid, u8 ssid, u16 schid, int add),
> +	    TP_ARGS(cssid, ssid, schid, add),
> +
> +	    TP_STRUCT__entry(
> +		    __field(u8, cssid)
> +		    __field(u8, ssid)
> +		    __field(u16, schid)
> +		    __field(int, add)
> +		),
> +
> +	    TP_fast_assign(
> +		    __entry->cssid = cssid;
> +		    __entry->ssid = ssid;
> +		    __entry->schid = schid;
> +		    __entry->add = add;
> +		),
> +
> +	    TP_printk("hotplug event for subchannel %x.%x.%04x (%s)\n",
> +		      __entry->cssid, __entry->ssid, __entry->schid,
> +		      __entry->add ? "attach" : "detach")
> +    );
> 
> #endif /* _TRACE_KVMS390_H */
> 
> diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
> index 2b29e62..5f743f3 100644
> --- a/arch/s390/kvm/trace.h
> +++ b/arch/s390/kvm/trace.h
> @@ -335,6 +335,28 @@ TRACE_EVENT(kvm_s390_handle_stsi,
> 			   __entry->addr)
> 	);
> 
> +TRACE_EVENT(kvm_s390_handle_ioinst,
> +	    TP_PROTO(char *name, u8 cssid, u8 ssid, u16 schid),
> +	    TP_ARGS(name, cssid, ssid, schid),
> +
> +	    TP_STRUCT__entry(
> +		__field(char *, name)
> +		__field(u8, cssid)
> +		__field(u8, ssid)
> +		__field(u16, schid)
> +		),
> +
> +	    TP_fast_assign(
> +		__entry->name = name;
> +		__entry->cssid = cssid;
> +		__entry->ssid = ssid;
> +		__entry->schid = schid;
> +		),
> +
> +	    TP_printk("I/O instruction %s (%x.%x.%04x)", __entry->name,
> +		      __entry->cssid, __entry->ssid, __entry->schid)
> +    );
> +
> #endif /* _TRACE_KVM_H */
> 
> /* This part must be outside protection */
> diff --git a/include/linux/kvm.h b/include/linux/kvm.h
> index 6bd6062..9c123e5 100644
> --- a/include/linux/kvm.h
> +++ b/include/linux/kvm.h
> @@ -167,6 +167,7 @@ struct kvm_pit_config {
> #define KVM_EXIT_OSI              18
> #define KVM_EXIT_PAPR_HCALL	  19
> #define KVM_EXIT_S390_UCONTROL	  20
> +#define KVM_EXIT_S390_SCH_IO      21
> 
> /* For KVM_EXIT_INTERNAL_ERROR */
> #define KVM_INTERNAL_ERROR_EMULATION 1
> @@ -280,6 +281,20 @@ struct kvm_run {
> 			__u64 ret;
> 			__u64 args[9];
> 		} papr_hcall;
> +		/* KVM_EXIT_S390_SCH_IO */
> +		struct {
> +			__u32 sch_id;
> +#define SCH_DO_CSCH 0
> +#define SCH_DO_HSCH 1
> +#define SCH_DO_SSCH 2
> +#define SCH_DO_RSCH 3
> +#define SCH_DO_XSCH 4
> +			__u8 func;
> +			__u8 pad;
> +			__u64 orb;
> +			__u32 scsw[3];
> +			__u32 pmcw[7];
> +		} s390_sch_io;
> 		/* Fix the size of the union. */
> 		char padding[256];
> 	};
> @@ -484,6 +499,45 @@ struct kvm_ppc_smmu_info {
> 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
> };
> 
> +/* for KVM_S390_CSS_NOTIFY */
> +struct kvm_css_notify {
> +	__u8 cssid;
> +	__u8 ssid;
> +	__u16 schid;
> +	__u32 scsw[3];
> +	__u32 pmcw[7];
> +	__u8 sense_data[32];
> +	__u8 unsolicited;
> +	__u8 func;
> +};
> +
> +/* for KVM_S390_CCW_HOTPLUG */
> +struct kvm_s390_sch_info {
> +	__u8 cssid;
> +	__u8 ssid;
> +	__u16 schid;
> +	__u16 devno;
> +	__u32 schib[12];
> +	int hotplugged;
> +	int add;
> +	int virtual;
> +};
> +
> +/* for KVM_S390_CHP_HOTPLUG */
> +struct kvm_s390_chp_info {
> +	__u8 cssid;
> +	__u8 chpid;
> +	__u8 type;
> +	int add;
> +	int virtual;
> +};
> +
> +/* for KVM_S390_ADD_CSS */
> +struct kvm_s390_css_info {
> +	__u8 cssid;
> +	__u8 default_image;
> +};
> +
> #define KVMIO 0xAE
> 
> /* machine type bits, to be used as argument to KVM_CREATE_VM */
> @@ -632,6 +686,7 @@ struct kvm_ppc_smmu_info {
> #ifdef __KVM_HAVE_READONLY_MEM
> #define KVM_CAP_READONLY_MEM 81
> #endif
> +#define KVM_CAP_S390_CSS_SUPPORT 82
> 
> #ifdef KVM_CAP_IRQ_ROUTING
> 
> @@ -845,6 +900,11 @@ struct kvm_s390_ucas_mapping {
> #define KVM_PPC_GET_SMMU_INFO	  _IOR(KVMIO,  0xa6, struct kvm_ppc_smmu_info)
> /* Available with KVM_CAP_PPC_ALLOC_HTAB */
> #define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
> +/* Available with KVM_CAP_S390_CSS_SUPPORT */
> +#define KVM_S390_CSS_NOTIFY       _IOW(KVMIO, 0xae, struct kvm_css_notify)
> +#define KVM_S390_CCW_HOTPLUG      _IOW(KVMIO, 0xab, struct kvm_s390_sch_info)
> +#define KVM_S390_CHP_HOTPLUG      _IOW(KVMIO, 0xac, struct kvm_s390_chp_info)
> +#define KVM_S390_ADD_CSS          _IOW(KVMIO, 0xad, struct kvm_s390_css_info)
> 
> /*
>  * ioctls for vcpu fds
> diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
> index 7ef9e75..939ba8b 100644
> --- a/include/trace/events/kvm.h
> +++ b/include/trace/events/kvm.h
> @@ -14,7 +14,7 @@
> 	ERSN(SHUTDOWN), ERSN(FAIL_ENTRY), ERSN(INTR), ERSN(SET_TPR),	\
> 	ERSN(TPR_ACCESS), ERSN(S390_SIEIC), ERSN(S390_RESET), ERSN(DCR),\
> 	ERSN(NMI), ERSN(INTERNAL_ERROR), ERSN(OSI), ERSN(PAPR_HCALL),	\
> -	ERSN(S390_UCONTROL)
> +	ERSN(S390_UCONTROL), ERSN(S390_SCH_IO)
> 
> TRACE_EVENT(kvm_userspace_exit,
> 	    TP_PROTO(__u32 reason, int errno),
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6425906..0830818 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1893,7 +1893,8 @@ static long kvm_vcpu_ioctl(struct file *filp,
> 	 * Special cases: vcpu ioctls that are asynchronous to vcpu execution,
> 	 * so vcpu_load() would break it.
> 	 */
> -	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT)
> +	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT ||
> +	    ioctl == KVM_S390_CSS_NOTIFY)
> 		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> #endif
> 
> -- 
> 1.7.11.5
> 
