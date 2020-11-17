Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQWTT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 17:19:19 -0500
Date: Tue, 17 Nov 2020 14:19:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v4 00/27]Fix several bad kernel-doc markups
Message-ID: <20201117141914.73056d1f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Theodore Ts'o <tytso@mit.edu>, Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Bounine <alex.bou9@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Anna Schumaker <anna.schumaker@netapp.com>, Anton Vorontsov <anton@enomsg.org>, Ben Segall <bsegall@google.com>, Colin Cross <ccross@android.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Evgeniy Polyakov <zbr@ioremap.net>, Heiner Kallweit <hkallweit1@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.com>, Juri Lelli <juri.lelli@redhat.com>, Kees Cook <keescook@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Matt Porter <mporter@kernel.crashing.org>, Maxime Ripard <mripard@kernel.org>, Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Richard Gong <richard.gong@linux.intel.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Thomas Zimmermann <tzimmermann@suse.de>, Tony Luck <tony.luck@intel.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Vincent Guittot <vincent.guittot@linaro.org>, Will Drewry <wad@chromium.org>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-ext4@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, target-devel@vger.kernel.org

On Mon, 16 Nov 2020 11:17:56 +0100 Mauro Carvalho Chehab wrote:
> Kernel-doc has always be limited to a probably bad documented
> rule:
> 
> The kernel-doc markups should appear *imediatelly before* the
> function or data structure that it documents.

Applied 1-3 to net-next, thanks!
