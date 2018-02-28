Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Feb 2018 23:50:44 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 10/11] kexec_file: Allow archs to set purgatory load
 address
Message-ID: <201802282337.Qqa5AcX6%fengguang.wu@intel.com>
References: <20180226151620.20970-11-prudo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20180226151620.20970-11-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, kexec@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Dave Young <dyoung@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>
List-ID: <linux-s390.vger.kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Philipp,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc3 next-20180228]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Philipp-Rudo/kexec_file-Clean-up-purgatory-load/20180228-223538
config: x86_64-randconfig-x015-201808 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/traps.c:30:0:
>> include/linux/kexec.h:237:62: warning: 'struct kexec_buf' declared inside parameter list will not be visible outside of this definition or declaration
    extern int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
                                                                 ^~~~~~~~~
   include/linux/kexec.h:288:52: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
                                                       ^~~~~~~~~~~~~~
   include/linux/kexec.h:292:48: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
                                                   ^~~~~~~~~~~~~~
   Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:set_bit
   Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:clear_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 include/linux/percpu-defs.h:__this_cpu_preempt_check
   Cyclomatic Complexity 1 arch/x86/include/asm/current.h:get_current
   Cyclomatic Complexity 4 include/linux/string.h:memmove
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:paravirt_get_debugreg
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:set_debugreg
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:read_cr0
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:write_cr0
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_disable
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_enable
   Cyclomatic Complexity 1 arch/x86/include/asm/ptrace.h:user_mode
   Cyclomatic Complexity 1 arch/x86/include/asm/ptrace.h:v8086_mode
   Cyclomatic Complexity 1 include/asm-generic/ptrace.h:instruction_pointer
   Cyclomatic Complexity 1 arch/x86/include/asm/processor.h:current_top_of_stack
   Cyclomatic Complexity 1 arch/x86/include/asm/processor.h:on_thread_stack
   Cyclomatic Complexity 1 include/linux/thread_info.h:set_ti_thread_flag
   Cyclomatic Complexity 1 include/linux/thread_info.h:clear_ti_thread_flag
   Cyclomatic Complexity 5 arch/x86/include/asm/preempt.h:__preempt_count_add
   Cyclomatic Complexity 5 arch/x86/include/asm/preempt.h:__preempt_count_sub
   Cyclomatic Complexity 1 include/linux/sched.h:task_pid_nr
   Cyclomatic Complexity 1 include/linux/sched.h:task_thread_info
   Cyclomatic Complexity 1 include/linux/sched.h:set_tsk_thread_flag
   Cyclomatic Complexity 1 include/linux/sched.h:clear_tsk_thread_flag
   Cyclomatic Complexity 1 arch/x86/include/asm/debugreg.h:debug_stack_usage_inc
   Cyclomatic Complexity 1 arch/x86/include/asm/debugreg.h:debug_stack_usage_dec
   Cyclomatic Complexity 3 arch/x86/include/asm/traps.h:get_si_code
   Cyclomatic Complexity 1 arch/x86/include/asm/vm86.h:handle_vm86_trap
   Cyclomatic Complexity 1 arch/x86/include/asm/umip.h:fixup_umip_exception
   Cyclomatic Complexity 2 arch/x86/kernel/traps.c:cond_local_irq_enable
   Cyclomatic Complexity 2 arch/x86/kernel/traps.c:cond_local_irq_disable
   Cyclomatic Complexity 4 arch/x86/kernel/traps.c:fill_trap_info
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:is_sysenter_singlestep
   Cyclomatic Complexity 6 arch/x86/kernel/traps.c:do_trap_no_signal
   Cyclomatic Complexity 6 arch/x86/kernel/traps.c:do_trap
   Cyclomatic Complexity 6 arch/x86/kernel/traps.c:math_error
   Cyclomatic Complexity 2 arch/x86/kernel/traps.c:ist_enter
   Cyclomatic Complexity 2 arch/x86/kernel/traps.c:ist_exit
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:ist_begin_non_atomic
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:ist_end_non_atomic
   Cyclomatic Complexity 3 arch/x86/kernel/traps.c:is_valid_bugaddr
   Cyclomatic Complexity 3 arch/x86/kernel/traps.c:fixup_bug
   Cyclomatic Complexity 4 arch/x86/kernel/traps.c:do_error_trap
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_divide_error
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_overflow
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_invalid_op
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_coprocessor_segment_overrun
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_invalid_TSS
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_segment_not_present
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_stack_segment
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_alignment_check
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_double_fault
   Cyclomatic Complexity 3 arch/x86/kernel/traps.c:do_bounds
   Cyclomatic Complexity 11 arch/x86/kernel/traps.c:do_general_protection
   Cyclomatic Complexity 3 arch/x86/kernel/traps.c:do_int3
   Cyclomatic Complexity 2 arch/x86/kernel/traps.c:sync_regs
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:fixup_bad_iret
   Cyclomatic Complexity 16 arch/x86/kernel/traps.c:do_debug
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_coprocessor_error
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_simd_coprocessor_error
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:do_spurious_interrupt_bug
   Cyclomatic Complexity 3 arch/x86/kernel/traps.c:do_device_not_available
   Cyclomatic Complexity 1 arch/x86/kernel/traps.c:trap_init
