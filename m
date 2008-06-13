Subject: Re: [RFC PATCH 0/2] Merge HUGETLB_PAGE and HUGETLBFS Kconfig
	options
From: Adam Litke <agl@us.ibm.com>
In-Reply-To: <20080613134629.GD16344@linux-mips.org>
References: <1213296540.17108.8.camel@localhost.localdomain>
	 <20080613134629.GD16344@linux-mips.org>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 10:03:28 -0400
Message-Id: <1213365808.15016.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <agl@us.ibm.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mm <linux-mm@kvack.org>, npiggin@suse.de, nacc@us.ibm.com, mel@csn.ul.ie, Eric B Munson <ebmunson@us.ibm.com>, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linux-mips@linux-mips.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2008-06-13 at 14:46 +0100, Ralf Baechle wrote:
> MIPS doesn't do HUGETLB (at least not in-tree atm) so I'm not sure why
> linux-mips@linux-mips.org was cc'ed at all.  So feel free to add my
> Couldnt-care-less: ack line ;-)

Sorry :)  My patches touched your defconfigs so I felt it prudent to
include the mips list as an FYI.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
