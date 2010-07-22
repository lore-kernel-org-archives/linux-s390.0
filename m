From: Michal Simek <michal.simek@petalogix.com>
Subject: Re: [PATCH wq#for-next] workqueue: fix how cpu number is stored in
 work->data
Date: Thu, 22 Jul 2010 22:13:27 +0200
Message-ID: <4C48A667.2000702@petalogix.com>
References: <4C46CEA3.7040503@in.ibm.com>	<4C4718D5.1080902@kernel.org> <20100722112557.14b65077@mschwide.boeblingen.de.ibm.com> <4C4838B8.1080400@kernel.org>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4C4838B8.1080400@kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Tejun Heo wrote:
> Once a work starts execution, its data contains the cpu number it was
> on instead of pointing to cwq.  This is added by commit 7a22ad75
> (workqueue: carry cpu number in work data once execution starts) to
> reliably determine the work was last on even if the workqueue itself
> was destroyed inbetween.
> 
> Whether data points to a cwq or contains a cpu number was
> distinguished by comparing the value against PAGE_OFFSET.  The
> assumption was that a cpu number should be below PAGE_OFFSET while a
> pointer to cwq should be above it.  However, on architectures which
> use separate address spaces for user and kernel spaces, this doesn't
> hold as PAGE_OFFSET is zero.
> 
> Fix it by using an explicit flag, WORK_STRUCT_CWQ, to mark what the
> data field contains.  If the flag is set, it's pointing to a cwq;
> otherwise, it contains a cpu number.
> 
> Reported on s390 and microblaze during linux-next testing.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Sachin Sant <sachinp@in.ibm.com>
> Reported-by: Michal Simek <michal.simek@petalogix.com>
> Reported-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> Yeah, that was a stupid assumption by me.  Can you guys please test
> whether this fixes the problem?
> 
> Thanks.

Microblaze is OK.

Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
