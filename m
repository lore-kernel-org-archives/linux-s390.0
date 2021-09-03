Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58AC433EF
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 23:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D676108E
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 23:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350731AbhICXZD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 19:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242236AbhICXZD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 3 Sep 2021 19:25:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17D4460FDC;
        Fri,  3 Sep 2021 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630711442;
        bh=ACCxEolEsBare+4plIWhMemWYTJcclcvIZOrthMVAZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ie3jZOjuQEegdSKsBXeNP5mzCP/oy8RYbKJ5vBRRmJm+QfeUjlJSH3cddq8ab3rHo
         kSmBI4RG6QnRyRXHSlMZM8LKOEsqwguAJVlVmDWW6bmJf+l9xQDcXhLbD/BHMJ83XJ
         /8O76OQD9aTe5HEnuryBrnaihzGJK2YqtC8sLa/JWme4EnelJw2BLEotA6u8DazbtZ
         VVC2JVoJWToAipnbGm4fhzvj9o31hI3EFZ02HUgVx18FaphDOUE1/HuhXgLdUAd1ID
         4NGr2R3r6khQI7pCGjl8l3pip8BVD85J0Iz+8GyIPKZpnZ4FVO5ncUcy8z9/bKtRQW
         muZk9jPiHkFXw==
Date:   Fri, 3 Sep 2021 16:23:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Marco Elver <elver@google.com>, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH] s390/unwind: use current_frame_address() to unwind
 current task
Message-ID: <YTKuj0Bu0CJRKqU7@Ryzen-9-3900X.localdomain>
References: <your-ad-here.call-01630505035-ext-2999@work.hours>
 <patch.git-04dd26be3043.your-ad-here.call-01630504868-ext-6188@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch.git-04dd26be3043.your-ad-here.call-01630504868-ext-6188@work.hours>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 01, 2021 at 04:05:59PM +0200, Vasily Gorbik wrote:
> current_stack_pointer() simply returns current value of %r15. If
> current_stack_pointer() caller allocates stack (which is the case in
> unwind code) %r15 points to a stack frame allocated for callees, meaning
> current_stack_pointer() caller (e.g. stack_trace_save) will end up in
> the stacktrace. This is not expected by stack_trace_save*() callers and
> causes problems.
> 
> current_frame_address() on the other hand returns function stack frame
> address, which matches %r15 upon function invocation. Using it in
> get_stack_pointer() makes it more aligned with x86 implementation
> (according to BACKTRACE_SELF_TEST output) and meets stack_trace_save*()
> caller's expectations, notably KCSAN.
> 
> Also make sure unwind_start is always inlined.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Sorry for the late response and I see that this has already been applied
but I took this for a spin and all of the tests pass with clang-14 in
QEMU. Thank you for the quick fix so that we can get this turned on in
CI :)

[   10.362073]     ok 1 - test_basic
[   13.870386]     ok 2 - test_concurrent_races
[   17.379643]     ok 3 - test_novalue_change
[   17.393315]     ok 4 - test_novalue_change_exception
[   17.409815]     ok 5 - test_unknown_origin
[   20.914289]     ok 6 - test_write_write_assume_atomic
[   20.982545]     ok 7 - test_write_write_struct
[   21.106135]     ok 8 - test_write_write_struct_part
[   24.622205]     ok 9 - test_read_atomic_write_atomic
[   24.662048]     ok 10 - test_read_plain_atomic_write
[   24.775291]     ok 11 - test_read_plain_atomic_rmw
[   28.294457]     ok 12 - test_zero_size_access
[   31.829529]     ok 13 - test_data_race
[   31.867174]     ok 14 - test_assert_exclusive_writer
[   31.929184]     ok 15 - test_assert_exclusive_access
[   35.446281]     ok 16 - test_assert_exclusive_access_writer
[   35.540228]     ok 17 - test_assert_exclusive_bits_change
[   39.052271]     ok 18 - test_assert_exclusive_bits_nochange
[   39.097020]     ok 19 - test_assert_exclusive_writer_scoped
[   39.152914]     ok 20 - test_assert_exclusive_access_scoped
[   42.675158]     ok 21 - test_jiffies_noreport
[   46.192453]     ok 22 - test_seqlock_noreport
[   49.712712]     ok 23 - test_atomic_builtins
[   49.746428]     ok 24 - test_1bit_value_change
[   49.753316] ok 1 - kcsan

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/s390/include/asm/stacktrace.h | 20 ++++++++++----------
>  arch/s390/include/asm/unwind.h     |  8 ++++----
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
> index 3d8a4b94c620..22c41d7fd95c 100644
> --- a/arch/s390/include/asm/stacktrace.h
> +++ b/arch/s390/include/asm/stacktrace.h
> @@ -34,16 +34,6 @@ static inline bool on_stack(struct stack_info *info,
>  	return addr >= info->begin && addr + len <= info->end;
>  }
>  
> -static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
> -						       struct pt_regs *regs)
> -{
> -	if (regs)
> -		return (unsigned long) kernel_stack_pointer(regs);
> -	if (task == current)
> -		return current_stack_pointer();
> -	return (unsigned long) task->thread.ksp;
> -}
> -
>  /*
>   * Stack layout of a C stack frame.
>   */
> @@ -74,6 +64,16 @@ struct stack_frame {
>  	((unsigned long)__builtin_frame_address(0) -			\
>  	 offsetof(struct stack_frame, back_chain))
>  
> +static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
> +						       struct pt_regs *regs)
> +{
> +	if (regs)
> +		return (unsigned long) kernel_stack_pointer(regs);
> +	if (task == current)
> +		return current_frame_address();
> +	return (unsigned long) task->thread.ksp;
> +}
> +
>  /*
>   * To keep this simple mark register 2-6 as being changed (volatile)
>   * by the called function, even though register 6 is saved/nonvolatile.
> diff --git a/arch/s390/include/asm/unwind.h b/arch/s390/include/asm/unwind.h
> index de9006b0cfeb..5ebf534ef753 100644
> --- a/arch/s390/include/asm/unwind.h
> +++ b/arch/s390/include/asm/unwind.h
> @@ -55,10 +55,10 @@ static inline bool unwind_error(struct unwind_state *state)
>  	return state->error;
>  }
>  
> -static inline void unwind_start(struct unwind_state *state,
> -				struct task_struct *task,
> -				struct pt_regs *regs,
> -				unsigned long first_frame)
> +static __always_inline void unwind_start(struct unwind_state *state,
> +					 struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 unsigned long first_frame)
>  {
>  	task = task ?: current;
>  	first_frame = first_frame ?: get_stack_pointer(task, regs);
> -- 
> 2.25.4
