From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Re: [RFC patch 5/6] s390: implement pci instruction
Date: Fri, 19 Sep 2014 17:12:15 +0200
Message-ID: <20140919171215.206cb074@oc7435384737.ibm.com>
References: <20140919115429.557279920@de.ibm.com>
	<20140919115940.481875559@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20140919115940.481875559@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, agraf@suse.de, qemu-devel@nongnu.org, alex.williamson@redhat.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>


 Hi Frank,

On Fri, 19 Sep 2014 13:54:34 +0200
frank.blaschka@de.ibm.com wrote:

> From: Frank Blaschka <frank.blaschka@de.ibm.com>
> 
> This patch implements the s390 pci instructions in qemu. This allows
> to attach qemu pci devices including vfio. This does not mean the
> devices are functional but at least detection and config/memory space
> access is working.
>     
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
> ---
>  target-s390x/Makefile.objs |    2 
>  target-s390x/kvm.c         |   52 +++
>  target-s390x/pci_ic.c      |  621 +++++++++++++++++++++++++++++++++++++++++++++
>  target-s390x/pci_ic.h      |  425 ++++++++++++++++++++++++++++++
>  4 files changed, 1099 insertions(+), 1 deletion(-)
> 
> --- a/target-s390x/Makefile.objs
> +++ b/target-s390x/Makefile.objs
> @@ -2,4 +2,4 @@ obj-y += translate.o helper.o cpu.o inte
>  obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
>  obj-y += gdbstub.o
>  obj-$(CONFIG_SOFTMMU) += ioinst.o arch_dump.o
> -obj-$(CONFIG_KVM) += kvm.o
> +obj-$(CONFIG_KVM) += kvm.o pci_ic.o
> --- a/target-s390x/kvm.c
> +++ b/target-s390x/kvm.c
> @@ -40,6 +40,7 @@
>  #include "exec/gdbstub.h"
>  #include "trace.h"
>  #include "qapi-event.h"
> +#include "pci_ic.h"
> 
>  /* #define DEBUG_KVM */
> 
> @@ -56,6 +57,7 @@
>  #define IPA0_B2                         0xb200
>  #define IPA0_B9                         0xb900
>  #define IPA0_EB                         0xeb00
> +#define IPA0_E3                         0xe300
> 
>  #define PRIV_B2_SCLP_CALL               0x20
>  #define PRIV_B2_CSCH                    0x30
> @@ -76,8 +78,17 @@
>  #define PRIV_B2_XSCH                    0x76
> 
>  #define PRIV_EB_SQBS                    0x8a
> +#define PRIV_EB_PCISTB                  0xd0
> +#define PRIV_EB_SIC                     0xd1
> 
>  #define PRIV_B9_EQBS                    0x9c
> +#define PRIV_B9_CLP                     0xa0
> +#define PRIV_B9_PCISTG                  0xd0
> +#define PRIV_B9_PCILG                   0xd2
> +#define PRIV_B9_RPCIT                   0xd3
> +
> +#define PRIV_E3_MPCIFC                  0xd0
> +#define PRIV_E3_STPCIFC                 0xd4
> 
>  #define DIAG_IPL                        0x308
>  #define DIAG_KVM_HYPERCALL              0x500
> @@ -813,6 +824,18 @@ static int handle_b9(S390CPU *cpu, struc
>      int r = 0;
> 
>      switch (ipa1) {
> +    case PRIV_B9_CLP:
> +        r = kvm_clp_service_call(cpu, run);
> +        break;
> +    case PRIV_B9_PCISTG:
> +        r = kvm_pcistg_service_call(cpu, run);
> +        break;
> +    case PRIV_B9_PCILG:
> +        r = kvm_pcilg_service_call(cpu, run);
> +        break;
> +    case PRIV_B9_RPCIT:
> +        r = kvm_rpcit_service_call(cpu, run);
> +        break;
>      case PRIV_B9_EQBS:
>          /* just inject exception */
>          r = -1;
> @@ -831,6 +854,12 @@ static int handle_eb(S390CPU *cpu, struc
>      int r = 0;
> 
>      switch (ipa1) {
> +    case PRIV_EB_PCISTB:
> +        r = kvm_pcistb_service_call(cpu, run);
> +        break;
> +    case PRIV_EB_SIC:
> +        r = kvm_sic_service_call(cpu, run);
> +        break;
>      case PRIV_EB_SQBS:
>          /* just inject exception */
>          r = -1;

I'm not sure, but I think the handler for the eb instructions is wrong:
The second byte of the opcode is encoded in the lowest byte of the ipb
field, not the lowest byte of the ipa field (just like with the e3
handler). Did you verify that your handlers get called correctly?

> @@ -844,6 +873,26 @@ static int handle_eb(S390CPU *cpu, struc
>      return r;
>  }
> 
> +static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
> +{
> +    int r = 0;
> +
> +    switch (ipa1) {
> +    case PRIV_E3_MPCIFC:
> +        r = kvm_mpcifc_service_call(cpu, run);
> +        break;
> +    case PRIV_E3_STPCIFC:
> +        r = kvm_stpcifc_service_call(cpu, run);
> +        break;
> +    default:
> +        r = -1;
> +        DPRINTF("KVM: unhandled PRIV: 0xe3%x\n", ipa1);
> +        break;
> +    }
> +
> +    return r;
> +}

Could you please replace "ipa1" with "ipb1" to avoid confusion here?

>  static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
>  {
>      CPUS390XState *env = &cpu->env;
> @@ -1038,6 +1087,9 @@ static int handle_instruction(S390CPU *c
>      case IPA0_EB:
>          r = handle_eb(cpu, run, ipa1);
>          break;
> +    case IPA0_E3:
> +        r = handle_e3(cpu, run, run->s390_sieic.ipb & 0xff);
> +        break;
>      case IPA0_DIAG:
>          r = handle_diag(cpu, run, run->s390_sieic.ipb);
>          break;
> --- /dev/null
> +++ b/target-s390x/pci_ic.c
> @@ -0,0 +1,621 @@
[...]
> +
> +int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
> +{
> +    CPUS390XState *env = &cpu->env;
> +    S390PCIBusDevice *pbdev;
> +    uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
> +    uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> +    PciLgStg *rp;
> +    uint64_t offset;
> +    uint64_t data;
> +
> +    cpu_synchronize_state(CPU(cpu));
> +    rp = (PciLgStg *)&env->regs[r2];

I think you have to check for r2 to be even here (and inject a
specification exception otherwise)

You should also check rp->len for a valid value and inject an operand
exception otherwise.

> +    offset = env->regs[r2 + 1];

You should also check for a valid offset value here (and inject an
operand exception otherwise).

... and while you're at it - it also seems like the pci instructions
are priviledged, so you should check for not being in the problem state
here, too, just to be sure ;-)

> +    pbdev = s390_pci_find_dev_by_fh(rp->fh);
> +    if (!pbdev) {
> +        DPRINTF("pcilg no pci dev\n");
> +        return -EIO;
> +    }
> +
> +    if (rp->pcias < 6) {
> +        MemoryRegion *mr = pbdev->pdev->io_regions[rp->pcias].memory;
> +        io_mem_read(mr, offset, &data, rp->len);

Does this also work if len != 8 ? I think the data should be put in the
rightmost  byte positions, with the unused leftmost bytes set to zero...
so some more logic might be needed here.

> +    } else if (rp->pcias == 15) {
> +        data =  pci_host_config_read_common(
> +                   pbdev->pdev, offset, pci_config_size(pbdev->pdev), rp->len);
> +
> +        switch (rp->len) {
> +        case 1:
> +            break;
> +        case 2:
> +            data = cpu_to_le16(data);
> +            break;
> +        case 4:
> +            data = cpu_to_le32(data);
> +            break;
> +        case 8:
> +            data = cpu_to_le64(data);
> +            break;
> +        default:
> +            abort();
> +        }
> +    } else {
> +        DPRINTF("invalid space\n");

Set condition code 1 in this case?

> +    }
> +
> +    env->regs[r1] = data;
> +    setcc(cpu, 0);
> +    return 0;
> +}
> +
> +int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
> +{
> +    CPUS390XState *env = &cpu->env;
> +    uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
> +    uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> +    PciLgStg *rp;
> +    uint64_t offset, data;
> +    S390PCIBusDevice *pbdev;
> +
> +    cpu_synchronize_state(CPU(cpu));
> +    rp = (PciLgStg *)&env->regs[r2];
> +    offset = env->regs[r2 + 1];

You likely need the same sanity checks here as with the pcilg function.

> +    pbdev = s390_pci_find_dev_by_fh(rp->fh);
> +    if (!pbdev) {
> +        DPRINTF("pcistg no pci dev\n");
> +        return -EIO;
> +    }
> +
> +    data = env->regs[r1];
> +
> +    if (rp->pcias < 6) {
> +        MemoryRegion *mr;
> +        if (pbdev->msix_table_bar == rp->pcias &&
> +            offset >= pbdev->msix_table_offset &&
> +            offset <= pbdev->msix_table_offset +
> +                      (pbdev->msix_entries - 1) * PCI_MSIX_ENTRY_SIZE) {
> +            offset = offset - pbdev->msix_table_offset;
> +            mr = &pbdev->pdev->msix_table_mmio;
> +        } else {
> +            mr = pbdev->pdev->io_regions[rp->pcias].memory;
> +        }
> +
> +        io_mem_write(mr, offset, data, rp->len);

Same concerns as with the pcilg - this likely only works for len == 8 ?

> +    } else if (rp->pcias == 15) {
> +        switch (rp->len) {
> +        case 1:
> +            break;
> +        case 2:
> +            data = le16_to_cpu(data);
> +            break;
> +        case 4:
> +            data = le32_to_cpu(data);
> +            break;
> +        case 8:
> +            data = le64_to_cpu(data);
> +            break;
> +        default:
> +            abort();
> +        }
> +
> +        pci_host_config_write_common(pbdev->pdev, offset,
> +                                     pci_config_size(pbdev->pdev),
> +                                     data, rp->len);
> +    } else {
> +        DPRINTF("pcistg invalid space\n");

Set condition code 1 in this case?

> +    }
> +
> +    setcc(cpu, 0);
> +    return 0;
> +}
> +
> +static uint64_t guest_io_table_walk(uint64_t guest_iota,
> +                                    uint64_t guest_dma_address)
> +{
> +    uint64_t sto_a, pto_a, px_a;
> +    uint64_t sto, pto, pte;
> +    uint32_t rtx, sx, px;
> +
> +    rtx = calc_rtx(guest_dma_address);
> +    sx = calc_sx(guest_dma_address);
> +    px = calc_px(guest_dma_address);
> +
> +    sto_a = guest_iota + rtx * sizeof(uint64_t);
> +    cpu_physical_memory_rw(sto_a, (uint8_t *)&sto, sizeof(uint64_t), 0);
> +    sto = (uint64_t)get_rt_sto(sto);
> +
> +    pto_a = sto + sx * sizeof(uint64_t);
> +    cpu_physical_memory_rw(pto_a, (uint8_t *)&pto, sizeof(uint64_t), 0);
> +    pto = (uint64_t)get_st_pto(pto);
> +
> +    px_a = pto + px * sizeof(uint64_t);
> +    cpu_physical_memory_rw(px_a, (uint8_t *)&pte, sizeof(uint64_t), 0);
> +
> +    return pte;
> +}
> +
> +int kvm_rpcit_service_call(S390CPU *cpu, struct kvm_run *run)
> +{
> +    CPUS390XState *env = &cpu->env;
> +    uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
> +    uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> +    uint32_t fh;
> +    uint64_t pte;
> +    S390PCIBusDevice *pbdev;
> +    ram_addr_t size;
> +    int flags;
> +    IOMMUTLBEntry entry;
> +
> +    cpu_synchronize_state(CPU(cpu));
> +
> +    fh = env->regs[r1] >> 32;
> +    size = env->regs[r2 + 1];

Missing two checks again:
- r2 should be even
- CPU should not be in problem state

> +    pbdev = s390_pci_find_dev_by_fh(fh);
> +
> +    if (!pbdev) {
> +        DPRINTF("rpcit no pci dev\n");
> +        return -EIO;

I think it would be better to set condition code 3 instead.

> +    }
> +
> +    pte = guest_io_table_walk(pbdev->g_iota, env->regs[r2]);
> +    flags = pte & ZPCI_PTE_FLAG_MASK;
> +    entry.target_as = &address_space_memory;
> +    entry.iova = env->regs[r2];
> +    entry.translated_addr = pte & ZPCI_PTE_ADDR_MASK;
> +    entry.addr_mask = size - 1;
> +
> +    if (flags & ZPCI_PTE_INVALID) {
> +        entry.perm = IOMMU_NONE;
> +    } else {
> +        entry.perm = IOMMU_RW;
> +    }
> +
> +    memory_region_notify_iommu(pci_device_iommu_address_space(
> +                               pbdev->pdev)->root, entry);
> +
> +    setcc(cpu, 0);
> +    return 0;
> +}
> +
> +int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
> +{
> +    DPRINTF("sic\n");
> +    return 0;
> +}
> +
> +int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
> +{
> +    CPUS390XState *env = &cpu->env;
> +    uint8_t r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
> +    uint8_t r3 = run->s390_sieic.ipa & 0x000f;
> +    PciStb *rp;
> +    uint64_t gaddr;
> +    uint64_t *uaddr, *pu;
> +    hwaddr len;
> +    S390PCIBusDevice *pbdev;
> +    MemoryRegion *mr;
> +    int i;
> +
> +    cpu_synchronize_state(CPU(cpu));
> +
> +    rp = (PciStb *)&env->regs[r1];
> +    gaddr = get_base_disp_rsy(cpu, run);
> +    len = rp->len;

Not sure, but don't you also have to check the length and offset here
for valid ranges?
At least you should check for problem state again.

> +    pbdev = s390_pci_find_dev_by_fh(rp->fh);
> +    if (!pbdev) {
> +        DPRINTF("pcistb no pci dev fh 0x%x\n", rp->fh);
> +        return -EIO;

User cc3 instead?

> +    }
> +
> +    uaddr = cpu_physical_memory_map(gaddr, &len, 0);
> +    mr = pbdev->pdev->io_regions[rp->pcias].memory;
> +
> +    pu = uaddr;
> +    for (i = 0; i < rp->len / 8; i++) {
> +        io_mem_write(mr, env->regs[r3] + i * 8, *pu, 8);
> +        pu++;
> +    }
> +
> +    cpu_physical_memory_unmap(uaddr, len, 0, len);
> +    setcc(cpu, 0);
> +    return 0;
> +}
[...]

 Thomas
