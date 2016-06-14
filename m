From: Waiman Long <waiman.long@hpe.com>
Subject: Re: [RFC PATCH-tip 2/6] locking/rwsem: Enable optional count-based
	spinning on reader
Date: Tue, 14 Jun 2016 15:11:23 -0400
Message-ID: <576056DB.5050701@hpe.com>
References: <1465927959-39719-1-git-send-email-Waiman.Long@hpe.com>
	<1465927959-39719-3-git-send-email-Waiman.Long@hpe.com>
	<20160614182757.GA15903@linux-80c1.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
In-Reply-To: <20160614182757.GA15903@linux-80c1.suse>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, Scott J Norton <scott.norton@hpe.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, xfs@oss.sgi.com, Ingo Molnar <mingo@redhat.com>, linux-alpha@vger.kernel.org, Douglas Hatch <doug.hatch@hpe.com>, Jason Low <jason.low2@hp.com>
List-ID: <linux-s390.vger.kernel.org>

On 06/14/2016 02:27 PM, Davidlohr Bueso wrote:
> On Tue, 14 Jun 2016, Waiman Long wrote:
>
>> This patch provides a way for the kernel code to designate specific
>> rwsems to be more aggressive in term of optimistic spinning that the
>> writers will continue to spin for some additional count-based time to
>> see if it can get the lock before sleeping. This aggressive spinning
>> mode should only be used on rwsems where the readers are unlikely to
>> go to sleep.
>
> Yikes, exposing this sort of thing makes me _very_ uneasy, not to mention
> the ad-hoc nature and its easiness to mess up. I'm not really for 
> this, even
> if it shows extraordinary performance boosts on benchmarks.
>
> Thanks,
> Davidlohr

I understand your concern. I will see if there is a way to autotune 
instead of using explicit enablement.

Cheers,
Longman

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
