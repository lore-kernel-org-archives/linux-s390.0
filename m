Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 13 Jun 2016 18:29:14 +0200
From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] s390/oprofile: Remove deprecated create_workqueue
Message-ID: <20160613162914.GK25086@rric.localdomain>
References: <20160607215912.GA19722@Karyakshetra>
 <20160609090056.GC3250@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160609090056.GC3250@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tejun Heo <tj@kernel.org>, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Andreas Arnez <arnez@linux.vnet.ibm.com>, William Cohen <wcohen@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Heiko,

On 09.06.16 11:00:56, Heiko Carstens wrote:
> However I'm wondering if we shouldn't simply remove at least the s390
> specific hwswampler code from the oprofile module. This would still leave
> the common code timer based sampling mode for oprofile working on s390.
> 
> It looks like the oprofile user space utility nowadays (since 2012) uses
> the kernel perf interface instead of the oprofile interface anyway, if
> present. So the oprofile module itself doesn't seem to have too many users
> left.
> 
> Any opinions?

yes, the kernel driver is not necessary for oprofile userland for a
while now. There is no ongoing development any longer, most patches
are due to changes in the kernel apis.

So if there is code that needs a larger rework due to other kernel
changes and there is no user anymore, I am fine with removing the code
instead of reworking it. I still would just keep existing code as long
as we can keep it unchanged (some like the lightwight of oprofile,
esp. in the embedded space). If there is a user of the code, a
Tested-by would be good for new code changes.

If there are users of the hwswampler, speak up now. Else, let's just
remove it.

-Robert
