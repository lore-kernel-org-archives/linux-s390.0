From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] Revert "tools include s390: Grab a copy of
 arch/s390/include/uapi/asm/unistd.h"
Date: Thu, 15 Feb 2018 14:37:55 +0100
Message-ID: <20180215133755.GA4491@linux.vnet.ibm.com>
References: <1518090470-2899-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1518090470-2899-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <20180215130535.GA22818@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180215130535.GA22818@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 15, 2018 at 10:05:35AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 08, 2018 at 12:47:48PM +0100, Hendrik Brueckner escreveu:
> > This reverts commit f120c7b187e6c418238710b48723ce141f467543 which is no
> > longer required with the introduction of a syscall.tbl on s390.
> 
> I'm applying this now, but putting this 1/3 patch, i.e. the first in
> this series, to be the last, as only after applying "perf s390: Rework
> system call table creation by using syscall.tbl" is that we can remove
> the unistd.h copy, right?

Correct.  After patches 2 and 3, the unistd.h copy is no longer used.

Thanks for that reordering.

- Hendrik
