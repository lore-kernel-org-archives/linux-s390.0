From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Rename is_compat_task to in_compat_syscall
Date: Tue, 19 Jan 2016 17:16:43 -0500 (EST)
Message-ID: <20160119.171643.1125867148856105860.davem@davemloft.net>
References: <79347eb4ec12be34098b36693bcf613eb597cbe9.1453239942.git.luto@kernel.org>
	<20160119215535.GU17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160119215535.GU17997@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: luto@kernel.org, torvalds@linux-foundation.org, mingo@kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 19 Jan 2016 21:55:36 +0000

> On Tue, Jan 19, 2016 at 01:47:24PM -0800, Andy Lutomirski wrote:
>> Essentially all users of is_compat_task in the kernel are trying to
>> determine whether they are executing in the context of a compat
>> syscall.  On at least x86_64 and sparc, these are not at all the
>> same question.
>> 
>> On x86_64 and sparc, therefore, is_compat_task doesn't return the
>> overall compat state of the task; it returns true if the task is
>> currently in a compat syscall.
> 
> The hell it does.  Andy, TIF_32BIT is *NOT* set on syscall entry; it is
> set by execve().  And 64bit task (with that bit clear) can bloody well
> issue 32bit syscalls.  Really.

Correct.
