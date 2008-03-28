Return-Path: <linux-kernel-owner+w=401wt.eu-S1755260AbYC1OIS@vger.kernel.org>
Date: Fri, 28 Mar 2008 15:06:34 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 09/10] Hugetlb common code update for System z.
Message-ID: <20080328140634.GA29218@elte.hu>
References: <20080312173155.703966894@de.ibm.com> <20080312173218.186436562@de.ibm.com> <1205344286.9828.91.camel@nimitz.home.sr71.net> <1205363937.5237.60.camel@localhost.localdomain> <20080312164303.cac9cab5.akpm@linux-foundation.org> <1206713119.5186.52.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1206713119.5186.52.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, haveblue@us.ibm.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>


* Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

>  include/asm-sh/hugetlb.h      |   28 +++++++++++++++++++++++++
>  include/asm-sparc64/hugetlb.h |   30 +++++++++++++++++++++++++++
>  include/asm-x86/hugetlb.h     |   28 +++++++++++++++++++++++++

these seem largely duplicated - shouldnt there be an 
asm-generic/hugetlb.h instead, which asm/hugetlb.h could include to get 
default behavior? It would probably reduce the linecount of your patch 
as well.

	Ingo
