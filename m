From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 27 Nov 2015 12:33:08 +0000
Subject: [linux-review:Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20151127-191620] bafdcb831ce105cb7ff2
Message-Id: <56584d84.4StRnjWkBzJ331mB%fengguang.wu@intel.com>
To: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparc@vger.kernel.org, linuxppc-embedded@vger.kernel.org, linux-mips@vger.kernel.org, linux-arm-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

https://github.com/0day-ci/linux  Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20151127-191620
bafdcb831ce105cb7ff2b9e11acfcf3764da11b9  printk/nmi: Increase the size of the temporary buffer

include/asm-generic/percpu.h:111:2: error: implicit declaration of function 'preempt_disable' [-Werror=implicit-function-declaration]
include/asm-generic/percpu.h:113:2: error: implicit declaration of function 'preempt_enable' [-Werror=implicit-function-declaration]
include/asm-generic/percpu.h:305:31: note: in expansion of macro 'this_cpu_generic_read'
include/linux/percpu-defs.h:101:9: note: in expansion of macro '__PCPU_ATTRS'
include/linux/percpu-defs.h:113:38: error: expected ')' before string constant
include/linux/percpu-defs.h:223:26: error: implicit declaration of function 'per_cpu_offset' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:223:2: note: in expansion of macro 'SHIFT_PERCPU_PTR'
include/linux/percpu-defs.h:229:2: error: implicit declaration of function 'arch_raw_cpu_ptr' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:239:27: note: in expansion of macro 'raw_cpu_ptr'
include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
include/linux/percpu-defs.h:304:1: error: called object is not a function or function pointer
include/linux/percpu-defs.h:311:23: note: in expansion of macro 'this_cpu_read_8'
include/linux/percpu-defs.h:49:34: error: 'PER_CPU_BASE_SECTION' undeclared here (not in a function)
include/linux/percpu-defs.h:494:29: note: in expansion of macro '__pcpu_size_call_return'
include/linux/percpu-defs.h:494:53: error: implicit declaration of function 'this_cpu_read_1' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:494:53: error: implicit declaration of function 'this_cpu_read_2' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:494:53: error: implicit declaration of function 'this_cpu_read_4' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:494:53: error: implicit declaration of function 'this_cpu_read_8' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:495:51: error: implicit declaration of function 'this_cpu_write_1' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:495:51: error: implicit declaration of function 'this_cpu_write_2' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:495:51: error: implicit declaration of function 'this_cpu_write_4' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:495:51: error: implicit declaration of function 'this_cpu_write_8' [-Werror=implicit-function-declaration]
include/linux/percpu-defs.h:49:59: error: expected identifier or '(' before ')' token
kernel/printk/nmi.c:106:9: error: unknown type name 'raw_spinlock_t'
kernel/printk/nmi.c:107:3: error: implicit declaration of function '__RAW_SPIN_LOCK_INITIALIZER' [-Werror=implicit-function-declaration]
kernel/printk/nmi.c:107:3: error: initializer element is not constant
kernel/printk/nmi.c:113:2: error: unknown type name 'raw_spinlock_t'
kernel/printk/nmi.c:113:9: error: unknown type name 'raw_spinlock_t'
kernel/printk/nmi.c:114:3: error: implicit declaration of function '__RAW_SPIN_LOCK_INITIALIZER'
kernel/printk/nmi.c:114:3: error: implicit declaration of function '__RAW_SPIN_LOCK_INITIALIZER' [-Werror=implicit-function-declaration]
kernel/printk/nmi.c:114:3: error: initializer element is not constant
kernel/printk/nmi.c:114: error: implicit declaration of function '__RAW_SPIN_LOCK_INITIALIZER'
kernel/printk/nmi.c:118:2: error: implicit declaration of function 'raw_spin_lock' [-Werror=implicit-function-declaration]
kernel/printk/nmi.c:125:2: error: implicit declaration of function 'raw_spin_lock'
kernel/printk/nmi.c:125:2: error: implicit declaration of function 'raw_spin_lock' [-Werror=implicit-function-declaration]
kernel/printk/nmi.c:125: error: implicit declaration of function 'raw_spin_lock'
kernel/printk/nmi.c:163:2: error: implicit declaration of function 'raw_spin_unlock' [-Werror=implicit-function-declaration]
kernel/printk/nmi.c:170:2: error: implicit declaration of function 'raw_spin_unlock'
kernel/printk/nmi.c:170:2: error: implicit declaration of function 'raw_spin_unlock' [-Werror=implicit-function-declaration]
kernel/printk/nmi.c:170: error: implicit declaration of function 'raw_spin_unlock'
kernel/printk/nmi.c:178:23: note: in expansion of macro 'per_cpu'
kernel/printk/nmi.c:178:3: error: implicit declaration of function 'per_cpu_offset' [-Werror=implicit-function-declaration]
kernel/printk/nmi.c:185:23: note: in expansion of macro 'per_cpu'
kernel/printk/nmi.c:194:17: error: 'printk_func' undeclared (first use in this function)
kernel/printk/nmi.c:194:2: note: in expansion of macro 'this_cpu_write'
kernel/printk/nmi.c:212:18: error: 'printk_func' undeclared (first use in this function)
kernel/printk/nmi.c:212:3: error: 'printk_func' undeclared (first use in this function)
kernel/printk/nmi.c:212:3: note: in expansion of macro 'this_cpu_write'
kernel/printk/nmi.c:212:51: error: 'printk_func' undeclared (first use in this function)
kernel/printk/nmi.c:38:1: note: in expansion of macro 'DEFINE_PER_CPU'
kernel/printk/nmi.c:43:24: error: 'PAGE_SIZE' undeclared here (not in a function)
kernel/printk/nmi.c:45:27: error: 'PAGE_SIZE' undeclared here (not in a function)
kernel/printk/nmi.c:45:28: error: 'PAGE_SIZE' undeclared here (not in a function)
kernel/printk/nmi.c:45: error: 'PAGE_SIZE' undeclared here (not in a function)
kernel/printk/nmi.c:56:26: note: in expansion of macro 'this_cpu_ptr'
kernel/printk/nmi.c:56:40: error: 'nmi_print_seq' undeclared (first use in this function)
kernel/printk/nmi.c:56:9: error: implicit declaration of function 'arch_raw_cpu_ptr' [-Werror=implicit-function-declaration]
kernel/printk/nmi.c:58:26: error: 'nmi_print_seq' undeclared (first use in this function)
kernel/printk/nmi.c:58:26: note: in expansion of macro 'this_cpu_ptr'
kernel/printk/nmi.c:58:40: error: 'nmi_print_seq' undeclared (first use in this function)
kernel/printk/nmi.c:58:71: error: 'nmi_print_seq' undeclared (first use in this function)
kernel/printk/nmi.c:58:85: error: 'nmi_print_seq' undeclared (first use in this function)
kernel/printk/printk.h:31:1: note: in expansion of macro 'DECLARE_PER_CPU'
kernel/printk/printk.h:34:19: error: 'printk_func' undeclared (first use in this function)
kernel/printk/printk.h:34:23: error: 'printk_func' undeclared (first use in this function)
kernel/printk/printk.h:34:35: error: called object '(({...}))' is not a function
kernel/printk/printk.h:34:475: error: called object '(({...}))' is not a function
kernel/printk/printk.h:34:9: error: 'printk_func' undeclared (first use in this function)
kernel/printk/printk.h:34:9: note: in expansion of macro 'this_cpu_read'
warning: (MN10300) selects HAVE_NMI_WATCHDOG which has unmet direct dependencies (HAVE_NMI)

