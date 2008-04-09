Return-Path: <linux-kernel-owner+w=401wt.eu-S1755431AbYDILhQ@vger.kernel.org>
Subject: Re: [PATCH 1/3] hugetlbfs: architecture header cleanup
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080407205906.25bd06c6.akpm@linux-foundation.org>
References: <1207327534.4605.18.camel@localhost.localdomain>
	 <1207327790.4605.21.camel@localhost.localdomain>
	 <20080407205906.25bd06c6.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 13:35:55 +0200
Message-Id: <1207740955.878.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-04-07 at 20:59 -0700, Andrew Morton wrote: 
> Seem that git-s390 is currently carrying the old versions of these patches.
> 
> I'll drop git-s390.  Which will presumably kick off a cascade of droppages
> due to git-s390 versus git-kvm damage control.  All of which will need to
> be undropped in some fashion when those trees come to their senses.  Ho
> hum.

Yes, git-s390 wasn't updated for a few days. I've dropped all the
hugetlbfs patches since the version we will push upstream depends on the
cleanup which will go in over -mm. I keep the fingers crossed that the
git-s390 now works again.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
