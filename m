Return-Path: <linux-pci-owner@vger.kernel.org>
Date: Thu, 17 Dec 2015 17:47:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: hotplug: use list_for_each_entry*
Message-ID: <20151217234744.GB4864@localhost>
References: <670d9aeb65d4030d9ed878ecb1e8e3a05dc34b27.1449927141.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <670d9aeb65d4030d9ed878ecb1e8e3a05dc34b27.1449927141.git.geliangtang@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Geliang Tang <geliangtang@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Gavin Shan <gwshan@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Dec 12, 2015 at 09:36:57PM +0800, Geliang Tang wrote:
> Use list_for_each_entry*() instead of list_for_each*() to simplify
> the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied to pci/hotplug for v4.5, thanks!

> ---
>  drivers/pci/hotplug/ibmphp_core.c      | 21 ++++++---------------
>  drivers/pci/hotplug/ibmphp_ebda.c      | 24 +++++++++---------------
>  drivers/pci/hotplug/ibmphp_hpc.c       | 18 ++++++++----------
>  drivers/pci/hotplug/ibmphp_res.c       | 32 +++++++++-----------------------
>  drivers/pci/hotplug/pci_hotplug_core.c |  4 +---
>  drivers/pci/hotplug/pcihp_skeleton.c   |  7 ++-----
>  drivers/pci/hotplug/rpadlpar_core.c    |  7 +++----
>  drivers/pci/hotplug/rpaphp_core.c      |  7 +++----
>  drivers/pci/hotplug/s390_pci_hpc.c     |  7 +++----
>  drivers/pci/hotplug/shpchp_core.c      |  7 ++-----
>  10 files changed, 46 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
> index 1530247..010e46a 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -116,11 +116,9 @@ static inline int slot_update(struct slot **sl)
>  static int __init get_max_slots (void)
>  {
>  	struct slot *slot_cur;
> -	struct list_head *tmp;
>  	u8 slot_count = 0;
>  
> -	list_for_each(tmp, &ibmphp_slot_head) {
> -		slot_cur = list_entry(tmp, struct slot, ibm_slot_list);
> +	list_for_each_entry(slot_cur, &ibmphp_slot_head, ibm_slot_list) {
>  		/* sometimes the hot-pluggable slots start with 4 (not always from 1) */
>  		slot_count = max(slot_count, slot_cur->number);
>  	}
> @@ -501,13 +499,10 @@ static int get_bus_name(struct hotplug_slot *hotplug_slot, char *value)
>  static int __init init_ops(void)
>  {
>  	struct slot *slot_cur;
> -	struct list_head *tmp;
>  	int retval;
>  	int rc;
>  
> -	list_for_each(tmp, &ibmphp_slot_head) {
> -		slot_cur = list_entry(tmp, struct slot, ibm_slot_list);
> -
> +	list_for_each_entry(slot_cur, &ibmphp_slot_head, ibm_slot_list) {
>  		if (!slot_cur)
>  			return -ENODEV;
>  
> @@ -669,9 +664,7 @@ static struct pci_func *ibm_slot_find(u8 busno, u8 device, u8 function)
>  {
>  	struct pci_func *func_cur;
>  	struct slot *slot_cur;
> -	struct list_head *tmp;
> -	list_for_each(tmp, &ibmphp_slot_head) {
> -		slot_cur = list_entry(tmp, struct slot, ibm_slot_list);
> +	list_for_each_entry(slot_cur, &ibmphp_slot_head, ibm_slot_list) {
>  		if (slot_cur->func) {
>  			func_cur = slot_cur->func;
>  			while (func_cur) {
> @@ -693,14 +686,12 @@ static struct pci_func *ibm_slot_find(u8 busno, u8 device, u8 function)
>   *************************************************************/
>  static void free_slots(void)
>  {
> -	struct slot *slot_cur;
> -	struct list_head *tmp;
> -	struct list_head *next;
> +	struct slot *slot_cur, *next;
>  
>  	debug("%s -- enter\n", __func__);
>  
> -	list_for_each_safe(tmp, next, &ibmphp_slot_head) {
> -		slot_cur = list_entry(tmp, struct slot, ibm_slot_list);
> +	list_for_each_entry_safe(slot_cur, next, &ibmphp_slot_head,
> +				 ibm_slot_list) {
>  		pci_hp_deregister(slot_cur->hotplug_slot);
>  	}
>  	debug("%s -- exit\n", __func__);
> diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
> index d9b197d..664b5d1 100644
> --- a/drivers/pci/hotplug/ibmphp_ebda.c
> +++ b/drivers/pci/hotplug/ibmphp_ebda.c
> @@ -1117,25 +1117,21 @@ int ibmphp_get_bus_index (u8 num)
>  
>  void ibmphp_free_bus_info_queue (void)
>  {
> -	struct bus_info *bus_info;
> -	struct list_head *list;
> -	struct list_head *next;
> +	struct bus_info *bus_info, *next;
>  
> -	list_for_each_safe (list, next, &bus_info_head ) {
> -		bus_info = list_entry (list, struct bus_info, bus_info_list);
> +	list_for_each_entry_safe(bus_info, next, &bus_info_head,
> +				 bus_info_list) {
>  		kfree (bus_info);
>  	}
>  }
>  
>  void ibmphp_free_ebda_hpc_queue (void)
>  {
> -	struct controller *controller = NULL;
> -	struct list_head *list;
> -	struct list_head *next;
> +	struct controller *controller = NULL, *next;
>  	int pci_flag = 0;
>  
> -	list_for_each_safe (list, next, &ebda_hpc_head) {
> -		controller = list_entry (list, struct controller, ebda_hpc_list);
> +	list_for_each_entry_safe(controller, next, &ebda_hpc_head,
> +				 ebda_hpc_list) {
>  		if (controller->ctlr_type == 0)
>  			release_region (controller->u.isa_ctlr.io_start, (controller->u.isa_ctlr.io_end - controller->u.isa_ctlr.io_start + 1));
>  		else if ((controller->ctlr_type == 1) && (!pci_flag)) {
> @@ -1148,12 +1144,10 @@ void ibmphp_free_ebda_hpc_queue (void)
>  
>  void ibmphp_free_ebda_pci_rsrc_queue (void)
>  {
> -	struct ebda_pci_rsrc *resource;
> -	struct list_head *list;
> -	struct list_head *next;
> +	struct ebda_pci_rsrc *resource, *next;
>  
> -	list_for_each_safe (list, next, &ibmphp_ebda_pci_rsrc_head) {
> -		resource = list_entry (list, struct ebda_pci_rsrc, ebda_pci_rsrc_list);
> +	list_for_each_entry_safe(resource, next, &ibmphp_ebda_pci_rsrc_head,
> +				 ebda_pci_rsrc_list) {
>  		kfree (resource);
>  		resource = NULL;
>  	}
> diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
> index 2208767..e260858 100644
> --- a/drivers/pci/hotplug/ibmphp_hpc.c
> +++ b/drivers/pci/hotplug/ibmphp_hpc.c
> @@ -537,7 +537,6 @@ int ibmphp_hpc_readslot (struct slot *pslot, u8 cmd, u8 *pstatus)
>  {
>  	void __iomem *wpg_bbar = NULL;
>  	struct controller *ctlr_ptr;
> -	struct list_head *pslotlist;
>  	u8 index, status;
>  	int rc = 0;
>  	int busindex;
> @@ -628,8 +627,8 @@ int ibmphp_hpc_readslot (struct slot *pslot, u8 cmd, u8 *pstatus)
>  
>  			// Not used
>  		case READ_ALLSLOT:
> -			list_for_each (pslotlist, &ibmphp_slot_head) {
> -				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
> +			list_for_each_entry(pslot, &ibmphp_slot_head,
> +					    ibm_slot_list) {
>  				index = pslot->ctlr_index;
>  				rc = hpc_wait_ctlr_notworking (HPC_CTLR_WORKING_TOUT, ctlr_ptr,
>  								wpg_bbar, &status);
> @@ -820,7 +819,6 @@ static int poll_hpc(void *data)
>  {
>  	struct slot myslot;
>  	struct slot *pslot = NULL;
> -	struct list_head *pslotlist;
>  	int rc;
>  	int poll_state = POLL_LATCH_REGISTER;
>  	u8 oldlatchlow = 0x00;
> @@ -838,10 +836,10 @@ static int poll_hpc(void *data)
>  		case POLL_LATCH_REGISTER:
>  			oldlatchlow = curlatchlow;
>  			ctrl_count = 0x00;
> -			list_for_each (pslotlist, &ibmphp_slot_head) {
> +			list_for_each_entry(pslot, &ibmphp_slot_head,
> +					    ibm_slot_list) {
>  				if (ctrl_count >= ibmphp_get_total_controllers())
>  					break;
> -				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
>  				if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
>  					ctrl_count++;
>  					if (READ_SLOT_LATCH (pslot->ctrl)) {
> @@ -859,8 +857,8 @@ static int poll_hpc(void *data)
>  			poll_state = POLL_SLEEP;
>  			break;
>  		case POLL_SLOTS:
> -			list_for_each (pslotlist, &ibmphp_slot_head) {
> -				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
> +			list_for_each_entry(pslot, &ibmphp_slot_head,
> +					    ibm_slot_list) {
>  				// make a copy of the old status
>  				memcpy ((void *) &myslot, (void *) pslot,
>  					sizeof (struct slot));
> @@ -870,10 +868,10 @@ static int poll_hpc(void *data)
>  					process_changeinstatus (pslot, &myslot);
>  			}
>  			ctrl_count = 0x00;
> -			list_for_each (pslotlist, &ibmphp_slot_head) {
> +			list_for_each_entry(pslot, &ibmphp_slot_head,
> +					    ibm_slot_list) {
>  				if (ctrl_count >= ibmphp_get_total_controllers())
>  					break;
> -				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
>  				if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
>  					ctrl_count++;
>  					if (READ_SLOT_LATCH (pslot->ctrl))
> diff --git a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
> index f279060..b5f2851 100644
> --- a/drivers/pci/hotplug/ibmphp_res.c
> +++ b/drivers/pci/hotplug/ibmphp_res.c
> @@ -203,15 +203,13 @@ int __init ibmphp_rsrc_init (void)
>  	struct bus_node *newbus = NULL;
>  	struct bus_node *bus_cur;
>  	struct bus_node *bus_prev;
> -	struct list_head *tmp;
>  	struct resource_node *new_io = NULL;
>  	struct resource_node *new_mem = NULL;
>  	struct resource_node *new_pfmem = NULL;
>  	int rc;
> -	struct list_head *tmp_ebda;
>  
> -	list_for_each (tmp_ebda, &ibmphp_ebda_pci_rsrc_head) {
> -		curr = list_entry (tmp_ebda, struct ebda_pci_rsrc, ebda_pci_rsrc_list);
> +	list_for_each_entry(curr, &ibmphp_ebda_pci_rsrc_head,
> +			    ebda_pci_rsrc_list) {
>  		if (!(curr->rsrc_type & PCIDEVMASK)) {
>  			/* EBDA still lists non PCI devices, so ignore... */
>  			debug ("this is not a PCI DEVICE in rsrc_init, please take care\n");
> @@ -369,8 +367,7 @@ int __init ibmphp_rsrc_init (void)
>  		}
>  	}
>  
> -	list_for_each (tmp, &gbuses) {
> -		bus_cur = list_entry (tmp, struct bus_node, bus_list);
> +	list_for_each_entry(bus_cur, &gbuses, bus_list) {
>  		/* This is to get info about PPB resources, since EBDA doesn't put this info into the primary bus info */
>  		rc = update_bridge_ranges (&bus_cur);
>  		if (rc)
> @@ -1571,19 +1568,16 @@ int ibmphp_find_resource (struct bus_node *bus, u32 start_address, struct resour
>   ***********************************************************************/
>  void ibmphp_free_resources (void)
>  {
> -	struct bus_node *bus_cur = NULL;
> +	struct bus_node *bus_cur = NULL, *next;
>  	struct bus_node *bus_tmp;
>  	struct range_node *range_cur;
>  	struct range_node *range_tmp;
>  	struct resource_node *res_cur;
>  	struct resource_node *res_tmp;
> -	struct list_head *tmp;
> -	struct list_head *next;
>  	int i = 0;
>  	flags = 1;
>  
> -	list_for_each_safe (tmp, next, &gbuses) {
> -		bus_cur = list_entry (tmp, struct bus_node, bus_list);
> +	list_for_each_entry_safe(bus_cur, next, &gbuses, bus_list) {
>  		if (bus_cur->noIORanges) {
>  			range_cur = bus_cur->rangeIO;
>  			for (i = 0; i < bus_cur->noIORanges; i++) {
> @@ -1691,10 +1685,8 @@ static int __init once_over (void)
>  	struct resource_node *pfmem_prev;
>  	struct resource_node *mem;
>  	struct bus_node *bus_cur;
> -	struct list_head *tmp;
>  
> -	list_for_each (tmp, &gbuses) {
> -		bus_cur = list_entry (tmp, struct bus_node, bus_list);
> +	list_for_each_entry(bus_cur, &gbuses, bus_list) {
>  		if ((!bus_cur->rangePFMem) && (bus_cur->firstPFMem)) {
>  			for (pfmem_cur = bus_cur->firstPFMem, pfmem_prev = NULL; pfmem_cur; pfmem_prev = pfmem_cur, pfmem_cur = pfmem_cur->next) {
>  				pfmem_cur->fromMem = 1;
> @@ -1767,14 +1759,10 @@ struct bus_node *ibmphp_find_res_bus (u8 bus_number)
>  static struct bus_node *find_bus_wprev (u8 bus_number, struct bus_node **prev, u8 flag)
>  {
>  	struct bus_node *bus_cur;
> -	struct list_head *tmp;
> -	struct list_head *tmp_prev;
>  
> -	list_for_each (tmp, &gbuses) {
> -		tmp_prev = tmp->prev;
> -		bus_cur = list_entry (tmp, struct bus_node, bus_list);
> +	list_for_each_entry(bus_cur, &gbuses, bus_list) {
>  		if (flag)
> -			*prev = list_entry (tmp_prev, struct bus_node, bus_list);
> +			*prev = list_prev_entry(bus_cur, bus_list);
>  		if (bus_cur->busno == bus_number)
>  			return bus_cur;
>  	}
> @@ -1788,7 +1776,6 @@ void ibmphp_print_test (void)
>  	struct bus_node *bus_cur = NULL;
>  	struct range_node *range;
>  	struct resource_node *res;
> -	struct list_head *tmp;
>  
>  	debug_pci ("*****************START**********************\n");
>  
> @@ -1797,8 +1784,7 @@ void ibmphp_print_test (void)
>  		return;
>  	}
>  
> -	list_for_each (tmp, &gbuses) {
> -		bus_cur = list_entry (tmp, struct bus_node, bus_list);
> +	list_for_each_entry(bus_cur, &gbuses, bus_list) {
>  		debug_pci ("This is bus # %d.  There are\n", bus_cur->busno);
>  		debug_pci ("IORanges = %d\t", bus_cur->noIORanges);
>  		debug_pci ("MemRanges = %d\t", bus_cur->noMemRanges);
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index d1fab97..fcd5e73 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -396,10 +396,8 @@ static void fs_remove_slot(struct pci_slot *pci_slot)
>  static struct hotplug_slot *get_slot_from_name(const char *name)
>  {
>  	struct hotplug_slot *slot;
> -	struct list_head *tmp;
>  
> -	list_for_each(tmp, &pci_hotplug_slot_list) {
> -		slot = list_entry(tmp, struct hotplug_slot, slot_list);
> +	list_for_each_entry(slot, &pci_hotplug_slot_list, slot_list) {
>  		if (strcmp(hotplug_slot_name(slot), name) == 0)
>  			return slot;
>  	}
> diff --git a/drivers/pci/hotplug/pcihp_skeleton.c b/drivers/pci/hotplug/pcihp_skeleton.c
> index d062c00..9d4a95e 100644
> --- a/drivers/pci/hotplug/pcihp_skeleton.c
> +++ b/drivers/pci/hotplug/pcihp_skeleton.c
> @@ -321,17 +321,14 @@ error:
>  
>  static void __exit cleanup_slots(void)
>  {
> -	struct list_head *tmp;
> -	struct list_head *next;
> -	struct slot *slot;
> +	struct slot *slot, *next;
>  
>  	/*
>  	 * Unregister all of our slots with the pci_hotplug subsystem.
>  	 * Memory will be freed in release_slot() callback after slot's
>  	 * lifespan is finished.
>  	 */
> -	list_for_each_safe(tmp, next, &slot_list) {
> -		slot = list_entry(tmp, struct slot, slot_list);
> +	list_for_each_entry_safe(slot, next, &slot_list, slot_list) {
>  		list_del(&slot->slot_list);
>  		pci_hp_deregister(slot->hotplug_slot);
>  	}
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index e12bafd..b46b57d 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -114,11 +114,10 @@ static struct device_node *find_dlpar_node(char *drc_name, int *node_type)
>   */
>  static struct slot *find_php_slot(struct device_node *dn)
>  {
> -	struct list_head *tmp, *n;
> -	struct slot *slot;
> +	struct slot *slot, *next;
>  
> -	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
> -		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
> +	list_for_each_entry_safe(slot, next, &rpaphp_slot_head,
> +				 rpaphp_slot_list) {
>  		if (slot->dn == dn)
>  			return slot;
>  	}
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index f2945fa..5a11232 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -356,8 +356,7 @@ EXPORT_SYMBOL_GPL(rpaphp_add_slot);
>  
>  static void __exit cleanup_slots(void)
>  {
> -	struct list_head *tmp, *n;
> -	struct slot *slot;
> +	struct slot *slot, *next;
>  
>  	/*
>  	 * Unregister all of our slots with the pci_hotplug subsystem,
> @@ -365,8 +364,8 @@ static void __exit cleanup_slots(void)
>  	 * memory will be freed in release_slot callback.
>  	 */
>  
> -	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
> -		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
> +	list_for_each_entry_safe(slot, next, &rpaphp_slot_head,
> +				 rpaphp_slot_list) {
>  		list_del(&slot->rpaphp_slot_list);
>  		pci_hp_deregister(slot->hotplug_slot);
>  	}
> diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
> index d77e46b..eb5efae 100644
> --- a/drivers/pci/hotplug/s390_pci_hpc.c
> +++ b/drivers/pci/hotplug/s390_pci_hpc.c
> @@ -201,11 +201,10 @@ error:
>  
>  void zpci_exit_slot(struct zpci_dev *zdev)
>  {
> -	struct list_head *tmp, *n;
> -	struct slot *slot;
> +	struct slot *slot, *next;
>  
> -	list_for_each_safe(tmp, n, &s390_hotplug_slot_list) {
> -		slot = list_entry(tmp, struct slot, slot_list);
> +	list_for_each_entry_safe(slot, next, &s390_hotplug_slot_list,
> +				 slot_list) {
>  		if (slot->zdev != zdev)
>  			continue;
>  		list_del(&slot->slot_list);
> diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
> index 294ef4b..7c854b6 100644
> --- a/drivers/pci/hotplug/shpchp_core.c
> +++ b/drivers/pci/hotplug/shpchp_core.c
> @@ -178,12 +178,9 @@ error:
>  
>  void cleanup_slots(struct controller *ctrl)
>  {
> -	struct list_head *tmp;
> -	struct list_head *next;
> -	struct slot *slot;
> +	struct slot *slot, *next;
>  
> -	list_for_each_safe(tmp, next, &ctrl->slot_list) {
> -		slot = list_entry(tmp, struct slot, slot_list);
> +	list_for_each_entry_safe(slot, next, &ctrl->slot_list, slot_list) {
>  		list_del(&slot->slot_list);
>  		cancel_delayed_work(&slot->work);
>  		destroy_workqueue(slot->wq);
> -- 
> 2.5.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
