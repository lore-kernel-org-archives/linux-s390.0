Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2064 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgD2AZR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 20:25:17 -0400
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <42cda753-a5df-9024-9076-11d75eec16c1@intel.com>
Date: Tue, 28 Apr 2020 17:25:16 -0700
MIME-Version: 1.0
In-Reply-To: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org, sean.j.christopherson@intel.com

On 4/28/20 3:50 PM, Claudio Imbrenda wrote:
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -106,6 +106,9 @@ static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
>  	struct page *page = buf->page;
>  	int err;
>  
> +	if (arch_make_page_accessible(page))
> +		return -EIO;
> +
>  	if (!PageUptodate(page)) {
>  		lock_page(page);

This is a cute fix, but doesn't it 100% depend on the internal
implementation detail of page cache sendfile() being implemented with a
pipe?  Depending on that seems rather fragile.  While I'm glad that you
surgically plugged the one single, specific case that I pointed out, I
can't help but suspect there are more of these.

For instance, I tried a file-to-file sendfile, basically:

	fd1 = open("file1");
	fd2 = open("file2");
	sendfile(fd1, fd2, ...);

ftrace showed page_cache_pipe_buf_confirm() getting called for the
source pipe pages but not the receiver.  There were no calls to
arch_make_page_accessible() outside of page_cache_pipe_buf_confirm() (I
put a stub in for it on x86 so I could trace it).

That indicates to me that one side of this might be fixed (the sender),
but the receiver is not.

This also doesn't even have the maintainer of fs/splice.c on cc.  The
changelog about what this is trying to do probably also lacks enough
context to bring Al up to speed about what this is trying to do.
