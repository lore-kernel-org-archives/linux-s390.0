Return-Path: <hch@lst.de>
Date: Thu, 18 May 2017 10:22:01 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/9] kthread: remove unused macros
Message-ID: <20170518082201.GA3812@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-4-hch@lst.de> <20170517120952.GB7297@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170517120952.GB7297@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>, Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 17, 2017 at 02:09:52PM +0200, Petr Mladek wrote:
> On Tue 2017-05-16 13:48:06, Christoph Hellwig wrote:
> > KTHREAD_DELAYED_WORK_INIT and DEFINE_KTHREAD_DELAYED_WORK are unused
> > and are using a timer helper that's about to go away.
> 
> A patch using this API is flying around, see
> https://lkml.kernel.org/r/1476715742-14924-1-git-send-email-pmladek@suse.com
> And I have one more, for hung_task.c, in the drawer.
> 
> I admit that I got sidetracked and did not push these conversions
> last months. But the conversions are useful and I want to continue
> or find a trainee that might continue.
> 
> I wanted to make your life easier, took inspiration from the
> workqueues conversion and prepared the patch below. It is tested
> with the above mentioned API user.
> 
> Please, let me known if you would prefer another approach.
> I do not want to complicate development of the new timer API.

Thanks, I'll add your patch to the series.  I just have a tendency to
remove unused bits instead of trying to fix them up without being able
to test the result.
