Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
References: 
Date: Tue, 03 Nov 2020 11:54:15 +0100
In-Reply-To: <54c02fa6-8c8a-667f-af99-e83a1f150586 () kernel ! dk> (Jens
        Axboe's message of "Mon, 02 Nov 2020 17:07:33 +0000")
Message-ID: <yt9dsg9q4so8.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Qian Cai <cai@redhat.com>

Jens Axboe <axboe () kernel ! dk> writes:

> On 11/2/20 9:59 AM, Qian Cai wrote:
>> On Sun, 2020-11-01 at 17:31 +0000, Heiko Carstens wrote:
>>> On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
>>>> Wire up TIF_NOTIFY_SIGNAL handling for s390.
>>>>
>>>> Cc: linux-s390@vger.kernel.org
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> 
>> Even though I did confirm that today's linux-next contains this additional patch
>> from Heiko below, a z10 guest is still unable to boot. Reverting the whole
>> series (reverting only "s390: add support for TIF_NOTIFY_SIGNAL" introduced
>> compiling errors) fixed the problem, i.e., git revert --no-edit
>> af0dd809f3d3..7b074c15374c [1]
>
> That's odd, it should build fine without that patch. How did it fail for you?
>
> Can you try and add this on top? Looks like I forgot the signal change for
> s390, though that shouldn't really cause any issues.
>
> diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
> index 9e900a8977bd..a68c3796a1bf 100644
> --- a/arch/s390/kernel/signal.c
> +++ b/arch/s390/kernel/signal.c
> @@ -472,7 +472,7 @@ void do_signal(struct pt_regs *regs)
>  	current->thread.system_call =
>  		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
>  
> -	if (get_signal(&ksig)) {
> +	if (test_thread_flag(TIF_NOTIFY_SIGNAL) && get_signal(&ksig)) {

Shouldn't that be TIF_SIGPENDING?

>  		/* Whee!  Actually deliver the signal.  */
>  		if (current->thread.system_call) {
>  			regs->int_code = current->thread.system_call;
