Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 6 Apr 2020 14:05:58 -0400
From: Jeremy Cline <jcline@redhat.com>
Subject: Re: [PATCH] kbuild: add dummy toolchains to enable all cc-option
 etc. in Kconfig
Message-ID: <20200406180558.GA22412@dev.jcline.org>
References: <20200403090224.24045-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090224.24045-1-masahiroy@kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Philipp Rudo <prudo@linux.ibm.com>, linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 06:02:24PM +0900, Masahiro Yamada wrote:
> Staring v4.18, Kconfig evaluates compiler capabilities, and hides CONFIG
> options your compiler does not support. This works well if you configure
> and build the kernel on the same host machine.
> 
> It is inconvenient if you prepare the .config that is carried to a
> different build environment (typically this happens when you package
> the kernel for distros) because using a different compiler potentially
> produces different CONFIG options than the real build environment.
> So, you probably want to make as many options visible as possible.
> In other words, you need to create a super-set of CONFIG options that
> cover any build environment. If some of the CONFIG options turned out
> to be unsupported on the build machine, they are automatically disabled
> by the nature of Kconfig.
> 
> However, it is not feasible to get a full-featured compiler for every
> arch.
> 
> This issue was discussed here:
> 
>   https://lkml.org/lkml/2019/12/9/620
> 
> Other than distros, savedefconfig is also a problem. Some arch subsytems
> periodically resync defconfig files. If you use a less-capable compiler
> for savedefconfig, options that do not meet 'depends on $(cc-option,...)'
> will be forcibly disabled. So, defconfig && savedefconfig may silently
> change the behavior.
> 
> This commit adds a set of dummy toolchains that pretend to support any
> feature.
> 
> Most of compiler features are tested by cc-option, which simply checks
> the exit code of $(CC). The dummy tools are just a shell script that
> exits with 0 in most cases. So, $(cc-option, ...) is evaluated as 'y'.
> 
> There are more complicated checks such as:
> 
>   scripts/gcc-x86_{32,64}-has-stack-protector.sh
>   scripts/gcc-plugin.sh
>   scripts/tools-support-relr.sh
> 
> I tried my best to implement the dummy scripts to pass all checks.
> 
> From the top directory of the source tree, you can do:
> 
>    $ make CROSS_COMPILE=scripts/dummy-tools/ oldconfig
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/dummy-tools/gcc     | 91 +++++++++++++++++++++++++++++++++++++
>  scripts/dummy-tools/ld      |  4 ++
>  scripts/dummy-tools/nm      |  4 ++
>  scripts/dummy-tools/objcopy |  4 ++
>  4 files changed, 103 insertions(+)
>  create mode 100755 scripts/dummy-tools/gcc
>  create mode 100755 scripts/dummy-tools/ld
>  create mode 100755 scripts/dummy-tools/nm
>  create mode 100755 scripts/dummy-tools/objcopy
> 

<snip>

> diff --git a/scripts/dummy-tools/ld b/scripts/dummy-tools/ld
> new file mode 100755
> index 000000000000..3bc56ae4cc15
> --- /dev/null
> +++ b/scripts/dummy-tools/ld
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Dummy script that always succeeds

It looks like scripts/Kbuild.include expects "$(LD) --version" to return
something. If it doesn't "ld-ifversion" stops working.

Other than that it seems to work as advertised. Thanks!

- Jeremy
