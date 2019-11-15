Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f180.google.com ([209.85.222.180]:36396 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfKOOzp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 09:55:45 -0500
Date: Fri, 15 Nov 2019 06:55:40 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
Message-ID: <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
 <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 07:26:21PM -0500, Qian Cai wrote:
> 
> 
> > On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> 
> Tejun, suppose you will take this patch via your tree together with the series or should I Cc Andrew who normally handle this file?

Patches in this area usually goes through Jens's block tree.

Thanks.

-- 
tejun
