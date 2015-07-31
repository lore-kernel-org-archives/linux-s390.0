Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 31 Jul 2015 11:35:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Build errors in -next due to ' s390/kernel: lazy restore fpu
 registers'
Message-ID: <20150731183510.GA9117@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

s390:defconfig and s390:allmodconfig fail to build in -next as follows.

arch/s390/kernel/entry.S:806: Error:
	operand out of range (0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
arch/s390/kernel/entry.S:1254: Error:
	operand out of range (0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)

bisect points to commit 9977e886cbb (" s390/kernel: lazy restore fpu
registers").

The build has been broken since at least July 20. I thought this was reported
before, but maybe not; there may have been other failures masking this one.

Guenter

---
bisect log:

# bad: [37bd1ea52d362219b1882814cb75bb365736890f] Add linux-next specific files for 20150731
# good: [cbfe8fa6cd672011c755c3cd85c9ffd4e2d10a6f] Linux 4.2-rc4
git bisect start 'HEAD' 'v4.2-rc4'
# bad: [dee8e3fb6da725af9f6576203043e28e1fc24112] Merge remote-tracking branch 'drm/drm-next'
git bisect bad dee8e3fb6da725af9f6576203043e28e1fc24112
# bad: [c8fd769bd069deb8413a291b3ed1065713a7c2ac] Merge remote-tracking branch 'nfsd/nfsd-next'
git bisect bad c8fd769bd069deb8413a291b3ed1065713a7c2ac
# good: [2aeaf3502ff5fc5e6546b90526c5ef83d8147338] Merge remote-tracking branch 'imx-mxs/for-next'
git bisect good 2aeaf3502ff5fc5e6546b90526c5ef83d8147338
# good: [a9a6463fbc01f5e6381a60fd26d18c8dbdcb212f] Merge remote-tracking branch 'arm64/for-next/core'
git bisect good a9a6463fbc01f5e6381a60fd26d18c8dbdcb212f
# good: [baec360b51b688dc8a2ada3cdd49b4dc53365c1e] Merge remote-tracking branch 'mips/mips-for-linux-next'
git bisect good baec360b51b688dc8a2ada3cdd49b4dc53365c1e
# bad: [fd8d2ad6933201e6fd3a322d14402aa5bf7dfc7f] Merge remote-tracking branch 'ext4/dev'
git bisect bad fd8d2ad6933201e6fd3a322d14402aa5bf7dfc7f
# bad: [7c1db7c111659e68167217d40440ec8be24b58e0] Merge remote-tracking branch 's390/features'
git bisect bad 7c1db7c111659e68167217d40440ec8be24b58e0
# bad: [515f022e8b59ce928fe5d82affb3e93ab53d12ed] s390/pci: handle events for unused functions
git bisect bad 515f022e8b59ce928fe5d82affb3e93ab53d12ed
# bad: [dcd2a9aaa0e0331ba0c4d7a64830788f22f26aa4] s390/kvm: fix interrupt race with HANDLE_SIE_INTERCEPT
git bisect bad dcd2a9aaa0e0331ba0c4d7a64830788f22f26aa4
# good: [155e839a814834a3b4b31e729f4716e59d3d2dd4] s390/kernel: dynamically allocate FP register save area
git bisect good 155e839a814834a3b4b31e729f4716e59d3d2dd4
# bad: [7d0c502040a23a5924d3021651cf5326c8694a77] cpufeature: correctly annotate the module init function
git bisect bad 7d0c502040a23a5924d3021651cf5326c8694a77
# bad: [9977e886cbbc758b4b601a160b5825ba573b5ca8] s390/kernel: lazy restore fpu registers
git bisect bad 9977e886cbbc758b4b601a160b5825ba573b5ca8
# good: [bd550337f61b6f10dee8c60d0bd17ac02367b56d] s390/vx: add vector instruction support for older binutils versions
git bisect good bd550337f61b6f10dee8c60d0bd17ac02367b56d
# first bad commit: [9977e886cbbc758b4b601a160b5825ba573b5ca8] s390/kernel: lazy restore fpu registers
