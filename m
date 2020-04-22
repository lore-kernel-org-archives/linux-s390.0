Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] hugetlbfs: remove hugetlb_add_hstate() warning for
 existing hstate
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-4-mike.kravetz@oracle.com>
 <87blnj4x9p.fsf@linux.ibm.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d39a33da-6095-c616-6bff-6af8795922d1@oracle.com>
Date: Wed, 22 Apr 2020 09:56:03 -0700
MIME-Version: 1.0
In-Reply-To: <87blnj4x9p.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Randy Dunlap <rdunlap@infradead.org>, Mina Almasry <almasrymina@google.com>, Peter Xu <peterx@redhat.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On 4/22/20 3:42 AM, Aneesh Kumar K.V wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
>> The routine hugetlb_add_hstate prints a warning if the hstate already
>> exists.  This was originally done as part of kernel command line
>> parsing.  If 'hugepagesz=' was specified more than once, the warning
>> 	pr_warn("hugepagesz= specified twice, ignoring\n");
>> would be printed.
>>
>> Some architectures want to enable all huge page sizes.  They would
>> call hugetlb_add_hstate for all supported sizes.  However, this was
>> done after command line processing and as a result hstates could have
>> already been created for some sizes.  To make sure no warning were
>> printed, there would often be code like:
>> 	if (!size_to_hstate(size)
>> 		hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT)
>>
>> The only time we want to print the warning is as the result of command
>> line processing.
> 
> Does this patch break hugepages=x command line? I haven't tested this
> yet. But one of the details w.r.t. skipping that hugetlb_add_hstate is
> to make sure we can configure the max_huge_pages. 
> 

Are you asking about hugepages=x being the only option on the command line?
If so, then the behavior is not changed.  This will result in x pages of
default huge page size being allocated.  Where default huge page size is of
course architecture dependent.  On an x86 VM,

[    0.040474] Kernel command line: BOOT_IMAGE=/vmlinuz-5.6.0-mm1+ root=/dev/mapper/fedora_new--host-root ro rd.lvm.lv=fedora_new-host/root rd.lvm.lv=fedora_new-host/swap console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugepages=128
[    0.332618] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.333245] HugeTLB registered 2.00 MiB page size, pre-allocated 128 pages

BTW - Here are the command line options I tested on x86 with this series.

No errors or warnings
---------------------
hugepages=128
hugepagesz=2M hugepages=128
default_hugepagesz=2M hugepages=128
hugepages=128 default_hugepagesz=2M
hugepagesz=1G hugepages=2
hugepages=2 default_hugepagesz=1G
default_hugepagesz=1G hugepages=2
hugepages=128 hugepagesz=1G hugepages=2
hugepagesz=1G hugepages=2 hugepagesz=2M hugepages=128
default_hugepagesz=2M hugepages=128 hugepagesz=1G hugepages=2
hugepages=128 default_hugepagesz=2M hugepagesz=1G hugepages=2
hugepages=2 default_hugepagesz=1G hugepagesz=2M hugepages=128
default_hugepagesz=1G hugepages=2 hugepagesz=2M hugepages=128
default_hugepagesz=2M hugepagesz=2M hugepages=128
default_hugepagesz=2M hugepagesz=1G hugepages=2 hugepagesz=2M hugepages=128

Error or warning
----------------
hugepages=128 hugepagesz=2M hugepages=256
hugepagesz=2M hugepages=128 hugepagesz=2M hugepages=256
default_hugepagesz=2M hugepages=128 hugepagesz=2M hugepages=256
hugepages=128 hugepages=256
hugepagesz=2M hugepages=128 hugepages=2 default_hugepagesz=1G

-- 
Mike Kravetz
