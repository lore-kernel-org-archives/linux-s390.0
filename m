From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 30 Jun 2017 12:26:44 +0000
Subject: Re: [CRIU] [PATCH v2 03/17] s390:proto: Add s390 to protocol buffer files
Message-Id: <CAJwJo6adFOvRxrkfOxXH+Q2jmVsgzB5vZG-EjVT=qdeLcRszvg@mail.gmail.com>
In-Reply-To: <20170629192445.55580-4-holzheu@linux.vnet.ibm.com>
References: <20170629192445.55580-4-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, openvz-criu@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

2017-06-29 22:24 GMT+03:00 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>

> ---
>  images/Makefile        |  1 +
>  images/core-s390.proto | 39 +++++++++++++++++++++++++++++++++++++++
>  images/core.proto      |  3 +++
>  images/cpuinfo.proto   |  5 +++++
>  4 files changed, 48 insertions(+)
>  create mode 100644 images/core-s390.proto
>
> diff --git a/images/Makefile b/images/Makefile
> index 0c1f6e7..af226dc 100644
> --- a/images/Makefile
> +++ b/images/Makefile
> @@ -4,6 +4,7 @@ proto-obj-y     += core-x86.o
>  proto-obj-y    += core-arm.o
>  proto-obj-y    += core-aarch64.o
>  proto-obj-y    += core-ppc64.o
> +proto-obj-y    += core-s390.o
>  proto-obj-y    += cpuinfo.o
>  proto-obj-y    += inventory.o
>  proto-obj-y    += fdinfo.o
> diff --git a/images/core-s390.proto b/images/core-s390.proto
> new file mode 100644
> index 0000000..78d3e14
> --- /dev/null
> +++ b/images/core-s390.proto
> @@ -0,0 +1,39 @@
> +syntax = "proto2";
> +
> +import "opts.proto";
> +
> +message user_s390_regs_entry {
> +       required uint64                 psw_mask        = 1;
> +       required uint64                 psw_addr        = 2;
> +       repeated uint64                 gprs            = 3;
> +       repeated uint32                 acrs            = 4;
> +       required uint64                 orig_gpr2       = 5;
> +       required uint32                 system_call     = 6;
> +}
> +
> +message user_s390_vxrs_low_entry {
> +       repeated uint64                 regs            = 1;
> +}
> +
> +/*
> + * The vxrs_high registers have 128 bit:
> + *
> + *   vxrs_high_0 = regs[0] << 64 | regs[1];
> + *   vxrs_high_1 = regs[2] << 64 | regs[3];
> + */
> +message user_s390_vxrs_high_entry {
> +       repeated uint64                 regs            = 1;
> +}
> +
> +message user_s390_fpregs_entry {
> +       required uint32                 fpc             = 1;
> +       repeated uint64                 fprs            = 2;
> +}
> +
> +message thread_info_s390 {
> +       required uint64                         clear_tid_addr  = 1[(criu).hex = true];
> +       required user_s390_regs_entry           gpregs          = 2[(criu).hex = true];
> +       required user_s390_fpregs_entry         fpregs          = 3[(criu).hex = true];
> +       optional user_s390_vxrs_low_entry       vxrs_low        = 4[(criu).hex = true];
> +       optional user_s390_vxrs_high_entry      vxrs_high       = 5[(criu).hex = true];
> +}
> diff --git a/images/core.proto b/images/core.proto
> index b527051..ea572d9 100644
> --- a/images/core.proto
> +++ b/images/core.proto
> @@ -4,6 +4,7 @@ import "core-x86.proto";
>  import "core-arm.proto";
>  import "core-aarch64.proto";
>  import "core-ppc64.proto";
> +import "core-s390.proto";
>
>  import "rlimit.proto";
>  import "timer.proto";
> @@ -95,6 +96,7 @@ message core_entry {
>                 ARM             = 2;
>                 AARCH64         = 3;
>                 PPC64           = 4;
> +               S390            = 5;
>         }
>
>         required march                  mtype           = 1;
> @@ -102,6 +104,7 @@ message core_entry {
>         optional thread_info_arm        ti_arm          = 6;
>         optional thread_info_aarch64    ti_aarch64      = 8;
>         optional thread_info_ppc64      ti_ppc64        = 9;
> +       optional thread_info_s390       ti_s390         = 10;
>
>         optional task_core_entry        tc              = 3;
>         optional task_kobj_ids_entry    ids             = 4;
> diff --git a/images/cpuinfo.proto b/images/cpuinfo.proto
> index 9fa34fb..a8cb8de 100644
> --- a/images/cpuinfo.proto
> +++ b/images/cpuinfo.proto
> @@ -27,6 +27,10 @@ message cpuinfo_ppc64_entry {
>         repeated uint64         hwcap           = 2;
>  }
>
> +message cpuinfo_s390_entry {
> +       repeated uint64         hwcap           = 2;
> +}
> +
>  message cpuinfo_entry {
>         /*
>          * Usually on SMP system there should be same CPUs
> @@ -35,4 +39,5 @@ message cpuinfo_entry {
>          */
>         repeated cpuinfo_x86_entry      x86_entry       = 1;
>         repeated cpuinfo_ppc64_entry    ppc64_entry     = 2;
> +       repeated cpuinfo_s390_entry     s390_entry      = 3;
>  }
> --
> 2.7.4
>
> _______________________________________________
> CRIU mailing list
> CRIU@openvz.org
> https://lists.openvz.org/mailman/listinfo/criu



-- 
             Dmitry
