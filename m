Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC6EC43219
	for <linux-s390@archiver.kernel.org>; Mon,  9 May 2022 07:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiEIHgg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 May 2022 03:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiEIHMm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 May 2022 03:12:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA1E185C86;
        Mon,  9 May 2022 00:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wBYJb025r/PmjnCJ2jgNM6Uu8wmuFqp0g2HraO+Rbss=; b=DvztEdZlncnAAApMh0zkmsqJ5K
        v7XcB/Nhdc1Se73DIYdf4e3R7gJTyb1yfyt0Qs20V+V+zDYYldBS1zKx6kZTt1glnEfoBJH25N2uF
        FEOg6hDS84YylnT7SlSGu2PXmBMApV1fx/M+BDgkE8eiwKMqF5sMTVoRqS/R8s/p9+7RmF/XLArYk
        gdcd4Qt0ngsj/pcnMjnSuqR4PaVEOBkBr7+877T9JEOHFzzcOS9HzeSAW148vcGuQrRHnsvYFdqSP
        17xS97WpxKH32HJPDde+cD4yZwFjlyPFPWWXn4TpcpDXCiYgwUb7hdg+91EVmwSU2PKtF1QtYIS8C
        ve6mOR5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnxVR-00CUSx-NY; Mon, 09 May 2022 07:08:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E258980E93; Mon,  9 May 2022 09:08:31 +0200 (CEST)
Date:   Mon, 9 May 2022 09:08:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] entry: Rename arch_check_user_regs() to
 arch_enter_from_user_mode()
Message-ID: <20220509070831.GD76023@worktop.programming.kicks-ass.net>
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
 <20220504062351.2954280-2-tmricht@linux.ibm.com>
 <YnV3iljKUM0Fqw/F@hirez.programming.kicks-ass.net>
 <yt9dsfpjgrba.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dsfpjgrba.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 09, 2022 at 08:20:41AM +0200, Sven Schnelle wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Wed, May 04, 2022 at 08:23:50AM +0200, Thomas Richter wrote:
> >> From: Sven Schnelle <svens@linux.ibm.com>
> >> 
> >> arch_check_user_regs() is used at the moment to verify that struct pt_regs
> >> contains valid values when entering the kernel from userspace. s390 needs
> >> a place in the generic entry code to modify a cpu data structure when
> >> switching from userspace to kernel mode. As arch_check_user_regs() is
> >> exactly this, rename it to arch_enter_from_user_mode().
> >> 
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Andy Lutomirski <luto@kernel.org>
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> ---
> >
> > With the note that NMI doesn't (necessarily) call this..
> >
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> How about:
> 
> "When entering the kernel from userspace, arch_check_user_regs() is
>  used to verify that struct pt_regs contains valid values. Note that
>  the NMI codepath doesn't call this function. s390 needs a place in the
>  generic entry code to modify a cpu data structure when switching from
>  userspace to kernel mode. As arch_check_user_regs() is exactly this,
>  rename it to arch_enter_from_user_mode()."

Sure, thanks!