--
   In file included from arch/x86/kernel/dumpstack_64.c:14:0:
>> include/linux/kexec.h:237:62: warning: 'struct kexec_buf' declared inside parameter list will not be visible outside of this definition or declaration
    extern int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
                                                                 ^~~~~~~~~
   include/linux/kexec.h:288:52: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
                                                       ^~~~~~~~~~~~~~
   include/linux/kexec.h:292:48: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
                                                   ^~~~~~~~~~~~~~
   Cyclomatic Complexity 1 arch/x86/include/asm/current.h:get_current
   Cyclomatic Complexity 1 arch/x86/include/asm/ptrace.h:user_mode
   Cyclomatic Complexity 2 arch/x86/kernel/dumpstack_64.c:in_irq_stack
   Cyclomatic Complexity 4 arch/x86/kernel/dumpstack_64.c:in_exception_stack
   Cyclomatic Complexity 5 arch/x86/kernel/dumpstack_64.c:stack_type_name
   Cyclomatic Complexity 11 arch/x86/kernel/dumpstack_64.c:get_stack_info
   Cyclomatic Complexity 8 arch/x86/kernel/dumpstack_64.c:show_regs
--
   In file included from arch/x86/kernel/dumpstack.c:16:0:
>> include/linux/kexec.h:237:62: warning: 'struct kexec_buf' declared inside parameter list will not be visible outside of this definition or declaration
    extern int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
                                                                 ^~~~~~~~~
   include/linux/kexec.h:288:52: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
                                                       ^~~~~~~~~~~~~~
   include/linux/kexec.h:292:48: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
                                                   ^~~~~~~~~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size_nocheck
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 2 include/linux/printk.h:console_verbose
   Cyclomatic Complexity 1 arch/x86/include/asm/current.h:get_current
   Cyclomatic Complexity 1 arch/x86/include/asm/ptrace.h:kernel_stack_pointer
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_cmpxchg
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_save_flags
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_restore
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_disable
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_save
   Cyclomatic Complexity 1 arch/x86/include/asm/preempt.h:preempt_count
   Cyclomatic Complexity 3 include/asm-generic/qspinlock.h:queued_spin_trylock
   Cyclomatic Complexity 2 include/asm-generic/qspinlock.h:queued_spin_lock
   Cyclomatic Complexity 1 include/linux/mm.h:debug_pagealloc_enabled
   Cyclomatic Complexity 1 include/linux/module.h:print_modules
   Cyclomatic Complexity 1 include/linux/ftrace.h:ftrace_graph_ret_addr
   Cyclomatic Complexity 1 include/linux/sched/task_stack.h:task_stack_page
   Cyclomatic Complexity 5 arch/x86/include/asm/stacktrace.h:on_stack
   Cyclomatic Complexity 1 arch/x86/include/asm/unwind.h:unwind_done
   Cyclomatic Complexity 3 arch/x86/include/asm/unwind.h:unwind_get_entry_regs
   Cyclomatic Complexity 1 arch/x86/include/asm/cpu_entry_area.h:cpu_entry_stack
   Cyclomatic Complexity 3 arch/x86/include/asm/stacktrace.h:get_stack_pointer
   Cyclomatic Complexity 2 arch/x86/include/asm/unwind.h:unwind_start
   Cyclomatic Complexity 1 include/linux/nmi.h:touch_nmi_watchdog
   Cyclomatic Complexity 2 arch/x86/kernel/dumpstack.c:printk_stack_address
   Cyclomatic Complexity 2 arch/x86/include/asm/qspinlock.h:native_queued_spin_unlock
   Cyclomatic Complexity 1 arch/x86/include/asm/qspinlock.h:queued_spin_unlock
   Cyclomatic Complexity 1 include/linux/kernel.h:kstrtoul
   Cyclomatic Complexity 4 arch/x86/kernel/dumpstack.c:code_bytes_setup
   Cyclomatic Complexity 2 arch/x86/kernel/dumpstack.c:in_task_stack
   Cyclomatic Complexity 2 arch/x86/kernel/dumpstack.c:in_entry_stack
   Cyclomatic Complexity 1 arch/x86/kernel/dumpstack.c:show_iret_regs
   Cyclomatic Complexity 5 arch/x86/kernel/dumpstack.c:show_regs_if_on_stack
   Cyclomatic Complexity 16 arch/x86/kernel/dumpstack.c:show_trace_log_lvl
   Cyclomatic Complexity 4 arch/x86/kernel/dumpstack.c:show_stack
   Cyclomatic Complexity 1 arch/x86/kernel/dumpstack.c:show_stack_regs
   Cyclomatic Complexity 3 arch/x86/kernel/dumpstack.c:oops_begin
   Cyclomatic Complexity 4 arch/x86/kernel/dumpstack.c:oops_end
   Cyclomatic Complexity 3 arch/x86/kernel/dumpstack.c:__die
   Cyclomatic Complexity 2 arch/x86/kernel/dumpstack.c:die
