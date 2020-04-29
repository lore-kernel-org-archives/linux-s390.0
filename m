Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:11787 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgD2QHf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 12:07:35 -0400
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
Date: Wed, 29 Apr 2020 09:07:13 -0700
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
> If a page is inaccesible and it is used for things like sendfile, then
> the content of the page is not always touched, and can be passed
> directly to a driver, causing issues.
> 
> This patch fixes the issue by adding a call to arch_make_page_accessible
> in page_cache_pipe_buf_confirm; this fixes the issue.

I spent about 5 minutes putting together a patch:

	https://sr71.net/~dave/intel/accessible.patch

It adds a page flag ("daccess") which starts out set.  It clears the
flag it when the page is added to the page cache or mapped as anonymous.
 This are presumably the the two mostly likely kinds of pages to be
problematic.  It re-sets the flag when it hits the new hook for s390:
arch_make_page_accessible().

It then patches the DMA mapping API.  If a page gets to the DMA mapping
API without being accessible, it hits a tracepoint.

It goes boom shortly after hitting userspace underneath a sys_sendto().
 That code uses lib/iov_iter.c which does get_user_pages_fast() and
apparently does not set FOLL_PIN, so never hits the s390 arch hooks.

I hacked out the FOLL_PIN check and just universally call the hook for
all gup_pte_range() calls.  I think you'll need to do that as well.  I
don't think the assumptions about FOLL_PIN always preceding I/O is true
universally.  Hacking out FOLL_PIN quiets down the warning spew quite a
bit, but it still hits a few of them.

Here's one example:

 0)  sd-reso-410   |               |  /* mm_accessible_error: ...
      sd-resolve-410   [000] ....   212.918838: <stack trace>
 => trace_event_raw_event_mm_accessible_error
 => check_page_accessible
 => e1000_xmit_frame
 => dev_hard_start_xmit
 => sch_direct_xmit
 => __qdisc_run
 => __dev_queue_xmit
 => ip_finish_output2
 => ip_output
 => ip_send_skb
 => udp_send_skb.isra.59
 => udp_sendmsg
 => ____sys_sendmsg
 => ___sys_sendmsg
 => __sys_sendmmsg
 => __x64_sys_sendmmsg
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

This is just from booting and sitting on an idle Ubuntu 16.04.6 system.
 I think the process in question here is the systemd resolver.