Error ids grouped by kconfigs:

recent_errors
��������� avr32-atngw100_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
��������� avr32-atstk1006_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
��������� blackfin-BF526-EZBRD_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� blackfin-BF533-EZKIT_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� blackfin-BF561-EZKIT-SMP_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-arch_raw_cpu_ptr
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-per_cpu_offset
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� blackfin-TCM-BF537_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� cris-etrax-100lx_v2_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� i386-alldefconfig
������� ��������� include-asm-generic-percpu.h:error:implicit-declaration-of-function-preempt_disable
������� ��������� include-asm-generic-percpu.h:error:implicit-declaration-of-function-preempt_enable
������� ��������� include-asm-generic-percpu.h:note:in-expansion-of-macro-this_cpu_generic_read
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-__pcpu_size_call_return
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-this_cpu_read_8
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:note:in-expansion-of-macro-this_cpu_read
��������� i386-randconfig-s1-201547
������� ��������� include-asm-generic-percpu.h:error:implicit-declaration-of-function-preempt_disable
������� ��������� include-asm-generic-percpu.h:error:implicit-declaration-of-function-preempt_enable
������� ��������� include-asm-generic-percpu.h:note:in-expansion-of-macro-this_cpu_generic_read
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-__pcpu_size_call_return
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-this_cpu_read_8
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:note:in-expansion-of-macro-this_cpu_read
��������� mips-bmips_be_defconfig
������� ��������� include-linux-percpu-defs.h:error:called-object-is-not-a-function-or-function-pointer
������� ��������� include-linux-percpu-defs.h:error:expected-)-before-string-constant
������� ��������� include-linux-percpu-defs.h:error:expected-identifier-or-(-before-)-token
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-arch_raw_cpu_ptr
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-per_cpu_offset
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_1
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_2
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_4
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_8
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_1
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_2
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_4
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_8
������� ��������� include-linux-percpu-defs.h:error:PER_CPU_BASE_SECTION-undeclared-here-(not-in-a-function)
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-__PCPU_ATTRS
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-__pcpu_size_call_return
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-raw_cpu_ptr
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-SHIFT_PERCPU_PTR
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-DEFINE_PER_CPU
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-per_cpu
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-this_cpu_ptr
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-this_cpu_write
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-printk.h:note:in-expansion-of-macro-DECLARE_PER_CPU
������� ��������� kernel-printk-printk.h:note:in-expansion-of-macro-this_cpu_read
��������� mips-fuloong2e_defconfig
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
��������� mips-jz4740
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
��������� mips-malta_kvm_defconfig
������� ��������� include-linux-percpu-defs.h:error:called-object-is-not-a-function-or-function-pointer
������� ��������� include-linux-percpu-defs.h:error:expected-)-before-string-constant
������� ��������� include-linux-percpu-defs.h:error:expected-identifier-or-(-before-)-token
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-arch_raw_cpu_ptr
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-per_cpu_offset
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_1
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_2
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_4
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_8
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_1
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_2
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_4
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_8
������� ��������� include-linux-percpu-defs.h:error:PER_CPU_BASE_SECTION-undeclared-here-(not-in-a-function)
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-__PCPU_ATTRS
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-raw_cpu_ptr
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-SHIFT_PERCPU_PTR
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-DEFINE_PER_CPU
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-per_cpu
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-this_cpu_ptr
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-this_cpu_write
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-printk.h:note:in-expansion-of-macro-DECLARE_PER_CPU
��������� mips-tb0226_defconfig
������� ��������� include-linux-percpu-defs.h:error:called-object-is-not-a-function-or-function-pointer
������� ��������� include-linux-percpu-defs.h:error:expected-)-before-string-constant
������� ��������� include-linux-percpu-defs.h:error:expected-identifier-or-(-before-)-token
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_1
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_2
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_4
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_read_8
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_1
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_2
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_4
������� ��������� include-linux-percpu-defs.h:error:implicit-declaration-of-function-this_cpu_write_8
������� ��������� include-linux-percpu-defs.h:error:PER_CPU_BASE_SECTION-undeclared-here-(not-in-a-function)
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-__PCPU_ATTRS
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-__pcpu_size_call_return
������� ��������� include-linux-percpu-defs.h:note:in-expansion-of-macro-raw_cpu_ptr
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-DEFINE_PER_CPU
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-per_cpu
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-this_cpu_ptr
������� ��������� kernel-printk-nmi.c:note:in-expansion-of-macro-this_cpu_write
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-printk.h:note:in-expansion-of-macro-DECLARE_PER_CPU
������� ��������� kernel-printk-printk.h:note:in-expansion-of-macro-this_cpu_read
��������� mips-txx9
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
��������� mn10300-asb2364_defconfig
������� ��������� warning:(MN10300)-selects-HAVE_NMI_WATCHDOG-which-has-unmet-direct-dependencies-(HAVE_NMI)
��������� powerpc-defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
��������� powerpc-kmp204x_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
��������� powerpc-ppc64_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
��������� sh-rsk7201_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� sh-rsk7269_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� sh-sh7785lcr_32bit_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� sh-titan_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:nmi_print_seq-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:PAGE_SIZE-undeclared-here-(not-in-a-function)
������� ��������� kernel-printk-nmi.c:error:printk_func-undeclared-(first-use-in-this-function)
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
������� ��������� kernel-printk-printk.h:error:called-object-((-...-))-is-not-a-function
������� ��������� kernel-printk-printk.h:error:printk_func-undeclared-(first-use-in-this-function)
��������� tile-defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
��������� tile-tilegx_defconfig
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
������� ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
������� ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
������� ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t
��������� x86_64-randconfig-i0-201547
    ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_lock
    ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-__RAW_SPIN_LOCK_INITIALIZER
    ��������� kernel-printk-nmi.c:error:implicit-declaration-of-function-raw_spin_unlock
    ��������� kernel-printk-nmi.c:error:initializer-element-is-not-constant
    ��������� kernel-printk-nmi.c:error:unknown-type-name-raw_spinlock_t

