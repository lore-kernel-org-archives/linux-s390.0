From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 26 Jun 2014 08:46:37 +0000
Subject: Re: [RFH][BROKEN PATCH] s390: ftrace: Remove check of obsolete variable function_trace_stop
Message-Id: <20140626084637.GA4259@osiris>
In-Reply-To: <20140625145523.250c9c2e@gandalf.local.home>
References: <20140625145523.250c9c2e@gandalf.local.home>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jun 25, 2014 at 02:55:23PM -0400, Steven Rostedt wrote:
> 
> function_trace_stop is becoming obsolete and archs should no longer be
> checking if it is zero or not to perform function tracing. I was able
> to figure out how to remove this from all the archs BUT s390, which is
> why I'm posting this "Request For Help" email.
> 
> All I want to do is remove any checks to function_trace_stop in the
> mcount code. I haven't the foggiest idea on how to change the s390 code
> to do this. I made a horrible attempt (attached below) and I now would
> like someone to do it right for me :-)
> 
> If you can send me a patch (author it and add your sign off by), I'll
> add it to my queue of patches to remove this variable.
> 
> Thanks!

Hi Steven,

the patch below should do what you want:
