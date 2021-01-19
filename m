Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 0/2] s390: uv: small UV fixes
Date: Tue, 19 Jan 2021 05:04:00 -0500
Message-Id: <20210119100402.84734-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com

Two small fixes:
    * Handle 3d PGMs where the address space id is not known
    * Clean up the UV query VCPU number field naming (it's N-1 not N as number in this context means ID)

Janosch Frank (2):
  s390: uv: Fix sysfs max number of VCPUs reporting
  s390: mm: Fix secure storage access exception handling

 arch/s390/boot/uv.c        |  2 +-
 arch/s390/include/asm/uv.h |  4 ++--
 arch/s390/kernel/uv.c      |  2 +-
 arch/s390/mm/fault.c       | 14 ++++++++++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.25.1