elapsed time: 75m

configs tested: 119

i386                     randconfig-a0-201547
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
m32r                    mappi2.opsp_defconfig
mips                       bmips_be_defconfig
mips                         tb0226_defconfig
sh                          rsk7201_defconfig
tile                                defconfig
x86_64               randconfig-x014-11241713
x86_64               randconfig-x016-11241713
x86_64               randconfig-x019-11241713
x86_64               randconfig-x010-11241713
x86_64               randconfig-x015-11241713
x86_64               randconfig-x011-11241713
x86_64               randconfig-x012-11241713
x86_64               randconfig-x013-11241713
x86_64               randconfig-x017-11241713
x86_64               randconfig-x018-11241713
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201547
i386                     randconfig-s1-201547
x86_64                 randconfig-s0-11271939
x86_64                 randconfig-s1-11271939
x86_64                 randconfig-s2-11271939
x86_64                           allmodconfig
x86_64                 randconfig-s3-11271943
x86_64                 randconfig-s4-11271943
x86_64                 randconfig-s5-11271943
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201547
arm                         palmz72_defconfig
arm                           sunxi_defconfig
powerpc               mpc85xx_basic_defconfig
xtensa                  nommu_kc705_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-11270816
i386                   randconfig-i1-11270816
x86_64                 randconfig-b0-11271947
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm64                               defconfig
mips                      malta_kvm_defconfig
powerpc                     tqm8548_defconfig
powerpc                      walnut_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201547
i386                   randconfig-h0-11271847
i386                   randconfig-h1-11271847
m32r                    mappi.nommu_defconfig
parisc                           alldefconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-x007-11230704
x86_64               randconfig-x001-11230704
x86_64               randconfig-x006-11230704
x86_64               randconfig-x008-11230704
x86_64               randconfig-x003-11230704
x86_64               randconfig-x002-11230704
x86_64               randconfig-x005-11230704
x86_64               randconfig-x000-11230704
x86_64               randconfig-x009-11230704
x86_64               randconfig-x004-11230704
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201547
i386                 randconfig-x003-11251907
i386                 randconfig-x001-11251907
i386                 randconfig-x005-11251907
i386                 randconfig-x004-11251907
i386                 randconfig-x002-11251907
i386                 randconfig-x000-11251907
i386                 randconfig-x007-11251907
i386                 randconfig-x008-11251907
i386                 randconfig-x006-11251907
i386                 randconfig-x009-11251907

Thanks,
Fengguang
