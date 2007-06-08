Return-Path: <linux-kernel-owner+w=401wt.eu-S969113AbXFHQIm@vger.kernel.org>
Message-ID: <46697ED4.3050403@de.ibm.com>
Date: Fri, 08 Jun 2007 18:07:48 +0200
From: Martin Peschke <mp3@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
References: <1181165656.7133.23.camel@dix> <20070606230641.GA11592@elte.hu> <46674EA9.9090601@de.ibm.com> <1181198376.7348.202.camel@twins> <4667ACC3.60009@de.ibm.com> <20070607072720.GA19976@elte.hu>
In-Reply-To: <20070607072720.GA19976@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Ingo Molnar wrote:
> if the infrastructure your are advocating does not allow us to keep the 
> existing output then it's simply not flexible enough.

Let's be precise. If "keep the existing output" means any format change is
unacceptible to you, then I broke things. If it means that my method provides
data equivalent in respect of content, then I didn't break the lock contention
output.

> Why on earth are you even arguing about this?
 > A "cleanup" should not change the output, simple as that.
 > Do a patch that has the _same_ output and then we can
> see whether it's a good patch. You made the same mistake with your 
> /proc/timer_stats cleanups.

We got to be careful here. My other proposal was doomed because timerstat became 
kernel ABI in the meantime. We won't break the kernel ABI. I was late, as simple 
as that.

The lock contention stuff isn't kernel ABI yet. This is -mm code, stuff
intented for a wider audience and discussion. It should be perfectly fine
to scrutinize kernel ABI additions before we get beyond the point of no return.

> I dont like NACK-ing patches but you seem to 
> be missing the basic precondition of cleanups: no functional effect to 
> the code, and certainly no change in output.

I don't see the point of judging something by goals that have not been set.
I have advertised my patches as: same purpose, different or generalised method,
differences in output format, output equivalent in respect of content,
much more code sharing.

Martin