--
   In file included from arch/x86/kernel/setup.c:45:0:
>> include/linux/kexec.h:237:62: warning: 'struct kexec_buf' declared inside parameter list will not be visible outside of this definition or declaration
    extern int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
                                                                 ^~~~~~~~~
   include/linux/kexec.h:288:52: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
                                                       ^~~~~~~~~~~~~~
   include/linux/kexec.h:292:48: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
                                                   ^~~~~~~~~~~~~~
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/kaslr.h:kernel_randomize_memory
   Cyclomatic Complexity 1 arch/x86/include/asm/page_types.h:get_max_mapped
   Cyclomatic Complexity 1 include/linux/string.h:strnlen
   Cyclomatic Complexity 4 include/linux/string.h:strlen
   Cyclomatic Complexity 6 include/linux/string.h:strlcpy
   Cyclomatic Complexity 3 include/linux/string.h:memset
   Cyclomatic Complexity 1 arch/x86/include/asm/special_insns.h:native_read_cr4
   Cyclomatic Complexity 1 arch/x86/include/asm/special_insns.h:__read_cr4
   Cyclomatic Complexity 1 arch/x86/include/asm/mpspec.h:get_smp_config
   Cyclomatic Complexity 1 arch/x86/include/asm/mpspec.h:find_smp_config
   Cyclomatic Complexity 1 arch/x86/include/asm/numa.h:init_cpu_to_node
   Cyclomatic Complexity 1 arch/x86/include/asm/apic.h:generic_apic_probe
   Cyclomatic Complexity 1 arch/x86/include/asm/apic.h:check_x2apic
   Cyclomatic Complexity 1 include/linux/kdev_t.h:old_decode_dev
   Cyclomatic Complexity 1 include/linux/sfi.h:sfi_init
   Cyclomatic Complexity 1 include/linux/efi.h:efi_esrt_init
   Cyclomatic Complexity 1 include/linux/efi.h:efi_fake_memmap
   Cyclomatic Complexity 1 include/linux/efi.h:efi_enabled
   Cyclomatic Complexity 1 include/linux/iscsi_ibft.h:find_ibft_region
   Cyclomatic Complexity 1 include/linux/dma-contiguous.h:dma_contiguous_reserve
   Cyclomatic Complexity 1 include/linux/usb/xhci-dbgp.h:early_xdbc_setup_hardware
   Cyclomatic Complexity 1 include/linux/usb/xhci-dbgp.h:early_xdbc_register_console
   Cyclomatic Complexity 1 arch/x86/include/asm/mtrr.h:mtrr_trim_uncached_memory
   Cyclomatic Complexity 1 arch/x86/include/asm/setup.h:kaslr_enabled
   Cyclomatic Complexity 1 arch/x86/include/asm/setup.h:kaslr_offset
   Cyclomatic Complexity 1 arch/x86/include/asm/efi.h:parse_efi_setup
   Cyclomatic Complexity 1 arch/x86/include/asm/kasan.h:kasan_init
   Cyclomatic Complexity 1 arch/x86/include/asm/gart.h:early_gart_iommu_check
   Cyclomatic Complexity 1 arch/x86/include/asm/mpx.h:mpx_mm_init
   Cyclomatic Complexity 1 arch/x86/include/asm/mmu_context.h:vma_pkey
   Cyclomatic Complexity 1 arch/x86/include/asm/olpc_ofw.h:olpc_ofw_detect
   Cyclomatic Complexity 1 arch/x86/include/asm/olpc_ofw.h:setup_olpc_ofw_pgd
   Cyclomatic Complexity 1 arch/x86/include/asm/prom.h:add_dtb
   Cyclomatic Complexity 1 arch/x86/include/asm/prom.h:x86_dtb_init
   Cyclomatic Complexity 1 arch/x86/include/asm/unwind.h:unwind_init
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:copy_edd
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:get_ramdisk_image
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:get_ramdisk_size
   Cyclomatic Complexity 4 arch/x86/kernel/setup.c:parse_reservelow
   Cyclomatic Complexity 3 arch/x86/kernel/setup.c:early_reserve_initrd
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:reserve_ibft_region
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:reserve_brk
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:trim_low_memory_range
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:dump_kernel_offset
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:memblock_x86_reserve_range_setup_data
   Cyclomatic Complexity 5 arch/x86/kernel/setup.c:parse_setup_data
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:e820_add_kernel_range
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:trim_bios_range
   Cyclomatic Complexity 1 arch/x86/include/asm/mtrr.h:mtrr_bp_init
   Cyclomatic Complexity 5 arch/x86/kernel/setup.c:snb_gfx_workaround_needed
   Cyclomatic Complexity 4 arch/x86/kernel/setup.c:trim_snb_memory
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:trim_platform_memory_ranges
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:relocate_initrd
   Cyclomatic Complexity 4 arch/x86/kernel/setup.c:reserve_initrd
   Cyclomatic Complexity 5 arch/x86/kernel/setup.c:reserve_crashkernel_low
   Cyclomatic Complexity 12 arch/x86/kernel/setup.c:reserve_crashkernel
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:register_kernel_offset_dumper
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:__brk_reservation_fn_dmi_alloc__
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:extend_brk
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:reserve_standard_io_resources
   Cyclomatic Complexity 14 arch/x86/kernel/setup.c:setup_arch
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:arch_show_smap
--
   In file included from include/linux/crash_dump.h:5:0,
                    from arch/x86/kernel/e820.c:11:
