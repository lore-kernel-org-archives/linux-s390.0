Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgFPNZK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 09:25:10 -0400
Date: Tue, 16 Jun 2020 15:24:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: fix syscall_get_error for compat processes
Message-ID: <20200616132457.GA4166@osiris>
References: <20200602180051.GA2427@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602180051.GA2427@altlinux.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <evgsyr@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 09:00:51PM +0300, Dmitry V. Levin wrote:
> If both the tracer and the tracee are compat processes, and gprs[2]
> is assigned a value by __poke_user_compat, then the higher 32 bits
> of gprs[2] are cleared, IS_ERR_VALUE() always returns false, and
> syscall_get_error() always returns 0.
> 
> Fix the implementation by sign-extending the value for compat processes
> the same way as x86 implementation does.
> 
> The bug was exposed to user space by commit 201766a20e30f ("ptrace: add
> PTRACE_GET_SYSCALL_INFO request") and detected by strace test suite.
> 
> This change fixes strace syscall tampering on s390.
> 
> Fixes: 753c4dd6a2fa2 ("[S390] ptrace changes")
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: stable@vger.kernel.org # v2.6.28+
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/s390/include/asm/syscall.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thank you!
