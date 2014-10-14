From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 14 Oct 2014 08:14:37 +0000
Subject: Re: [PATCH 1/3] s390/kernel: add system calls for access PCI memory
Message-Id: <20141014081437.GB6031@osiris>
In-Reply-To: <20141013103945.27be11ef@mschwide>
References: <20141013103945.27be11ef@mschwide>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 10, 2014 at 11:40:23AM +0200, Alexey Ishchuk wrote:
> Add the new __NR_s390_pci_mmio_write and __NR_s390_pci_mmio_read
> system calls to allow user space applications to access device PCI I/O
> memory pages on s390x platform.
> 
> Signed-off-by: Alexey Ishchuk <alexey_ishchuk@ru.ibm.com>

You probably want to send your patch set not only to the linux-s390 mailing
list if you want to get more comments about the rest of your patch set...


> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 33225e8..3e71b7e 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -60,6 +60,7 @@ ifdef CONFIG_64BIT
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_cpum_cf.o perf_cpum_sf.o \
>  						perf_cpum_cf_events.o
>  obj-y				+= runtime_instr.o cache.o
> +obj-y				+= pci_mmio.o
>  endif

Your new file won't compile/link without CONFIG_PCI. So obj-$(CONFIG_PCI) is
probably the way to go. Which again means that you also need cond_syscalls.

