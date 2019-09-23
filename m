Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:50744 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407253AbfIWJtQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 05:49:16 -0400
Date: Mon, 23 Sep 2019 11:49:16 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] seccomp: remove unused arg from secure_computing()
Message-ID: <20190923094916.GB15355@zn.tnic>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920131907.6886-1-christian.brauner@ubuntu.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Brauner <christian.brauner@ubuntu.com>, Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org

On Fri, Sep 20, 2019 at 03:19:09PM +0200, Christian Brauner wrote:
> While touching seccomp code I realized that the struct seccomp_data
> argument to secure_computing() seems to be unused by all current
> callers. So let's remove it unless there is some subtlety I missed.
> Note, I only tested this on x86.

What was amluto thinking in

2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
