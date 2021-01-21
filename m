Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 0/2] s390: uv: small UV fixes
Date: Thu, 21 Jan 2021 10:14:33 -0500
Message-Id: <20210121151436.417240-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, hca@linux.ibm.com, mihajlov@linux.ibm.com

Two small fixes:
    * Handle 3d PGMs where the address space id is not known
    * Clean up the UV query VCPU number field naming (it's N-1 not N as number in this context means ID)

v2:
	* Renamed the struct member from max_guest_cpu to max_guest_cpu_id
	* Improved a comment text

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
