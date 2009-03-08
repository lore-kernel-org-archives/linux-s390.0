Return-Path: <linux-kernel-owner+w=401wt.eu-S1751273AbZCHHVn@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
Date: Sun, 8 Mar 2009 08:21:28 +0100
References: <200903080230.10099.elendil@planet.nl>
In-Reply-To: <200903080230.10099.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903080821.29609.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sunday 08 March 2009, Frans Pop wrote:
> Kernels after 2.6.27 fail to boot in the Hercules S/390 emulator, quite
> early in the boot process:
>      0.141419! Initializing cgroup subsys ns
>      0.141605! Initializing cgroup subsys cpuacct
>      0.142009! Initializing cgroup subsys devices
>      0.180403! cpu: 2 configured CPUs, 0 standby CPUs
>
> I've bisected this to the following commit:
> commit 5cd1c9c5cf30d4b33df3d3f74d8142f278d536b7
> Author: Roman Zippel <zippel@linux-m68k.org>
> Date:   Mon Sep 22 14:42:43 2008 -0700
>     timekeeping: fix rounding problem during clock update
>
> After reverting 5cd1c9c5cf30 and the somewhat related 6c9bacb41c10 on
> top of 2.6.28.7, the system boots OK again.

JFYI, with the same reverts 2.6.29-rc7 boots correctly too.
