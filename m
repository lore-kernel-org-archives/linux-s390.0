Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29203 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2440401AbgDNP2F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 11:28:05 -0400
Received: by mail-qv1-f70.google.com with SMTP id p6so93444qvo.18
        for <linux-s390@vger.kernel.org>; Tue, 14 Apr 2020 08:28:00 -0700 (PDT)
Date: Tue, 14 Apr 2020 11:27:56 -0400
From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 4/4] hugetlbfs: clean up command line processing
Message-ID: <20200414152756.GG38470@xz-x1>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-5-mike.kravetz@oracle.com>
 <20200410203730.GG3172@xz-x1>
 <ce42fa12-023b-7ed2-a60e-7dbf9c530981@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce42fa12-023b-7ed2-a60e-7dbf9c530981@oracle.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Mina Almasry <almasrymina@google.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Apr 13, 2020 at 10:59:26AM -0700, Mike Kravetz wrote:
> On 4/10/20 1:37 PM, Peter Xu wrote:
> > On Wed, Apr 01, 2020 at 11:38:19AM -0700, Mike Kravetz wrote:
> >> With all hugetlb page processing done in a single file clean up code.
> >> - Make code match desired semantics
> >>   - Update documentation with semantics
> >> - Make all warnings and errors messages start with 'HugeTLB:'.
> >> - Consistently name command line parsing routines.
> >> - Check for hugepages_supported() before processing parameters.
> >> - Add comments to code
> >>   - Describe some of the subtle interactions
> >>   - Describe semantics of command line arguments
> >>
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         | 35 ++++---
> >>  Documentation/admin-guide/mm/hugetlbpage.rst  | 44 +++++++++
> >>  mm/hugetlb.c                                  | 96 +++++++++++++++----
> >>  3 files changed, 142 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index 1bd5454b5e5f..de653cfe1726 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -832,12 +832,15 @@
> >>  			See also Documentation/networking/decnet.txt.
> >>  
> >>  	default_hugepagesz=
> >> -			[same as hugepagesz=] The size of the default
> >> -			HugeTLB page size. This is the size represented by
> >> -			the legacy /proc/ hugepages APIs, used for SHM, and
> >> -			default size when mounting hugetlbfs filesystems.
> >> -			Defaults to the default architecture's huge page size
> >> -			if not specified.
> >> +			[HW] The size of the default HugeTLB page size. This
> > 
> > Could I ask what's "HW"?  Sorry this is not a comment at all but
> > really a pure question I wanted to ask... :)
> 
> kernel-parameters.rst includes kernel-parameters.txt and included the meaning
> for these codes.
> 
>        HW      Appropriate hardware is enabled.
> 
> Previously, it listed an obsolete list of architectures.

I see. It was a bit confusing since hugepage is not a real hardware,
"CAP (capability)" might be easier, but I get the point now, thanks!

[...]