>> include/linux/kexec.h:237:62: warning: 'struct kexec_buf' declared inside parameter list will not be visible outside of this definition or declaration
    extern int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
                                                                 ^~~~~~~~~
   include/linux/kexec.h:288:52: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
                                                       ^~~~~~~~~~~~~~
   include/linux/kexec.h:292:48: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
                                                   ^~~~~~~~~~~~~~
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 include/linux/printk.h:early_printk
   Cyclomatic Complexity 3 include/linux/string.h:memset
   Cyclomatic Complexity 4 include/linux/string.h:memcpy
   Cyclomatic Complexity 1 include/linux/kasan.h:kasan_kmalloc
   Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 1 include/linux/slab.h:kmem_cache_alloc_trace
   Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_order_trace
   Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/suspend.h:register_nosave_region
   Cyclomatic Complexity 1 include/linux/firmware-map.h:firmware_map_add_early
   Cyclomatic Complexity 8 arch/x86/kernel/e820.c:__e820__mapped_all
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:cpcompare
   Cyclomatic Complexity 5 arch/x86/kernel/e820.c:e820_search_gap
   Cyclomatic Complexity 8 arch/x86/kernel/e820.c:e820_type_to_string
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:e820_type_to_iomem_type
   Cyclomatic Complexity 5 arch/x86/kernel/e820.c:e820_type_to_iores_desc
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:do_mark_busy
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:ram_alignment
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:__e820__range_add
   Cyclomatic Complexity 7 arch/x86/kernel/e820.c:e820_print_type
   Cyclomatic Complexity 7 arch/x86/kernel/e820.c:e820_end_pfn
   Cyclomatic Complexity 10 arch/x86/kernel/e820.c:__e820__range_update
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__range_update_kexec
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:e820__register_nvs_regions
   Cyclomatic Complexity 0 arch/x86/kernel/e820.c:early_panic
   Cyclomatic Complexity 2 include/linux/memblock.h:memblock_dump_all
   Cyclomatic Complexity 6 arch/x86/kernel/e820.c:e820__mapped_any
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__mapped_all
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:e820__get_entry_type
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__range_add
   Cyclomatic Complexity 4 arch/x86/kernel/e820.c:__append_e820_table
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:append_e820_table
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:e820__print_table
   Cyclomatic Complexity 18 arch/x86/kernel/e820.c:e820__update_table
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__update_table_kexec
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__range_update
   Cyclomatic Complexity 12 arch/x86/kernel/e820.c:e820__range_remove
   Cyclomatic Complexity 4 arch/x86/kernel/e820.c:parse_memopt
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:e820__update_table_print
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:e820__setup_pci_gap
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__reallocate_tables
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__memory_setup_extended
   Cyclomatic Complexity 5 arch/x86/kernel/e820.c:e820__register_nosave_regions
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:e820__memblock_alloc_reserved
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__end_of_ram_pfn
   Cyclomatic Complexity 9 arch/x86/kernel/e820.c:parse_memmap_one
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:parse_memmap_opt
   Cyclomatic Complexity 1 arch/x86/kernel/e820.c:e820__end_of_low_ram_pfn
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:e820__reserve_setup_data
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:e820__finish_early_params
   Cyclomatic Complexity 4 arch/x86/kernel/e820.c:e820__reserve_resources
   Cyclomatic Complexity 7 arch/x86/kernel/e820.c:e820__reserve_resources_late
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:e820__memory_setup_default
   Cyclomatic Complexity 2 arch/x86/kernel/e820.c:e820__memory_setup
   Cyclomatic Complexity 3 arch/x86/kernel/e820.c:e820__memblock_setup
