Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6845A524F;
	Tue, 11 Feb 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278946; cv=none; b=M1MHakSm+mLyx6cXa5kBvd0GdgwySN1kmrTjFBzLrNCsDXQMRu1LuygRnIfkV2dPQAYL1EV1p7fmn5NlVNtaJmSzYIu3AmV2SWN/yR9bpPl5xyZwwAqgNUunc0yvqYZ8W2xD2ItZTBGXYKEtmgjBHowqmPbqAU9RNB6cKDzzPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278946; c=relaxed/simple;
	bh=UIT3nL8T6WZ83CAtmo+44fcUifKFuxa829u+1ScYy5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKJ9y6Lwi7yF9bKStg5nKtKpR+2hPdhqCdlZ07SBT3jTZZAHFrQBWgANLrAAMxuq4Im799vijBC/zuqXBUGhoSl2LgkSVufGn0IvyOnbVKi3bZGPObb8BWGZQvgDfZhxvkAR3xQCRiwut7Ez/Ov8H78wzwCSpeEv3S6wlN5LhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 45B7572C8CC;
	Tue, 11 Feb 2025 16:02:17 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 1F4537CCB3A; Tue, 11 Feb 2025 15:02:17 +0200 (IST)
Date: Tue, 11 Feb 2025 15:02:17 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Sven Schnelle <svens@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	strace-devel@lists.strace.io, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
Message-ID: <20250211130216.GA13417@strace.io>
References: <20250204151420.GA30282@strace.io>
 <yt9d8qqkyd43.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9d8qqkyd43.fsf@linux.ibm.com>

On Wed, Feb 05, 2025 at 10:06:36AM +0100, Sven Schnelle wrote:
> "Dmitry V. Levin" <ldv@strace.io> writes:
> > On Mon, Feb 03, 2025 at 12:35:42PM +0200, Dmitry V. Levin wrote:
> >> On Mon, Feb 03, 2025 at 10:29:37AM +0100, Alexander Gordeev wrote:
> >> > On Mon, Feb 03, 2025 at 08:58:49AM +0200, Dmitry V. Levin wrote:
> >> > 
> >> > Hi Dmitry,
> >> > 
> >> > > PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> >> > > PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
> >> > > system calls the tracee is blocked in.
> >> > ...
> >> > 
> >> > FWIW, I am getting these on s390:
> >> > 
> >> > # ./tools/testing/selftests/ptrace/set_syscall_info 
> >> > TAP version 13
> >> > 1..1
> >> > # Starting 1 tests from 1 test cases.
> >> > #  RUN           global.set_syscall_info ...
> >> > # set_syscall_info.c:87:set_syscall_info:Expected exp_entry->nr (-1) == info->entry.nr (65535)
> >> > # set_syscall_info.c:88:set_syscall_info:wait #3: PTRACE_GET_SYSCALL_INFO #2: syscall nr mismatch
> >> > # set_syscall_info: Test terminated by assertion
> >> > #          FAIL  global.set_syscall_info
> >> > not ok 1 global.set_syscall_info
> >> > # FAILED: 0 / 1 tests passed.
> >> > # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> >> > 
> >> > I remember one of the earlier versions (v1 or v2) was working for me.
> >> > 
> >> > Thanks!
> >> 
> >> In v3, this test was extended to check whether PTRACE_GET_SYSCALL_INFO
> >> called immediately after PTRACE_SET_SYSCALL_INFO returns the same syscall
> >> number, and on s390 it apparently doesn't, thanks to its implementation
> >> of syscall_get_nr() that returns 0xffff in this case.
> >> 
> >> To workaround this, we could either change syscall_get_nr() to return -1
> >> in this case, or add an #ifdef __s390x__ exception to the test.
> >> 
> >> What would you prefer?
> >
> > OK, I'm going to apply the following s390 workaround to the test:
> >
> > diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/testing/selftests/ptrace/set_syscall_info.c
> > index 0ec69401c008..4198248ef874 100644
> > --- a/tools/testing/selftests/ptrace/set_syscall_info.c
> > +++ b/tools/testing/selftests/ptrace/set_syscall_info.c
> > @@ -71,6 +71,11 @@ check_psi_entry(struct __test_metadata *_metadata,
> >  		const char *text)
> >  {
> >  	unsigned int i;
> > +	int exp_nr = exp_entry->nr;
> > +#if defined __s390__ || defined __s390x__
> > +	/* s390 is the only architecture that has 16-bit syscall numbers */
> > +	exp_nr &= 0xffff;
> > +#endif
> >  
> >  	ASSERT_EQ(PTRACE_SYSCALL_INFO_ENTRY, info->op) {
> >  		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
> > @@ -84,7 +89,7 @@ check_psi_entry(struct __test_metadata *_metadata,
> >  	ASSERT_TRUE(info->stack_pointer) {
> >  		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
> >  	}
> > -	ASSERT_EQ(exp_entry->nr, info->entry.nr) {
> > +	ASSERT_EQ(exp_nr, info->entry.nr) {
> >  		LOG_KILL_TRACEE("%s: syscall nr mismatch", text);
> >  	}
> >  	for (i = 0; i < ARRAY_SIZE(exp_entry->args); ++i) {
> 
> Fine with me. As you already noted only 16 bit of the syscall number is
> stored in pt_regs::int_code. A quick hack would be possible to do sign
> extensions, so -1 would work. But i think this would be odd, because
> positive numbers would still be limited.
> 
> So i think the patch you proposed is fine.

Thanks, I've applied this workaround in v5:
https://lore.kernel.org/all/20250210113336.GA887@strace.io/

Please consider adding your Reviewed-by.


-- 
ldv
