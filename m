Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725841AbgKBVPr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 16:15:47 -0500
Message-ID: <0bd01646f4b429e89359d0618d25f5d6cf92c4f5.camel@redhat.com>
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
From: Qian Cai <cai@redhat.com>
Date: Mon, 02 Nov 2020 16:15:34 -0500
In-Reply-To: <b7b2fa41-fab2-7fd4-f10f-9c352bc9c692@kernel.dk>
References: <20201101173153.GC9375 () osiris>
         <362e3645e2c0891309c07e244a147f0c32f106da.camel@redhat.com>
         <54c02fa6-8c8a-667f-af99-e83a1f150586@kernel.dk>
         <d60d24de6b7c9b948333e4e288452fe0a39d2380.camel@redhat.com>
         <b7b2fa41-fab2-7fd4-f10f-9c352bc9c692@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>

On Mon, 2020-11-02 at 12:50 -0700, Jens Axboe wrote:
> Ah, but that's because later patches assume that TIF_NOTIFY_SIGNAL is
> always there once all archs have been converted. If you just want to back
> out that patch, you'll need to just revert this one:
> 
> commit 82ef6998ed9d488e56bbfbcc2ec9adf62bf78f08
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Oct 9 16:04:39 2020 -0600
> 
>     kernel: remove checking for TIF_NOTIFY_SIGNAL
> 
> as well and I suspect it should build.

No, at the minimal, I'll need to revert those to build successfully.

7b074c15374c io_uring: remove 'twa_signal_ok' deadlock work-around
eb48a0f216fa kernel: remove checking for TIF_NOTIFY_SIGNAL
c634e6b63a81 signal: kill JOBCTL_TASK_WORK
f8b667db31a3 io_uring: JOBCTL_TASK_WORK is no longer used by task_work
4c3d9c3b415a s390: add support for TIF_NOTIFY_SIGNAL

Then, it will fix the boot issue as well.