> diff --git a/arch/s390/kernel/pci_mmio.c b/arch/s390/kernel/pci_mmio.c
> new file mode 100644
> index 0000000..f318207
> --- /dev/null
> +++ b/arch/s390/kernel/pci_mmio.c
> @@ -0,0 +1,207 @@
> +/*
> + * Access to PCI I/O memory from user space programs.
> + *
> + * Copyright IBM Corp. 2014
> + * Author(s): Alexey Ishchuk <aishchuk@linux.vnet.ibm.com>
> + */
> +#include <linux/kernel.h>
> +#include <linux/syscalls.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/errno.h>
> +#include <linux/pci.h>
> +
> +union value_buffer {
> +	u8 buf8;
> +	u16 buf16;
> +	u32 buf32;
> +	u64 buf64;
> +	u8 buf_large[64];
> +};
> +
> +static long get_pfn(const unsigned long user_addr,
> +		    const unsigned long access,
> +		    unsigned long *pfn)
> +{
> +	struct vm_area_struct *vma = NULL;
> +	long ret = 0L;

Unconditionally initializing all variables is considered bad practice, since
this might hide bugs in your code. The compiler will _never_ warn about not
initialized variables, where e.g. you forgot a call to a helper function.
Also, there is not much value in adding the long cast in the assignment above.

> +
> +	if (!pfn)
> +		return -EINVAL;
> +
> +	down_read(&current->mm->mmap_sem);
> +	vma = find_vma(current->mm, user_addr);
> +	if (vma) {
> +		if (!(vma->vm_flags & access))
> +			ret = -EACCES;
> +		else
> +			ret = follow_pfn(vma, user_addr, pfn);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +	up_read(&current->mm->mmap_sem);
> +
> +	return ret;
> +}

So, both ret and vma should be always initialized. No reason to preinitialize
them.

> +static long choose_buffer(const size_t length,
> +			  union value_buffer *value,
> +			  void **buf)
> +{
> +	long ret = 0L;
> +
> +	if (length > sizeof(value->buf_large)) {
> +		*buf = kmalloc(length, GFP_KERNEL);
> +		if (!*buf)
> +			return -ENOMEM;
> +		ret = 1;
> +	} else {
> +		*buf = value->buf_large;
> +	}
> +	return ret;
> +}

I'd rather change the helper function to something

static inline int need_allocate(size_t len)
{
	return len > sizeof(...)
}

and open code the kmalloc() in the code below. That's much more readable.
The "< 0", "== 0" and "> 0" are not very easy too read...

> +
> +SYSCALL_DEFINE3(s390_pci_mmio_write,
> +		const unsigned long, mmio_addr,
> +		const void __user *, user_buffer,
> +		const size_t, length)
> +{
> +	long ret = 0L;
> +	void *buf = NULL;
> +	long buf_allocated = 0;
> +	void __iomem *io_addr = NULL;
> +	unsigned long pfn = 0UL;
> +	unsigned long offset = 0UL;
> +	unsigned long page_addr = 0UL;
> +	union value_buffer value;

same as above...

> +	if (!length)
> +		return -EINVAL;
> +	if (!zpci_is_enabled())
> +		return -ENODEV;
> +
> +	ret = get_pfn(mmio_addr, VM_WRITE, &pfn);
> +	if (ret)
> +		return ret;
> +
> +	page_addr = pfn << PAGE_SHIFT;
> +	if (!verify_page_addr(page_addr))
> +		return -EFAULT;
> +
> +	offset = mmio_addr & ~PAGE_MASK;
> +	if (offset + length > PAGE_SIZE)
> +		return -EINVAL;

offset + length might be < PAGE_SIZE for length == -1UL.
It (currently) still can't be exploited since the buffer allocation will fail,
but the above checks need improvement...

> +	io_addr = (void *)(page_addr | offset);
> +
> +	buf_allocated = choose_buffer(length, &value, &buf);
> +	if (buf_allocated < 0L)
> +		return -ENOMEM;

e.g. use need_allocate() from above and open code kmalloc().

> +
> +	switch (length) {
> +	case 1:
> +		ret = get_user(value.buf8, ((u8 *)user_buffer));
> +		break;
> +	case 2:
> +		ret = get_user(value.buf16, ((u16 *)user_buffer));
> +		break;
> +	case 4:
> +		ret = get_user(value.buf32, ((u32 *)user_buffer));
> +		break;
> +	case 8:
> +		ret = get_user(value.buf64, ((u64 *)user_buffer));
> +		break;
> +	default:
> +		ret = copy_from_user(buf, user_buffer, length);

Is really worth to add all the get_user() calls? I'd assume just sticking
to the copy_from_user() call should be fast enough, given that in older
kernels get_user() was just a wrapper for copy_from_user() ;)

Also ret = copy_from_user() is wrong.

copy_from_user() returns the bytes not copied instead of -EFAULT on error.
So your code should look like

		if (copy_from_user(buf, user_buffer, length))
			ret = -EFAULT;

> +	switch (length) {
> +	case 1:
> +		value.buf8 = __raw_readb(io_addr);
> +		ret = put_user(value.buf8, ((u8 *)user_buffer));
> +		break;
> +	case 2:
> +		value.buf16 = __raw_readw(io_addr);
> +		ret = put_user(value.buf16, ((u16 *)user_buffer));
> +		break;
> +	case 4:
> +		value.buf32 = __raw_readl(io_addr);
> +		ret = put_user(value.buf32, ((u32 *)user_buffer));
> +		break;
> +	case 8:
> +		value.buf64 = __raw_readq(io_addr);
> +		ret = put_user(value.buf64, ((u64 *)user_buffer));
> +		break;
> +	default:
> +		memcpy_fromio(buf, io_addr, length);
> +		ret = copy_to_user(user_buffer, buf, length);
> +	}
> +	if (buf_allocated > 0L)
> +		kfree(buf);
> +	return ret;

Same here: a single copy_to_user() should do the job. Return code handling
is broken like above.

> diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
> index fe5cdf2..1faa942 100644
> --- a/arch/s390/kernel/syscalls.S
> +++ b/arch/s390/kernel/syscalls.S
> @@ -356,3 +356,5 @@ SYSCALL(sys_finit_module,sys_finit_module,compat_sys_finit_module)
>  SYSCALL(sys_sched_setattr,sys_sched_setattr,compat_sys_sched_setattr) /* 345 */
>  SYSCALL(sys_sched_getattr,sys_sched_getattr,compat_sys_sched_getattr)
>  SYSCALL(sys_renameat2,sys_renameat2,compat_sys_renameat2)
> +SYSCALL(sys_ni_syscall,sys_s390_pci_mmio_write,sys_ni_syscall)
> +SYSCALL(sys_ni_syscall,sys_s390_pci_mmio_read,sys_ni_syscall)

The compat system call is missing. 31 bit user space may also use this system
call with a 64 bit kernel.