--
   In file included from arch/x86/kernel/setup_percpu.c:9:0:
>> include/linux/kexec.h:237:62: warning: 'struct kexec_buf' declared inside parameter list will not be visible outside of this definition or declaration
    extern int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
                                                                 ^~~~~~~~~
   include/linux/kexec.h:288:52: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
                                                       ^~~~~~~~~~~~~~
   include/linux/kexec.h:292:48: warning: 'struct purgatory_info' declared inside parameter list will not be visible outside of this definition or declaration
    int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
                                                   ^~~~~~~~~~~~~~
   Cyclomatic Complexity 2 arch/x86/include/asm/page_64.h:__phys_addr_nodebug
   Cyclomatic Complexity 1 arch/x86/include/asm/topology.h:setup_node_to_cpumask_map
   Cyclomatic Complexity 1 arch/x86/include/asm/stackprotector.h:setup_stack_canary_segment
   Cyclomatic Complexity 1 arch/x86/kernel/setup_percpu.c:pcpu_cpu_distance
   Cyclomatic Complexity 1 arch/x86/kernel/setup_percpu.c:setup_percpu_segment
   Cyclomatic Complexity 1 arch/x86/kernel/setup_percpu.c:pcpup_populate_pte
   Cyclomatic Complexity 1 arch/x86/kernel/setup_percpu.c:pcpu_fc_free
   Cyclomatic Complexity 1 arch/x86/kernel/setup_percpu.c:pcpu_alloc_bootmem
   Cyclomatic Complexity 1 arch/x86/kernel/setup_percpu.c:pcpu_fc_alloc
   Cyclomatic Complexity 6 arch/x86/kernel/setup_percpu.c:setup_per_cpu_areas
..

vim +237 include/linux/kexec.h

   225	
   226	/* kexec interface functions */
   227	extern void machine_kexec(struct kimage *image);
   228	extern int machine_kexec_prepare(struct kimage *image);
   229	extern void machine_kexec_cleanup(struct kimage *image);
   230	extern asmlinkage long sys_kexec_load(unsigned long entry,
   231						unsigned long nr_segments,
   232						struct kexec_segment __user *segments,
   233						unsigned long flags);
   234	extern int kernel_kexec(void);
   235	extern struct page *kimage_alloc_control_pages(struct kimage *image,
   236							unsigned int order);
 > 237	extern int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
   238	extern int kexec_purgatory_get_set_symbol(struct kimage *image,
   239						  const char *name, void *buf,
   240						  unsigned int size, bool get_value);
   241	extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
   242						     const char *name);
   243	extern void __crash_kexec(struct pt_regs *);
   244	extern void crash_kexec(struct pt_regs *);
   245	int kexec_should_crash(struct task_struct *);
   246	int kexec_crash_loaded(void);
   247	void crash_save_cpu(struct pt_regs *regs, int cpu);
   248	extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
   249	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ZGiS0Q5IWpPtfppv--
