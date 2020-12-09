Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgLIPJq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 10:09:46 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63313C061793
        for <linux-s390@vger.kernel.org>; Wed,  9 Dec 2020 07:09:06 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id x16so2590207ejj.7
        for <linux-s390@vger.kernel.org>; Wed, 09 Dec 2020 07:09:06 -0800 (PST)
MIME-Version: 1.0
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
In-Reply-To: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Dec 2020 20:38:52 +0530
Message-ID: <CA+G9fYuK9a7gSWBmcc9DZ+sJEKYBhSLVYib5Qxk_+EC1ow_PyA@mail.gmail.com>
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>

On Thu, 26 Nov 2020 at 22:32, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> The directed MSIs are delivered to CPUs whose address is
> written to the MSI message data. The current code assumes
> that a CPU logical number (as it is seen by the kernel)
> is also that CPU address.
>
> The above assumption is not correct, as the CPU address
> is rather the value returned by STAP instruction. That
> value does not necessarily match the kernel logical CPU
> number.
>
> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 743f257cf2cb..75217fb63d7b 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
>  {
>         struct msi_desc *entry = irq_get_msi_desc(data->irq);
>         struct msi_msg msg = entry->msg;
> +       int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));

While building S390 the following kernel warning / error noticed
on stable -rc 5.4 branch with gcc-8, gcc-9 and gcc-10 and defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/6/tmp ARCH=s390
CROSS_COMPILE=s390x-linux-gnu- 'CC=sccache s390x-linux-gnu-gcc'
'HOSTCC=sccache gcc' vmlinux
arch/s390/pci/pci_irq.c: In function 'zpci_set_irq_affinity':
arch/s390/pci/pci_irq.c:106:17: error: implicit declaration of
function 'smp_cpu_get_cpu_address'
[-Werror=implicit-function-declaration]
  106 |  int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~


Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
--------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime docker --target-arch s390 --toolchain gcc-9
--kconfig defconfig


metadata:
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
    target_arch: s390
    toolchain: gcc-9
    git_describe: v5.4.82-36-gc45075765dae
    kernel_version: 5.4.83-rc1


full build log link,
https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/899272224

-- 
Linaro LKFT
https://lkft.linaro.org
