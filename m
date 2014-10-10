From: Alexey Ishchuk <aishchuk@linux.vnet.ibm.com>
Date: Fri, 10 Oct 2014 09:40:22 +0000
Subject: [PATCH 0/3] DAPL support on s390x platform
Message-Id: <1412934025-56018-1-git-send-email-aishchuk@linux.vnet.ibm.com>
In-Reply-To: <1412933657-52641-1-git-send-email-aishchuk@linux.vnet.ibm.com>
References: <1412933657-52641-1-git-send-email-aishchuk@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The s390 kernel maintainer is going to include the new system calls for
PCI I/O memory access into the s390 Linux kernel. To make the final
decision we would like to receive feedback from the libmlx4 and libibverbs
user space library maintainers with direct answer to the question: will
those system calls be used in the libmlx4 user space library to provide
support for the s390x platform?
This patch series contains the changes to kernel and users pace libraries
required to provide support for the DAPL API on s390x platform.
The current implementation of Infiniband verbs uses mapped memory areas to
directly access the device UAR and Blueflame pages, which are located in
the PCI I/O memory, from user space. On the s390x platform the PCI I/O
memory can be accessed only using special privileged CPU instructions that
cannot be used directly in user space programs. This restricts the usage of
mapped memory areas to access the PCI I/O memory on s390x platform.
This version of changes introduces two new kernel system calls which allow
to execute the privileged CPU instructions in kernel space on request from
user space programs. One system call allows the user space programs to
write data to a PCI I/O memory page and the second one can be used to read
data from PCI I/O memory to user space program buffer using mapped memory
area addresses as arguments.
This approach of the DAPL API support on s390x platform has the following
advantages:
	* the current Infiniband and mlx4 support kernel modules remain
	  unchanged;
	* the changes are separated into the special kernel platform
	  specific directory;
	* no conditional compilation directives are used in the kernel
	  source code;
	* no changes required to the kernel virtual memory management;
	* only minor changes are required in the user space DAPL API
	  components.
There are 1 patch for the Linux kernel and 2 patches for the DAPL API user
space components. The kernel patch is not changed since the previous post
and is included into this patch series just for reference. The patches for
the perftest and dapl packages are not included into this series because
those changes have been already applied to corresponding packages by the
maintainers.
	[PATCH 1/3] s390/kernel: add system calls for access PCI memory
This patch contains the new system call implementation required for the PCI
I/O memory access from user space programs on s390x platform.
	[PATCH 2/3] libibverbs: add support for the s390x plaform
This patch contains the changes to the libibverbs user space library to
provide support of the s390x platform.
	[PATCH 3/3] libmlx4: add support for the s390x platform
This patch contains the changes to the libmlx4 user space library intended
to provide the PCI I/O memory access on the s390x platform. The direct
access to mapped memory areas is replaced by appropriate system call
invocation.

Alexey Ishchuk (3):
  s390/kernel: add system calls for access PCI memory
  libibverbs: add s390x platform support
  libmlx4: add s390x platform support
-- 
1.8.5.5
