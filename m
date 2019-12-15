Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44774 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfLOTQB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 15 Dec 2019 14:16:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so3487451plb.11
        for <linux-s390@vger.kernel.org>; Sun, 15 Dec 2019 11:16:01 -0800 (PST)
Date: Sun, 15 Dec 2019 11:15:58 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net] net/smc: add fallback check to connect()
Message-ID: <20191215111558.57dfdcf9@cakuba.netronome.com>
In-Reply-To: <20191212213558.10564-1-kgraul@linux.ibm.com>
References: <20191212213558.10564-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Thu, 12 Dec 2019 22:35:58 +0100, Karsten Graul wrote:
> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> FASTOPEN setsockopt() or sendmsg() may switch the SMC socket to fallback
> mode. Once fallback mode is active, the native TCP socket functions are
> called. Nevertheless there is a small race window, when FASTOPEN
> setsockopt/sendmsg runs in parallel to a connect(), and switch the
> socket into fallback mode before connect() takes the sock lock.
> Make sure the SMC-specific connect setup is omitted in this case.
> 
> This way a syzbot-reported refcount problem is fixed, triggered by
> different threads running non-blocking connect() and FASTOPEN_KEY
> setsockopt.
> 
> Reported-by: syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com
> Fixes: 6d6dd528d5af ("net/smc: fix refcount non-blocking connect() -part 2")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied, and queued for stable, thank you!
