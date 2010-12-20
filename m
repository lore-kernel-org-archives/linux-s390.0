Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20101220130541.446049933@linux.vnet.ibm.com>
Date: Mon, 20 Dec 2010 14:05:41 +0100
From: graalfs@linux.vnet.ibm.com
Subject: [patch 0/4] OProfile support for System z's hardware sampling
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: robert.richter@amd.com
Cc: mingo@elte.hu, oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

So far, OProfile takes samples by using a software interrupt.
The purpose of this series of patches is to add support for System z hardware sampling to OProfile.

Hardware (HW) sampling is a feature provided by System z processors (z10 and follow ons).
When sampling, the processor takes samples containing the instruction address, PID, and other information.
The samples are taken at a programmable rate and stored into a buffer provided by the operating system.
The sampling process is implemented in hardware and millicode and thus does not affect the operating system
being oberved, apart from requiring buffer memory that the Linux kernel must provide.

Hardware sampling is available in LPAR mode on 64 BIT processors only.

The overall approach is to replace the software-based sample generation by hardware sampling.
The driver for the HW sampling mechanism is a kernel module named hwsampler.
Kernel module hwsampler provides functions for
 - controlling the sampling hardware,
 - setting up appropriate buffer structures (HW buffers),
 - retrieving sample entries from these buffers.
Kernel module hwsampler can handle multiple CPUs.

The samples contain the instruction address, a bit distinguishing between kernel and user space,
and for user space samples also the PID.
Instead of taking samples from its own per-CPU buffers, OProfile would rather take samples from the
HW buffers.

When hardware sampling can be enabled on the current System z processor it will be the new default.
Switching back to timer based sampling can be established by using

   echo 0 > /dev/oprofile/hwsampling/hwsampler

The user space drivers of OProfile also need an extension to control hw sampling by appropriate options.