> >> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> >> index 1cc0bc78d10e..de340c586995 100644
> >> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> >> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> >> @@ -100,6 +100,50 @@ with a huge page size selection parameter "hugepagesz=<size>".  <size> must
> >>  be specified in bytes with optional scale suffix [kKmMgG].  The default huge
> >>  page size may be selected with the "default_hugepagesz=<size>" boot parameter.
> >>  
> >> +Hugetlb boot command line parameter semantics
> >> +hugepagesz - Specify a huge page size.  Used in conjunction with hugepages
> >> +	parameter to preallocate a number of huge pages of the specified
> >> +	size.  Hence, hugepagesz and hugepages are typically specified in
> >> +	pairs such as:
> >> +		hugepagesz=2M hugepages=512
> >> +	hugepagesz can only be specified once on the command line for a
> >> +	specific huge page size.  Valid huge page sizes are architecture
> >> +	dependent.
> >> +hugepages - Specify the number of huge pages to preallocate.  This typically
> >> +	follows a valid hugepagesz parameter.  However, if hugepages is the
> >> +	first or only hugetlb command line parameter it specifies the number
> >> +	of huge pages of default size to allocate.  The number of huge pages
> >> +	of default size specified in this manner can be overwritten by a
> >> +	hugepagesz,hugepages parameter pair for the default size.
> >> +	For example, on an architecture with 2M default huge page size:
> >> +		hugepages=256 hugepagesz=2M hugepages=512
> >> +	will result in 512 2M huge pages being allocated.  If a hugepages
> >> +	parameter is preceded by an invalid hugepagesz parameter, it will
> >> +	be ignored.
> >> +default_hugepagesz - Specify the default huge page size.  This parameter can
> >> +	only be specified once on the command line.  No other hugetlb command
> >> +	line parameter is associated with default_hugepagesz.  Therefore, it
> >> +	can appear anywhere on the command line.  If hugepages= is the first
> >> +	hugetlb command line parameter, the specified number of huge pages
> >> +	will apply to the default huge page size specified with
> >> +	default_hugepagesz.  For example,
> >> +		hugepages=512 default_hugepagesz=2M
> > 
> > No strong opinion, but considering to the special case of gigantic
> > huge page mentioned below, I'm thinking maybe it's easier to just ask
> > the user to always use "hugepagesz=X hugepages=Y" pair when people
> > want to reserve huge pages.
> 
> We can ask people to do this.  However, I do not think we can force it at
> this time.  Why?  Mostly because I have seen many instances where people
> only specify 'hugepages=X' on the command line to preallocate X huge pages
> of default size.  So, forcing 'hugepagesz=X hugepages=Y' would break those
> users.
> 
> > For example, some user might start to use this after this series
> > legally:
> > 
> >     default_hugepagesz=2M hugepages=1024
> 
> Well, that 'works' today.  You get that silly error message:
> 
> HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152
> 
> But, it does preallocate 1024 huge pages of size 2M.  Because people
> have noticed the silly error message, I suspect this usage,
> 
> 	default_hugepagesz=X hugepages=Y
> 
> is in use today and we need to support it.

Fair enough.

[...]

> >> @@ -3209,19 +3209,35 @@ static int __init hugetlb_init(void)
> >>  	if (!hugepages_supported())
> >>  		return 0;
> >>  
> >> -	if (!size_to_hstate(default_hstate_size)) {
> >> -		if (default_hstate_size != 0) {
> >> -			pr_err("HugeTLB: unsupported default_hugepagesz %lu. Reverting to %lu\n",
> >> -			       default_hstate_size, HPAGE_SIZE);
> >> -		}
> >> -
> >> +	/*
> >> +	 * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
> >> +	 * architectures depend on setup being done here.
> >> +	 *
> >> +	 * If a valid default huge page size was specified on the command line,
> >> +	 * add associated hstate if necessary.  If not, set default_hstate_size
> >> +	 * to default size.  default_hstate_idx is used at runtime to identify
> >> +	 * the default huge page size/hstate.
> >> +	 */
> >> +	hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
> >> +	if (default_hstate_size)
> >> +		hugetlb_add_hstate(ilog2(default_hstate_size) - PAGE_SHIFT);
> >> +	else
> >>  		default_hstate_size = HPAGE_SIZE;
> >> -		hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
> >> -	}
> >>  	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_size));
> >> +
> >> +	/*
> >> +	 * default_hstate_max_huge_pages != 0 indicates a count (hugepages=)
> >> +	 * specified before a size (hugepagesz=).  Use this count for the
> >> +	 * default huge page size, unless a specific value was specified for
> >> +	 * this size in a hugepagesz/hugepages pair.
> >> +	 */
> >>  	if (default_hstate_max_huge_pages) {
> > 
> > Since we're refactoring this - Could default_hstate_max_huge_pages be
> > dropped directly (in hugepages= we can create the default hstate, then
> > we set max_huge_pages of the default hstate there)?  Or did I miss
> > anything important?
> 
> I do not think that works for 'hugepages=X default_hugepagesz=Y' processing?
> It seems like there will need to be more work done on default_hugepagesz
> processing.

That was really an awkward kernel cmdline... But I guess you're right.

I think it awkward because it can be also read in sequence as "reserve
X huge pages of default huge page size, then change default value to
Y".  So instead of awkward, maybe "ambiguous".  However I have totally
no clue on how to make this better either - there's really quite a lot
of freedom right now on specifying all these options right now.

Thanks,

-- 
Peter Xu
